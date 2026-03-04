/// Notification Service
/// Main service for managing all types of notifications

import 'package:supabase_flutter/supabase_flutter.dart';
import 'push_notification_service.dart';
import 'email_notification_service.dart';
import '../models/notification_model.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final SupabaseClient _supabase = SupabaseConfig.client;

  /// Initialize all notification services
  Future<void> initialize() async {
    // Initialize push notifications
    await PushNotificationService.initializeLocalNotifications();
    await PushNotificationService.initialize();

    print('✅ Notification service initialized');
  }

  /// Send push notification
  Future<void> sendPushNotification({
    required String userId,
    required String title,
    required String message,
    NotificationType type = NotificationType.systemAlert,
  }) async {
    // Create notification in database
    await _supabase.from('notifications').insert({
      'user_id': userId,
      'title': title,
      'message': message,
      'type': type.name,
      'is_read': false,
      'created_at': DateTime.now().toIso8601String(),
    });

    // Send FCM message (would need server-side implementation)
    print('📱 Push notification sent: $title');
  }

  /// Send email notification
  Future<void> sendEmailNotification({
    required String email,
    required String subject,
    required String htmlContent,
  }) async {
    // Would implement actual email sending
    print('📧 Email notification sent: $subject');
  }

  /// Trigger gamification notifications
  Future<void> triggerAchievementNotification({
    required String userId,
    required String achievementName,
  }) async {
    final user = await _supabase
        .from('user_stats')
        .select()
        .eq('id', userId)
        .single();

    await sendPushNotification(
      userId: userId,
      title: 'Achievement Unlocked!',
      message: 'You earned the "$achievementName" badge',
      type: NotificationType.achievement,
    );

    await EmailNotificationService.sendAchievementEmail(
      recipientEmail: user['email'],
      username: user['username'],
      achievementName: achievementName,
    );
  }

  /// Trigger task reminder
  Future<void> triggerTaskReminder({
    required String userId,
    required String taskTitle,
    required DateTime dueDate,
  }) async {
    final user = await _supabase
        .from('user_stats')
        .select()
        .eq('id', userId)
        .single();

    await sendPushNotification(
      userId: userId,
      title: 'Task Reminder',
      message: 'Complete: $taskTitle',
      type: NotificationType.taskReminder,
    );
  }

  /// Trigger level up notification
  Future<void> triggerLevelUpNotification({
    required String userId,
    required int newLevel,
  }) async {
    final user = await _supabase
        .from('user_stats')
        .select()
        .eq('id', userId)
        .single();

    await sendPushNotification(
      userId: userId,
      title: 'Level Up!',
      message: 'Congratulations! You reached Level $newLevel',
      type: NotificationType.levelUp,
    );
  }

  /// Get user notifications
  Future<List<NotificationModel>> getUserNotifications(String userId) async {
    final response = await _supabase
        .from('notifications')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((json) {
      return NotificationModel.fromJson(json as Map<String, dynamic>);
    }).toList();
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    await _supabase
        .from('notifications')
        .update({'is_read': true})
        .eq('id', notificationId);
  }
}
