/// Riverpod Providers for Supabase
/// Educational Project - Gamified Task Management App

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/supabase/supabase_service.dart';
import 'core/models/task_model.dart';
import 'core/models/user_stats_model.dart';

// ========== SUPABASE SERVICE PROVIDER ==========

final supabaseServiceProvider = Provider<SupabaseService>((ref) {
  return SupabaseService();
});

// ========== AUTH PROVIDER ==========

final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (state) => state.session?.user,
    loading: () => null,
    error: (_, __) => null,
  );
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
});

// ========== TASKS PROVIDER ==========

class TasksNotifier extends StateNotifier<AsyncValue<List<TaskModel>>> {
  TasksNotifier(this._supabaseService, this._userId) : super(const AsyncValue.loading()) {
    _loadTasks();
    _subscribeToTasks();
  }

  final SupabaseService _supabaseService;
  final String _userId;
  StreamSubscription<List<TaskModel>>? _subscription;

  Future<void> _loadTasks() async {
    try {
      final tasks = await _supabaseService.getTasks(_userId);
      state = AsyncValue.data(tasks);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void _subscribeToTasks() {
    _subscription = _supabaseService.subscribeToTasks(_userId).listen(
      (tasks) {
        state = AsyncValue.data(tasks);
      },
      onError: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
    );
  }

  Future<void> addTask(TaskModel task) async {
    try {
      await _supabaseService.createTask(task);
      // State will be updated automatically via subscription
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await _supabaseService.updateTask(task);
      // State will be updated automatically via subscription
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _supabaseService.deleteTask(taskId);
      // State will be updated automatically via subscription
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> completeTask(String taskId) async {
    try {
      await _supabaseService.completeTask(taskId);
      // State will be updated automatically via subscription
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final tasksProvider = StateNotifierProvider.family<TasksNotifier, AsyncValue<List<TaskModel>>, String>(
  (ref, userId) {
    final supabaseService = ref.read(supabaseServiceProvider);
    return TasksNotifier(supabaseService, userId);
  },
);

// ========== USER STATS PROVIDER ==========

class UserStatsNotifier extends StateNotifier<AsyncValue<UserStatsModel?>> {
  UserStatsNotifier(this._supabaseService, this._userId) : super(const AsyncValue.loading()) {
    _loadUserStats();
    _subscribeToUserStats();
  }

  final SupabaseService _supabaseService;
  final String _userId;
  StreamSubscription<UserStatsModel?>? _subscription;

  Future<void> _loadUserStats() async {
    try {
      final stats = await _supabaseService.getUserStats(_userId);
      state = AsyncValue.data(stats);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void _subscribeToUserStats() {
    _subscription = _supabaseService.subscribeToUserStats(_userId).listen(
      (stats) {
        state = AsyncValue.data(stats);
      },
      onError: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
    );
  }

  Future<void> updateStats(UserStatsModel stats) async {
    try {
      await _supabaseService.updateUserStats(stats);
      // State will be updated automatically via subscription
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addXP(int xpAmount) async {
    try {
      await _supabaseService.addUserXP(_userId, xpAmount);
      // State will be updated automatically via subscription
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateStreak() async {
    try {
      await _supabaseService.updateUserStreak(_userId);
      // State will be updated automatically via subscription
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final userStatsProvider = StateNotifierProvider.family<UserStatsNotifier, AsyncValue<UserStatsModel?>, String>(
  (ref, userId) {
    final supabaseService = ref.read(supabaseServiceProvider);
    return UserStatsNotifier(supabaseService, userId);
  },
);

// ========== COMBINED APP STATE ==========

class AppState {
  final User? user;
  final AsyncValue<List<TaskModel>> tasks;
  final AsyncValue<UserStatsModel?> userStats;
  final String? error;

  AppState({
    this.user,
    required this.tasks,
    required this.userStats,
    this.error,
  });

  List<TaskModel> get activeTasks {
    return tasks.when(
      data: (tasks) => tasks.where((task) => !task.isCompleted).toList(),
      loading: () => [],
      error: (_, __) => [],
    );
  }

  List<TaskModel> get completedTasks {
    return tasks.when(
      data: (tasks) => tasks.where((task) => task.isCompleted).toList(),
      loading: () => [],
      error: (_, __) => [],
    );
  }
}

final appStateProvider = Provider<AppState>((ref) {
  final user = ref.watch(currentUserProvider);
  final tasks = ref.watch(tasksProvider(user?.id ?? ''));
  final userStats = ref.watch(userStatsProvider(user?.id ?? ''));

  return AppState(
    user: user,
    tasks: tasks,
    userStats: userStats,
  );
});

// ========== FILTERS ==========

class FiltersState {
  final String selectedCategory;
  final String selectedPriority;

  FiltersState({
    this.selectedCategory = 'All',
    this.selectedPriority = 'All',
  });

  FiltersState copyWith({
    String? selectedCategory,
    String? selectedPriority,
  }) {
    return FiltersState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedPriority: selectedPriority ?? this.selectedPriority,
    );
  }
}

class FiltersNotifier extends StateNotifier<FiltersState> {
  FiltersNotifier() : super(FiltersState());

  void setCategoryFilter(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void setPriorityFilter(String priority) {
    state = state.copyWith(selectedPriority: priority);
  }

  void reset() {
    state = FiltersState();
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifier, FiltersState>(
  (ref) => FiltersNotifier(),
);

// ========== AUTH METHODS ==========

final authMethodsProvider = Provider<AuthMethods>((ref) {
  final supabaseService = ref.read(supabaseServiceProvider);
  return AuthMethods(supabaseService);
});

class AuthMethods {
  final SupabaseService _supabaseService;

  AuthMethods(this._supabaseService);

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String username,
  }) {
    return _supabaseService.signUp(
      email: email,
      password: password,
      username: username,
    );
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return _supabaseService.signIn(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signInAnonymously() {
    return _supabaseService.signInAnonymously();
  }

  Future<void> signOut() {
    return _supabaseService.signOut();
  }
}
