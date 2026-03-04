/// Authentication Repository Implementation
/// Educational Project - Gamified Task Management App
///
/// Concrete implementation of AuthRepository using Supabase

import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';
import '../data_sources/auth_data_source.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  bool isAuthenticated() {
    return _dataSource.isAuthenticated();
  }

  @override
  UserModel? getCurrentUser() {
    // Get current user from auth session
    final user = _dataSource.getCurrentUser();
    return user;
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String username,
    String? fullName,
  }) async {
    final response = await _dataSource.signUp(
      email: email,
      password: password,
      metadata: {
        'username': username,
        'full_name': fullName,
      },
    );

    if (response.user == null) {
      throw Exception('Failed to create user');
    }

    // Wait for the profile to be created by the database trigger
    await Future.delayed(const Duration(seconds: 1));

    // Get the full user profile
    final userWithProfile = await (_dataSource as dynamic)
        .getCurrentUserWithProfile();

    if (userWithProfile == null) {
      throw Exception('Failed to load user profile');
    }

    return userWithProfile;
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _dataSource.signIn(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Failed to sign in');
    }

    // Get the full user profile
    final userWithProfile = await (_dataSource as dynamic)
        .getCurrentUserWithProfile();

    if (userWithProfile == null) {
      throw Exception('Failed to load user profile');
    }

    return userWithProfile;
  }

  @override
  Future<void> signOut() async {
    await _dataSource.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _dataSource.resetPassword(email);
  }

  @override
  Future<UserModel> updateProfile({
    String? username,
    String? fullName,
    String? avatarUrl,
  }) async {
    return await _dataSource.updateProfile(
      username: username,
      fullName: fullName,
      avatarUrl: avatarUrl,
    );
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return _dataSource.authStateChanges.asyncMap((event) async {
      if (event.event == AuthChangeEvent.signedIn ||
          event.event == AuthChangeEvent.tokenRefreshed) {
        final userWithProfile = await (_dataSource as dynamic)
            .getCurrentUserWithProfile();
        return userWithProfile;
      } else if (event.event == AuthChangeEvent.signedOut) {
        return null;
      }
      return null;
    });
  }
}
