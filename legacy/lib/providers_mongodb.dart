/// Riverpod Providers for MongoDB
/// Educational Project - Gamified Task Management App
/// Real MongoDB Backend - No Demo Mode

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/mongodb/mongodb_service.dart';
import 'core/models/task_model.dart';
import 'core/models/user_stats_model.dart';

// ========== MONGODB SERVICE PROVIDER ==========

final mongoDBServiceProvider = Provider<MongoDBService>((ref) {
  return MongoDBService();
});

// ========== TASKS PROVIDER ==========

class TasksNotifier extends StateNotifier<AsyncValue<List<TaskModel>>> {
  TasksNotifier(this._mongoDBService, this._userId) : super(const AsyncValue.loading()) {
    _loadTasks();
  }

  final MongoDBService _mongoDBService;
  final String _userId;

  Future<void> _loadTasks() async {
    try {
      final tasks = await _mongoDBService.getTasks(_userId);
      state = AsyncValue.data(tasks);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      final createdTask = await _mongoDBService.createTask(task);
      final currentTasks = state.value ?? [];
      state = AsyncValue.data([createdTask, ...currentTasks]);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      final updatedTask = await _mongoDBService.updateTask(task);
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
      await _mongoDBService.deleteTask(taskId);
      final currentTasks = state.value ?? [];
      final newTasks = currentTasks.where((t) => t.effectiveId != taskId).toList();
      state = AsyncValue.data(newTasks);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> completeTask(String taskId) async {
    try {
      final updatedTask = await _mongoDBService.completeTask(taskId);
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
    final mongoDBService = ref.read(mongoDBServiceProvider);
    return TasksNotifier(mongoDBService, userId);
  },
);

// ========== USER STATS PROVIDER ==========

class UserStatsNotifier extends StateNotifier<AsyncValue<UserStatsModel?>> {
  UserStatsNotifier(this._mongoDBService, this._userId) : super(const AsyncValue.loading()) {
    _loadUserStats();
  }

  final MongoDBService _mongoDBService;
  final String _userId;

  Future<void> _loadUserStats() async {
    try {
      final stats = await _mongoDBService.getUserStats(_userId);
      state = AsyncValue.data(stats);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateStats(UserStatsModel stats) async {
    try {
      await _mongoDBService.updateUserStats(stats);
      state = AsyncValue.data(stats);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addXP(int xpAmount) async {
    try {
      await _mongoDBService.addUserXP(_userId, xpAmount);
      await _loadUserStats(); // Reload to get updated stats
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateStreak() async {
    try {
      await _mongoDBService.updateUserStreak(_userId);
      await _loadUserStats(); // Reload to get updated stats
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final userStatsProvider = StateNotifierProvider.family<UserStatsNotifier, AsyncValue<UserStatsModel?>, String>(
  (ref, userId) {
    final mongoDBService = ref.read(mongoDBServiceProvider);
    return UserStatsNotifier(mongoDBService, userId);
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

// ========== AUTH METHODS (MOCK) ==========

final authMethodsProvider = Provider<AuthMethods>((ref) {
  final mongoDBService = ref.read(mongoDBServiceProvider);
  return AuthMethods(mongoDBService);
});

class AuthMethods {
  final MongoDBService _mongoDBService;

  AuthMethods(this._mongoDBService);

  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String username,
  }) {
    return _mongoDBService.signUp(
      email: email,
      password: password,
      username: username,
    );
  }

  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) {
    return _mongoDBService.signIn(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() {
    return _mongoDBService.signOut();
  }
}

// ========== MOCK AUTH PROVIDERS ==========

/// Mock user for demo purposes
class MockUser {
  final String id;
  final String email;
  final String username;

  MockUser({
    required this.id,
    required this.email,
    required this.username,
  });
}

final currentUserProvider = Provider<MockUser?>((ref) {
  // Return mock user for now
  return MockUser(
    id: 'demo-user',
    email: 'demo@example.com',
    username: 'Demo User',
  );
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  // Always return true for mock authentication
  return true;
});
