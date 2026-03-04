// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CrmNotificationModelImpl _$$CrmNotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CrmNotificationModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      type: $enumDecode(_$CrmNotificationTypeEnumMap, json['type']),
      priority: $enumDecode(_$CrmNotificationPriorityEnumMap, json['priority']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool,
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
      clientId: json['clientId'] as String?,
      dealId: json['dealId'] as String?,
      taskId: json['taskId'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$$CrmNotificationModelImplToJson(
        _$CrmNotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'type': _$CrmNotificationTypeEnumMap[instance.type]!,
      'priority': _$CrmNotificationPriorityEnumMap[instance.priority]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
      'readAt': instance.readAt?.toIso8601String(),
      'metadata': instance.metadata,
      'clientId': instance.clientId,
      'dealId': instance.dealId,
      'taskId': instance.taskId,
      'userId': instance.userId,
    };

const _$CrmNotificationTypeEnumMap = {
  CrmNotificationType.dealCreated: 'dealCreated',
  CrmNotificationType.dealUpdated: 'dealUpdated',
  CrmNotificationType.dealWon: 'dealWon',
  CrmNotificationType.dealLost: 'dealLost',
  CrmNotificationType.taskAssigned: 'taskAssigned',
  CrmNotificationType.taskCompleted: 'taskCompleted',
  CrmNotificationType.taskOverdue: 'taskOverdue',
  CrmNotificationType.clientCreated: 'clientCreated',
  CrmNotificationType.clientUpdated: 'clientUpdated',
  CrmNotificationType.meetingScheduled: 'meetingScheduled',
  CrmNotificationType.followUpDue: 'followUpDue',
  CrmNotificationType.pipelineStageChanged: 'pipelineStageChanged',
  CrmNotificationType.activityLog: 'activityLog',
  CrmNotificationType.reminder: 'reminder',
  CrmNotificationType.system: 'system',
};

const _$CrmNotificationPriorityEnumMap = {
  CrmNotificationPriority.low: 'low',
  CrmNotificationPriority.normal: 'normal',
  CrmNotificationPriority.high: 'high',
  CrmNotificationPriority.urgent: 'urgent',
};
