# CRM Notifications System

## Overview

The CRM system includes a comprehensive notifications system that keeps users informed about important events and activities. The system supports multiple notification types, priorities, and real-time updates.

## Table of Contents

1. [Features](#features)
2. [Notification Types](#notification-types)
3. [Database Schema](#database-schema)
4. [API Reference](#api-reference)
5. [UI Components](#ui-components)
6. [Usage Examples](#usage-examples)
7. [Best Practices](#best-practices)

## Features

- **Multiple Notification Types**: Deal updates, task assignments, follow-ups, meetings
- **Priority Levels**: Low, Normal, High, Urgent
- **Read/Unread Status**: Track which notifications have been viewed
- **Rich Metadata**: Additional data stored in JSON format
- **Real-time Updates**: Instant notifications (with Supabase Realtime)
- **Badge Indicators**: Visual badges showing unread count
- **Auto-generated Notifications**: System-generated notifications for common events

## Notification Types

### Deal Notifications
- `dealCreated` - New deal created
- `dealUpdated` - Deal information updated
- `dealWon` - Deal successfully closed
- `dealLost` - Deal lost
- `pipelineStageChanged` - Deal moved between pipeline stages

### Task Notifications
- `taskAssigned` - New task assigned to user
- `taskCompleted` - Task completed
- `taskOverdue` - Task is past due date
- `reminder` - General reminder

### Client Notifications
- `clientCreated` - New client added
- `clientUpdated` - Client information updated

### Meeting Notifications
- `meetingScheduled` - Meeting scheduled

### Follow-up Notifications
- `followUpDue` - Follow-up is due

### System Notifications
- `system` - System-wide messages
- `activityLog` - Activity history entries

## Database Schema

### Table: crm_notifications

```sql
CREATE TABLE crm_notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  type VARCHAR(50) NOT NULL,
  priority VARCHAR(20) NOT NULL DEFAULT 'normal',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  is_read BOOLEAN NOT NULL DEFAULT false,
  read_at TIMESTAMP WITH TIME ZONE,
  metadata JSONB,
  client_id UUID REFERENCES crm_clients(id),
  deal_id UUID REFERENCES crm_deals(id),
  task_id UUID REFERENCES crm_tasks(id),
  user_id UUID,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Indexes

- `idx_crm_notifications_user_id` - Filter by user
- `idx_crm_notifications_is_read` - Filter unread notifications
- `idx_crm_notifications_created_at` - Sort by creation date
- `idx_crm_notifications_type` - Filter by type
- `idx_crm_notifications_priority` - Filter by priority

### Schema File

The complete schema is available in:
```
supabase_notifications_schema.sql
```

## API Reference

### CrmNotificationService

The `CrmNotificationService` class provides all notification operations.

#### Creating Notifications

```dart
final notification = CrmNotificationModel(
  id: 'unique-id',
  title: 'New Deal',
  message: 'You have a new deal',
  type: CrmNotificationType.dealCreated,
  priority: CrmNotificationPriority.normal,
  createdAt: DateTime.now(),
  isRead: false,
);

await notificationService.createNotification(notification);
```

#### Getting Notifications

```dart
// Get all notifications
final allNotifications = await notificationService.getNotifications();

// Get unread notifications only
final unreadNotifications = await notificationService.getUnreadNotifications();

// Get with limit
final recentNotifications = await notificationService.getNotifications(limit: 20);
```

#### Marking as Read

```dart
// Mark single notification as read
await notificationService.markAsRead('notification-id');

// Mark all notifications as read
await notificationService.markAllAsRead();
```

#### Deleting Notifications

```dart
// Delete single notification
await notificationService.deleteNotification('notification-id');

// Delete all read notifications
await notificationService.deleteAllRead();
```

#### Getting Unread Count

```dart
final unreadCount = await notificationService.getUnreadCount();
print('Unread: $unreadCount');
```

#### Auto-Generated Notifications

The service provides convenient methods to create notifications for common events:

```dart
// Deal events
await notificationService.notifyDealCreated('deal-id', 'Deal Title');
await notificationService.notifyDealWon('deal-id', 'Deal Title', 50000.0);
await notificationService.notifyPipelineStageChanged(
  'deal-id',
  'Deal Title',
  'Lead',
  'Qualified',
);

// Task events
await notificationService.notifyTaskAssigned('task-id', 'Task Title');
await notificationService.notifyTaskOverdue('task-id', 'Task Title');

// Client events
await notificationService.notifyClientCreated('client-id', 'Client Name');

// Other events
await notificationService.notifyFollowUpDue('client-id', 'Client Name');
await notificationService.notifyMeetingScheduled(
  'Meeting Title',
  DateTime.now().add(Duration(hours: 1)),
  'John Doe',
);
```

## UI Components

### NotificationsScreen

Full-screen notification list with:
- Unread count indicator
- Mark all as read functionality
- Delete read notifications
- Pull to refresh
- Notification cards with icons and timestamps

```dart
context.push('/crm/notifications');
```

### NotificationBadge

Widget that wraps other widgets with a notification badge.

```dart
NotificationBadge(
  child: IconButton(
    icon: Icon(Icons.notifications),
    onPressed: () {
      context.push('/crm/notifications');
    },
  ),
)
```

### Notification Card

Individual notification display with:
- Type-specific icon
- Priority color
- Title and message
- Creation timestamp
- Read/unread state
- Actions menu

## Usage Examples

### Basic Implementation

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationService = ref.read(crmNotificationServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        actions: [
          NotificationBadge(
            child: IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                context.push('/crm/notifications');
              },
            ),
          ),
        ],
      ),
      body: ElevatedButton(
        child: Text('Create Test Notification'),
        onPressed: () async {
          await notificationService.notifySystem(
            'Test',
            'This is a test notification',
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Notification created!')),
          );
        },
      ),
    );
  }
}
```

### Real-time Notifications

To enable real-time notifications, subscribe to the notifications table:

```dart
final channel = supabase
    .channel('notifications')
    .on(
      PostgresChangeEvent.insert,
      filter: PostgresFilter(
        table: 'crm_notifications',
        schema: 'public',
      ),
      (payload) {
        // Handle new notification
        final notification = CrmNotificationModel.fromJson(
          payload.newRecord,
        );
        // Show in-app notification or update UI
      },
    )
    .subscribe();

@override
void dispose() {
  channel.unsubscribe();
  super.dispose();
}
```

### Creating Custom Notifications

```dart
// Create notification with metadata
await notificationService.createNotification(
  CrmNotificationModel(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    title: 'Custom Event',
    message: 'Something happened in your CRM',
    type: CrmNotificationType.system,
    priority: CrmNotificationPriority.normal,
    createdAt: DateTime.now(),
    isRead: false,
    metadata: {
      'custom_field': 'custom_value',
      'important': true,
    },
  ),
);
```

### Navigation from Notifications

When a user taps a notification, navigate to the relevant screen:

```dart
void _handleNotificationTap(BuildContext context, CrmNotificationModel notification) {
  if (notification.dealId != null) {
    context.push('/crm/deals/${notification.dealId}');
  } else if (notification.clientId != null) {
    context.push('/crm/clients/${notification.clientId}');
  } else if (notification.taskId != null) {
    context.push('/crm/tasks/${notification.taskId}');
  }
}
```

## Best Practices

### When to Create Notifications

1. **User Actions**
   - Creating deals, clients, or tasks
   - Completing important tasks
   - Updating critical information

2. **System Events**
   - Deal stage changes
   - Task assignments
   - Overdue items
   - Scheduled events

3. **User Preferences**
   - Allow users to customize notification preferences
   - Provide opt-in/opt-out for certain types
   - Respect notification frequency limits

### Notification Content

1. **Clear Titles**
   - Keep titles concise and descriptive
   - Start with action verb
   - Example: "Task Completed", "Deal Won"

2. **Informative Messages**
   - Include relevant details
   - Provide context
   - Example: "Task 'Follow up with client' has been completed"

3. **Appropriate Priority**
   - Use priority levels sparingly
   - Reserve urgent for critical issues
   - Normal for general updates

### Performance

1. **Pagination**
   - Limit initial load to 50 notifications
   - Load more as user scrolls

2. **Caching**
   - Cache unread count
   - Update on focus/refresh

3. **Cleanup**
   - Automatically delete old read notifications
   - Provide bulk delete options

### Security

1. **Row Level Security**
   - Users only see their notifications
   - Admin users can see all

2. **Metadata Validation**
   - Validate metadata structure
   - Sanitize user input

3. **Rate Limiting**
   - Limit notifications per user per hour
   - Prevent spam

## Troubleshooting

### Common Issues

1. **Badge Not Updating**
   - Ensure state management is properly set up
   - Call setState() after marking notifications

2. **Real-time Not Working**
   - Verify Supabase Realtime is enabled
   - Check subscription is active

3. **Navigation Errors**
   - Verify navigation context is valid
   - Check route paths are correct

### Debugging

Enable logging:

```dart
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
  debug: true,
);
```

## Future Enhancements

- [ ] Push notifications (FCM)
- [ ] Email notifications
- [ ] SMS notifications
- [ ] Notification templates
- [ ] User preferences UI
- [ ] Notification scheduling
- [ ] Grouped notifications
- [ ] Notification analytics
- [ ] Slack integration
- [ ] Webhook support

## Conclusion

The CRM notifications system provides a robust way to keep users informed about important events. It supports multiple notification types, priority levels, and real-time updates, making it easy to build engaging user experiences.

For more information, refer to:
- [Supabase Realtime](https://supabase.com/docs/guides/realtime)
- [Flutter State Management](https://docs.flutter.dev/testing/unit-test-mocking)
- [Material Design - Badges](https://material.io/design/communication/notification-badges.html)
