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
  inProgress,
  completed,
  cancelled,
}

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String userId,
    required String title,
    String? description,
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

  /// Convert to JSON for database (maps to Supabase schema)
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description ?? '',
      'category': category ?? 'General',
      'priority': _priorityToInt(priority),
      'status': _statusToString(status),
      'due_date': dueDate?.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Convert priority enum to int
  int _priorityToInt(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return 1;
      case TaskPriority.medium:
        return 2;
      case TaskPriority.high:
        return 3;
      case TaskPriority.urgent:
        return 3; // Map urgent to highest priority
    }
  }

  /// Convert status enum to string
  String _statusToString(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return 'pending';
      case TaskStatus.inProgress:
        return 'in_progress';
      case TaskStatus.completed:
        return 'completed';
      case TaskStatus.cancelled:
        return 'cancelled';
    }
  }
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
