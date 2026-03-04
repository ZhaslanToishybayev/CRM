/// Task Data Source Interface
/// Educational Project - Gamified Task Management App
///
/// Abstract data source for task operations

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/task_model.dart';

abstract class TaskDataSource {
  /// Get all tasks from remote
  Future<List<TaskModel>> getTasks();

  /// Get single task by ID
  Future<TaskModel?> getTaskById(String taskId);

  /// Create task in remote
  Future<TaskModel> createTask(TaskModel task);

  /// Update task in remote
  Future<TaskModel> updateTask(TaskModel task);

  /// Delete task from remote
  Future<void> deleteTask(String taskId);

  /// Mark task as completed
  Future<TaskModel> completeTask(String taskId);

  /// Stream of task changes
  Stream<List<TaskModel>> watchTasks();
}

/// Local Task Data Source Interface (Hive)
abstract class LocalTaskDataSource {
  /// Get all tasks from local storage
  List<TaskModel> getTasks();

  /// Save tasks to local storage
  Future<void> saveTasks(List<TaskModel> tasks);

  /// Add single task to local storage
  Future<void> addTask(TaskModel task);

  /// Update task in local storage
  Future<void> updateTask(TaskModel task);

  /// Delete task from local storage
  Future<void> deleteTask(String taskId);

  /// Get tasks by user ID
  List<TaskModel> getTasksByUserId(String userId);

  /// Clear all tasks
  Future<void> clearTasks();
}
