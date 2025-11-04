/// Microsoft Teams Integration Service
/// Send notifications to Teams channels using Microsoft Graph API
/// Phase 4: Microsoft Teams Integration

import 'dart:convert';
import 'package:http/http.dart' as http;

class TeamsIntegrationService {
  static final TeamsIntegrationService _instance =
      TeamsIntegrationService._internal();
  factory TeamsIntegrationService() => _instance;
  TeamsIntegrationService._internal();

  final String _graphBaseUrl = 'https://graph.microsoft.com/v1.0';
  String? _accessToken;

  /// Initialize Teams integration
  Future<bool> initialize({
    required String clientId,
    required String clientSecret,
    required String tenantId,
    required String redirectUri,
  }) async {
    try {
      // In a real implementation, you would use OAuth2 to get access token
      // Store tokens securely and refresh when expired
      return true;
    } catch (e) {
      print('Error initializing Teams: $e');
      return false;
    }
  }

  /// Get access token (refresh if needed)
  Future<String?> getAccessToken() async {
    // In a real implementation, retrieve stored access token
    // and refresh if expired using refresh token
    return _accessToken;
  }

  /// Get list of teams the bot has access to
  Future<List<TeamsTeam>> getTeams() async {
    try {
      final token = await getAccessToken();
      if (token == null) return [];

      final response = await http.get(
        Uri.parse('$_graphBaseUrl/me/joinedTeams'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final teams = data['value'] as List;
        return teams.map((team) => TeamsTeam.fromJson(team)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching Teams: $e');
      return [];
    }
  }

  /// Get channels for a team
  Future<List<TeamsChannel>> getChannels(String teamId) async {
    try {
      final token = await getAccessToken();
      if (token == null) return [];

      final response = await http.get(
        Uri.parse('$_graphBaseUrl/teams/$teamId/channels'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final channels = data['value'] as List;
        return channels.map((channel) => TeamsChannel.fromJson(channel)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching channels: $e');
      return [];
    }
  }

  /// Send message to Teams channel
  Future<bool> sendMessage({
    required String teamId,
    required String channelId,
    required String content,
    List<TeamsAttachment>? attachments,
  }) async {
    try {
      final token = await getAccessToken();
      if (token == null) return false;

      final message = {
        'body': {
          'contentType': 'html',
          'content': content,
        },
      };

      if (attachments != null && attachments.isNotEmpty) {
        message['attachments'] = attachments.map((a) => a.toJson()).toList();
      }

      final response = await http.post(
        Uri.parse('$_graphBaseUrl/teams/$teamId/channels/$channelId/messages'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(message),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Error sending Teams message: $e');
      return false;
    }
  }

  /// Send task completion notification
  Future<bool> sendTaskCompletionNotification({
    required String teamId,
    required String channelId,
    required String userName,
    required String taskTitle,
    required int xpEarned,
  }) async {
    final content = '''
      <h3>✅ Task Completed!</h3>
      <p><strong>$userName</strong> completed task: <em>$taskTitle</em></p>
      <p><strong>XP Earned:</strong> $xpEarned</p>
    ''';

    return await sendMessage(
      teamId: teamId,
      channelId: channelId,
      content: content,
    );
  }

  /// Send achievement unlock notification
  Future<bool> sendAchievementNotification({
    required String teamId,
    required String channelId,
    required String userName,
    required String achievementTitle,
    required String achievementDescription,
    required int xpReward,
  }) async {
    final content = '''
      <h3>🏆 Achievement Unlocked!</h3>
      <p><strong>$userName</strong> unlocked: <strong>$achievementTitle</strong></p>
      <p>$achievementDescription</p>
      <p><strong>XP Reward:</strong> $xpReward</p>
    ''';

    return await sendMessage(
      teamId: teamId,
      channelId: channelId,
      content: content,
    );
  }

  /// Send deadline reminder
  Future<bool> sendDeadlineReminder({
    required String teamId,
    required String channelId,
    required String userId,
    required String taskTitle,
    required DateTime dueDate,
  }) async {
    final now = DateTime.now();
    final hoursLeft = dueDate.difference(now).inHours;

    final content = '''
      <h3>⚠️ Deadline Reminder</h3>
      <p><strong>$userId</strong>, your task <em>$taskTitle</em> is due in <strong>$hoursLeft hours</strong></p>
      <p><strong>Due Date:</strong> ${dueDate.toIso8601String()}</p>
    ''';

    return await sendMessage(
      teamId: teamId,
      channelId: channelId,
      content: content,
    );
  }

  /// Send team performance update
  Future<bool> sendTeamPerformanceUpdate({
    required String teamId,
    required String channelId,
    required String teamName,
    required int tasksCompleted,
    required int totalTasks,
    required double completionRate,
    required String topPerformer,
  }) async {
    final content = '''
      <h3>📊 Team Performance Update</h3>
      <p><strong>Team:</strong> $teamName</p>
      <p><strong>Tasks Completed:</strong> $tasksCompleted / $totalTasks</p>
      <p><strong>Completion Rate:</strong> ${(completionRate * 100).toStringAsFixed(1)}%</p>
      <p><strong>Top Performer:</strong> $topPerformer</p>
    ''';

    return await sendMessage(
      teamId: teamId,
      channelId: channelId,
      content: content,
    );
  }

  /// Send weekly summary
  Future<bool> sendWeeklySummary({
    required String teamId,
    required String channelId,
    required String userId,
    required int tasksCompleted,
    required int xpEarned,
    required int achievementsUnlocked,
    required int streakDays,
  }) async {
    final content = '''
      <h3>📈 Weekly Summary</h3>
      <p><strong>$userId</strong> - Here's your weekly performance:</p>
      <ul>
        <li><strong>Tasks Completed:</strong> $tasksCompleted</li>
        <li><strong>XP Earned:</strong> $xpEarned</li>
        <li><strong>Achievements:</strong> $achievementsUnlocked</li>
        <li><strong>Current Streak:</strong> $streakDays days</li>
      </ul>
    ''';

    return await sendMessage(
      teamId: teamId,
      channelId: channelId,
      content: content,
    );
  }

  /// Create adaptive card message
  Future<bool> sendAdaptiveCard({
    required String teamId,
    required String channelId,
    required Map<String, dynamic> card,
  }) async {
    try {
      final token = await getAccessToken();
      if (token == null) return false;

      final message = {
        'body': {
          'contentType': 'html',
          'content': '<div>Adaptive Card</div>',
        },
        'attachments': [
          {
            'contentType': 'application/vnd.microsoft.card.adaptive',
            'content': card,
          }
        ],
      };

      final response = await http.post(
        Uri.parse('$_graphBaseUrl/teams/$teamId/channels/$channelId/messages'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(message),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Error sending adaptive card: $e');
      return false;
    }
  }

  /// Send task assignment notification
  Future<bool> sendTaskAssignmentNotification({
    required String teamId,
    required String channelId,
    required String assignedTo,
    required String assignedBy,
    required String taskTitle,
    required String taskDescription,
    required DateTime dueDate,
  }) async {
    final card = {
      'type': 'AdaptiveCard',
      'version': '1.0',
      'body': [
        {
          'type': 'TextBlock',
          'weight': 'Bolder',
          'size': 'Medium',
          'text': '📋 New Task Assignment',
        },
        {
          'type': 'TextBlock',
          'text': '**Assigned To:** $assignedTo',
          'wrap': true,
        },
        {
          'type': 'TextBlock',
          'text': '**Task:** $taskTitle',
          'wrap': true,
        },
        {
          'type': 'TextBlock',
          'text': '**Description:** $taskDescription',
          'wrap': true,
        },
        {
          'type': 'TextBlock',
          'text': '**Due Date:** ${dueDate.toIso8601String()}',
          'wrap': true,
        },
      ],
      'actions': [
        {
          'type': 'Action.OpenUrl',
          'title': 'View Task',
          'url': 'https://your-app-url.com/tasks',
        },
      ],
    };

    return await sendAdaptiveCard(
      teamId: teamId,
      channelId: channelId,
      card: card,
    );
  }

  /// Send milestone achievement notification
  Future<bool> sendMilestoneNotification({
    required String teamId,
    required String channelId,
    required String userName,
    required String milestone,
    required String description,
    required int xpReward,
  }) async {
    final content = '''
      <h3>🎯 Milestone Achieved!</h3>
      <p><strong>$userName</strong> reached milestone: <strong>$milestone</strong></p>
      <p>$description</p>
      <p><strong>XP Reward:</strong> $xpReward</p>
    ''';

    return await sendMessage(
      teamId: teamId,
      channelId: channelId,
      content: content,
    );
  }

  /// Get team members
  Future<List<TeamsUser>> getTeamMembers(String teamId) async {
    try {
      final token = await getAccessToken();
      if (token == null) return [];

      final response = await http.get(
        Uri.parse('$_graphBaseUrl/teams/$teamId/members'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final members = data['value'] as List;
        return members.map((member) => TeamsUser.fromJson(member)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching team members: $e');
      return [];
    }
  }

  bool get isConnected => _accessToken != null;
}

// ====================
// MODELS
// ====================

class TeamsTeam {
  final String id;
  final String displayName;
  final String? description;

  TeamsTeam({
    required this.id,
    required this.displayName,
    this.description,
  });

  factory TeamsTeam.fromJson(Map<String, dynamic> json) {
    return TeamsTeam(
      id: json['id'],
      displayName: json['displayName'],
      description: json['description'],
    );
  }
}

class TeamsChannel {
  final String id;
  final String displayName;
  final String? description;
  final String webUrl;

  TeamsChannel({
    required this.id,
    required this.displayName,
    this.description,
    required this.webUrl,
  });

  factory TeamsChannel.fromJson(Map<String, dynamic> json) {
    return TeamsChannel(
      id: json['id'],
      displayName: json['displayName'],
      description: json['description'],
      webUrl: json['webUrl'],
    );
  }
}

class TeamsUser {
  final String id;
  final String displayName;
  final String? email;
  final String? userPrincipalName;

  TeamsUser({
    required this.id,
    required this.displayName,
    this.email,
    this.userPrincipalName,
  });

  factory TeamsUser.fromJson(Map<String, dynamic> json) {
    return TeamsUser(
      id: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      userPrincipalName: json['userPrincipalName'],
    );
  }
}

class TeamsAttachment {
  final String contentType;
  final Map<String, dynamic> content;

  TeamsAttachment({
    required this.contentType,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'contentType': contentType,
      'content': content,
    };
  }
}
