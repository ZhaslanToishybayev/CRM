/// Notification Card Widget
/// Displays a single notification

import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;

  const NotificationCard({
    Key? key,
    required this.notification,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = _getNotificationColor(notification.type);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(
            _getNotificationIcon(notification.type),
            color: color,
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text(notification.message),
        trailing: Icon(
          notification.isRead ? Icons.check_circle : Icons.circle_outlined,
          color: notification.isRead ? Colors.grey : color,
        ),
        onTap: onTap,
      ),
    );
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.achievement:
        return Icons.emoji_events;
      case NotificationType.taskReminder:
        return Icons.alarm;
      case NotificationType.teamUpdate:
        return Icons.group;
      case NotificationType.levelUp:
        return Icons.trending_up;
      case NotificationType.systemAlert:
        return Icons.warning;
      case NotificationType.dailyDigest:
        return Icons.today;
      case NotificationType.weeklyReport:
        return Icons.analytics;
    }
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.achievement:
        return Colors.amber;
      case NotificationType.taskReminder:
        return Colors.orange;
      case NotificationType.teamUpdate:
        return Colors.blue;
      case NotificationType.levelUp:
        return Colors.green;
      case NotificationType.systemAlert:
        return Colors.red;
      case NotificationType.dailyDigest:
        return Colors.purple;
      case NotificationType.weeklyReport:
        return Colors.indigo;
    }
  }
}
