/// Unified Notification Service - TEMPORARILY DISABLED
/// Combines Slack, Teams, Email, and Calendar integrations
/// Phase 4: Unified Notification System
///
/// TODO: Re-enable when integration services are implemented
/*
import '../integrations/slack_integration_service.dart';
import '../integrations/teams_integration_service.dart';
import '../integrations/email_integration_service.dart';
import '../integrations/calendar_integration_service.dart';
import '../../features/tasks/models/work_task_model.dart';
import '../../features/achievements/models/work_achievement_definitions.dart';
import 'supabase_service.dart';

class UnifiedNotificationService {
  static final UnifiedNotificationService _instance =
      UnifiedNotificationService._internal();
  factory UnifiedNotificationService() => _instance;
  UnifiedNotificationService._internal();

  final SlackIntegrationService _slack = SlackIntegrationService();
  final TeamsIntegrationService _teams = TeamsIntegrationService();
  final EmailIntegrationService _email = EmailIntegrationService();
  final CalendarIntegrationService _calendar = CalendarIntegrationService();
  final CorporateSupabaseService _supabase = CorporateSupabaseService();

  // ====================
  // INITIALIZATION
  // ====================

  Future<bool> initializeAll({
    // Slack config
    String? slackBotToken,
    String? slackWebhookUrl,

    // Teams config
    String? teamsClientId,
    String? teamsClientSecret,
    String? teamsTenantId,
    String? teamsRedirectUri,

    // Email config
    String? smtpHost,
    int? smtpPort,
    String? smtpUsername,
    String? smtpPassword,
    bool smtpUseSSL = true,

    // SendGrid config
    String? sendGridApiKey,
    String? sendGridFromEmail,
  }) async {
    print('Initializing Unified Notification Service...');
    bool allSuccess = true;

    try {
      // Initialize Slack
      if (slackBotToken != null || slackWebhookUrl != null) {
        final slackSuccess = await _slack.initialize(
          botToken: slackBotToken,
          webhookUrl: slackWebhookUrl,
        );
        print('Slack initialized: $slackSuccess');
        allSuccess &= slackSuccess;
      }
    } catch (e) {
      print('Error initializing Slack: $e');
      allSuccess = false;
    }

    try {
      // Initialize Teams
      if (teamsClientId != null && teamsClientSecret != null) {
        final teamsSuccess = await _teams.initialize(
          clientId: teamsClientId,
          clientSecret: teamsClientSecret,
          tenantId: teamsTenantId,
          redirectUri: teamsRedirectUri,
        );
        print('Teams initialized: $teamsSuccess');
        allSuccess &= teamsSuccess;
      }
    } catch (e) {
      print('Error initializing Teams: $e');
      allSuccess = false;
    }

    try {
      // Initialize Email (placeholder - email integration not implemented)
      if (smtpHost != null || sendGridApiKey != null) {
        final emailSuccess = await _email.initialize(
          smtpHost: smtpHost,
          smtpPort: smtpPort,
          smtpUsername: smtpUsername,
          smtpPassword: smtpPassword,
          smtpUseSSL: smtpUseSSL,
          sendGridApiKey: sendGridApiKey,
          sendGridFromEmail: sendGridFromEmail,
        );
        print('Email initialized: $emailSuccess');
        allSuccess &= emailSuccess;
      }
    } catch (e) {
      print('Error initializing Email: $e');
      allSuccess = false;
    }

    try {
      // Initialize Calendar (placeholder - calendar integration not implemented)
      final calendarSuccess = await _calendar.initialize();
      print('Calendar initialized: $calendarSuccess');
      allSuccess &= calendarSuccess;
    } catch (e) {
      print('Error initializing Calendar: $e');
      allSuccess = false;
    }

    print('Unified Notification Service initialization complete: $allSuccess');
    return allSuccess;
  }

  // ====================
  // TASK NOTIFICATIONS
  // ====================

  Future<void> notifyTaskCreated(WorkTaskModel task) async {
    try {
      final message = '📝 New task created: ${task.title}';
      await notifyAllChannels(message);
    } catch (e) {
      print('Error sending task created notification: $e');
    }
  }

  Future<void> notifyTaskAssigned(WorkTaskModel task) async {
    try {
      final message = '👤 Task assigned: ${task.title}\n'
          'Description: ${task.description}\n'
          'Due Date: ${task.dueDate}\n'
          'Assignee: ${task.assigneeId}';
      await notifyAllChannels(message);
    } catch (e) {
      print('Error sending task assigned notification: $e');
    }
  }

  Future<void> notifyTaskCompleted(WorkTaskModel task) async {
    try {
      final message = '✅ Task completed: ${task.title}';
      await notifyAllChannels(message);
    } catch (e) {
      print('Error sending task completed notification: $e');
    }
  }

  Future<void> notifyTaskOverdue(WorkTaskModel task) async {
    try {
      final message = '⚠️ Task overdue: ${task.title} (Due: ${task.dueDate})';
      await notifyAllChannels(message);
    } catch (e) {
      print('Error sending task overdue notification: $e');
    }
  }

  Future<void> notifyTaskDueSoon(WorkTaskModel task, DateTime dueDate) async {
    try {
      final message = '⏰ Task due soon: ${task.title} (Due: ${task.dueDate})';
      await notifyAllChannels(message);
    } catch (e) {
      print('Error sending task due soon notification: $e');
    }
  }

  Future<void> notifyTaskStatusChanged(
    WorkTaskModel task,
    String newStatus,
  ) async {
    try {
      final message = '🔄 Task status changed: ${task.title} → $newStatus';
      await notifyAllChannels(message);
    } catch (e) {
      print('Error sending task status changed notification: $e');
    }
  }

  Future<void> notifyTaskCommentAdded(
    WorkTaskModel task,
    String comment,
  ) async {
    try {
      final message = '💬 New comment on task: ${task.title}\n'
          'Comment: ${task.description}';
      await notifyAllChannels(message);
    } catch (e) {
      print('Error sending task comment notification: $e');
    }
  }

  Future<void> notifyTaskDeleted(WorkTaskModel task) async {
    try {
      final message = '🗑️ Task deleted: ${task.title}';
      await notifyAllChannels(message);
    } catch (e) {
      print('Error sending task deleted notification: $e');
    }
  }

  Future<void> notifyTaskRestored(WorkTaskModel task) async {
    try {
      final message = '♻️ Task restored: ${task.title}';
      await notifyAllChannels(message);
    } catch (e) {
      print('Error sending task restored notification: $e');
    }
  }

  // ====================
  // ACHIEVEMENT NOTIFICATIONS
  // ====================

  Future<void> notifyAchievementUnlocked(WorkAchievementDefinition achievement) async {
    try {
      final message = '🏆 Achievement unlocked: ${achievement.name}';
      await notifyAllChannels(message);
    } catch (e) {
      print('Error sending achievement notification: $e');
    }
  }

  Future<void> notifyAchievementProgress(
    String achievementName,
    int currentProgress,
    int requiredProgress,
  ) async {
    try {
      final message = '📊 Achievement progress: $achievementName ($currentProgress/$requiredProgress)';
      await notifyAllChannels(message);
    } catch (e) {
      print('Error sending achievement progress notification: $e');
    }
  }

  // ====================
  // BULK NOTIFICATIONS
  // ====================

  Future<void> notifyBulkTasks(List<WorkTaskModel> tasks) async {
    try {
      final message = '📋 Bulk update: ${tasks.length} tasks processed';
      await notifyAllChannels(message);
    } catch (e) {
      print('Error sending bulk tasks notification: $e');
    }
  }

  Future<void> notifySystemMaintenance(String message) async {
    try {
      await notifyAllChannels('🔧 System maintenance: $message');
    } catch (e) {
      print('Error sending maintenance notification: $e');
    }
  }

  Future<void> notifySystemAlert(String message) async {
    try {
      await notifyAllChannels('🚨 System alert: $message');
    } catch (e) {
      print('Error sending alert notification: $e');
    }
  }

  // ====================
  // INTERNAL HELPERS
  // ====================

  Future<void> notifyAllChannels(String message) async {
    try {
      // Send to all initialized channels
      await Future.wait([
        _slack.sendMessage(message),
        _teams.sendMessage(message),
        _email.sendEmail(
          to: 'admin@example.com',
          subject: 'Notification',
          body: message,
        ),
        _calendar.createEvent(
          title: 'Notification',
          description: message,
          startTime: DateTime.now(),
          endTime: DateTime.now().add(Duration(minutes: 30)),
        ),
      ]);
    } catch (e) {
      print('Error sending notification to all channels: $e');
    }
  }

  // ====================
  // CHANNEL SPECIFIC METHODS
  // ====================

  Future<void> notifySlackOnly(String message) async {
    try {
      await _slack.sendMessage(message);
    } catch (e) {
      print('Error sending Slack notification: $e');
    }
  }

  Future<void> notifyTeamsOnly(String message) async {
    try {
      await _teams.sendMessage(message);
    } catch (e) {
      print('Error sending Teams notification: $e');
    }
  }

  Future<void> notifyEmailOnly(String to, String subject, String body) async {
    try {
      await _email.sendEmail(
        to: to,
        subject: subject,
        body: body,
      );
    } catch (e) {
      print('Error sending Email notification: $e');
    }
  }

  Future<void> notifyCalendarEvent({
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    List<String>? attendees,
  }) async {
    try {
      await _calendar.createEvent(
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime,
        attendees: attendees,
      );
    } catch (e) {
      print('Error creating calendar event: $e');
    }
  }

  // ====================
  // TASK SYNC METHODS
  // ====================

  Future<void> TaskToSync(WorkTaskModel task) async {
    try {
      final message = '🔄 Task synced: ${task.title}\n'
          'Description: ${task.description}\n'
          'Due Date: ${task.dueDate}\n'
          'Status: ${task.dueDate}';
      await notifyAllChannels(message);
    } catch (e) {
      print('Error syncing task: $e');
    }
  }

  Future<void> syncUnifiedCalendarModel(UnifiedCalendarModel model) async {
    try {
      // Placeholder for unified calendar model sync
      print('Syncing unified calendar model: ${model.toString()}');
    } catch (e) {
      print('Error syncing unified calendar model: $e');
    }
  }
}
*/
