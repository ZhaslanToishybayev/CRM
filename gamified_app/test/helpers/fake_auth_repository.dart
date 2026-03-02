import 'dart:async';

import 'package:gamified_task_app/features/auth/models/user_model.dart';
import 'package:gamified_task_app/features/auth/repositories/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  UserModel? _currentUser;
  String? lastResetPasswordEmail;
  final StreamController<UserModel?> _controller =
      StreamController<UserModel?>.broadcast();

  @override
  Stream<UserModel?> get authStateChanges => _controller.stream;

  @override
  UserModel? getCurrentUser() => _currentUser;

  @override
  bool isAuthenticated() => _currentUser != null;

  @override
  Future<void> resetPassword(String email) async {
    lastResetPasswordEmail = email;
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final user = UserModel(
      id: 'user-1',
      email: email,
      username: email.split('@').first,
      totalXP: 0,
      currentLevel: 1,
      streakCount: 0,
    );
    _currentUser = user;
    _controller.add(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _controller.add(null);
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String username,
    String? fullName,
  }) async {
    final user = UserModel(
      id: 'user-2',
      email: email,
      username: username,
      fullName: fullName,
      totalXP: 0,
      currentLevel: 1,
      streakCount: 0,
    );
    _currentUser = user;
    _controller.add(user);
    return user;
  }

  @override
  Future<UserModel> updateProfile({
    String? username,
    String? fullName,
    String? avatarUrl,
  }) async {
    final current = _currentUser;
    if (current == null) {
      throw StateError('No authenticated user');
    }

    final updated = current.copyWith(
      username: username ?? current.username,
      fullName: fullName ?? current.fullName,
      avatarUrl: avatarUrl ?? current.avatarUrl,
    );
    _currentUser = updated;
    _controller.add(updated);
    return updated;
  }

  void dispose() {
    _controller.close();
  }
}
