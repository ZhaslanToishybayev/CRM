/// Task Provider
/// Educational Project - Gamified Task Management App
///
/// Manages task state using Riverpod

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/task_model.dart';
import '../repositories/task_repository.dart';
import '../repositories/task_repository_impl.dart';
import '../data_sources/supabase_task_data_source.dart';
import '../data_sources/local_task_data_source.dart';
import '../../gamification/providers/gamification_provider.dart';
import '../../streak/providers/streak_provider.dart';

part 'task_provider.g.dart';

// Provider for the task repository
@Riverpod(keepAlive: true)
TaskRepository taskRepository(TaskRepositoryRef ref) {
  final remoteDataSource = ref.read(supabaseTaskDataSourceProvider);
  final localDataSource = ref.read(localTaskDataSourceProvider);
  return TaskRepositoryImpl(remoteDataSource, localDataSource);
}

// Provider for the remote task data source
@Riverpod(keepAlive: true)
SupabaseTaskDataSource supabaseTaskDataSource(SupabaseTaskDataSourceRef ref) {
  return SupabaseTaskDataSource();
}

// Provider for the local task data source
@Riverpod(keepAlive: true)
LocalTaskDataSource localTaskDataSource(LocalTaskDataSourceRef ref) {
  return LocalTaskDataSource();
}

// Provider for the current user's tasks
@Riverpod(keepAlive: true)
class TaskNotifier extends _$TaskNotifier {
  @override
  List<TaskModel> build() {
    // Load tasks on initialization
    _loadTasks();
    return [];
  }

  /// Load all tasks
  Future<void> _loadTasks() async {
    final repository = ref.read(taskRepositoryProvider);
    final tasks = await repository.getTasks();
    state = tasks;
  }

  /// Create a new task
  Future<TaskModel> createTask({
    required String title,
    String? description,
    required TaskPriority priority,
    String? category,
    DateTime? dueDate,
  }) async {
    final repository = ref.read(taskRepositoryProvider);

    // Get current user from auth provider
    final authState = ref.read(authProvider.notifier);
    final userId = authState.getUserId();

    final task = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      title: title,
      description: description,
      xp: _getXPForPriority(priority),
      priority: priority,
      status: TaskStatus.pending,
      dueDate: dueDate,
      category: category,
      completedAt: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final createdTask = await repository.createTask(task);
    state = [createdTask, ...state];
    return createdTask;
  }

  /// Update an existing task
  Future<TaskModel> updateTask(TaskModel task) async {
    final repository = ref.read(taskRepositoryProvider);
    final updatedTask = await repository.updateTask(task);

    state = [
      for (final t in state)
        if (t.id == task.id) updatedTask else t,
    ];

    return updatedTask;
  }

  /// Delete a task
  Future<void> deleteTask(String taskId) async {
    final repository = ref.read(taskRepositoryProvider);
    await repository.deleteTask(taskId);

    state = [
      for (final t in state)
        if (t.id != taskId) t,
    ];
  }

  /// Clear all tasks (for logout)
  void clearTasks() {
    state = [];
  }

  /// Complete a task with XP reward
  Future<TaskModel> completeTask(
    String taskId, {
    VoidCallback? onLevelUp,
  }) async {
    final repository = ref.read(taskRepositoryProvider);
    final task = state.firstWhere(
      (t) => t.id == taskId,
      orElse: () => throw Exception('Task not found'),
    );

    // Get current XP state
    final currentXP = ref.read(currentXPProvider);
    final oldXP = currentXP;

    // Complete the task
    final completedTask = await repository.completeTask(taskId);

    // Award XP through gamification system
    final gamificationNotifier = ref.read(gamificationNotifierProvider.notifier);

    // Get streak count from streak provider
    final streakCount = ref.read(streakNotifierProvider).currentStreak;

    try {
      final newXP = await gamificationNotifier.awardXP(
        priority: task.priority.name,
        dueDate: task.dueDate,
        completedAt: DateTime.now(),
        streakCount: streakCount,
      );

      // Check for level up
      if (oldXP != null &&
          gamificationNotifier.hasLeveledUp(oldXP, newXP)) {
        // Trigger level up celebration
        if (onLevelUp != null) {
          onLevelUp();
        }
      }
    } catch (e) {
      // Handle XP award failure gracefully
      print('Failed to award XP: $e');
    }

    // Update task state
    state = [
      for (final t in state)
        if (t.id == taskId) completedTask else t,
    ];

    return completedTask;
  }

