import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/crm/notification_model.dart';

part 'crm_notification_service.g.dart';

class CrmNotificationService {
  late final SupabaseClient _supabase;

  CrmNotificationService() {
    _supabase = Supabase.instance.client;
  }

  // Create a new notification
  Future<CrmNotificationModel> createNotification(CrmNotificationModel notification) async {
    try {
      final response = await _supabase
          .from('crm_notifications')
          .insert(notification.toJson())
          .select()
          .single();

      return CrmNotificationModel.fromJson(response);
    } catch (e) {
      print('Error creating notification: $e');
      rethrow;
    }
  }

  // Get all notifications for current user
  Future<List<CrmNotificationModel>> getNotifications({int limit = 50}) async {
    try {
      final response = await _supabase
          .from('crm_notifications')
          .select()
          .order('created_at', ascending: false)
          .limit(limit);

      return (response as List)
          .map((json) => CrmNotificationModel.fromJson(json))
          .toList();
    } catch (e) {
      print('Error getting notifications: $e');
      return [];
    }
  }

  // Get unread notifications
  Future<List<CrmNotificationModel>> getUnreadNotifications() async {
    try {
      final response = await _supabase
          .from('crm_notifications')
          .select()
          .eq('is_read', false)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => CrmNotificationModel.fromJson(json))
          .toList();
    } catch (e) {
      print('Error getting unread notifications: $e');
      return [];
    }
  }

  // Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _supabase
          .from('crm_notifications')
          .update({
            'is_read': true,
            'read_at': DateTime.now().toIso8601String(),
          })
          .eq('id', notificationId);
    } catch (e) {
      print('Error marking notification as read: $e');
      rethrow;
    }
  }

  // Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      await _supabase
          .from('crm_notifications')
          .update({
            'is_read': true,
            'read_at': DateTime.now().toIso8601String(),
          })
          .eq('is_read', false);
    } catch (e) {
      print('Error marking all notifications as read: $e');
      rethrow;
    }
  }

  // Delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _supabase
          .from('crm_notifications')
          .delete()
          .eq('id', notificationId);
    } catch (e) {
      print('Error deleting notification: $e');
      rethrow;
    }
  }

  // Delete all read notifications
  Future<void> deleteAllRead() async {
    try {
      await _supabase
          .from('crm_notifications')
          .delete()
          .eq('is_read', true);
    } catch (e) {
      print('Error deleting read notifications: $e');
      rethrow;
    }
  }

  // Get unread count
  Future<int> getUnreadCount() async {
    try {
      final response = await _supabase
          .from('crm_notifications')
          .select('id')
          .eq('is_read', false);

      return response.length;
    } catch (e) {
      print('Error getting unread count: $e');
      return 0;
    }
  }

  // Auto-create notifications based on events
  Future<void> notifyDealCreated(String dealId, String dealTitle) async {
    await createNotification(
      CrmNotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'New Deal Created',
        message: 'Deal "$dealTitle" has been created',
        type: CrmNotificationType.dealCreated,
        priority: CrmNotificationPriority.normal,
        createdAt: DateTime.now(),
        isRead: false,
        dealId: dealId,
        metadata: {'deal_title': dealTitle},
      ),
    );
  }

  Future<void> notifyDealWon(String dealId, String dealTitle, double amount) async {
    await createNotification(
      CrmNotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Deal Won!',
        message: 'Congratulations! Deal "$dealTitle" worth \$${amount.toStringAsFixed(0)} has been won',
        type: CrmNotificationType.dealWon,
        priority: CrmNotificationPriority.high,
        createdAt: DateTime.now(),
        isRead: false,
        dealId: dealId,
        metadata: {
          'deal_title': dealTitle,
          'amount': amount,
        },
      ),
    );
  }

  Future<void> notifyTaskAssigned(String taskId, String taskTitle) async {
    await createNotification(
      CrmNotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'New Task Assigned',
        message: 'You have been assigned to task "$taskTitle"',
        type: CrmNotificationType.taskAssigned,
        priority: CrmNotificationPriority.normal,
        createdAt: DateTime.now(),
        isRead: false,
        taskId: taskId,
        metadata: {'task_title': taskTitle},
      ),
    );
  }

  Future<void> notifyTaskOverdue(String taskId, String taskTitle) async {
    await createNotification(
      CrmNotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Task Overdue',
        message: 'Task "$taskTitle" is overdue and requires attention',
        type: CrmNotificationType.taskOverdue,
        priority: CrmNotificationPriority.urgent,
        createdAt: DateTime.now(),
        isRead: false,
        taskId: taskId,
        metadata: {'task_title': taskTitle},
      ),
    );
  }

  Future<void> notifyFollowUpDue(String clientId, String clientName) async {
    await createNotification(
      CrmNotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Follow-up Due',
        message: 'Follow-up is due for client "$clientName"',
        type: CrmNotificationType.followUpDue,
        priority: CrmNotificationPriority.high,
        createdAt: DateTime.now(),
        isRead: false,
        clientId: clientId,
        metadata: {'client_name': clientName},
      ),
    );
  }

  Future<void> notifyPipelineStageChanged(
    String dealId,
    String dealTitle,
    String oldStage,
    String newStage,
  ) async {
    await createNotification(
      CrmNotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Pipeline Stage Changed',
        message: 'Deal "$dealTitle" moved from "$oldStage" to "$newStage"',
        type: CrmNotificationType.pipelineStageChanged,
        priority: CrmNotificationPriority.normal,
        createdAt: DateTime.now(),
        isRead: false,
        dealId: dealId,
        metadata: {
          'deal_title': dealTitle,
          'old_stage': oldStage,
          'new_stage': newStage,
        },
      ),
    );
  }

  Future<void> notifyClientCreated(String clientId, String clientName) async {
    await createNotification(
      CrmNotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'New Client Added',
        message: 'Client "$clientName" has been added to your CRM',
        type: CrmNotificationType.clientCreated,
        priority: CrmNotificationPriority.normal,
        createdAt: DateTime.now(),
        isRead: false,
        clientId: clientId,
        metadata: {'client_name': clientName},
      ),
    );
  }

  Future<void> notifyMeetingScheduled(
    String title,
    DateTime meetingTime,
    String attendee,
  ) async {
    await createNotification(
      CrmNotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Meeting Scheduled',
        message: 'Meeting "$title" scheduled with $attendee at ${meetingTime.toLocal()}',
        type: CrmNotificationType.meetingScheduled,
        priority: CrmNotificationPriority.normal,
        createdAt: DateTime.now(),
        isRead: false,
        metadata: {
          'meeting_title': title,
          'meeting_time': meetingTime.toIso8601String(),
          'attendee': attendee,
        },
      ),
    );
  }

  Future<void> notifySystem(String title, String message) async {
    await createNotification(
      CrmNotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        message: message,
        type: CrmNotificationType.system,
        priority: CrmNotificationPriority.normal,
        createdAt: DateTime.now(),
        isRead: false,
      ),
    );
  }
}

// Riverpod provider
@Riverpod(keepAlive: true)
CrmNotificationService crmNotificationService(CrmNotificationServiceRef ref) {
  return CrmNotificationService();
}
