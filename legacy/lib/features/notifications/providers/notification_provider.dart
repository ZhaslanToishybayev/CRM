/// Notification Provider
/// Manages notification state using Riverpod

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/notification_model.dart';
import '../models/notification_settings_model.dart';

part 'notification_provider.g.dart';

@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  @override
  List<NotificationModel> build() {
    // Initialize with mock notifications
    return _getMockNotifications();
  }

  /// Add a new notification
  void addNotification(NotificationModel notification) {
    state = [notification, ...state];
  }

  /// Mark notification as read
  void markAsRead(String id) {
    state = [
      for (final notification in state)
        if (notification.id == id)
          notification.copyWith(isRead: true)
        else
          notification,
    ];
  }

  /// Mark all notifications as read
  void markAllAsRead() {
    state = [
      for (final notification in state) notification.copyWith(isRead: true),
    ];
  }

  /// Delete notification
  void deleteNotification(String id) {
    state = state.where((n) => n.id != id).toList();
  }

  /// Clear all notifications
  void clearAll() {
    state = [];
  }

  /// Get unread count
  int get unreadCount => state.where((n) => !n.isRead).length;
}

@Riverpod(keepAlive: true)
class NotificationSettingsNotifier extends _$NotificationSettingsNotifier {
  @override
  NotificationSettingsModel build() {
    return NotificationSettingsModel(
      userId: 'user1',
      pushEnabled: true,
      emailEnabled: true,
      inAppEnabled: true,
      typeSettings: {
        NotificationType.achievement: true,
        NotificationType.taskReminder: true,
        NotificationType.teamUpdate: true,
        NotificationType.levelUp: true,
        NotificationType.systemAlert: true,
        NotificationType.dailyDigest: false,
        NotificationType.weeklyReport: false,
      },
      quietHoursEnabled: false,
    );
  }

  /// Update push notification setting
  void updatePushEnabled(bool enabled) {
    state = state.copyWith(pushEnabled: enabled);
  }

  /// Update email notification setting
  void updateEmailEnabled(bool enabled) {
    state = state.copyWith(emailEnabled: enabled);
  }

  /// Update in-app notification setting
  void updateInAppEnabled(bool enabled) {
    state = state.copyWith(inAppEnabled: enabled);
  }

  /// Update notification type setting
  void updateTypeSetting(NotificationType type, bool enabled) {
    state = state.copyWith(
      typeSettings: {...state.typeSettings, type: enabled},
    );
  }

  /// Update quiet hours
  void updateQuietHours({
    required bool enabled,
    DateTime? start,
    DateTime? end,
  }) {
    state = state.copyWith(
      quietHoursEnabled: enabled,
      quietHoursStart: start,
      quietHoursEnd: end,
    );
  }
}

List<NotificationModel> _getMockNotifications() {
  return [
    NotificationModel(
      id: '1',
      title: 'Achievement Unlocked!',
      message: 'You earned the "Task Master" badge',
      type: NotificationType.achievement,
      priority: NotificationPriority.medium,
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: false,
      userId: 'user1',
    ),
    NotificationModel(
      id: '2',
      title: 'Task Reminder',
      message: 'Complete your daily review',
      type: NotificationType.taskReminder,
      priority: NotificationPriority.high,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: false,
      userId: 'user1',
    ),
    NotificationModel(
      id: '3',
      title: 'Level Up!',
      message: 'Congratulations! You reached Level 5',
      type: NotificationType.levelUp,
      priority: NotificationPriority.high,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
      userId: 'user1',
    ),
  ];
}
