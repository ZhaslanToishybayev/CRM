/// Notification Model
/// Represents a notification in the system

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String title,
    required String message,
    required NotificationType type,
    required NotificationPriority priority,
    required DateTime createdAt,
    required bool isRead,
    String? userId,
    String? actionUrl,
    Map<String, dynamic>? data,
    String? iconUrl,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
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

enum NotificationPriority {
  low,
  medium,
  high,
  urgent,
}
