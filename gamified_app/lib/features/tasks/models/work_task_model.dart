/// Work Task Model
/// Extended TaskModel for corporate/organizational use
/// Represents a task entity with corporate properties

import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_task_model.freezed.dart';
part 'work_task_model.g.dart';

/// Task type based on work context
enum WorkTaskType {
  personal,  // Personal task
  project,   // Project task
  team,      // Team task
}

/// Task source - how the task was created
enum WorkTaskSource {
  manual,    // Created manually in app
  email,     // Created from email
  calendar,  // Created from calendar
  slack,     // Created from Slack message
  manager,   // Assigned by manager
}

/// Task progress status
enum WorkTaskProgress {
  notStarted,
  inProgress,
  review,
  completed,
}

/// Task priority levels (extended)
enum WorkTaskPriority {
  low,
  medium,
  high,
  urgent,
  critical,
}

@freezed
class WorkTaskModel with _$WorkTaskModel {
  const factory WorkTaskModel({
    required String id,
    required String userId,
    required String title,
    String? description,
    required int xp,
    required WorkTaskPriority priority,
    required WorkTaskProgress progress,
    DateTime? dueDate,
    DateTime? startDate,
    String? category,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,

    // 🆕 Corporate fields
    required String organizationId,
    String? projectId,           // Associated project
    String? departmentId,        // Department
    String? teamId,              // Team responsible

    // Assignment
    String? assignedBy,          // Who assigned this task
    List<String>? assignedTo,    // Who should complete this (multiple people)
    String? assigneeNote,        // Note from assignee

    // Task metadata
    required WorkTaskType type,  // Type of task
    required WorkTaskSource source, // How task was created
    int? estimatedHours,         // Estimated time to complete
    int? actualHours,            // Actual time spent
    bool billable,               // Whether task is billable
    String? parentTaskId,        // For subtasks
    @Default([]) List<String> subtaskIds, // IDs of subtasks

    // Quality and rating
    int? qualityRating,          // Rating 1-5 from manager
    String? managerFeedback,     // Feedback from manager

    // Tracking
    @Default(0) int timeSpent,   // Minutes spent
    DateTime? lastActivityAt,    // Last time someone worked on this

    // Collaboration
    @Default([]) List<String> watcherIds, // People to notify of changes
    @Default([]) List<String> commentIds, // Comments on task
  }) = _WorkTaskModel;

  factory WorkTaskModel.fromJson(Map<String, dynamic> json) =>
      _$WorkTaskModelFromJson(json);

  /// Create a copy with updated fields
  WorkTaskModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    int? xp,
    WorkTaskPriority? priority,
    WorkTaskProgress? progress,
    DateTime? dueDate,
    DateTime? startDate,
    String? category,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? organizationId,
    String? projectId,
    String? departmentId,
    String? teamId,
    String? assignedBy,
    List<String>? assignedTo,
    String? assigneeNote,
    WorkTaskType? type,
    WorkTaskSource? source,
    int? estimatedHours,
    int? actualHours,
    bool? billable,
    String? parentTaskId,
    List<String>? subtaskIds,
    int? qualityRating,
    String? managerFeedback,
    int? timeSpent,
    DateTime? lastActivityAt,
    List<String>? watcherIds,
    List<String>? commentIds,
  }) {
    return WorkTaskModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      xp: xp ?? this.xp,
      priority: priority ?? this.priority,
      progress: progress ?? this.progress,
      dueDate: dueDate ?? this.dueDate,
      startDate: startDate ?? this.startDate,
      category: category ?? this.category,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      organizationId: organizationId ?? this.organizationId,
      projectId: projectId ?? this.projectId,
      departmentId: departmentId ?? this.departmentId,
      teamId: teamId ?? this.teamId,
      assignedBy: assignedBy ?? this.assignedBy,
      assignedTo: assignedTo ?? this.assignedTo,
      assigneeNote: assigneeNote ?? this.assigneeNote,
      type: type ?? this.type,
      source: source ?? this.source,
      estimatedHours: estimatedHours ?? this.estimatedHours,
      actualHours: actualHours ?? this.actualHours,
      billable: billable ?? this.billable,
      parentTaskId: parentTaskId ?? this.parentTaskId,
      subtaskIds: subtaskIds ?? this.subtaskIds,
      qualityRating: qualityRating ?? this.qualityRating,
      managerFeedback: managerFeedback ?? this.managerFeedback,
      timeSpent: timeSpent ?? this.timeSpent,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
      watcherIds: watcherIds ?? this.watcherIds,
      commentIds: commentIds ?? this.commentIds,
    );
  }
}

