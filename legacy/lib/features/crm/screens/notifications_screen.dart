import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/crm/notification_model.dart';
import '../services/crm_notification_service.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final notificationService = ref.read(crmNotificationServiceProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () async {
              await notificationService.markAllAsRead();
              setState(() {});
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All notifications marked as read')),
                );
              }
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              switch (value) {
                case 'delete_read':
                  await notificationService.deleteAllRead();
                  setState(() {});
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All read notifications deleted')),
                    );
                  }
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete_read',
                child: Row(
                  children: [
                    Icon(Icons.delete_sweep, size: 20),
                    SizedBox(width: 8),
                    Text('Delete Read'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Unread Count
          FutureBuilder<int>(
            future: notificationService.getUnreadCount(),
            builder: (context, snapshot) {
              final unreadCount = snapshot.data ?? 0;
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: theme.colorScheme.surface,
                child: Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      unreadCount > 0
                          ? '$unreadCount unread notification${unreadCount == 1 ? '' : 's'}'
                          : 'All caught up!',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(height: 1),

          // Notifications List
          Expanded(
            child: _buildNotificationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    final notificationService = ref.read(crmNotificationServiceProvider);

    return FutureBuilder<List<CrmNotificationModel>>(
      future: notificationService.getNotifications(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'Error loading notifications',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        }

        final notifications = snapshot.data ?? [];

        if (notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications_none, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No notifications yet',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'You will see notifications here when they arrive',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return _buildNotificationCard(context, notification);
            },
          ),
        );
      },
    );
  }

  Widget _buildNotificationCard(BuildContext context, CrmNotificationModel notification) {
    final theme = Theme.of(context);
    final priorityColor = notification.priority.color;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: notification.isRead ? theme.colorScheme.surface : theme.colorScheme.primaryContainer,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: priorityColor,
          child: _getNotificationIcon(notification.type),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.message),
            const SizedBox(height: 4),
            Text(
              _formatTime(notification.createdAt),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            final notificationService = ref.read(crmNotificationServiceProvider);
            switch (value) {
              case 'mark_read':
                if (!notification.isRead) {
                  await notificationService.markAsRead(notification.id);
                  setState(() {});
                }
                break;
              case 'delete':
                await notificationService.deleteNotification(notification.id);
                setState(() {});
                break;
            }
          },
          itemBuilder: (context) => [
            if (!notification.isRead)
              const PopupMenuItem(
                value: 'mark_read',
                child: Row(
                  children: [
                    Icon(Icons.check, size: 20),
                    SizedBox(width: 8),
                    Text('Mark as read'),
                  ],
                ),
              ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 20),
                  SizedBox(width: 8),
                  Text('Delete'),
                ],
              ),
            ),
          ],
        ),
        onTap: () async {
          if (!notification.isRead) {
            final notificationService = ref.read(crmNotificationServiceProvider);
            await notificationService.markAsRead(notification.id);
            setState(() {});
          }

          // Navigate based on notification type
          _handleNotificationTap(context, notification);
        },
      ),
    );
  }

  Icon _getNotificationIcon(CrmNotificationType type) {
    switch (type) {
      case CrmNotificationType.dealCreated:
      case CrmNotificationType.dealUpdated:
      case CrmNotificationType.dealWon:
      case CrmNotificationType.dealLost:
      case CrmNotificationType.pipelineStageChanged:
        return const Icon(Icons.trending_up, color: Colors.white, size: 20);
      case CrmNotificationType.taskAssigned:
      case CrmNotificationType.taskCompleted:
      case CrmNotificationType.taskOverdue:
      case CrmNotificationType.reminder:
        return const Icon(Icons.task, color: Colors.white, size: 20);
      case CrmNotificationType.clientCreated:
      case CrmNotificationType.clientUpdated:
        return const Icon(Icons.person, color: Colors.white, size: 20);
      case CrmNotificationType.meetingScheduled:
        return const Icon(Icons.event, color: Colors.white, size: 20);
      case CrmNotificationType.followUpDue:
        return const Icon(Icons.schedule, color: Colors.white, size: 20);
      case CrmNotificationType.activityLog:
        return const Icon(Icons.history, color: Colors.white, size: 20);
      case CrmNotificationType.system:
        return const Icon(Icons.settings, color: Colors.white, size: 20);
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  void _handleNotificationTap(BuildContext context, CrmNotificationModel notification) {
    if (notification.dealId != null) {
      context.push('/crm/deals/${notification.dealId}');
    } else if (notification.clientId != null) {
      context.push('/crm/clients/${notification.clientId}');
    } else if (notification.taskId != null) {
      context.push('/crm/tasks/${notification.taskId}');
    }
  }
}
