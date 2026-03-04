import 'package:freezed_annotation/freezed_annotation.dart';

part 'crm_task_model.freezed.dart';
part 'crm_task_model.g.dart';

@freezed
class CrmTaskModel with _$CrmTaskModel {
  const factory CrmTaskModel({
    required String id,
    required String title,
    String? description,

    // Relations
    required String clientId,
    String? clientName,
    String? companyId,
    String? companyName,
    String? dealId,
    String? dealName,

    // Task details
    required TaskType type,
    TaskPriority? priority,
    TaskStatus? status,

    // Dates
    DateTime? dueDate,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,

    // Assignment
    String? assignedTo,
    String? assignedToName,
    required String createdBy,

    // Reminders
    @Default([]) List<DateTime> reminders,

    // Notes and tags
    String? notes,
    @Default([]) List<String> tags,
    Map<String, dynamic>? customFields,
  }) = _CrmTaskModel;

  factory CrmTaskModel.fromJson(Map<String, dynamic> json) =>
      _$CrmTaskModelFromJson(json);
}

enum TaskType {
  call,
  email,
  meeting,
  followUp,
  demo,
  proposal,
  contract,
  support,
  other,
}

enum TaskPriority {
  low,
  medium,
  high,
  urgent,
}

enum TaskStatus {
  pending,
  inProgress,
  completed,
  cancelled,
  overdue,
}

extension TaskTypeExtension on TaskType {
  String get displayName {
    switch (this) {
      case TaskType.call:
        return 'Phone Call';
      case TaskType.email:
        return 'Email';
      case TaskType.meeting:
        return 'Meeting';
      case TaskType.followUp:
        return 'Follow Up';
      case TaskType.demo:
        return 'Demo';
      case TaskType.proposal:
        return 'Proposal';
      case TaskType.contract:
        return 'Contract';
      case TaskType.support:
        return 'Support';
      case TaskType.other:
        return 'Other';
    }
  }

  String get iconName {
    switch (this) {
      case TaskType.call:
        return 'phone';
      case TaskType.email:
        return 'email';
      case TaskType.meeting:
        return 'event';
      case TaskType.followUp:
        return 'schedule';
      case TaskType.demo:
        return 'tv';
      case TaskType.proposal:
        return 'description';
      case TaskType.contract:
        return 'assignment';
      case TaskType.support:
        return 'support_agent';
      case TaskType.other:
        return 'task_alt';
    }
  }
}

extension TaskPriorityExtension on TaskPriority {
  String get displayName {
    switch (this) {
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

  String get color {
    switch (this) {
      case TaskPriority.low:
        return '0xFF9E9E9E'; // Grey
      case TaskPriority.medium:
        return '0xFFFFB74D'; // Orange
      case TaskPriority.high:
        return '0xFFFF9800'; // Deep Orange
      case TaskPriority.urgent:
        return '0xFFF44336'; // Red
    }
  }
}

extension TaskStatusExtension on TaskStatus {
  String get displayName {
    switch (this) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.cancelled:
        return 'Cancelled';
      case TaskStatus.overdue:
        return 'Overdue';
    }
  }

  String get color {
    switch (this) {
      case TaskStatus.pending:
        return '0xFF9E9E9E'; // Grey
      case TaskStatus.inProgress:
        return '0xFF2196F3'; // Blue
      case TaskStatus.completed:
        return '0xFF4CAF50'; // Green
      case TaskStatus.cancelled:
        return '0xFF757575'; // Dark Grey
      case TaskStatus.overdue:
        return '0xFFF44336'; // Red
    }
  }
}
