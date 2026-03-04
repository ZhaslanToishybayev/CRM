/// Task Model for Supabase
/// Educational Project - Gamified Task Management App

import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

enum TaskPriority { low, medium, high }

@JsonSerializable()
class TaskModel {
  /// Convert int to priority enum
  static TaskPriority _intToPriority(int priority) {
    switch (priority) {
      case 1:
        return TaskPriority.low;
      case 2:
        return TaskPriority.medium;
      case 3:
        return TaskPriority.high;
      default:
        return TaskPriority.medium;
    }
  }

  /// MongoDB ObjectId (optional for backward compatibility)
  final String? sId;
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'user_id')
  final String userId;
  final String title;
  final String description;
  final TaskPriority priority;
  final String category;
  @JsonKey(name: 'due_date')
  final DateTime? dueDate;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'is_completed')
  final bool isCompleted;

  /// Get effective ID (use sId if id is null, otherwise use id)
  String get effectiveId => sId ?? id ?? '';

  TaskModel({
    this.sId,
    this.id,
    required this.userId,
    required this.title,
    this.description = '',
    this.priority = TaskPriority.medium,
    this.category = 'General',
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    this.isCompleted = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    // Support both old (is_completed) and new (status) formats
    bool completed = false;
    if (json.containsKey('status')) {
      completed = json['status'] == 'completed';
    } else {
      completed = json['is_completed'] ?? false;
    }

    // Support both int and string priority
    TaskPriority priority = TaskPriority.medium;
    if (json['priority'] is int) {
      priority = _intToPriority(json['priority']);
    } else {
      priority = TaskPriority.values.firstWhere(
        (p) => p.toString().split('.').last == json['priority'],
        orElse: () => TaskPriority.medium,
      );
    }

    return TaskModel(
      sId: json['_id'],
      id: json['id'],
      userId: json['user_id'] ?? 'demo-user',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      priority: priority,
      category: json['category'] ?? 'General',
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      isCompleted: completed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'priority': priority.toString().split('.').last,
      'category': category,
      'due_date': dueDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_completed': isCompleted,
    };
  }

  /// Convert to JSON for Supabase database (maps to schema)
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'priority': _priorityToInt(priority),
      'status': isCompleted ? 'completed' : 'pending',
      'category': category,
      'due_date': dueDate?.toIso8601String(),
      'completed_at': isCompleted ? DateTime.now().toIso8601String() : null,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Convert priority enum to int
  static int _priorityToInt(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return 1;
      case TaskPriority.medium:
        return 2;
      case TaskPriority.high:
        return 3;
    }
  }

  TaskModel copyWith({
    String? sId,
    String? id,
    String? userId,
    String? title,
    String? description,
    TaskPriority? priority,
    String? category,
    DateTime? dueDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isCompleted,
  }) {
    return TaskModel(
      sId: sId ?? this.sId,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Create a new task with auto-generated ID
  factory TaskModel.create({
    required String userId,
    required String title,
    String description = '',
    TaskPriority priority = TaskPriority.medium,
    String category = 'General',
    DateTime? dueDate,
  }) {
    return TaskModel(
      id: '', // Will be generated by database
      userId: userId,
      title: title,
      description: description,
      priority: priority,
      category: category,
      dueDate: dueDate,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isCompleted: false,
    );
  }

  @override
  String toString() {
    return 'TaskModel(id: $effectiveId, title: $title, priority: $priority, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
