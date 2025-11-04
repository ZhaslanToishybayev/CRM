/// Project Model
/// Represents a project within an organization/team

import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_model.freezed.dart';
part 'project_model.g.dart';

/// Project status
enum ProjectStatus {
  planning,    // Project is being planned
  active,      // Project is actively being worked on
  onHold,      // Project is temporarily paused
  completed,   // Project is completed
  cancelled,   // Project was cancelled
}

/// Project priority
enum ProjectPriority {
  low,
  medium,
  high,
  critical,
}

@freezed
class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    required String id,
    required String name,
    required String organizationId,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,

    // Project details
    String? description,
    String? icon,
    String? color, // Hex color for UI

    // Team and department
    String? teamId,
    String? departmentId,

    // Dates
    DateTime? startDate,
    DateTime? endDate,
    DateTime? dueDate,

    // Status and priority
    @Default(ProjectStatus.planning) ProjectStatus status,
    @Default(ProjectPriority.medium) ProjectPriority priority,

    // Metrics
    @Default(0) int totalTasks,
    @Default(0) int completedTasks,
    @Default(0) int totalBudget,
    @Default(0) int spentBudget,

    // Team members
    @Default([]) List<String> memberIds,

    // Completion percentage (calculated)
    @Default(0) int completionPercentage,
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  /// Create a copy with updated fields
  ProjectModel copyWith({
    String? id,
    String? name,
    String? organizationId,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    String? icon,
    String? color,
    String? teamId,
    String? departmentId,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? dueDate,
    ProjectStatus? status,
    ProjectPriority? priority,
    int? totalTasks,
    int? completedTasks,
    int? totalBudget,
    int? spentBudget,
    List<String>? memberIds,
    int? completionPercentage,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      organizationId: organizationId ?? this.organizationId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      teamId: teamId ?? this.teamId,
      departmentId: departmentId ?? this.departmentId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      totalTasks: totalTasks ?? this.totalTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      totalBudget: totalBudget ?? this.totalBudget,
      spentBudget: spentBudget ?? this.spentBudget,
      memberIds: memberIds ?? this.memberIds,
      completionPercentage: completionPercentage ?? this.completionPercentage,
    );
  }

  /// Calculate completion percentage based on tasks
  double calculateCompletion() {
    if (totalTasks == 0) return 0.0;
    return (completedTasks / totalTasks) * 100;
  }

  /// Check if project is overdue
  bool get isOverdue {
    if (dueDate == null) return false;
    return DateTime.now().isAfter(dueDate!) && status != ProjectStatus.completed;
  }

  /// Check if project is due soon (within 7 days)
  bool get isDueSoon {
    if (dueDate == null) return false;
    final now = DateTime.now();
    final sevenDaysFromNow = now.add(Duration(days: 7));
    return dueDate!.isBefore(sevenDaysFromNow) && dueDate!.isAfter(now);
  }
}

/// Helper extensions for ProjectModel
extension ProjectModelExtensions on ProjectModel {
  /// Get display name
  String get displayName => name;

  /// Get status display name
  String get statusDisplayName {
    switch (status) {
      case ProjectStatus.planning:
        return 'Planning';
      case ProjectStatus.active:
        return 'Active';
      case ProjectStatus.onHold:
        return 'On Hold';
      case ProjectStatus.completed:
        return 'Completed';
      case ProjectStatus.cancelled:
        return 'Cancelled';
    }
  }

  /// Get status display name in Russian
  String get statusDisplayNameRu {
    switch (status) {
      case ProjectStatus.planning:
        return 'Планирование';
      case ProjectStatus.active:
        return 'В работе';
      case ProjectStatus.onHold:
        return 'Приостановлен';
      case ProjectStatus.completed:
        return 'Завершен';
      case ProjectStatus.cancelled:
        return 'Отменен';
    }
  }

  /// Get priority display name
  String get priorityDisplayName {
    switch (priority) {
      case ProjectPriority.low:
        return 'Low';
      case ProjectPriority.medium:
        return 'Medium';
      case ProjectPriority.high:
        return 'High';
      case ProjectPriority.critical:
        return 'Critical';
    }
  }

  /// Get priority display name in Russian
  String get priorityDisplayNameRu {
    switch (priority) {
      case ProjectPriority.low:
        return 'Низкий';
      case ProjectPriority.medium:
        return 'Средний';
      case ProjectPriority.high:
        return 'Высокий';
      case ProjectPriority.critical:
        return 'Критический';
    }
  }

  /// Get color for status
  String get statusColor {
    switch (status) {
      case ProjectStatus.planning:
        return '#9E9E9E'; // Gray
      case ProjectStatus.active:
        return '#2196F3'; // Blue
      case ProjectStatus.onHold:
        return '#FFC107'; // Amber
      case ProjectStatus.completed:
        return '#4CAF50'; // Green
      case ProjectStatus.cancelled:
        return '#F44336'; // Red
    }
  }

  /// Get color for priority
  String get priorityColor {
    switch (priority) {
      case ProjectPriority.low:
        return '#2196F3'; // Blue
      case ProjectPriority.medium:
        return '#FF9800'; // Orange
      case ProjectPriority.high:
        return '#F44336'; // Red
      case ProjectPriority.critical:
        return '#B71C1C'; // Deep Red
    }
  }
}
