/// Task Detail Screen
/// Educational Project - Gamified Task Management App
///
/// Detailed view of a single task

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../../gamification/providers/gamification_provider.dart';
import '../../gamification/screens/level_up_celebration_screen.dart';

class TaskDetailScreen extends ConsumerStatefulWidget {
  final String taskId;

  const TaskDetailScreen({
    super.key,
    required this.taskId,
  });

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final task = ref.watch(taskNotifierProvider).firstWhere(
          (t) => t.id == widget.taskId,
          orElse: () => null as TaskModel,
        );

    if (task == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Task')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: task.status == TaskStatus.completed
            ? AppTheme.completed
            : AppTheme.primary,
        foregroundColor: AppTheme.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.push('/tasks/${task.id}/edit');
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _showDeleteDialog(task),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Task Header
            _buildTaskHeader(task),

            const SizedBox(height: 24),

            // Task Details
            _buildTaskDetails(task),

            const SizedBox(height: 24),

            // Completion Button
            if (task.status == TaskStatus.pending)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _completeTask,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.check),
                  label: const Text('Complete Task'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.completed,
                    foregroundColor: AppTheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskHeader(TaskModel task) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppTheme.getXPGradient(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: task.status == TaskStatus.completed
                  ? AppTheme.completed
                  : AppTheme.warning,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              task.statusDisplayName,
              style: TextStyle(
                color: AppTheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Title
          Text(
            task.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          // Description
          if (task.description != null)
            Text(
              task.description!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTaskDetails(TaskModel task) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildDetailRow(
            'XP Reward',
            '${task.xp} XP',
            Icons.star,
            AppTheme.xpColor,
          ),
          const Divider(height: 24),
          _buildDetailRow(
            'Priority',
            task.priorityDisplayName,
            _getPriorityIcon(task.priority),
            AppTheme.getPriorityColor(task.priority.name),
          ),
          const Divider(height: 24),
          _buildDetailRow(
            'Category',
            task.category ?? 'No Category',
            Icons.category_outlined,
            AppTheme.textSecondary,
          ),
          const Divider(height: 24),
          _buildDetailRow(
            'Due Date',
            task.dueDate != null
                ? DateFormat('MMM dd, yyyy').format(task.dueDate!)
                : 'No Due Date',
            Icons.calendar_today,
            task.isOverdue
                ? AppTheme.error
                : task.isDueToday
                    ? AppTheme.warning
                    : AppTheme.textSecondary,
          ),
          const Divider(height: 24),
          _buildDetailRow(
            'Created',
            DateFormat('MMM dd, yyyy').format(task.createdAt),
            Icons.create,
            AppTheme.textSecondary,
          ),
          if (task.completedAt != null) ...[
            const Divider(height: 24),
            _buildDetailRow(
              'Completed',
              DateFormat('MMM dd, yyyy').format(task.completedAt!),
              Icons.check_circle,
              AppTheme.completed,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getPriorityIcon(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Icons.arrow_downward;
      case TaskPriority.medium:
        return Icons.remove;
      case TaskPriority.high:
        return Icons.arrow_upward;
      case TaskPriority.urgent:
        return Icons.priority_high;
    }
  }

  void _showDeleteDialog(TaskModel task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref.read(taskNotifierProvider.notifier).deleteTask(task.id);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Task deleted'),
                    backgroundColor: AppTheme.success,
                  ),
                );
                context.pop();
              }
            },
            child: Text(
              'Delete',
              style: TextStyle(
                color: AppTheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _completeTask() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get current XP before completing
      final currentXP = ref.read(currentXPProvider);

      // Complete the task with XP reward
      await ref.read(taskNotifierProvider.notifier).completeTask(
        widget.taskId,
        onLevelUp: () {
          // Show level up celebration
          final oldXP = currentXP;
          final newXP = ref.read(currentXPProvider);
          if (oldXP != null && newXP != null) {
            showLevelUpCelebration(
              context: context,
              oldXP: oldXP,
              newXP: newXP,
            );
          }
        },
      );

      if (mounted) {
        // Get task to show XP reward
        final task = ref.read(taskNotifierProvider).firstWhere(
              (t) => t.id == widget.taskId,
            );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Task completed! +${task.xp} XP',
            ),
            backgroundColor: AppTheme.completed,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
