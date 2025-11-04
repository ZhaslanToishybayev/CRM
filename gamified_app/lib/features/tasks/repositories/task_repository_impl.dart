/// Task Repository Implementation
/// Educational Project - Gamified Task Management App
///
/// Concrete implementation of TaskRepository with offline-first support

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/task_model.dart';
import '../models/category_model.dart';
import '../data_sources/task_data_source.dart';
import 'task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource _remoteDataSource;
  final LocalTaskDataSource _localDataSource;

  TaskRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<List<TaskModel>> getTasks() async {
    // Try to get from local first (offline-first)
    final localTasks = _localDataSource.getTasks();

    // If online, sync with remote
    if (isOnline()) {
      try {
        final remoteTasks = await _remoteDataSource.getTasks();
        // Save to local
        await _localDataSource.saveTasks(remoteTasks);
        return remoteTasks;
      } catch (e) {
        // If remote fails, return local
        return localTasks;
      }
    }

    return localTasks;
  }

  @override
  Future<List<TaskModel>> getTasksByStatus(TaskStatus status) async {
    final allTasks = await getTasks();
    return allTasks.where((task) => task.status == status).toList();
  }

  @override
  Future<List<TaskModel>> getTasksByCategory(String category) async {
    final allTasks = await getTasks();
    return allTasks
        .where((task) => task.category?.toLowerCase() == category.toLowerCase())
        .toList();
  }

  @override
  Future<List<TaskModel>> getOverdueTasks() async {
    final allTasks = await getTasks();
    final now = DateTime.now();
    return allTasks
        .where((task) =>
            task.status == TaskStatus.pending &&
            task.dueDate != null &&
            task.dueDate!.isBefore(now))
        .toList();
  }

  @override
  Future<List<TaskModel>> getTasksDueToday() async {
    final allTasks = await getTasks();
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return allTasks
        .where((task) =>
            task.dueDate != null &&
            task.dueDate!.isAfter(startOfDay) &&
            task.dueDate!.isBefore(endOfDay))
        .toList();
  }

  @override
  Future<List<TaskModel>> searchTasks(String query) async {
    final allTasks = await getTasks();
    final lowerQuery = query.toLowerCase();
    return allTasks.where((task) {
      return task.title.toLowerCase().contains(lowerQuery) ||
          (task.description?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  @override
  Future<TaskModel?> getTaskById(String taskId) async {
    // Check local first
    final localTasks = _localDataSource.getTasks();
    final localTask =
        localTasks.firstWhere((task) => task.id == taskId, orElse: () => null as TaskModel);

    if (localTask != null && !isOnline()) {
      return localTask;
    }

    // If online, get from remote
    if (isOnline()) {
      return await _remoteDataSource.getTaskById(taskId);
    }

    return localTasks.isNotEmpty
        ? localTasks.firstWhere((task) => task.id == taskId, orElse: () => null)
        : null;
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    // Save to local immediately (offline-first)
    await _localDataSource.addTask(task);

    // Try to sync with remote if online
    if (isOnline()) {
      try {
        final remoteTask = await _remoteDataSource.createTask(task);
        // Update local with remote version
        await _localDataSource.updateTask(remoteTask);
        return remoteTask;
      } catch (e) {
        // If remote sync fails, keep local version
        return task;
      }
    }

    return task;
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    // Update local immediately
    await _localDataSource.updateTask(task);

    // Try to sync with remote if online
    if (isOnline()) {
      try {
        final remoteTask = await _remoteDataSource.updateTask(task);
        await _localDataSource.updateTask(remoteTask);
        return remoteTask;
      } catch (e) {
        return task;
      }
    }

    return task;
  }

  @override
  Future<void> deleteTask(String taskId) async {
    // Delete from local immediately
    await _localDataSource.deleteTask(taskId);

    // Try to delete from remote if online
    if (isOnline()) {
      try {
        await _remoteDataSource.deleteTask(taskId);
      } catch (e) {
        // If remote delete fails, task remains deleted locally
        // Will be retried in sync
      }
    }
  }

  @override
  Future<TaskModel> completeTask(String taskId) async {
    // Check if task exists
    final task = await getTaskById(taskId);
    if (task == null) {
      throw Exception('Task not found');
    }

    final completedTask = task.copyWith(
      status: TaskStatus.completed,
      completedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return await updateTask(completedTask);
  }

  @override
  Future<void> syncTasks() async {
    if (!isOnline()) return;

    // Get local tasks
    final localTasks = _localDataSource.getTasks();

    // Sync each task to remote
    for (final task in localTasks) {
      try {
        // Check if task exists remotely
        final remoteTask = await _remoteDataSource.getTaskById(task.id);

        if (remoteTask == null) {
          // Task doesn't exist remotely, create it
          await _remoteDataSource.createTask(task);
        } else if (task.updatedAt.isAfter(remoteTask.updatedAt)) {
          // Local task is newer, update remote
          await _remoteDataSource.updateTask(task);
        }
      } catch (e) {
        // Ignore sync errors for individual tasks
      }
    }

    // Pull remote changes
    final remoteTasks = await _remoteDataSource.getTasks();
    await _localDataSource.saveTasks(remoteTasks);
  }

  @override
  bool isOnline() {
    // Simple connectivity check
    // In production, use connectivity_plus package
    return true; // Assume online for now
  }
}
