/// Task Repository Interface
/// Educational Project - Gamified Task Management App
///
/// Abstract repository for task operations

import '../models/task_model.dart';
import '../models/category_model.dart';

abstract class TaskRepository {
  /// Get all tasks for current user
  Future<List<TaskModel>> getTasks();

  /// Get tasks by status
  Future<List<TaskModel>> getTasksByStatus(TaskStatus status);

  /// Get tasks by category
  Future<List<TaskModel>> getTasksByCategory(String category);

  /// Get overdue tasks
  Future<List<TaskModel>> getOverdueTasks();

  /// Get tasks due today
  Future<List<TaskModel>> getTasksDueToday();

  /// Search tasks by title or description
  Future<List<TaskModel>> searchTasks(String query);

  /// Get single task by ID
  Future<TaskModel?> getTaskById(String taskId);

  /// Create new task
  Future<TaskModel> createTask(TaskModel task);

  /// Update existing task
  Future<TaskModel> updateTask(TaskModel task);

  /// Delete task
  Future<void> deleteTask(String taskId);

  /// Mark task as completed
  Future<TaskModel> completeTask(String taskId);

  /// Sync tasks with remote (offline-first)
  Future<void> syncTasks();

  /// Check if online
  bool isOnline();
}

/// Category Repository Interface
abstract class CategoryRepository {
  /// Get all categories for current user
  Future<List<CategoryModel>> getCategories();

  /// Create new category
  Future<CategoryModel> createCategory(CategoryModel category);

  /// Update category
  Future<CategoryModel> updateCategory(CategoryModel category);

  /// Delete category
  Future<void> deleteCategory(String categoryId);

  /// Get predefined categories
  List<CategoryModel> getPredefinedCategories();
}
