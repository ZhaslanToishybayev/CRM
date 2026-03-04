// Supabase configuration.
//
// Security rules:
// - never hardcode credentials in source code
// - pass credentials via --dart-define (recommended for Flutter Web)
// - optionally use local .env for development only

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  SupabaseConfig._();

  static const String _urlFromDefine = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );
  static const String _anonKeyFromDefine = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '',
  );

  static String? _supabaseUrl;
  static String? _supabaseAnonKey;
  static SupabaseClient? _client;
  static bool _dotenvLoaded = false;

  static String get supabaseUrl => _supabaseUrl ?? '';
  static String get supabaseAnonKey => _supabaseAnonKey ?? '';

  static bool get isConfigured =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;

  static Future<void> _tryLoadDotEnv() async {
    if (_dotenvLoaded) return;
    _dotenvLoaded = true;
    try {
      await dotenv.load(fileName: '.env');
    } catch (_) {
      // Optional for local development; dart-define remains primary source.
    }
  }

  static Future<void> initialize() async {
    await _tryLoadDotEnv();

    _supabaseUrl = _firstNonEmpty(_urlFromDefine, _dotenvValue('SUPABASE_URL'));
    _supabaseAnonKey = _firstNonEmpty(
      _anonKeyFromDefine,
      _dotenvValue('SUPABASE_ANON_KEY'),
    );

    if (!isConfigured) {
      throw StateError(
        'Supabase credentials are missing. '
        'Provide SUPABASE_URL and SUPABASE_ANON_KEY via --dart-define '
        'or local .env (not committed).',
      );
    }

    if (_client != null) return;

    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
    _client = Supabase.instance.client;
  }

  static SupabaseClient get client {
    if (_client != null) return _client!;
    if (!isConfigured) {
      throw StateError(
        'Supabase is not initialized. Call SupabaseConfig.initialize() first.',
      );
    }
    _client = SupabaseClient(supabaseUrl, supabaseAnonKey);
    return _client!;
  }

  static Future<Map<String, dynamic>?> getProfile(String userId) async {
    try {
      final response = await client
          .from('user_stats')
          .select()
          .eq('id', userId)
          .maybeSingle();
      return response;
    } catch (_) {
      return null;
    }
  }

  static Future<void> createProfile({
    required String userId,
    required String username,
    required String email,
  }) async {
    await client.from('user_stats').insert({
      'id': userId,
      'username': username,
      'email': email,
      'xp': 0,
      'level': 1,
      'streak': 0,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  static Future<Box> openLocalBox() async {
    return Hive.openBox('supabase_local');
  }

  static String _firstNonEmpty(String a, String b) {
    if (a.trim().isNotEmpty) return a.trim();
    if (b.trim().isNotEmpty) return b.trim();
    return '';
  }

  static String _dotenvValue(String key) {
    try {
      return dotenv.maybeGet(key) ?? '';
    } catch (_) {
      return '';
    }
  }
}
