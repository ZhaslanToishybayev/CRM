/// Slack Integration Service
/// Send notifications and updates to Slack channels
/// Phase 4: Slack Integration

import 'dart:convert';
import 'package:http/http.dart' as http;

class SlackIntegrationService {
  static final SlackIntegrationService _instance =
      SlackIntegrationService._internal();
  factory SlackIntegrationService() => _instance;
  SlackIntegrationService._internal();

  String? _botToken;
  String? _webhookUrl;

  /// Initialize Slack integration with bot token
  Future<bool> initialize({
    required String botToken,
    String? webhookUrl,
  }) async {
    try {
      _botToken = botToken;
      _webhookUrl = webhookUrl;

      // Verify bot token by calling Slack API
      final response = await http.get(
        Uri.parse('https://slack.com/api/auth.test'),
        headers: {
          'Authorization': 'Bearer $_botToken',
        },
      );

      final data = json.decode(response.body);
      return data['ok'] == true;
    } catch (e) {
      print('Error initializing Slack: $e');
      return false;
    }
  }

  /// Get list of channels
  Future<List<SlackChannel>> getChannels() async {
    if (_botToken == null) return [];

    try {
      final response = await http.post(
        Uri.parse('https://slack.com/api/conversations.list'),
        headers: {
          'Authorization': 'Bearer $_botToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'types': 'public_channel,private_channel',
          'limit': 200,
        }),
      );

      final data = json.decode(response.body);
      if (data['ok'] == true) {
        final channels = data['channels'] as List;
        return channels
            .map((channel) => SlackChannel.fromJson(channel))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching Slack channels: $e');
      return [];
    }
  }

  /// Get list of users
  Future<List<SlackUser>> getUsers() async {
    if (_botToken == null) return [];

    try {
      final response = await http.post(
        Uri.parse('https://slack.com/api/users.list'),
        headers: {
          'Authorization': 'Bearer $_botToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'limit': 200,
        }),
      );

      final data = json.decode(response.body);
      if (data['ok'] == true) {
        final users = data['members'] as List;
        return users
            .map((user) => SlackUser.fromJson(user))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching Slack users: $e');
      return [];
    }
  }

