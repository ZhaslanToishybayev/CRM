/// Unified Notification Service
/// Combines Slack, Teams, Email, and Calendar integrations
/// Phase 4: Unified Notification System

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
    try {
      bool allInitialized = true;

      // Initialize Slack
      if (slackBotToken != null) {
        final slackOk = await _slack.initialize(
          botToken: slackBotToken,
          webhookUrl: slackWebhookUrl,
        );
        print('Slack initialized: $slackOk');
        if (!slackOk) allInitialized = false;
      }

      // Initialize Teams
      if (teamsClientId != null && teamsClientSecret != null) {
        final teamsOk = await _teams.initialize(
          clientId: teamsClientId,
          clientSecret: teamsClientSecret,
          tenantId: teamsTenantId ?? '',
          redirectUri: teamsRedirectUri ?? '',
        );
        print('Teams initialized: $teamsOk');
        if (!teamsOk) allInitialized = false;
      }

      // Initialize Email (SMTP or SendGrid)
      if (smtpHost != null && smtpPort != null) {
        final smtpOk = await _email.initializeSMTP(
          host: smtpHost,
          port: smtpPort,
          username: smtpUsername ?? '',
          password: smtpPassword ?? '',
          useSSL: smtpUseSSL,
        );
        print('SMTP initialized: $smtpOk');
        if (!smtpOk) allInitialized = false;
      }

      if (sendGridApiKey != null) {
        _email.initializeSendGrid(
          apiKey: sendGridApiKey,
          fromEmail: sendGridFromEmail,
        );
        print('SendGrid initialized');
      }

      return allInitialized;
    } catch (e) {
      print('Error initializing notifications: $e');
      return false;
    }
  }

  // ====================
  // TASK NOTIFICATIONS
  // ====================

  /// Send task assignment notification to all channels
  Future<bool> sendTaskAssignmentNotification({
    required String taskId,
    required WorkTaskModel task,
    required String assignedToEmail,
    required String assignedByName,
    List<String>? slackChannels,
    List<String>? teamsChannels,
    bool sendEmail = true,
    bool syncCalendar = true,
  }) async {
    try {
      bool success = true;

      // Send to Slack channels
      if (slackChannels != null && _slack.isConnected) {
        for (final channel in slackChannels) {
          await _slack.sendMessage(
            channel: channel,
            text:
                '📋 New Task Assignment: ${task.title}\nAssigned to: ${task.assigneeId}\nDue: ${task.dueDate}',
          );
        }
      }

      // Send to Teams channels
      if (teamsChannels != null && _teams.isConnected) {
        for (final channel in teamsChannels) {
          final [teamId, channelId] = channel.split(':');
          await _teams.sendTaskAssignmentNotification(
            teamId: teamId,
            channelId: channelId,
            assignedTo: task.assigneeId,
            assignedBy: assignedByName,
            taskTitle: task.title,
            taskDescription: task.description,
            dueDate: task.dueDate ?? DateTime.now(),
          );
        }
      }

      // Send email
      if (sendEmail) {
        final emailSent = await _email.sendTaskAssignmentEmail(
          to: assignedToEmail,
          assignedTo: task.assigneeId,
          assignedBy: assignedByName,
          taskTitle: task.title,
          taskDescription: task.description,
          dueDate: task.dueDate ?? DateTime.now(),
        );
        if (!emailSent) success = false;
      }

      // Sync with calendar
      if (syncCalendar && task.dueDate != null) {
        await _calendar.createEvent(
          provider: 'google',
          calendarId: 'primary',
          title: task.title,
          description: task.description,
          startDate: task.dueDate!,
          endDate: task.dueDate!.add(const Duration(hours: 1)),
          attendees: [assignedToEmail],
        );
      }

      return success;
    } catch (e) {
      print('Error sending task assignment notification: $e');
      return false;
    }
  }

  /// Send task completion notification
  Future<bool> sendTaskCompletionNotification({
    required String userId,
    required WorkTaskModel task,
    required int xpEarned,
    List<String>? slackChannels,
    List<String>? teamsChannels,
    bool sendEmail = true,
  }) async {
    try {
      final user = await _supabase.getCorporateUser(userId);
      if (user == null) return false;

      bool success = true;

      // Send to Slack channels
      if (slackChannels != null && _slack.isConnected) {
        for (final channel in slackChannels) {
          await _slack.sendTaskCompletionNotification(
            channel: channel,
            userName: user.username,
            taskTitle: task.title,
            xpEarned: xpEarned,
          );
        }
      }

      // Send to Teams channels
      if (teamsChannels != null && _teams.isConnected) {
        for (final channel in teamsChannels) {
          final [teamId, channelId] = channel.split(':');
          await _teams.sendTaskCompletionNotification(
            teamId: teamId,
            channelId: channelId,
            userName: user.fullName,
            taskTitle: task.title,
            xpEarned: xpEarned,
          );
        }
      }

      // Send email
      if (sendEmail) {
        final emailSent = await _email.sendAchievementEmail(
          to: user.email,
          userName: user.fullName,
          achievementTitle: 'Task Completed',
          achievementDescription:
              'You successfully completed: ${task.title}',
          xpReward: xpEarned,
        );
        if (!emailSent) success = false;
      }

      return success;
    } catch (e) {
      print('Error sending task completion notification: $e');
      return false;
    }
  }

  // ====================
  // ACHIEVEMENT NOTIFICATIONS
  // ====================

  /// Send achievement unlocked notification
  Future<bool> sendAchievementNotification({
    required String userId,
    required WorkAchievementDefinition achievement,
    List<String>? slackChannels,
    List<String>? teamsChannels,
    bool sendEmail = true,
  }) async {
    try {
      final user = await _supabase.getCorporateUser(userId);
      if (user == null) return false;

      bool success = true;

      // Send to Slack channels
      if (slackChannels != null && _slack.isConnected) {
        for (final channel in slackChannels) {
          await _slack.sendAchievementNotification(
            channel: channel,
            userName: user.username,
            achievementTitle: achievement.title,
            achievementDescription: achievement.description,
            xpReward: achievement.xpReward,
          );
        }
      }

      // Send to Teams channels
      if (teamsChannels != null && _teams.isConnected) {
        for (final channel in teamsChannels) {
          final [teamId, channelId] = channel.split(':');
          await _teams.sendAchievementNotification(
            teamId: teamId,
            channelId: channelId,
            userName: user.fullName,
            achievementTitle: achievement.title,
            achievementDescription: achievement.description,
            xpReward: achievement.xpReward,
          );
        }
      }

      // Send email
      if (sendEmail) {
        final emailSent = await _email.sendAchievementEmail(
          to: user.email,
          userName: user.fullName,
          achievementTitle: achievement.title,
          achievementDescription: achievement.description,
          xpReward: achievement.xpReward,
        );
        if (!emailSent) success = false;
      }

      return success;
    } catch (e) {
      print('Error sending achievement notification: $e');
      return false;
    }
  }

  // ====================
  // DEADLINE REMINDERS
  // ====================

  /// Send deadline reminder
  Future<bool> sendDeadlineReminder({
    required String userId,
    required WorkTaskModel task,
    required int hoursUntilDeadline,
    List<String>? slackChannels,
    List<String>? teamsChannels,
    bool sendEmail = true,
  }) async {
    try {
      final user = await _supabase.getCorporateUser(userId);
      if (user == null || task.dueDate == null) return false;

      bool success = true;

      // Send to Slack channels
      if (slackChannels != null && _slack.isConnected) {
        for (final channel in slackChannels) {
          await _slack.sendDeadlineReminder(
            channel: channel,
            userId: user.username,
            taskTitle: task.title,
            dueDate: task.dueDate!,
            hoursUntilDeadline: hoursUntilDeadline,
          );
        }
      }

      // Send to Teams channels
      if (teamsChannels != null && _teams.isConnected) {
        for (final channel in teamsChannels) {
          final [teamId, channelId] = channel.split(':');
          await _teams.sendDeadlineReminder(
            teamId: teamId,
            channelId: channelId,
            userId: user.fullName,
            taskTitle: task.title,
            dueDate: task.dueDate!,
          );
        }
      }

      // Send email
      if (sendEmail) {
        final emailSent = await _email.sendDeadlineReminderEmail(
          to: user.email,
          userName: user.fullName,
          taskTitle: task.title,
          dueDate: task.dueDate!,
          hoursUntilDeadline: hoursUntilDeadline,
        );
        if (!emailSent) success = false;
      }

      return success;
    } catch (e) {
      print('Error sending deadline reminder: $e');
      return false;
    }
  }

  // ====================
  // TEAM PERFORMANCE
  // ====================

  /// Send team performance update
  Future<bool> sendTeamPerformanceUpdate({
    required String teamId,
    required String teamName,
    required int tasksCompleted,
    required int totalTasks,
    required double completionRate,
    required String topPerformer,
    List<String>? slackChannels,
    List<String>? teamsChannels,
  }) async {
    try {
      bool success = true;

      // Send to Slack channels
      if (slackChannels != null && _slack.isConnected) {
        for (final channel in slackChannels) {
          await _slack.sendTeamPerformanceUpdate(
            channel: channel,
            teamName: teamName,
            tasksCompleted: tasksCompleted,
            totalTasks: totalTasks,
            completionRate: completionRate,
            topPerformer: topPerformer,
          );
        }
      }

      // Send to Teams channels
      if (teamsChannels != null && _teams.isConnected) {
        for (final channel in teamsChannels) {
          final [teamIdSplit, channelId] = channel.split(':');
          await _teams.sendTeamPerformanceUpdate(
            teamId: teamIdSplit,
            channelId: channelId,
            teamName: teamName,
            tasksCompleted: tasksCompleted,
            totalTasks: totalTasks,
            completionRate: completionRate,
            topPerformer: topPerformer,
          );
        }
      }

      return success;
    } catch (e) {
      print('Error sending team performance update: $e');
      return false;
    }
  }

  // ====================
  // WEEKLY SUMMARIES
  // ====================

  /// Send weekly summary to user
  Future<bool> sendWeeklySummary({
    required String userId,
    required int tasksCompleted,
    required int xpEarned,
    required int achievementsUnlocked,
    required int streakDays,
    List<String>? slackChannels,
    List<String>? teamsChannels,
    bool sendEmail = true,
  }) async {
    try {
      final user = await _supabase.getCorporateUser(userId);
      if (user == null) return false;

      bool success = true;

      // Send to Slack channels
      if (slackChannels != null && _slack.isConnected) {
        for (final channel in slackChannels) {
          await _slack.sendWeeklySummary(
            channel: channel,
            userId: user.username,
            tasksCompleted: tasksCompleted,
            xpEarned: xpEarned,
            achievementsUnlocked: achievementsUnlocked,
            streakDays: streakDays,
          );
        }
      }

      // Send to Teams channels
      if (teamsChannels != null && _teams.isConnected) {
        for (final channel in teamsChannels) {
          final [teamId, channelId] = channel.split(':');
          await _teams.sendWeeklySummary(
            teamId: teamId,
            channelId: channelId,
            userId: user.fullName,
            tasksCompleted: tasksCompleted,
            xpEarned: xpEarned,
            achievementsUnlocked: achievementsUnlocked,
            streakDays: streakDays,
          );
        }
      }

      // Send email
      if (sendEmail) {
        final emailSent = await _email.sendWeeklySummaryEmail(
          to: user.email,
          userName: user.fullName,
          tasksCompleted: tasksCompleted,
          xpEarned: xpEarned,
          achievementsUnlocked: achievementsUnlocked,
          streakDays: streakDays,
        );
        if (!emailSent) success = false;
      }

      return success;
    } catch (e) {
      print('Error sending weekly summary: $e');
      return false;
    }
  }

  // ====================
  // CALENDAR SYNC
  // ====================

  /// Sync tasks with calendar
  Future<bool> syncTasksWithCalendar({
    required String userId,
    required List<WorkTaskModel> tasks,
    String provider = 'google',
    String calendarId = 'primary',
  }) async {
    try {
      final tasksToSync = tasks
          .where((t) => t.dueDate != null)
          .map((task) => TaskToSync(
                title: task.title,
                description: task.description,
                startDate: task.dueDate!,
                endDate: task.dueDate!.add(const Duration(hours: 1)),
                attendees: [],
              ))
          .toList();

      if (provider == 'google') {
        return await _calendar.syncTasksWithGoogleCalendar(
          calendarId: calendarId,
          tasks: tasksToSync,
        );
      } else if (provider == 'outlook') {
        return await _calendar.syncTasksWithOutlook(
          calendarId: calendarId,
          tasks: tasksToSync,
        );
      }
      return false;
    } catch (e) {
      print('Error syncing tasks with calendar: $e');
      return false;
    }
  }

  // ====================
  // UTILITY METHODS
  // ====================

  /// Get connection status of all services
  Map<String, bool> getConnectionStatus() {
    return {
      'slack': _slack.isConnected,
      'teams': _teams.isConnected,
      'email_smtp': _email.isSMTPConnected,
      'email_sendgrid': _email.isSendGridConnected,
      'calendar_google': _calendar.isGoogleConnected,
      'calendar_outlook': _calendar.isOutlookConnected,
    };
  }

  /// Check if any notification service is connected
  bool get isAnyConnected =>
      _slack.isConnected ||
      _teams.isConnected ||
      _email.isSMTPConnected ||
      _email.isSendGridConnected;

  /// Get available Slack channels
  Future<List<SlackChannel>> getSlackChannels() async {
    return await _slack.getChannels();
  }

  /// Get available Teams
  Future<List<TeamsTeam>> getTeams() async {
    return await _teams.getTeams();
  }

  /// Get team channels
  Future<List<TeamsChannel>> getTeamsChannels(String teamId) async {
    return await _teams.getChannels(teamId);
  }

  /// Get calendars
  Future<List<UnifiedCalendarModel>> getCalendars() async {
    return await _calendar.getAllCalendars();
  }
}
