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

    // Note: This is a simplified version. In production, you might want to cache the profile
    // For now, we'll return a basic user model
    // The full profile will be loaded when needed
    return null;
  }

  /// Get current user with full profile
  Future<UserModel?> getCurrentUserWithProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final profile = await SupabaseConfig.getProfile(user.id);
    if (profile == null) return null;

    return UserModel(
      id: profile['id'] as String,
      email: user.email!,
      username: profile['username'] as String,
      fullName: profile['full_name'] as String?,
      avatarUrl: profile['avatar_url'] as String?,
      totalXP: profile['total_xp'] as int? ?? 0,
      currentLevel: profile['current_level'] as int? ?? 1,
      streakCount: profile['streak_count'] as int? ?? 0,
      lastTaskDate: profile['last_task_date'] != null
          ? DateTime.parse(profile['last_task_date'] as String)
          : null,
      createdAt: DateTime.parse(profile['created_at'] as String),
      updatedAt: DateTime.parse(profile['updated_at'] as String),
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

    final updates = <String, dynamic>{};
    if (username != null) updates['username'] = username;
    if (fullName != null) updates['full_name'] = fullName;
    if (avatarUrl != null) updates['avatar_url'] = avatarUrl;
    updates['updated_at'] = DateTime.now().toIso8601String();

    await _client
        .from('profiles')
        .update(updates)
        .eq('id', user.id);

    // Return updated user
    final profile = SupabaseConfig.getProfile(user.id);
    final profileData = await profile;

    if (profileData == null) {
      throw Exception('Profile not found');
    }

    return UserModel(
      id: profileData['id'] as String,
      email: user.email!,
      username: profileData['username'] as String,
      fullName: profileData['full_name'] as String?,
      avatarUrl: profileData['avatar_url'] as String?,
      totalXP: profileData['total_xp'] as int? ?? 0,
      currentLevel: profileData['current_level'] as int? ?? 1,
      streakCount: profileData['streak_count'] as int? ?? 0,
      lastTaskDate: profileData['last_task_date'] != null
          ? DateTime.parse(profileData['last_task_date'] as String)
          : null,
      createdAt: DateTime.parse(profileData['created_at'] as String),
      updatedAt: DateTime.parse(profileData['updated_at'] as String),
    );
  }

  @override
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;
}