  /// Send message to channel
  Future<bool> sendMessage({
    required String channel,
    required String text,
    List<SlackBlock>? blocks,
    String? threadTs,
  }) async {
    if (_botToken == null) return false;

    try {
      final payload = <String, dynamic>{
        'channel': channel,
        'text': text,
      };

      if (blocks != null) {
        payload['blocks'] = blocks.map((b) => b.toJson()).toList();
      }

      if (threadTs != null) {
        payload['thread_ts'] = threadTs;
      }

      final response = await http.post(
        Uri.parse('https://slack.com/api/chat.postMessage'),
        headers: {
          'Authorization': 'Bearer $_botToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      final data = json.decode(response.body);
      return data['ok'] == true;
    } catch (e) {
      print('Error sending Slack message: $e');
      return false;
    }
  }

  /// Send notification about task completion
  Future<bool> sendTaskCompletionNotification({
    required String channel,
    required String userName,
    required String taskTitle,
    required int xpEarned,
    String? channelId,
  }) async {
    final blocks = [
      SlackBlock(
        type: 'section',
        text: SlackText(
          type: 'mrkdwn',
          text:
              '*✅ Task Completed!*\n<@$userName> completed: *$taskTitle*',
        ),
      ),
      SlackBlock(
        type: 'section',
        fields: [
          SlackText(
            type: 'mrkdwn',
            text: '*XP Earned:*\n$xpEarned',
          ),
        ],
      ),
      SlackBlock(
        type: 'divider',
      ),
    ];

    return await sendMessage(
      channel: channel,
      text: 'Task completed by $userName',
      blocks: blocks,
      threadTs: channelId,
    );
  }

  /// Send achievement unlock notification
  Future<bool> sendAchievementNotification({
    required String channel,
    required String userName,
    required String achievementTitle,
    required String achievementDescription,
    required int xpReward,
  }) async {
    final blocks = [
      SlackBlock(
        type: 'section',
        text: SlackText(
          type: 'mrkdwn',
          text:
              '*🏆 Achievement Unlocked!*\n<@$userName> unlocked: *$achievementTitle*',
        ),
      ),
      SlackBlock(
        type: 'section',
        text: SlackText(
          type: 'mrkdwn',
          text: achievementDescription,
        ),
      ),
      SlackBlock(
        type: 'section',
        fields: [
          SlackText(
            type: 'mrkdwn',
            text: '*XP Reward:*\n$xpReward',
          ),
        ],
      ),
    ];

    return await sendMessage(
      channel: channel,
      text: 'New achievement unlocked!',
      blocks: blocks,
    );
  }

  /// Send deadline reminder
  Future<bool> sendDeadlineReminder({
    required String channel,
    required String userId,
    required String taskTitle,
    required DateTime dueDate,
    int hoursUntilDeadline = 24,
  }) async {
    final now = DateTime.now();
    final hoursLeft = dueDate.difference(now).inHours;

    final blocks = [
      SlackBlock(
        type: 'section',
        text: SlackText(
          type: 'mrkdwn',
          text:
              ':warning: *Deadline Reminder*\n<@$userId> your task *$taskTitle* is due in *$hoursLeft hours*',
        ),
      ),
      SlackBlock(
        type: 'section',
        text: SlackText(
          type: 'mrkdwn',
          text:
              '*Due Date:* <!date^${dueDate.millisecondsSinceEpoch / 1000}^ {date_pretty} at {time}|${dueDate.toIso8601String()}>',
        ),
      ),
    ];

    return await sendMessage(
      channel: channel,
      text: 'Deadline reminder for $taskTitle',
      blocks: blocks,
    );
  }

  /// Send team performance update
  Future<bool> sendTeamPerformanceUpdate({
    required String channel,
    required String teamName,
    required int tasksCompleted,
    required int totalTasks,
    required double completionRate,
    required String topPerformer,
  }) async {
    final blocks = [
      SlackBlock(
        type: 'section',
        text: SlackText(
          type: 'mrkdwn',
          text:
              '*📊 Team Performance Update*\nTeam: *$teamName*',
        ),
      ),
      SlackBlock(
        type: 'section',
        fields: [
          SlackText(
            type: 'mrkdwn',
            text: '*Tasks Completed:*\n$tasksCompleted / $totalTasks',
          ),
          SlackText(
            type: 'mrkdwn',
            text: '*Completion Rate:*\n${(completionRate * 100).toStringAsFixed(1)}%',
          ),
        ],
      ),
      SlackBlock(
        type: 'section',
        text: SlackText(
          type: 'mrkdwn',
          text: '*Top Performer:* <@$topPerformer>',
        ),
      ),
      SlackBlock(
        type: 'divider',
      ),
    ];

    return await sendMessage(
      channel: channel,
      text: 'Team performance update for $teamName',
      blocks: blocks,
    );
  }

  /// Send weekly summary
  Future<bool> sendWeeklySummary({
    required String channel,
    required String userId,
    required int tasksCompleted,
    required int xpEarned,
    required int achievementsUnlocked,
    required int streakDays,
  }) async {
    final blocks = [
      SlackBlock(
        type: 'section',
        text: SlackText(
          type: 'mrkdwn',
          text:
              '*📈 Weekly Summary*\n<@$userId> here\'s your weekly performance:',
        ),
      ),
      SlackBlock(
        type: 'section',
        fields: [
          SlackText(
            type: 'mrkdwn',
            text: '*Tasks Completed:*\n$tasksCompleted',
          ),
          SlackText(
            type: 'mrkdwn',
            text: '*XP Earned:*\n$xpEarned',
          ),
          SlackText(
            type: 'mrkdwn',
            text: '*Achievements:*\n$achievementsUnlocked',
          ),
          SlackText(
            type: 'mrkdwn',
            text: '*Current Streak:*\n$streakDays days',
          ),
        ],
      ),
    ];

    return await sendMessage(
      channel: channel,
      text: 'Weekly summary for $userId',
      blocks: blocks,
    );
  }

  /// Create a thread for project discussions
  Future<String?> createProjectThread({
    required String channel,
    required String projectName,
    required String projectDescription,
  }) async {
    final blocks = [
      SlackBlock(
        type: 'section',
        text: SlackText(
          type: 'mrkdwn',
          text:
              '*🎯 Project Thread: $projectName*\n$projectDescription',
        ),
      ),
    ];

    final response = await sendMessage(
      channel: channel,
      text: 'Project thread created: $projectName',
      blocks: blocks,
    );

    if (response) {
      // In a real implementation, you would capture the thread_ts from the response
      return 'thread_ts_value';
    }
    return null;
  }

  /// Update message in thread
  Future<bool> updateThreadMessage({
    required String channel,
    required String threadTs,
    required String text,
  }) async {
    return await sendMessage(
      channel: channel,
      text: text,
      threadTs: threadTs,
    );
  }

  /// Get channel info
  Future<SlackChannel?> getChannelInfo(String channelId) async {
    if (_botToken == null) return null;

    try {
      final response = await http.post(
        Uri.parse('https://slack.com/api/conversations.info'),
        headers: {
          'Authorization': 'Bearer $_botToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'channel': channelId,
        }),
      );

      final data = json.decode(response.body);
      if (data['ok'] == true) {
        return SlackChannel.fromJson(data['channel']);
      }
      return null;
    } catch (e) {
      print('Error fetching channel info: $e');
      return null;
    }
  }

  /// Send webhook notification (alternative method)
  Future<bool> sendWebhook({
    required String text,
    Map<String, dynamic>? payload,
  }) async {
    if (_webhookUrl == null) return false;

    try {
      final response = await http.post(
        Uri.parse(_webhookUrl!),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(payload ?? {'text': text}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error sending webhook: $e');
      return false;
    }
  }

  bool get isConnected => _botToken != null;
}

// ====================
// MODELS
// ====================

class SlackChannel {
  final String id;
  final String name;
  final bool isPrivate;
  final bool isMember;

  SlackChannel({
    required this.id,
    required this.name,
    required this.isPrivate,
    required this.isMember,
  });

  factory SlackChannel.fromJson(Map<String, dynamic> json) {
    return SlackChannel(
      id: json['id'],
      name: json['name'],
      isPrivate: json['is_private'] ?? false,
      isMember: json['is_member'] ?? false,
    );
  }
}

class SlackUser {
  final String id;
  final String name;
  final String? displayName;
  final String? email;
  final bool isBot;

  SlackUser({
    required this.id,
    required this.name,
    this.displayName,
    this.email,
    required this.isBot,
  });

  factory SlackUser.fromJson(Map<String, dynamic> json) {
    return SlackUser(
      id: json['id'],
      name: json['name'],
      displayName: json['profile']['display_name'],
      email: json['profile']['email'],
      isBot: json['is_bot'] ?? false,
    );
  }
}

class SlackBlock {
  final String type;
  final SlackText? text;
  final List<SlackText>? fields;
  final SlackElement? accessory;

  SlackBlock({
    required this.type,
    this.text,
    this.fields,
    this.accessory,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'type': type,
    };

    if (text != null) {
      json['text'] = text!.toJson();
    }

    if (fields != null) {
      json['fields'] = fields!.map((f) => f.toJson()).toList();
    }

    if (accessory != null) {
      json['accessory'] = accessory!.toJson();
    }

    return json;
  }
}

class SlackText {
  final String type; // 'mrkdwn' or 'plain_text'
  final String text;

  SlackText({
    required this.type,
    required this.text,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'text': text,
    };
  }
}

class SlackElement {
  final String type;

  SlackElement({required this.type});

  Map<String, dynamic> toJson() {
    return {
      'type': type,
    };
  }
}
