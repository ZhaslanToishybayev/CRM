/// Task Card Widget
/// Educational Project - Gamified Task Management App
///
/// Displays a task in a card format

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../models/task_model.dart';

class TaskCard extends ConsumerWidget {
  final TaskModel task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.status == TaskStatus.completed
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description != null) ...[
              Text(task.description!),
              const SizedBox(height: 4),
            ],
            Row(
              children: [
                _buildPriorityChip(task.priority),
                const SizedBox(width: 8),
                _buildXPChip(task.xp),
              ],
            ),
          ],
        ),
        trailing: Icon(
          task.status == TaskStatus.completed
              ? Icons.check_circle
              : Icons.radio_button_unchecked,
          color: task.status == TaskStatus.completed
              ? AppTheme.success
              : AppTheme.textSecondary,
        ),
        onTap: () {
          context.push('/tasks/detail/${task.id}');
        },
      ),
    );
  }

  Widget _buildPriorityChip(TaskPriority priority) {
    Color color;
    switch (priority) {
      case TaskPriority.low:
        color = Colors.grey;
        break;
      case TaskPriority.medium:
        color = Colors.blue;
        break;
      case TaskPriority.high:
        color = Colors.orange;
        break;
      case TaskPriority.urgent:
        color = Colors.red;
        break;
    }

    return Chip(
      label: Text(
        priority.name.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildXPChip(int xp) {
    return Chip(
      label: Text(
        '+$xp XP',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: AppTheme.xpColor,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
