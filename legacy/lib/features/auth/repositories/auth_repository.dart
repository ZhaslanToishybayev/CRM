/// Authentication Repository Interface
/// Educational Project - Gamified Task Management App
///
/// Abstract repository for authentication operations

import '../models/user_model.dart';

abstract class AuthRepository {
  /// Check if user is currently authenticated
  bool isAuthenticated();

  /// Get current authenticated user
  UserModel? getCurrentUser();

  /// Sign up with email and password
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String username,
    String? fullName,
  });

  /// Sign in with email and password
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  /// Sign out current user
  Future<void> signOut();

  /// Send password reset email
  Future<void> resetPassword(String email);

  /// Update user profile
  Future<UserModel> updateProfile({
    String? username,
    String? fullName,
    String? avatarUrl,
  });

  /// Listen to authentication state changes
  Stream<UserModel?> get authStateChanges;
}
