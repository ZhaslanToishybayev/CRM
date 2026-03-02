/// Supabase Authentication Data Source
/// Educational Project - Gamified Task Management App
///
/// Concrete implementation of AuthDataSource using Supabase

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/database/supabase_config.dart';
import '../models/user_model.dart';
import 'auth_data_source.dart';

class SupabaseAuthDataSource implements AuthDataSource {
  final _client = SupabaseConfig.client;

  @override
  UserModel? getCurrentUser() {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final metadata = user.userMetadata ?? const <String, dynamic>{};
    final username = (metadata['username'] as String?) ??
        (user.email?.split('@').first) ??
        'user_${user.id.substring(0, 8)}';

    return UserModel(
      id: user.id,
      email: user.email ?? '',
      username: username,
      fullName: metadata['full_name'] as String?,
      avatarUrl: metadata['avatar_url'] as String?,
      totalXP: 0,
      currentLevel: 1,
      streakCount: 0,
    );
  }

  /// Get current user with full profile
  @override
  Future<UserModel?> getCurrentUserWithProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final profile = await SupabaseConfig.getProfile(user.id);
    if (profile == null) return getCurrentUser();

    final metadata = user.userMetadata ?? const <String, dynamic>{};
    final username = _readString(profile, ['username']) ??
        (metadata['username'] as String?) ??
        (user.email?.split('@').first) ??
        'user_${user.id.substring(0, 8)}';

    return UserModel(
      id: _readString(profile, ['id']) ?? user.id,
      email: user.email ?? (_readString(profile, ['email']) ?? ''),
      username: username,
      fullName:
          _readString(profile, ['full_name', 'fullName']) ??
          (metadata['full_name'] as String?),
      avatarUrl:
          _readString(profile, ['avatar_url', 'avatarUrl']) ??
          (metadata['avatar_url'] as String?),
      totalXP: _readInt(profile, ['total_xp', 'xp'], fallback: 0),
      currentLevel: _readInt(profile, ['current_level', 'level'], fallback: 1),
      streakCount: _readInt(profile, ['streak_count', 'streak'], fallback: 0),
      lastTaskDate: _readDate(profile, ['last_task_date', 'lastTaskDate']),
      createdAt: _readDate(profile, ['created_at', 'createdAt']),
      updatedAt: _readDate(profile, ['updated_at', 'updatedAt']),
    );
  }

  @override
  bool isAuthenticated() {
    return _client.auth.currentSession != null;
  }

  @override
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? metadata,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: metadata,
    );

    return response;
  }

  @override
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return response;
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  @override
  Future<UserModel> updateProfile({
    String? username,
    String? fullName,
    String? avatarUrl,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user');
    }

    final timestamp = DateTime.now().toIso8601String();
    final profileUpdates = <String, dynamic>{'updated_at': timestamp};
    final userStatsUpdates = <String, dynamic>{'updated_at': timestamp};

    if (username != null) {
      profileUpdates['username'] = username;
      userStatsUpdates['username'] = username;
    }
    if (fullName != null) {
      profileUpdates['full_name'] = fullName;
      userStatsUpdates['full_name'] = fullName;
    }
    if (avatarUrl != null) {
      profileUpdates['avatar_url'] = avatarUrl;
      userStatsUpdates['avatar_url'] = avatarUrl;
    }

    await _bestEffortUpdate('profiles', profileUpdates, user.id);
    await _bestEffortUpdate('user_stats', userStatsUpdates, user.id);

    final updatedProfile = await getCurrentUserWithProfile();
    if (updatedProfile != null) {
      return updatedProfile;
    }

    final fallback = getCurrentUser();
    if (fallback != null) {
      return fallback;
    }

    throw Exception('Profile not found');
  }

  @override
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  Future<void> _bestEffortUpdate(
    String table,
    Map<String, dynamic> updates,
    String userId,
  ) async {
    try {
      await _client.from(table).update(updates).eq('id', userId);
    } catch (_) {
      // Table may differ across schema versions.
    }
  }

  static String? _readString(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value is String && value.isNotEmpty) return value;
    }
    return null;
  }

  static int _readInt(
    Map<String, dynamic> map,
    List<String> keys, {
    required int fallback,
  }) {
    for (final key in keys) {
      final value = map[key];
      if (value is int) return value;
      if (value is num) return value.toInt();
      if (value is String) {
        final parsed = int.tryParse(value);
        if (parsed != null) return parsed;
      }
    }
    return fallback;
  }

  static DateTime? _readDate(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value is DateTime) return value;
      if (value is String) {
        final parsed = DateTime.tryParse(value);
        if (parsed != null) return parsed;
      }
    }
    return null;
  }
}
