/// Riverpod Providers for Supabase
/// Educational Project - Gamified Task Management App
/// Supabase Backend with Demo Mode Support

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

// ========== TASKS PROVIDER ==========

class TasksNotifier extends StateNotifier<AsyncValue<List<TaskModel>>> {
  TasksNotifier(this._supabaseService, this._userId) : super(const AsyncValue.loading()) {
    _loadTasks();
  }

  final SupabaseService _supabaseService;
  final String _userId;

  Future<void> _loadTasks() async {
    try {
      final tasks = await _supabaseService.getTasks(_userId);
      state = AsyncValue.data(tasks);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      final createdTask = await _supabaseService.createTask(task);
      final currentTasks = state.value ?? [];
      state = AsyncValue.data([createdTask, ...currentTasks]);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      final updatedTask = await _supabaseService.updateTask(task);
      final currentTasks = state.value ?? [];
      final index = currentTasks.indexWhere((t) => t.effectiveId == task.effectiveId);
      if (index != -1) {
        final newTasks = [...currentTasks];
        newTasks[index] = updatedTask;
        state = AsyncValue.data(newTasks);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _supabaseService.deleteTask(taskId);
      final currentTasks = state.value ?? [];
      final newTasks = currentTasks.where((t) => t.effectiveId != taskId).toList();
      state = AsyncValue.data(newTasks);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> completeTask(String taskId) async {
    try {
      final updatedTask = await _supabaseService.completeTask(taskId);
      final currentTasks = state.value ?? [];
      final index = currentTasks.indexWhere((t) => t.effectiveId == taskId);
      if (index != -1) {
        final newTasks = [...currentTasks];
        newTasks[index] = updatedTask;
        state = AsyncValue.data(newTasks);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> toggleTask(String taskId) async {
    try {
      final currentTasks = state.value ?? [];
      final task = currentTasks.firstWhere((t) => t.effectiveId == taskId);
      final updatedTask = task.copyWith(
        isCompleted: !task.isCompleted,
      );
      await updateTask(updatedTask);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
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
  }

  final SupabaseService _supabaseService;
  final String _userId;

  Future<void> _loadUserStats() async {
    try {
      final stats = await _supabaseService.getUserStats(_userId);
      state = AsyncValue.data(stats);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateStats(UserStatsModel stats) async {
    try {
      await _supabaseService.updateUserStats(stats);
      state = AsyncValue.data(stats);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addXP(int xpAmount) async {
    try {
      await _supabaseService.addUserXP(_userId, xpAmount);
      await _loadUserStats(); // Reload to get updated stats
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateStreak() async {
    try {
      await _supabaseService.updateUserStreak(_userId);
      await _loadUserStats(); // Reload to get updated stats
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
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
  final List<TaskModel> tasks;
  final UserStatsModel? userStats;
  final String? error;

  AppState({
    required this.tasks,
    this.userStats,
    this.error,
  });

  List<TaskModel> get activeTasks {
    return tasks.where((task) => !task.isCompleted).toList();
  }

  List<TaskModel> get completedTasks {
    return tasks.where((task) => task.isCompleted).toList();
  }
}

final appStateProvider = Provider<AppState>((ref) {
  final tasksState = ref.watch(tasksProvider('demo-user'));
  final userStatsState = ref.watch(userStatsProvider('demo-user'));

  final tasks = tasksState.when(
    data: (tasks) => tasks,
    loading: () => <TaskModel>[],
    error: (_, __) => <TaskModel>[],
  );

  final userStats = userStatsState.when(
    data: (stats) => stats,
    loading: () => null,
    error: (_, __) => null,
  );

  return AppState(
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

  Future<void> signOut() {
    return _supabaseService.signOut();
  }

  Future<AuthResponse> signInAnonymously() {
    return _supabaseService.signInAnonymously();
  }
}

// ========== AUTH PROVIDERS ==========

/// Current authenticated user
final currentUserProvider = Provider<User?>((ref) {
  final supabaseService = ref.read(supabaseServiceProvider);
  return supabaseService.currentUser;
});

/// Authentication status
final isAuthenticatedProvider = Provider<bool>((ref) {
  final supabaseService = ref.read(supabaseServiceProvider);
  return supabaseService.isAuthenticated;
});

/// Demo mode status
final isDemoModeProvider = Provider<bool>((ref) {
  final supabaseService = ref.read(supabaseServiceProvider);
  return supabaseService.isDemoMode;
});
