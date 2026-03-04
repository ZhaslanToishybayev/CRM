// Authentication service with backend-first runtime behavior.

import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../core/config/runtime_flags.dart';
import '../core/database/supabase_config.dart';

class User {
  final String id;
  final String email;
  final String name;

  User({required this.id, required this.email, required this.name});
}

class AuthService {
  static User? _currentUser;
  static StreamSubscription<supabase.AuthState>? _authSubscription;
  static bool _isInitialized = false;
  static String? _initializationError;

  /// For tests only: allows forcing demo auth without compile-time define.
  static bool debugForceDemoMode = false;

  static bool get _useDemoAuth => kDemoMode || debugForceDemoMode;

  static User? get currentUser => _currentUser;
  static bool get isAuthenticated => _currentUser != null;
  static String? get initializationError => _initializationError;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    _isInitialized = true;
    _initializationError = null;

    if (_useDemoAuth) return;

    try {
      await SupabaseConfig.initialize();
      _syncFromSupabaseUser(SupabaseConfig.client.auth.currentUser);
      _authSubscription ??= SupabaseConfig.client.auth.onAuthStateChange.listen(
        (authState) {
          _syncFromSupabaseUser(authState.session?.user);
        },
      );
    } catch (error) {
      _initializationError =
          'Supabase auth не инициализирован: $error. Проверьте SUPABASE_URL/SUPABASE_ANON_KEY.';
      developer.log('event=auth_init_failed error=$error');
      _isInitialized = false;
    }
  }

  static void _syncFromSupabaseUser(supabase.User? supabaseUser) {
    if (supabaseUser == null) {
      _currentUser = null;
      return;
    }

    final metadata = supabaseUser.userMetadata ?? const {};
    final fullName = (metadata['full_name'] ?? metadata['name'])?.toString();
    final username = metadata['username']?.toString();
    final email = supabaseUser.email ?? '';

    _currentUser = User(
      id: supabaseUser.id,
      email: email,
      name: fullName ?? username ?? email.split('@').first,
    );
  }

  static Stream<User?> authChanges() async* {
    if (_useDemoAuth) {
      yield _currentUser;
      return;
    }

    await initialize();
    yield _currentUser;

    if (!SupabaseConfig.isConfigured) {
      return;
    }

    yield* SupabaseConfig.client.auth.onAuthStateChange.map((authState) {
      _syncFromSupabaseUser(authState.session?.user);
      return _currentUser;
    });
  }

  static Future<User> login(String email, String password) async {
    if (_useDemoAuth) {
      await Future.delayed(const Duration(milliseconds: 300));

      if (email == 'demo@crm.com' && password == 'demo') {
        _currentUser = User(id: 'demo-user', email: email, name: 'Demo User');
        return _currentUser!;
      }
      throw Exception(
        'Неверный email или пароль. Используйте: demo@crm.com / demo',
      );
    }

    await initialize();
    if (_initializationError != null) {
      throw Exception(_initializationError!);
    }

    final response = await SupabaseConfig.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    _syncFromSupabaseUser(response.user ?? response.session?.user);

    if (_currentUser == null) {
      throw Exception('Не удалось получить сессию пользователя.');
    }
    return _currentUser!;
  }

  static Future<User> signUp({
    required String email,
    required String password,
    String? username,
    String? fullName,
  }) async {
    if (_useDemoAuth) {
      throw Exception('Регистрация отключена в Demo Mode.');
    }

    await initialize();
    if (_initializationError != null) {
      throw Exception(_initializationError!);
    }

    final response = await SupabaseConfig.client.auth.signUp(
      email: email,
      password: password,
      data: {
        if (username != null && username.isNotEmpty) 'username': username,
        if (fullName != null && fullName.isNotEmpty) 'full_name': fullName,
      },
    );

    final createdUser = response.user ?? response.session?.user;
    _syncFromSupabaseUser(createdUser);

    // If email confirmation is required, Supabase may not return an active
    // session/user right away. Do not create a fake user with an empty UUID.
    if (_currentUser == null) {
      throw Exception(
        'Аккаунт создан, но email еще не подтвержден. '
        'Подтвердите письмо и затем выполните вход.',
      );
    }

    return _currentUser!;
  }

  static Future<void> logout() async {
    if (_useDemoAuth) {
      _currentUser = null;
      return;
    }

    if (!SupabaseConfig.isConfigured) {
      _currentUser = null;
      return;
    }

    try {
      await SupabaseConfig.client.auth.signOut();
    } finally {
      _currentUser = null;
    }
  }

  static void resetForTest() {
    _currentUser = null;
    _initializationError = null;
    _isInitialized = false;
    debugForceDemoMode = false;
  }
}

final authStateProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(AuthService.currentUser) {
    AuthService.initialize();
    _subscription = AuthService.authChanges().listen((user) {
      state = user;
    });
  }

  StreamSubscription<User?>? _subscription;

  Future<void> login(String email, String password) async {
    final user = await AuthService.login(email, password);
    state = user;
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? username,
    String? fullName,
  }) async {
    final user = await AuthService.signUp(
      email: email,
      password: password,
      username: username,
      fullName: fullName,
    );
    state = user;
  }

  void logout() {
    unawaited(AuthService.logout());
    state = null;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    super.dispose();
  }
}
