/// Authentication Data Source Interface
/// Educational Project - Gamified Task Management App
///
/// Abstract data source for authentication operations

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';

abstract class AuthDataSource {
  /// Get current authenticated user
  UserModel? getCurrentUser();

  /// Check if user is authenticated
  bool isAuthenticated();

  /// Sign up with email and password
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? metadata,
  });

  /// Sign in with email and password
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  });

  /// Sign out
  Future<void> signOut();

  /// Send password reset email
  Future<void> resetPassword(String email);

  /// Update user in profiles table
  Future<UserModel> updateProfile({
    String? username,
    String? fullName,
    String? avatarUrl,
  });

  /// Stream of auth state changes
  Stream<AuthState> get authStateChanges;
}
