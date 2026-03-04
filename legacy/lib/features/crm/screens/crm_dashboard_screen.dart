import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/crm/client_model.dart';
import '../../../../core/models/crm/deal_model.dart';
import '../services/crm_service.dart';
import '../widgets/notification_badge.dart';

class CrmDashboardScreen extends ConsumerStatefulWidget {
  const CrmDashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CrmDashboardScreen> createState() => _CrmDashboardScreenState();
}

class _CrmDashboardScreenState extends ConsumerState<CrmDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final crmService = ref.read(crmServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CRM Dashboard'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
          NotificationBadge(
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                context.push('/crm/notifications');
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Stats Cards
            _buildQuickStats(context),
            const SizedBox(height: 24),

            // Today's Tasks
            _buildTodaysTasks(context),
            const SizedBox(height: 24),

            // Recent Deals
            _buildRecentDeals(context),
            const SizedBox(height: 24),

            // Recent Activities
            _buildRecentActivities(context),
            const SizedBox(height: 24),

            // Quick Actions
            _buildQuickActions(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showQuickAddMenu(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return FutureBuilder<CrmAnalytics>(
      future: ref.read(crmServiceProvider).getAnalytics(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final analytics = snapshot.data!;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            _buildStatCard(
              context,
              'Total Clients',
              analytics.totalClients.toString(),
              Icons.people,
              Colors.blue,
            ),
            _buildStatCard(
              context,
              'Active Deals',
              analytics.activeDeals.toString(),
              Icons.trending_up,
              Colors.green,
            ),
            _buildStatCard(
              context,
              'Total Revenue',
              '\$${analytics.totalRevenue.toStringAsFixed(0)}',
              Icons.attach_money,
              Colors.orange,
            ),
            _buildStatCard(
              context,
              'Conversion Rate',
              '${analytics.conversionRate.toStringAsFixed(1)}%',
              Icons.percent,
              Colors.purple,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaysTasks(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Tasks",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    context.push('/crm/tasks');
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // TODO: Load and display today's tasks
            const Text('No tasks for today'),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentDeals(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Deals',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    context.push('/crm/deals');
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // TODO: Load and display recent deals
            const Text('No recent deals'),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivities(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activities',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    context.push('/crm/activities');
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // TODO: Load and display recent activities
            const Text('No recent activities'),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildActionButton(
                  context,
                  'New Client',
                  Icons.person_add,
                  () => context.push('/crm/clients/new'),
                ),
                _buildActionButton(
                  context,
                  'New Deal',
                  Icons.add_business,
                  () => context.push('/crm/deals/new'),
                ),
                _buildActionButton(
                  context,
                  'Add Task',
                  Icons.task_alt,
                  () => context.push('/crm/tasks/new'),
                ),
                _buildActionButton(
                  context,
                  'View Activities',
                  Icons.history,
                  () => context.push('/crm/activities'),
                ),
                _buildActionButton(
                  context,
                  'Sales Reports',
                  Icons.analytics,
                  () => context.push('/crm/reports'),
                ),
                _buildActionButton(
                  context,
                  'Sales Funnel',
                  Icons.filter_alt,
                  () => context.push('/crm/funnel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  void _showQuickAddMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quick Add',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('New Client'),
              onTap: () {
                Navigator.pop(context);
                context.push('/crm/clients/new');
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_business),
              title: const Text('New Deal'),
              onTap: () {
                Navigator.pop(context);
                context.push('/crm/deals/new');
              },
            ),
            ListTile(
              leading: const Icon(Icons.task_alt),
              title: const Text('New Task'),
              onTap: () {
                Navigator.pop(context);
                context.push('/crm/tasks/new');
              },
            ),
          ],
        ),
      ),
    );
  }
}
