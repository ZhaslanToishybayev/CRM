import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/crm/crm_task_model.dart';
import '../services/crm_service.dart';

class CrmTasksScreen extends ConsumerStatefulWidget {
  const CrmTasksScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CrmTasksScreen> createState() => _CrmTasksScreenState();
}

class _CrmTasksScreenState extends ConsumerState<CrmTasksScreen> {
  TaskType? _selectedTypeFilter;
  TaskStatus? _selectedStatusFilter;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final crmService = ref.read(crmServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CRM Tasks'),
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

          // Task List
          Expanded(
            child: _buildTaskList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/crm/tasks/new');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Type Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTypeFilterChip('All', null),
                const SizedBox(width: 8),
                _buildTypeFilterChip('Call', TaskType.call),
                const SizedBox(width: 8),
                _buildTypeFilterChip('Email', TaskType.email),
                const SizedBox(width: 8),
                _buildTypeFilterChip('Meeting', TaskType.meeting),
                const SizedBox(width: 8),
                _buildTypeFilterChip('Follow-up', TaskType.followUp),
                const SizedBox(width: 8),
                _buildTypeFilterChip('Task', TaskType.other),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Status Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildStatusFilterChip('All', null),
                const SizedBox(width: 8),
                _buildStatusFilterChip('Pending', TaskStatus.pending),
                const SizedBox(width: 8),
                _buildStatusFilterChip('In Progress', TaskStatus.inProgress),
                const SizedBox(width: 8),
                _buildStatusFilterChip('Completed', TaskStatus.completed),
                const SizedBox(width: 8),
                _buildStatusFilterChip('Cancelled', TaskStatus.cancelled),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeFilterChip(String label, TaskType? type) {
    final isSelected = _selectedTypeFilter == type;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedTypeFilter = selected ? type : null;
        });
      },
      backgroundColor: isSelected
          ? Theme.of(context).colorScheme.primaryContainer
          : null,
      checkmarkColor: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildStatusFilterChip(String label, TaskStatus? status) {
    final isSelected = _selectedStatusFilter == status;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedStatusFilter = selected ? status : null;
        });
      },
      backgroundColor: isSelected
          ? Theme.of(context).colorScheme.secondaryContainer
          : null,
      checkmarkColor: Theme.of(context).colorScheme.secondary,
    );
  }

  Widget _buildTaskList() {
    final crmService = ref.read(crmServiceProvider);

    return FutureBuilder<List<CrmTaskModel>>(
      future: crmService.getCrmTasks(),
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
                  'Error loading tasks',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        }

        final tasks = snapshot.data ?? [];

        if (tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.task_alt_outlined, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'No tasks found',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Create your first CRM task to get started',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    context.push('/crm/tasks/new');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Create Task'),
                ),
              ],
            ),
          );
        }

        // Filter tasks
        var filteredTasks = tasks;
        if (_selectedTypeFilter != null) {
          filteredTasks = filteredTasks.where((t) => t.type == _selectedTypeFilter).toList();
        }
        if (_selectedStatusFilter != null) {
          filteredTasks = filteredTasks.where((t) => t.status == _selectedStatusFilter).toList();
        }

        if (filteredTasks.isEmpty) {
          return const Center(
            child: Text('No tasks match the selected filters'),
          );
        }

        // Sort by due date (handle nulls)
        filteredTasks.sort((a, b) {
          final aDate = a.dueDate;
          final bDate = b.dueDate;
          if (aDate == null && bDate == null) return 0;
          if (aDate == null) return 1;
          if (bDate == null) return -1;
          return aDate.compareTo(bDate);
        });

        return RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              final task = filteredTasks[index];
              return _buildTaskCard(context, task);
            },
          ),
        );
      },
    );
  }

  Widget _buildTaskCard(BuildContext context, CrmTaskModel task) {
    final isOverdue = task.dueDate != null &&
        task.dueDate!.isBefore(DateTime.now()) &&
        task.status != TaskStatus.completed;
    final isToday = task.dueDate != null &&
        task.dueDate!.year == DateTime.now().year &&
        task.dueDate!.month == DateTime.now().month &&
        task.dueDate!.day == DateTime.now().day;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getTypeColor(task.type),
          child: _getTypeIcon(task.type),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: task.status == TaskStatus.completed ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description != null && task.description!.isNotEmpty)
              Text(
                task.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: isOverdue ? Colors.red : Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDueDate(task.dueDate, isToday, isOverdue),
                  style: TextStyle(
                    color: isOverdue ? Colors.red : null,
                    fontSize: 12,
                  ),
                ),
                if (task.clientName != null) ...[
                  const SizedBox(width: 12),
                  Icon(
                    Icons.person,
                    size: 14,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    task.clientName!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (task.status != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(task.status!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  task.status!.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            const SizedBox(height: 4),
            if (task.priority != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task.priority!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  task.priority!.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        onTap: () {
          context.push('/crm/tasks/${task.id}');
        },
      ),
    );
  }

  Color _getTypeColor(TaskType type) {
    switch (type) {
      case TaskType.call:
        return Colors.green;
      case TaskType.email:
        return Colors.blue;
      case TaskType.meeting:
        return Colors.orange;
      case TaskType.followUp:
        return Colors.purple;
      case TaskType.demo:
        return Colors.indigo;
      case TaskType.proposal:
        return Colors.cyan;
      case TaskType.contract:
        return Colors.blueGrey;
      case TaskType.support:
        return Colors.lime;
      case TaskType.other:
        return Colors.teal;
    }
  }

  Icon _getTypeIcon(TaskType type) {
    switch (type) {
      case TaskType.call:
        return const Icon(Icons.phone, color: Colors.white, size: 20);
      case TaskType.email:
        return const Icon(Icons.email, color: Colors.white, size: 20);
      case TaskType.meeting:
        return const Icon(Icons.people, color: Colors.white, size: 20);
      case TaskType.followUp:
        return const Icon(Icons.refresh, color: Colors.white, size: 20);
      case TaskType.demo:
        return const Icon(Icons.play_circle, color: Colors.white, size: 20);
      case TaskType.proposal:
        return const Icon(Icons.description, color: Colors.white, size: 20);
      case TaskType.contract:
        return const Icon(Icons.file_copy, color: Colors.white, size: 20);
      case TaskType.support:
        return const Icon(Icons.headset, color: Colors.white, size: 20);
      case TaskType.other:
        return const Icon(Icons.task, color: Colors.white, size: 20);
    }
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return Colors.grey;
      case TaskStatus.inProgress:
        return Colors.blue;
      case TaskStatus.completed:
        return Colors.green;
      case TaskStatus.cancelled:
        return Colors.red;
      case TaskStatus.overdue:
        return Colors.deepOrange;
    }
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.grey;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.urgent:
        return Colors.purple;
    }
  }

  String _formatDueDate(DateTime? dueDate, bool isToday, bool isOverdue) {
    if (dueDate == null) return 'No due date';

    if (isToday) {
      return 'Today ${TimeOfDay.fromDateTime(dueDate).format(context)}';
    } else if (isOverdue) {
      return 'Overdue ${_formatDate(dueDate)}';
    } else {
      return _formatDate(dueDate);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${TimeOfDay.fromDateTime(date).format(context)}';
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
              'Filter Tasks',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.all_inclusive),
              title: const Text('All Tasks'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedTypeFilter = null;
                  _selectedStatusFilter = null;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.pending),
              title: const Text('Pending'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedStatusFilter = TaskStatus.pending;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.sync),
              title: const Text('In Progress'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedStatusFilter = TaskStatus.inProgress;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text('Completed'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedStatusFilter = TaskStatus.completed;
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
        title: const Text('Search Tasks'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Enter task title or description...',
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
              _performSearch();
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Searching for: $query'),
        ),
      );
    }
  }
}
