/// Notification Settings Model
/// User notification preferences

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings_model.freezed.dart';
part 'notification_settings_model.g.dart';

@freezed
class NotificationSettingsModel with _$NotificationSettingsModel {
  const factory NotificationSettingsModel({
    required String userId,
    required bool pushEnabled,
    required bool emailEnabled,
    required bool inAppEnabled,
    required Map<NotificationType, bool> typeSettings,
    required bool quietHoursEnabled,
    DateTime? quietHoursStart,
    DateTime? quietHoursEnd,
  }) = _NotificationSettingsModel;

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsModelFromJson(json);
}

enum NotificationType {
  achievement,
  taskReminder,
  teamUpdate,
  levelUp,
  systemAlert,
  dailyDigest,
  weeklyReport,
}
