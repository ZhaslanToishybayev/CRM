/// Supabase Configuration - canonical source of runtime credentials.
/// Configure values through:
/// `flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...`

import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String _supabaseUrlFromEnv = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );
  static const String _supabaseAnonKeyFromEnv = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '',
  );

  static SupabaseClient? _client;

  static const String _tasksTableFromEnv = String.fromEnvironment(
    'TASKS_TABLE',
    defaultValue: 'tasks',
  );
  static const String _userStatsTableFromEnv = String.fromEnvironment(
    'USER_STATS_TABLE',
    defaultValue: 'user_stats',
  );
  static const String _profilesTableFromEnv = String.fromEnvironment(
    'PROFILES_TABLE',
    defaultValue: 'profiles',
  );

  static String get supabaseUrl => _supabaseUrlFromEnv.trim();
  static String get supabaseAnonKey => _supabaseAnonKeyFromEnv.trim();
  static String get tasksTable => _tasksTableFromEnv.trim().isEmpty
      ? 'tasks'
      : _tasksTableFromEnv.trim();
  static String get userStatsTable => _userStatsTableFromEnv.trim().isEmpty
      ? 'user_stats'
      : _userStatsTableFromEnv.trim();
  static String get profilesTable => _profilesTableFromEnv.trim().isEmpty
      ? 'profiles'
      : _profilesTableFromEnv.trim();

  static bool get isCorporateTasksSchema => tasksTable == 'work_tasks';
  static String get taskUserIdColumn =>
      isCorporateTasksSchema ? 'assignee_id' : 'user_id';
  static String get taskReporterIdColumn =>
      isCorporateTasksSchema ? 'reporter_id' : 'user_id';

  static bool get isConfigured {
    return supabaseUrl.isNotEmpty &&
        supabaseAnonKey.isNotEmpty &&
        !_looksLikePlaceholder(supabaseUrl) &&
        !_looksLikePlaceholder(supabaseAnonKey);
  }

  static bool _looksLikePlaceholder(String value) {
    final lower = value.toLowerCase();
    return lower.contains('your_') || lower.contains('placeholder');
  }

  static void _ensureConfigured() {
    if (!isConfigured) {
      throw StateError(
        'Supabase is not configured. Pass SUPABASE_URL and SUPABASE_ANON_KEY '
        'via --dart-define.',
      );
    }
  }

  static SupabaseClient get client {
    _ensureConfigured();
    _client ??= SupabaseClient(supabaseUrl, supabaseAnonKey);
    return _client!;
  }

  static Future<void> initialize() async {
    _ensureConfigured();
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  /// Supports both legacy (`user_stats`) and new (`profiles`) schemas.
  static Future<Map<String, dynamic>?> getProfile(String userId) async {
    final candidates = <String>[
      userStatsTable,
      profilesTable,
      if (userStatsTable != 'user_stats') 'user_stats',
      if (profilesTable != 'profiles') 'profiles',
      'corporate_users',
    ].toSet().toList();

    for (final table in candidates) {
      try {
        final query = client.from(table).select();
        final response = table == 'corporate_users'
            ? await query.eq('user_id', userId).single()
            : await query.eq('id', userId).single();
        return response as Map<String, dynamic>;
      } catch (_) {
        // try next table
      }
    }

    return null;
  }

  static Future<String> detectTaskTable() async {
    final candidates = <String>[
      tasksTable,
      if (tasksTable != 'tasks') 'tasks',
      if (tasksTable != 'work_tasks') 'work_tasks',
    ].toSet().toList();

    for (final table in candidates) {
      try {
        await client.from(table).select('id').limit(1);
        return table;
      } catch (_) {
        // try next table
      }
    }

    throw StateError('No compatible tasks table found (checked: $candidates)');
  }

  static Future<String> detectUserStatsTable() async {
    final candidates = <String>[
      userStatsTable,
      if (userStatsTable != 'user_stats') 'user_stats',
      if (userStatsTable != 'corporate_users') 'corporate_users',
      if (userStatsTable != 'profiles') 'profiles',
    ].toSet().toList();

    for (final table in candidates) {
      try {
        await client.from(table).select('id').limit(1);
        return table;
      } catch (_) {
        // try next table
      }
    }

    throw StateError(
      'No compatible user profile/stats table found (checked: $candidates)',
    );
  }

  static Future<void> upsertProfile({
    required String userId,
    required String username,
    required String email,
    int? xp,
    int? level,
    int? streak,
  }) async {
    final now = DateTime.now().toIso8601String();
    final table = await detectUserStatsTable();

    try {
      if (table == 'corporate_users') {
        final updatePayload = <String, dynamic>{
          'username': username,
          'email': email,
          'full_name': username,
          'total_xp': xp ?? 0,
          'current_level': level ?? 1,
          'streak_count': streak ?? 0,
          'updated_at': now,
        };

        final existing = await client
            .from(table)
            .select('id')
            .eq('user_id', userId)
            .limit(1);

        if (existing is List && existing.isNotEmpty) {
          await client.from(table).update(updatePayload).eq('user_id', userId);
        } else {
          await client.from(table).insert({
            'user_id': userId,
            ...updatePayload,
            'created_at': now,
          });
        }
      } else if (table == 'user_stats') {
        await client.from(table).upsert({
          'id': userId,
          'username': username,
          'email': email,
          'xp': xp ?? 0,
          'level': level ?? 1,
          'streak': streak ?? 0,
          'created_at': now,
          'updated_at': now,
        });
      } else {
        await client.from(table).upsert({
          'id': userId,
          'username': username,
          'email': email,
          'total_xp': xp ?? 0,
          'current_level': level ?? 1,
          'streak_count': streak ?? 0,
          'created_at': now,
          'updated_at': now,
        });
      }
    } catch (_) {
      // fallback legacy behavior
      await client.from('user_stats').upsert({
        'id': userId,
        'username': username,
        'email': email,
        'xp': xp ?? 0,
        'level': level ?? 1,
        'streak': streak ?? 0,
        'created_at': now,
        'updated_at': now,
      });
    }
  }

  static Future<void> createProfile({
    required String userId,
    required String username,
    required String email,
  }) async {
    await upsertProfile(
      userId: userId,
      username: username,
      email: email,
      xp: 0,
      level: 1,
      streak: 0,
    );
  }

  static Future<Box> openLocalBox() async {
    return Hive.openBox('supabase_local');
  }
}
