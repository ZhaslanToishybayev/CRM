import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/crm/activity_model.dart';
import '../services/crm_activity_tracking_service.dart';

class ActivityTimelineScreen extends ConsumerStatefulWidget {
  final String? clientId;
  final String? dealId;

  const ActivityTimelineScreen({
    Key? key,
    this.clientId,
    this.dealId,
  }) : super(key: key);

  @override
  ConsumerState<ActivityTimelineScreen> createState() => _ActivityTimelineScreenState();
}

class _ActivityTimelineScreenState extends ConsumerState<ActivityTimelineScreen> {
  ActivityType? _selectedFilter;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activityService = ref.read(crmActivityTrackingServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clientId != null ? 'Client Activities' : 'Activity Timeline'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterMenu,
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters
          _buildFilters(),
          const Divider(height: 1),

          // Activity Timeline
          Expanded(
            child: _buildActivityTimeline(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddActivityDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip('All', null),
            const SizedBox(width: 8),
            _buildFilterChip('Calls', ActivityType.call),
            const SizedBox(width: 8),
            _buildFilterChip('Emails', ActivityType.email),
            const SizedBox(width: 8),
            _buildFilterChip('Meetings', ActivityType.meeting),
            const SizedBox(width: 8),
            _buildFilterChip('Notes', ActivityType.note),
            const SizedBox(width: 8),
            _buildFilterChip('Deals', ActivityType.deal),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, ActivityType? type) {
    final isSelected = _selectedFilter == type;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? type : null;
        });
      },
      backgroundColor: isSelected
          ? Theme.of(context).colorScheme.primaryContainer
          : null,
      checkmarkColor: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildActivityTimeline() {
    final activityService = ref.read(crmActivityTrackingServiceProvider);

    Future<List<ActivityModel>> futureActivities;

    if (widget.clientId != null) {
      futureActivities = activityService.getClientActivities(widget.clientId!);
    } else if (widget.dealId != null) {
      futureActivities = activityService.getDealActivities(widget.dealId!);
    } else {
      futureActivities = activityService.getRecentActivities(limit: 50);
    }

    return FutureBuilder<List<ActivityModel>>(
      future: futureActivities,
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
                  'Error loading activities',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        }

        var activities = snapshot.data ?? [];

        // Filter activities by type
        if (_selectedFilter != null) {
          activities = activities.where((a) => a.type == _selectedFilter).toList();
        }

        if (activities.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timeline, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No activities yet',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Activities will appear here as they happen',
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
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return _buildActivityItem(context, activity);
            },
          ),
        );
      },
    );
  }

  Widget _buildActivityItem(BuildContext context, ActivityModel activity) {
    final theme = Theme.of(context);
    final isLast = false; // Can be used for styling

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline line
        Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: _getActivityColor(activity.type),
              child: _getActivityIcon(activity.type),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 16),

        // Activity content
        Expanded(
          child: Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        activity.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _formatDateTime(activity.createdAt),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (activity.description != null)
                    Text(
                      activity.description!,
                      style: theme.textTheme.bodyMedium,
                    ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getActivityColor(activity.type).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      activity.type.displayName,
                      style: TextStyle(
                        color: _getActivityColor(activity.type),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getActivityColor(ActivityType type) {
    switch (type) {
      case ActivityType.call:
        return Colors.green;
      case ActivityType.email:
        return Colors.blue;
      case ActivityType.meeting:
        return Colors.orange;
      case ActivityType.note:
        return Colors.purple;
      case ActivityType.deal:
        return Colors.teal;
      case ActivityType.task:
        return Colors.indigo;
      case ActivityType.sms:
        return Colors.pink;
      case ActivityType.videoCall:
        return Colors.brown;
      case ActivityType.social:
        return Colors.blueGrey;
      case ActivityType.other:
        return Colors.grey;
    }
  }

  Icon _getActivityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.call:
        return const Icon(Icons.phone, color: Colors.white, size: 20);
      case ActivityType.email:
        return const Icon(Icons.email, color: Colors.white, size: 20);
      case ActivityType.meeting:
        return const Icon(Icons.people, color: Colors.white, size: 20);
      case ActivityType.note:
        return const Icon(Icons.note, color: Colors.white, size: 20);
      case ActivityType.deal:
        return const Icon(Icons.trending_up, color: Colors.white, size: 20);
      case ActivityType.task:
        return const Icon(Icons.check_circle, color: Colors.white, size: 20);
      case ActivityType.sms:
        return const Icon(Icons.message, color: Colors.white, size: 20);
      case ActivityType.videoCall:
        return const Icon(Icons.videocam, color: Colors.white, size: 20);
      case ActivityType.social:
        return const Icon(Icons.share, color: Colors.white, size: 20);
      case ActivityType.other:
        return const Icon(Icons.info, color: Colors.white, size: 20);
    }
  }

  String _formatDateTime(DateTime dateTime) {
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
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
    }
  }

  void _showFilterMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Activities',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.all_inclusive),
              title: const Text('All Activities'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedFilter = null;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Calls'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedFilter = ActivityType.call;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Emails'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedFilter = ActivityType.email;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Meetings'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedFilter = ActivityType.meeting;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Activities'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Enter search term...',
            prefixIcon: Icon(Icons.search),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _searchController.clear();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement search functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Searching for: ${_searchController.text}'),
                ),
              );
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _showAddActivityDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Activity'),
        content: const Text('Activity type selection would go here'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Activity added!'),
                ),
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