  /// Search tasks
  Future<List<TaskModel>> searchTasks(String query) async {
    final repository = ref.read(taskRepositoryProvider);
    return await repository.searchTasks(query);
  }

  /// Get tasks by status
  List<TaskModel> getTasksByStatus(TaskStatus status) {
    return state.where((task) => task.status == status).toList();
  }

  /// Get tasks by category
  List<TaskModel> getTasksByCategory(String category) {
    return state
        .where((task) => task.category?.toLowerCase() == category.toLowerCase())
        .toList();
  }

  /// Get overdue tasks
  List<TaskModel> getOverdueTasks() {
    final now = DateTime.now();
    return state
        .where((task) =>
            task.status == TaskStatus.pending &&
            task.dueDate != null &&
            task.dueDate!.isBefore(now))
        .toList();
  }

  /// Get tasks due today
  List<TaskModel> getTasksDueToday() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return state
        .where((task) =>
            task.dueDate != null &&
            task.dueDate!.isAfter(startOfDay) &&
            task.dueDate!.isBefore(endOfDay))
        .toList();
  }

  /// Refresh tasks
  Future<void> refresh() async {
    await _loadTasks();
  }

  /// Sync tasks with remote
  Future<void> sync() async {
    final repository = ref.read(taskRepositoryProvider);
    await repository.syncTasks();
    await _loadTasks();
  }

  /// Get XP for task priority
  int _getXPForPriority(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return 10;
      case TaskPriority.medium:
        return 25;
      case TaskPriority.high:
        return 40;
      case TaskPriority.urgent:
        return 50;
    }
  }
}

// Provider for filtered tasks
@Riverpod(keepAlive: true)
List<TaskModel> filteredTasks(FilteredTasksRef ref) {
  final taskState = ref.watch(taskNotifierProvider);
  final filter = ref.watch(taskFilterProvider);
  final searchQuery = ref.watch(taskSearchProvider);

  var filtered = taskState;

  // Filter by status
  if (filter != TaskFilter.all) {
    filtered = taskState.where((task) {
      switch (filter) {
        case TaskFilter.pending:
          return task.status == TaskStatus.pending;
        case TaskFilter.completed:
          return task.status == TaskStatus.completed;
        case TaskFilter.overdue:
          final now = DateTime.now();
          return task.status == TaskStatus.pending &&
              task.dueDate != null &&
              task.dueDate!.isBefore(now);
        default:
          return true;
      }
    }).toList();
  }

  // Filter by search query
  if (searchQuery.isNotEmpty) {
    final query = searchQuery.toLowerCase();
    filtered = filtered.where((task) {
      return task.title.toLowerCase().contains(query) ||
          (task.description?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  return filtered;
}

// Provider for task filter
@Riverpod(keepAlive: true)
TaskFilter taskFilter(TaskFilterRef ref) {
  return TaskFilter.all;
}

// Provider for tasks list
@riverpod
Future<List<TaskModel>> tasksList(TasksListRef ref) async {
  final repository = ref.read(taskRepositoryProvider);
  return repository.getTasks();
}

// Provider for task search query
@riverpod
String taskSearch(TaskSearchRef ref) {
  return '';
}

// Provider for task search state
@riverpod
class TaskSearchNotifier extends _$TaskSearchNotifier {
  @override
  String build() {
    return '';
  }

  void updateSearch(String value) {
    state = value;
  }
}

/// Task filter options
enum TaskFilter {
  all,
  pending,
  completed,
  overdue,
}
