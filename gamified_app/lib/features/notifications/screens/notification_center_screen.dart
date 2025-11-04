/// Notification Center Screen
/// Shows all user notifications

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/notification_model.dart';
import '../widgets/notification_card.dart';

class NotificationCenterScreen extends ConsumerStatefulWidget {
  const NotificationCenterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NotificationCenterScreen> createState() =>
      _NotificationCenterScreenState();
}

class _NotificationCenterScreenState
    extends ConsumerState<NotificationCenterScreen> {
  NotificationType? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    // Mock notifications data
    final notifications = _getMockNotifications();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            onPressed: () {
              // Mark all as read
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All notifications marked as read')),
              );
            },
          ),
          PopupMenuButton<NotificationType>(
            icon: const Icon(Icons.filter_list),
            onSelected: (type) {
              setState(() {
                _selectedFilter = type;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: null,
                child: Text('All Notifications'),
              ),
              ...NotificationType.values.map(
                (type) => PopupMenuItem(
                  value: type,
                  child: Text(_getNotificationTypeName(type)),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 8,
              children: NotificationType.values.map((type) {
                final isSelected = _selectedFilter == type;
                return FilterChip(
                  label: Text(_getNotificationTypeName(type)),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = selected ? type : null;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          // Notifications list
          Expanded(
            child: notifications.isEmpty
                ? const Center(
                    child: Text('No notifications'),
                  )
                : ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return NotificationCard(
                        notification: notification,
                        onTap: () {
                          // Handle notification tap
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  List<NotificationModel> _getMockNotifications() {
    final allNotifications = [
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

    if (_selectedFilter == null) {
      return allNotifications;
    }

    return allNotifications
        .where((n) => n.type == _selectedFilter)
        .toList();
  }

  String _getNotificationTypeName(NotificationType type) {
    switch (type) {
      case NotificationType.achievement:
        return 'Achievements';
      case NotificationType.taskReminder:
        return 'Reminders';
      case NotificationType.teamUpdate:
        return 'Team Updates';
      case NotificationType.levelUp:
        return 'Level Ups';
      case NotificationType.systemAlert:
        return 'System Alerts';
      case NotificationType.dailyDigest:
        return 'Daily Digest';
      case NotificationType.weeklyReport:
        return 'Weekly Reports';
    }
  }
}
