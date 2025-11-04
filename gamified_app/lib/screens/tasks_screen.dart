/// Tasks Screen with Supabase
/// Educational Project - Gamified Task Management App

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers_supabase.dart';
import '../core/models/task_model.dart';
import '../core/models/user_stats_model.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final tasksAsync = ref.watch(tasksProvider(currentUser?.id ?? ''));
    final userStatsAsync = ref.watch(userStatsProvider(currentUser?.id ?? ''));
    final authMethods = ref.read(authMethodsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${currentUser?.email ?? 'User'}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              GoRouter.of(context).go('/tasks/profile');
            },
            tooltip: 'Profile',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authMethods.signOut().then((_) {
              context.go('/login');
            }),
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Card
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: userStatsAsync.when(
                data: (userStats) {
                  final stats = userStats ?? UserStatsModel(
                    id: currentUser?.id ?? '',
                    username: currentUser?.email ?? 'User',
                    email: currentUser?.email ?? '',
                    xp: 0,
                    level: 1,
                    streak: 0,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );
                  return Column(
                    children: [
                      Text(
                        'Your Stats',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('Level', stats.level.toString(), Icons.trending_up),
                          _buildStatItem('XP', stats.xp.toString(), Icons.stars),
                          _buildStatItem('Streak', '${stats.streak}', Icons.local_fire_department),
                        ],
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Text('Error: $error'),
              ),
            ),
          ),
          // Task List
          Expanded(
            child: tasksAsync.when(
              data: (tasks) {
                if (tasks.isEmpty) {
                  return const Center(
                    child: Text('No tasks yet. Tap + to add one!'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(
                          task.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (task.description.isNotEmpty) ...[
                              Text(task.description),
                              const SizedBox(height: 4),
                            ],
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor(task.priority).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    task.priority.name.toUpperCase(),
                                    style: TextStyle(
                                      color: _getPriorityColor(task.priority),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  task.category,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                if (task.dueDate != null) ...[
                                  const SizedBox(width: 8),
                                  Text(
                                    'Due: ${formatDate(task.dueDate!)}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isOverdue(task.dueDate!) ? Colors.red : Colors.grey,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                ref.read(tasksProvider(task.userId).notifier).deleteTask(task.id);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                task.isCompleted ? Icons.undo : Icons.check_circle,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                ref.read(tasksProvider(task.userId).notifier).completeTask(task.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error loading tasks: $error'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref.refresh(tasksProvider(currentUser?.id ?? ''));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, ref, currentUser?.id ?? ''),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.green),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.low:
        return Colors.green;
    }
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  bool isOverdue(DateTime? dueDate) {
    if (dueDate == null) return false;
    return DateTime.now().isAfter(dueDate);
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref, String userId) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    TaskPriority priority = TaskPriority.medium;
    String category = 'General';
    DateTime? dueDate;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title *'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<TaskPriority>(
                    value: priority,
                    decoration: const InputDecoration(labelText: 'Priority'),
                    items: TaskPriority.values.map((p) {
                      return DropdownMenuItem(
                        value: p,
                        child: Text(p.name.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() {
                          priority = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: category,
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: ['Work', 'Personal', 'Shopping', 'Health', 'General']
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() {
                          category = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        setDialogState(() {
                          dueDate = date;
                        });
                      }
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: Text(dueDate != null
                        ? 'Due: ${formatDate(dueDate!)}'
                        : 'Set Due Date'),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final task = TaskModel.create(
                  userId: userId,
                  title: titleController.text,
                  description: descriptionController.text,
                  priority: priority,
                  category: category,
                  dueDate: dueDate,
                );
                ref.read(tasksProvider(userId).notifier).addTask(task);
                Navigator.pop(context);
              }
            },
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }
}