/// Helper extensions for WorkTaskModel
extension WorkTaskModelExtensions on WorkTaskModel {
  /// Check if task is overdue
  bool get isOverdue {
    if (dueDate == null) return false;
    return DateTime.now().isAfter(dueDate!) && progress != WorkTaskProgress.completed;
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

  /// Check if task is due soon (within 2 days)
  bool get isDueSoon {
    if (dueDate == null) return false;
    final now = DateTime.now();
    final twoDaysFromNow = now.add(Duration(days: 2));
    return dueDate!.isBefore(twoDaysFromNow) && dueDate!.isAfter(now);
  }

  /// Get priority display name
  String get priorityDisplayName {
    switch (priority) {
      case WorkTaskPriority.low:
        return 'Low';
      case WorkTaskPriority.medium:
        return 'Medium';
      case WorkTaskPriority.high:
        return 'High';
      case WorkTaskPriority.urgent:
        return 'Urgent';
      case WorkTaskPriority.critical:
        return 'Critical';
    }
  }

  /// Get priority display name in Russian
  String get priorityDisplayNameRu {
    switch (priority) {
      case WorkTaskPriority.low:
        return 'Низкий';
      case WorkTaskPriority.medium:
        return 'Средний';
      case WorkTaskPriority.high:
        return 'Высокий';
      case WorkTaskPriority.urgent:
        return 'Срочный';
      case WorkTaskPriority.critical:
        return 'Критический';
    }
  }

  /// Get type display name
  String get typeDisplayName {
    switch (type) {
      case WorkTaskType.personal:
        return 'Personal';
      case WorkTaskType.project:
        return 'Project';
      case WorkTaskType.team:
        return 'Team';
    }
  }

  /// Get type display name in Russian
  String get typeDisplayNameRu {
    switch (type) {
      case WorkTaskType.personal:
        return 'Личная';
      case WorkTaskType.project:
        return 'Проектная';
      case WorkTaskType.team:
        return 'Командная';
    }
  }

  /// Get progress display name
  String get progressDisplayName {
    switch (progress) {
      case WorkTaskProgress.notStarted:
        return 'Not Started';
      case WorkTaskProgress.inProgress:
        return 'In Progress';
      case WorkTaskProgress.review:
        return 'Under Review';
      case WorkTaskProgress.completed:
        return 'Completed';
    }
  }

  /// Get progress display name in Russian
  String get progressDisplayNameRu {
    switch (progress) {
      case WorkTaskProgress.notStarted:
        return 'Не начато';
      case WorkTaskProgress.inProgress:
        return 'В работе';
      case WorkTaskProgress.review:
        return 'На проверке';
      case WorkTaskProgress.completed:
        return 'Завершено';
    }
  }

  /// Get priority color
  String get priorityColor {
    switch (priority) {
      case WorkTaskPriority.low:
        return '#2196F3'; // Blue
      case WorkTaskPriority.medium:
        return '#FF9800'; // Orange
      case WorkTaskPriority.high:
        return '#F44336'; // Red
      case WorkTaskPriority.urgent:
        return '#B71C1C'; // Deep Red
      case WorkTaskPriority.critical:
        return '#880E4F'; // Dark Purple
    }
  }

  /// Get type color
  String get typeColor {
    switch (type) {
      case WorkTaskType.personal:
        return '#9C27B0'; // Purple
      case WorkTaskType.project:
        return '#009688'; // Teal
      case WorkTaskType.team:
        return '#3F51B5'; // Indigo
    }
  }

  /// Check if user is assigned to this task
  bool isAssignedTo(String userId) {
    if (assignedTo == null) return false;
    return assignedTo!.contains(userId);
  }

  /// Check if task is a subtask
  bool get isSubtask => parentTaskId != null;

  /// Check if task has subtasks
  bool get hasSubtasks => subtaskIds.isNotEmpty;

  /// Get completion percentage based on progress
  double get completionPercentage {
    switch (progress) {
      case WorkTaskProgress.notStarted:
        return 0.0;
      case WorkTaskProgress.inProgress:
        return 0.5;
      case WorkTaskProgress.review:
        return 0.8;
      case WorkTaskProgress.completed:
        return 1.0;
    }
  }

  /// Check if task is completed
  bool get isCompleted => progress == WorkTaskProgress.completed;

  /// Check if task is in progress
  bool get isInProgress => progress == WorkTaskProgress.inProgress;

  /// Check if task is under review
  bool get isUnderReview => progress == WorkTaskProgress.review;

  /// Check if task hasn't started
  bool get notStarted => progress == WorkTaskProgress.notStarted;
}
