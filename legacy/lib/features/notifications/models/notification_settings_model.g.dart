// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationSettingsModelImpl _$$NotificationSettingsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationSettingsModelImpl(
      userId: json['userId'] as String,
      pushEnabled: json['pushEnabled'] as bool,
      emailEnabled: json['emailEnabled'] as bool,
      inAppEnabled: json['inAppEnabled'] as bool,
      typeSettings: (json['typeSettings'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry($enumDecode(_$NotificationTypeEnumMap, k), e as bool),
      ),
      quietHoursEnabled: json['quietHoursEnabled'] as bool,
      quietHoursStart: json['quietHoursStart'] == null
          ? null
          : DateTime.parse(json['quietHoursStart'] as String),
      quietHoursEnd: json['quietHoursEnd'] == null
          ? null
          : DateTime.parse(json['quietHoursEnd'] as String),
    );

Map<String, dynamic> _$$NotificationSettingsModelImplToJson(
        _$NotificationSettingsModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'pushEnabled': instance.pushEnabled,
      'emailEnabled': instance.emailEnabled,
      'inAppEnabled': instance.inAppEnabled,
      'typeSettings': instance.typeSettings
          .map((k, e) => MapEntry(_$NotificationTypeEnumMap[k]!, e)),
      'quietHoursEnabled': instance.quietHoursEnabled,
      'quietHoursStart': instance.quietHoursStart?.toIso8601String(),
      'quietHoursEnd': instance.quietHoursEnd?.toIso8601String(),
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
