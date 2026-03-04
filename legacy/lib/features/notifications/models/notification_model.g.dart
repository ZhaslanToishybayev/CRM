// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      priority: $enumDecode(_$NotificationPriorityEnumMap, json['priority']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool,
      userId: json['userId'] as String?,
      actionUrl: json['actionUrl'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      iconUrl: json['iconUrl'] as String?,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'priority': _$NotificationPriorityEnumMap[instance.priority]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
      'userId': instance.userId,
      'actionUrl': instance.actionUrl,
      'data': instance.data,
      'iconUrl': instance.iconUrl,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.achievement: 'achievement',
  NotificationType.taskReminder: 'taskReminder',
  NotificationType.teamUpdate: 'teamUpdate',
  NotificationType.levelUp: 'levelUp',
  NotificationType.systemAlert: 'systemAlert',
  NotificationType.dailyDigest: 'dailyDigest',
  NotificationType.weeklyReport: 'weeklyReport',
};

const _$NotificationPriorityEnumMap = {
  NotificationPriority.low: 'low',
  NotificationPriority.medium: 'medium',
  NotificationPriority.high: 'high',
  NotificationPriority.urgent: 'urgent',
};
