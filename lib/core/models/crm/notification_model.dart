import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class CrmNotificationModel with _$CrmNotificationModel {
  const factory CrmNotificationModel({
    required String id,
    required String title,
    required String message,
    required CrmNotificationType type,
    required CrmNotificationPriority priority,
    required DateTime createdAt,
    required bool isRead,
    DateTime? readAt,
    Map<String, dynamic>? metadata,
    String? clientId,
    String? dealId,
    String? taskId,
    String? userId,
  }) = _CrmNotificationModel;

  factory CrmNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$CrmNotificationModelFromJson(json);
}

enum CrmNotificationType {
  dealCreated,
  dealUpdated,
  dealWon,
  dealLost,
  taskAssigned,
  taskCompleted,
  taskOverdue,
  clientCreated,
  clientUpdated,
  meetingScheduled,
  followUpDue,
  pipelineStageChanged,
  activityLog,
  reminder,
  system,
}

enum CrmNotificationPriority {
  low,
  normal,
  high,
  urgent,
}

extension CrmNotificationTypeExtension on CrmNotificationType {
  String get displayName {
    switch (this) {
      case CrmNotificationType.dealCreated:
        return 'Deal Created';
      case CrmNotificationType.dealUpdated:
        return 'Deal Updated';
      case CrmNotificationType.dealWon:
        return 'Deal Won';
      case CrmNotificationType.dealLost:
        return 'Deal Lost';
      case CrmNotificationType.taskAssigned:
        return 'Task Assigned';
      case CrmNotificationType.taskCompleted:
        return 'Task Completed';
      case CrmNotificationType.taskOverdue:
        return 'Task Overdue';
      case CrmNotificationType.clientCreated:
        return 'Client Created';
      case CrmNotificationType.clientUpdated:
        return 'Client Updated';
      case CrmNotificationType.meetingScheduled:
        return 'Meeting Scheduled';
      case CrmNotificationType.followUpDue:
        return 'Follow Up Due';
      case CrmNotificationType.pipelineStageChanged:
        return 'Pipeline Stage Changed';
      case CrmNotificationType.activityLog:
        return 'Activity Log';
      case CrmNotificationType.reminder:
        return 'Reminder';
      case CrmNotificationType.system:
        return 'System';
    }
  }

  String get iconName {
    switch (this) {
      case CrmNotificationType.dealCreated:
      case CrmNotificationType.dealUpdated:
      case CrmNotificationType.dealWon:
      case CrmNotificationType.dealLost:
      case CrmNotificationType.pipelineStageChanged:
        return 'trending_up';
      case CrmNotificationType.taskAssigned:
      case CrmNotificationType.taskCompleted:
      case CrmNotificationType.taskOverdue:
      case CrmNotificationType.reminder:
        return 'task';
      case CrmNotificationType.clientCreated:
      case CrmNotificationType.clientUpdated:
        return 'person';
      case CrmNotificationType.meetingScheduled:
        return 'event';
      case CrmNotificationType.followUpDue:
        return 'schedule';
      case CrmNotificationType.activityLog:
        return 'history';
      case CrmNotificationType.system:
        return 'settings';
    }
  }
}

extension CrmNotificationPriorityExtension on CrmNotificationPriority {
  String get displayName {
    switch (this) {
      case CrmNotificationPriority.low:
        return 'Low';
      case CrmNotificationPriority.normal:
        return 'Normal';
      case CrmNotificationPriority.high:
        return 'High';
      case CrmNotificationPriority.urgent:
        return 'Urgent';
    }
  }

  int get value {
    switch (this) {
      case CrmNotificationPriority.low:
        return 1;
      case CrmNotificationPriority.normal:
        return 2;
      case CrmNotificationPriority.high:
        return 3;
      case CrmNotificationPriority.urgent:
        return 4;
    }
  }

  Color get color {
    switch (this) {
      case CrmNotificationPriority.low:
        return Colors.grey;
      case CrmNotificationPriority.normal:
        return Colors.blue;
      case CrmNotificationPriority.high:
        return Colors.orange;
      case CrmNotificationPriority.urgent:
        return Colors.red;
    }
  }
}
