# CRM System Integration with Supabase

## Overview

This document provides a comprehensive guide for integrating the CRM system with Supabase, including database schema, data sources, and service configuration.

## Table of Contents

1. [Database Schema](#database-schema)
2. [Setup Instructions](#setup-instructions)
3. [Data Sources](#data-sources)
4. [Service Layer](#service-layer)
5. [Models](#models)
6. [Screens](#screens)
7. [Usage Examples](#usage-examples)
8. [Troubleshooting](#troubleshooting)

## Database Schema

### Tables

The CRM system uses the following tables in Supabase:

1. **crm_clients** - Stores client information
2. **crm_companies** - Stores company information
3. **crm_deals** - Stores sales deals/opportunities
4. **crm_tasks** - Stores CRM tasks (calls, emails, meetings, etc.)
5. **crm_activities** - Stores activity history
6. **crm_pipelines** - Stores sales pipelines
7. **crm_pipeline_stages** - Stores pipeline stages

### Schema File

The complete SQL schema is available in:
```
supabase_crm_schema.sql
```

## Setup Instructions

### 1. Create Supabase Project

1. Go to [Supabase](https://supabase.com)
2. Create a new project
3. Note your project URL and API key

### 2. Configure Environment Variables

Create/update `.env` file:

```env
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 3. Run Database Schema

1. Go to Supabase Dashboard > SQL Editor
2. Copy the contents of `supabase_crm_schema.sql`
3. Run the SQL to create all tables, indexes, and policies

### 4. Enable Row Level Security (RLS)

RLS is enabled on all CRM tables. The schema includes basic policies that allow all authenticated users to read/write. You can customize these policies based on your needs.

### 5. Install Dependencies

Ensure you have the required dependencies in `pubspec.yaml`:

```yaml
dependencies:
  supabase_flutter: ^2.0.0
  riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0

dev_dependencies:
  riverpod_generator: ^2.3.0
  build_runner: ^2.4.0
```

Run:
```bash
flutter pub get
```

### 6. Generate Code

Run the code generator:
```bash
dart run build_runner build
```

## Data Sources

The system uses a data source pattern for separating data access logic:

### Available Data Sources

1. **SupabaseClientDataSource** - Client CRUD operations
2. **SupabaseDealDataSource** - Deal CRUD operations
3. **SupabaseCompanyDataSource** - Company CRUD operations
4. **SupabaseCrmTaskDataSource** - CRM task CRUD operations
5. **SupabaseActivityDataSource** - Activity CRUD operations
6. **SupabasePipelineDataSource** - Pipeline CRUD operations

### File Structure

```
lib/features/crm/data_sources/
├── supabase_client_data_source.dart
├── supabase_deal_data_source.dart
├── supabase_company_data_source.dart
├── supabase_crm_task_data_source.dart
├── supabase_activity_data_source.dart
└── supabase_pipeline_data_source.dart
```

## Service Layer

The `CrmService` class provides a high-level API for all CRM operations. It uses the data sources to interact with Supabase.

### Key Features

- Automatic error handling
- Type-safe operations
- Comprehensive CRUD operations
- Analytics calculations
- Search capabilities

### File Location

```
lib/features/crm/services/crm_service.dart
```

## Models

All CRM models are located in:

```
lib/core/models/crm/
├── client_model.dart
├── deal_model.dart
├── company_model.dart
├── crm_task_model.dart
├── activity_model.dart
└── pipeline_model.dart
```

All models are generated using Freezed for immutability and pattern matching.

## Screens

The CRM system includes the following screens:

1. **CrmDashboardScreen** - Main CRM dashboard with analytics
2. **ClientsScreen** - Client list with filtering and search
3. **DealsScreen** - Deals with Kanban pipeline and list views
4. **CrmTasksScreen** - CRM task management

### File Locations

```
lib/features/crm/screens/
├── crm_dashboard_screen.dart
├── clients_screen.dart
├── deals_screen.dart
└── crm_tasks_screen.dart
```

## Usage Examples

### Getting All Clients

```dart
final crmService = ref.read(crmServiceProvider);
final clients = await crmService.getClients();
```

### Creating a New Client

```dart
final newClient = ClientModel(
  id: DateTime.now().millisecondsSinceEpoch.toString(),
  firstName: 'John',
  lastName: 'Doe',
  email: 'john.doe@example.com',
  status: ClientStatus.lead,
  source: 'manual',
  leadScore: 50,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final createdClient = await crmService.createClient(newClient);
```

### Getting Analytics

```dart
final analytics = await crmService.getAnalytics();
print('Total Clients: ${analytics.totalClients}');
print('Total Revenue: \$${analytics.totalRevenue}');
print('Conversion Rate: ${analytics.conversionRate}%');
```

### Filtering Deals by Status

```dart
final deals = await crmService.getDeals();
final wonDeals = deals.where((deal) => deal.status == DealStatus.won).toList();
```

### Creating a CRM Task

```dart
final task = CrmTaskModel(
  id: DateTime.now().millisecondsSinceEpoch.toString(),
  title: 'Follow up with client',
  description: 'Schedule a follow-up call',
  type: CrmTaskType.call,
  status: CrmTaskStatus.pending,
  priority: CrmTaskPriority.high,
  dueDate: DateTime.now().add(Duration(days: 1)),
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final createdTask = await crmService.createCrmTask(task);
```

## Routing

The CRM screens are accessible via the following routes:

- `/crm` - CRM Dashboard
- `/crm/clients` - Clients Screen
- `/crm/deals` - Deals Screen
- `/crm/tasks` - CRM Tasks Screen

Navigation example:
```dart
context.push('/crm/clients');
context.go('/crm/deals');
```

## Architecture

### Data Flow

```
UI Screens
    ↓
CrmService
    ↓
Data Sources
    ↓
Supabase Client
    ↓
PostgreSQL Database
```

### Dependency Injection

The system uses Riverpod for dependency injection. The `CrmService` is provided as a singleton:

```dart
@Riverpod(keepAlive: true)
CrmService crmService(CrmServiceRef ref) {
  return CrmService();
}
```

Access it in your widgets:
```dart
final crmService = ref.read(crmServiceProvider);
```

## Security

### Row Level Security (RLS)

All tables have RLS enabled. The schema includes basic policies that allow authenticated users to read/write. For production, consider:

1. User-specific policies
2. Team-based access control
3. Audit logging
4. Data encryption

### Authentication

The system integrates with Supabase Auth. Ensure users are authenticated before accessing CRM data.

## Performance Optimization

### Indexes

The schema includes indexes on frequently queried columns:

- Client status and email
- Deal status and stage
- Task due dates
- Activity dates

### Best Practices

1. Use pagination for large datasets
2. Cache frequently accessed data
3. Use selective queries
4. Optimize image uploads

## Troubleshooting

### Common Issues

1. **Table not found error**
   - Ensure schema is executed in Supabase
   - Check table names match exactly

2. **RLS Policy errors**
   - Verify user is authenticated
   - Check policy definitions

3. **Network errors**
   - Verify Supabase URL and API key
   - Check internet connection

4. **Data type errors**
   - Ensure model fields match database columns
   - Check JSON serialization

### Debugging

Enable debug logging:
```dart
import 'package:supabase_flutter/supabase_flutter.dart';

await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
  debug: true,
);
```

### Getting Help

- Check the [Supabase Flutter docs](https://supabase.com/docs/reference/dart)
- Review [Dart/Flutter troubleshooting](https://docs.flutter.dev/testing/debugging)
- Open an issue on GitHub

## Testing

### Unit Tests

Test data sources and services:
```bash
flutter test test/unit/crm/
```

### Integration Tests

Test end-to-end flows:
```bash
flutter test test/integration/crm/
```

### Test Data

Use the sample data in `supabase_crm_schema.sql` for testing.

## Production Deployment

### Checklist

- [ ] Configure production Supabase project
- [ ] Update environment variables
- [ ] Set up RLS policies for production
- [ ] Enable database backups
- [ ] Set up monitoring and alerts
- [ ] Configure SSL/TLS
- [ ] Set up error tracking (Sentry)

### Monitoring

Track:
- Database performance
- API response times
- Error rates
- User activity

## Future Enhancements

- [ ] Real-time subscriptions
- [ ] Offline support
- [ ] File uploads
- [ ] Advanced analytics
- [ ] Email integration
- [ ] Calendar integration
- [ ] Webhook support
- [ ] Data export

## Conclusion

This CRM system provides a solid foundation for customer relationship management with Supabase. The architecture is scalable, maintainable, and follows Flutter/Dart best practices.

For more information, refer to:
- [Supabase Documentation](https://supabase.com/docs)
- [Flutter Documentation](https://docs.flutter.dev)
- [Riverpod Documentation](https://riverpod.dev)
