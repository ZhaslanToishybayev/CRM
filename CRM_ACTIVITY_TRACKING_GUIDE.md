# CRM Activity Tracking System

## Overview

The CRM system includes a comprehensive activity tracking feature that logs all client interactions and CRM events. This provides a complete timeline of activities for better customer relationship management and sales tracking.

## Table of Contents

1. [Features](#features)
2. [Activity Types](#activity-types)
3. [Database Schema](#database-schema)
4. [API Reference](#api-reference)
5. [UI Components](#ui-components)
6. [Usage Examples](#usage-examples)
7. [Best Practices](#best-practices)

## Features

- **Automatic Activity Logging**: Activities are automatically logged for common events
- **Manual Activity Logging**: Manually log custom activities
- **Activity Timeline**: Visual timeline of all activities
- **Activity Filtering**: Filter by activity type, date, or client
- **Activity Search**: Search through activity history
- **Activity Statistics**: View statistics and metrics
- **Rich Metadata**: Store additional context with each activity
- **Client-Centric**: All activities are linked to clients and deals

## Activity Types

### Communication Activities
- `call` - Phone calls (inbound/outbound)
- `email` - Email communications
- `meeting` - In-person or virtual meetings
- `sms` - Text messages

### CRM Activities
- `dealCreated` - New deal created
- `dealUpdated` - Deal information updated
- `statusChanged` - Deal status changed
- `clientCreated` - New client added
- `clientUpdated` - Client information updated
- `taskCompleted` - Task completed

### Note-Taking Activities
- `note` - Notes added
- `documentShared` - Documents shared with client

### Custom Activities
- `custom` - Custom activity type

## Database Schema

### Table: crm_activities

```sql
CREATE TABLE crm_activities (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type VARCHAR(50) NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  client_id UUID REFERENCES crm_clients(id),
  deal_id UUID REFERENCES crm_deals(id),
  activity_date TIMESTAMP WITH TIME ZONE NOT NULL,
  metadata JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Indexes

- `idx_crm_activities_client_id` - Filter by client
- `idx_crm_activities_deal_id` - Filter by deal
- `idx_crm_activities_activity_date` - Sort by date
- `idx_crm_activities_type` - Filter by type

### Relationships

- Each activity can be linked to a client (optional)
- Each activity can be linked to a deal (optional)
- Activities can have rich metadata in JSON format

## API Reference

### CrmActivityTrackingService

The `CrmActivityTrackingService` class provides all activity tracking operations.

#### Logging Activities

```dart
// Log a custom activity
final activity = ActivityModel(
  id: 'unique-id',
  type: ActivityType.call,
  title: 'Phone Call',
  description: 'Discussed project requirements',
  activityDate: DateTime.now(),
  clientId: 'client-id',
  metadata: {
    'duration': 30,
    'call_type': 'outbound',
  },
);

await activityService.logActivity(activity);
```

#### Getting Activities

```dart
// Get all activities for a client
final clientActivities = await activityService.getClientActivities('client-id');

// Get all activities for a deal
final dealActivities = await activityService.getDealActivities('deal-id');

// Get recent activities (all clients)
final recentActivities = await activityService.getRecentActivities(limit: 50);

// Get activities by date range
final activities = await activityService.getActivitiesByDateRange(
  DateTime(2024, 1, 1),
  DateTime(2024, 12, 31),
);

// Get activities by type
final calls = await activityService.getActivitiesByType(ActivityType.call);
```

#### Automatic Activity Logging

The service provides convenient methods to automatically log common activities:

```dart
// Deal activities
await activityService.logDealCreated('deal-id', 'Deal Title', 'client-id');
await activityService.logDealUpdated('deal-id', 'Deal Title', 'client-id', changes);
await activityService.logDealStatusChanged('deal-id', 'Deal Title', 'client-id', 'lead', 'qualified');

// Communication activities
await activityService.logCall(
  'client-id',
  'deal-id',
  'Discussed project requirements',
  Duration(minutes: 30),
);

await activityService.logEmail(
  'client-id',
  'deal-id',
  'Re: Project Proposal',
  'outbound',
);

await activityService.logMeeting(
  'client-id',
  'deal-id',
  'Initial meeting to discuss requirements',
  ['John Doe', 'Jane Smith'],
);

// CRM activities
await activityService.logTaskCompleted('client-id', 'deal-id', 'Prepare proposal');

// Note activities
await activityService.logNote('client-id', 'deal-id', 'Client interested in premium package');

// Client activities
await activityService.logClientCreated('client-id', 'John Doe');
await activityService.logClientUpdated('client-id', 'John Doe', changes);

// Document activities
await activityService.logDocumentShared(
  'client-id',
  'deal-id',
  'Project Proposal.pdf',
  'https://example.com/proposal.pdf',
);
```

#### Activity Statistics

```dart
// Get activity statistics for a client
final stats = await activityService.getActivityStatistics('client-id');

print('Total activities: ${stats['total']}');
print('Calls: ${stats['calls']}');
print('Emails: ${stats['emails']}');
print('Meetings: ${stats['meetings']}');
```

#### Activity Timeline

```dart
// Get activity timeline for dashboard
final timeline = await activityService.getTimeline(limit: 10);
```

## UI Components

### ActivityTimelineScreen

Full-screen activity timeline with:
- Visual timeline with icons and connecting lines
- Activity cards with rich information
- Filtering by activity type
- Search functionality
- Pull to refresh
- Add activity FAB

**Routes:**
- `/crm/activities` - Global activity timeline
- `/crm/clients/{id}/activities` - Client-specific activities
- `/crm/deals/{id}/activities` - Deal-specific activities

### Activity Item Component

Displays individual activity with:
- Activity type icon
- Color-coded by type
- Title and description
- Timestamp
- Type badge

## Usage Examples

### Basic Implementation

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientDetailScreen extends ConsumerWidget {
  final String clientId;

  const ClientDetailScreen({Key? key, required this.clientId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityService = ref.read(crmActivityTrackingServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Client Activities'),
        actions: [
          IconButton(
            icon: Icon(Icons.timeline),
            onPressed: () {
              context.push('/crm/clients/$clientId/activities');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ... client details ...
          Expanded(
            child: FutureBuilder<List<ActivityModel>>(
              future: activityService.getClientActivities(clientId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final activity = snapshot.data![index];
                    return ActivityCard(activity: activity);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await activityService.logNote(
            clientId,
            null,
            'Met with client to discuss requirements',
          );
          // Refresh activities
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### Auto-Logging in Services

Integrate activity logging into your CRM services:

```dart
class CrmService {
  Future<DealModel> createDeal(DealModel deal) async {
    // Create deal in database
    final createdDeal = await _dealDataSource.createDeal(deal);

    // Log activity
    await _activityTrackingService.logDealCreated(
      createdDeal.id,
      createdDeal.title,
      createdDeal.clientId!,
    );

    return createdDeal;
  }

  Future<DealModel> updateDeal(DealModel deal) async {
    final oldDeal = await _dealDataSource.getDealById(deal.id);
    final updatedDeal = await _dealDataSource.updateDeal(deal);

    // Log activity if status changed
    if (oldDeal?.status != deal.status) {
      await _activityTrackingService.logDealStatusChanged(
        deal.id,
        deal.title,
        deal.clientId!,
        oldDeal?.status.name ?? 'unknown',
        deal.status.name,
      );
    } else {
      // Log general update
      await _activityTrackingService.logDealUpdated(
        deal.id,
        deal.title,
        deal.clientId!,
        {'updated_fields': ['title', 'amount']},
      );
    }

    return updatedDeal;
  }
}
```

### Activity Timeline Widget

Create a reusable activity timeline widget:

```dart
class ActivityTimelineWidget extends StatelessWidget {
  final String? clientId;
  final String? dealId;
  final int limit;

  const ActivityTimelineWidget({
    Key? key,
    this.clientId,
    this.dealId,
    this.limit = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final activityService = ref.read(crmActivityTrackingServiceProvider);

        Future<List<ActivityModel>> futureActivities;

        if (clientId != null) {
          futureActivities = activityService.getClientActivities(clientId!);
        } else if (dealId != null) {
          futureActivities = activityService.getDealActivities(dealId!);
        } else {
          futureActivities = activityService.getTimeline(limit: limit);
        }

        return FutureBuilder<List<ActivityModel>>(
          future: futureActivities,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final activities = snapshot.data ?? [];

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return _buildActivityItem(activities[index]);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildActivityItem(ActivityModel activity) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getActivityColor(activity.type),
          child: _getActivityIcon(activity.type),
        ),
        title: Text(activity.title),
        subtitle: Text(activity.description),
        trailing: Text(_formatDateTime(activity.activityDate)),
      ),
    );
  }
}
```

## Best Practices

### When to Log Activities

1. **Important Events**
   - Deal creation and updates
   - Status changes
   - Task completion

2. **Client Interactions**
   - All calls and meetings
   - Important emails
   - Document sharing

3. **Milestones**
   - Proposal sent
   - Contract signed
   - Payment received

4. **Notes**
   - Important conversation details
   - Client preferences
   - Next steps

### Activity Content

1. **Clear Titles**
   - Keep titles concise and action-oriented
   - Example: "Phone Call", "Email Sent", "Meeting Held"

2. **Descriptive Descriptions**
   - Include relevant details
   - Mention participants
   - Note outcomes

3. **Rich Metadata**
   - Store additional context
   - Include numeric data (duration, amount)
   - Reference external systems

### Activity Types

1. **Use Existing Types**
   - Prefer standard types when possible
   - Use 'custom' for unique scenarios

2. **Consistent Naming**
   - Follow naming conventions
   - Keep type names lowercase with underscores

### Performance

1. **Lazy Loading**
   - Load activities on demand
   - Use pagination for large datasets

2. **Caching**
   - Cache frequently accessed activities
   - Invalidate cache on new activities

3. **Filtering**
   - Filter on the server when possible
   - Use indexes for common queries

### User Experience

1. **Visual Design**
   - Use consistent icons for each type
   - Color-code by activity type
   - Show clear timestamps

2. **Navigation**
   - Make activities clickable
   - Link to related records (deals, tasks)

3. **Search and Filter**
   - Provide easy-to-use filters
   - Enable text search
   - Show activity counts

## Troubleshooting

### Common Issues

1. **Activities Not Appearing**
   - Check database connection
   - Verify activity was logged
   - Check date filters

2. **Performance Issues**
   - Add database indexes
   - Implement pagination
   - Cache frequently accessed data

3. **Missing Metadata**
   - Check activity creation code
   - Verify metadata structure

### Debugging

Enable logging:

```dart
// Enable Supabase debug logging
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
  debug: true,
);
```

## Future Enhancements

- [ ] Real-time activity updates
- [ ] Activity templates
- [ ] Activity categories
- [ ] Team activity feeds
- [ ] Activity analytics and insights
- [ ] Export activities to CSV/PDF
- [ ] Integration with calendar systems
- [ ] Activity reminders
- [ ] Activity goals and targets
- [ ] Mobile push notifications

## Conclusion

The CRM activity tracking system provides a comprehensive way to log and visualize all client interactions. It automatically captures important events and allows manual logging of custom activities, providing a complete timeline for better customer relationship management.

For more information, refer to:
- [Supabase Data Types](https://supabase.com/docs/guides/database/tables#data-types)
- [Flutter Performance Best Practices](https://docs.flutter.dev/perf/best-practices)
- [Material Design - Timeline](https://material.io/design/communication/activity-feed.html)
