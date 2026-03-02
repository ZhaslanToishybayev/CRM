/// Task Model
/// Educational Project - Gamified Task Management App
///
/// Represents a task entity with all its properties

import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

/// Task priority levels
enum TaskPriority {
  low,
  medium,
  high,
  urgent,
}

/// Task status
enum TaskStatus {
  pending,
  completed,
}

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String userId,
    required String title,
    String? description,
    required int xp,
    required TaskPriority priority,
    required TaskStatus status,
    DateTime? dueDate,
    String? category,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}

/// Helper extensions for TaskModel
extension TaskModelExtensions on TaskModel {
  /// Check if task is overdue
  bool get isOverdue {
    if (dueDate == null) return false;
    return DateTime.now().isAfter(dueDate!) && status == TaskStatus.pending;
  }

  /// Check if task is due today
  bool get isDueToday {
    if (dueDate == null) return false;
    final now = DateTime.now();
    final taskDate = dueDate!;
    return taskDate.year == now.year &&
        taskDate.month == now.month &&
        taskDate.day == now.day;
  }

  /// Get priority color from AppTheme
  // Note: Color logic will be in UI layer, not here

  /// Convert priority to display name
  String get priorityDisplayName {
    switch (priority) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
      case TaskPriority.urgent:
        return 'Urgent';
    }
  }

  /// Convert status to display name
  String get statusDisplayName {
    switch (status) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.completed:
        return 'Completed';
    }
  }
}
