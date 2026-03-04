/// Authentication Provider
/// Educational Project - Gamified Task Management App
///
/// Manages authentication state using Riverpod

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../repositories/auth_repository_impl.dart';
import '../data_sources/supabase_auth_data_source.dart';
import '../data_sources/auth_data_source.dart';

part 'auth_provider.g.dart';

// Provider for the auth repository
@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final dataSource = ref.read(authDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
}

// Provider for the auth data source
@Riverpod(keepAlive: true)
AuthDataSource authDataSource(AuthDataSourceRef ref) {
  return SupabaseAuthDataSource();
}

// Provider for the current user
@Riverpod(keepAlive: true)
UserModel? currentUser(CurrentUserRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  // This will be managed by the auth state provider
  return null;
}

// Provider for authentication state
@Riverpod(keepAlive: true)
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  UserModel? build() {
    // Initialize by checking current auth state
    final authRepository = ref.read(authRepositoryProvider);

    // Start listening to auth state changes
    _startListeningToAuthChanges();

    // Return current user if any
    return authRepository.getCurrentUser();
  }

  void _startListeningToAuthChanges() {
    final authRepository = ref.read(authRepositoryProvider);

    // Listen to auth state changes
    authRepository.authStateChanges.listen((user) {
      state = user;
    });
  }

  /// Sign in with email and password
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);
    final user = await authRepository.signIn(
      email: email,
      password: password,
    );
    state = user;
    return user;
  }

  /// Sign up with email, password and username
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String username,
    String? fullName,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);
    final user = await authRepository.signUp(
      email: email,
      password: password,
      username: username,
      fullName: fullName,
    );
    state = user;
    return user;
  }

  /// Sign out
  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.signOut();
    state = null;
  }

  /// Send password reset email
  Future<void> resetPassword(String email) async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.resetPassword(email);
  }

  /// Update user profile
  Future<UserModel> updateProfile({
    String? username,
    String? fullName,
    String? avatarUrl,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);
    final user = await authRepository.updateProfile(
      username: username,
      fullName: fullName,
      avatarUrl: avatarUrl,
    );
    state = user;
    return user;
  }
}

// Provider for authentication state
@Riverpod(keepAlive: true)
UserModel? authState(AuthStateRef ref) {
  return ref.watch(authStateNotifierProvider);
}

// Helper provider to check if user is authenticated
@Riverpod(keepAlive: true)
bool isAuthenticated(IsAuthenticatedRef ref) {
  final authState = ref.watch(authStateProvider);
  return authState != null;
}
