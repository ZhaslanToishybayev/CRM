/// Project Card Widget
/// Displays project information in a card format

import 'package:flutter/material.dart';
import '../models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProjectCard({
    Key? key,
    required this.project,
    this.onTap,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  // Project icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _parseColor(project.color ?? '#2196F3'),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getIconData(project.icon),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Project name and status
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _buildStatusChip(context),
                            const SizedBox(width: 8),
                            _buildPriorityChip(context),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Menu button
                  if (onEdit != null || onDelete != null)
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        switch (value) {
                          case 'edit':
                            onEdit?.call();
                            break;
                          case 'delete':
                            _showDeleteDialog(context);
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        if (onEdit != null)
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 18),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          ),
                        if (onDelete != null)
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, size: 18),
                                SizedBox(width: 8),
                                Text('Delete'),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // Description
              if (project.description != null) ...[
                Text(
                  project.description!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
              ],

              // Progress bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      Text(
                        '${project.completionPercentage}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: _parseColor(project.statusColor),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: project.completionPercentage / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _parseColor(project.statusColor),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Stats row
              Row(
                children: [
                  Expanded(
                    child: _buildStat(
                      context,
                      icon: Icons.task_alt_outlined,
                      label: 'Tasks',
                      value: '${project.completedTasks}/${project.totalTasks}',
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: _buildStat(
                      context,
                      icon: Icons.people_outline,
                      label: 'Members',
                      value: '${project.memberIds.length}',
                      color: Colors.green,
                    ),
                  ),
                  if (project.totalBudget > 0)
                    Expanded(
                      child: _buildStat(
                        context,
                        icon: Icons.account_balance_wallet_outlined,
                        label: 'Budget',
                        value: '${project.spentBudget}/${project.totalBudget}',
                        color: Colors.orange,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // Dates row
              if (project.dueDate != null) ...[
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: project.isOverdue
                          ? Colors.red
                          : project.isDueSoon
                              ? Colors.orange
                              : Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Due: ${_formatDate(project.dueDate!)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: project.isOverdue
                                ? Colors.red
                                : project.isDueSoon
                                    ? Colors.orange
                                    : Colors.grey[600],
                            fontWeight: project.isOverdue || project.isDueSoon
                                ? FontWeight.bold
                                : null,
                          ),
                    ),
                    if (project.isOverdue) ...[
                      const SizedBox(width: 4),
                      Icon(Icons.error_outline, size: 14, color: Colors.red),
                      const SizedBox(width: 4),
                      Text(
                        'Overdue',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ] else if (project.isDueSoon) ...[
                      const SizedBox(width: 4),
                      Icon(Icons.schedule, size: 14, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        'Due Soon',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    final status = project.status;
    final statusColor = _parseColor(project.statusColor);

    IconData icon;
    switch (status) {
      case ProjectStatus.planning:
        icon = Icons.planning;
        break;
      case ProjectStatus.active:
        icon = Icons.play_circle_outline;
        break;
      case ProjectStatus.onHold:
        icon = Icons.pause_circle_outline;
        break;
      case ProjectStatus.completed:
        icon = Icons.check_circle;
        break;
      case ProjectStatus.cancelled:
        icon = Icons.cancel;
        break;
    }

    return Chip(
      avatar: Icon(icon, size: 16, color: statusColor),
      label: Text(
        project.statusDisplayName,
        style: TextStyle(color: statusColor, fontSize: 12),
      ),
      backgroundColor: statusColor.withOpacity(0.1),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildPriorityChip(BuildContext context) {
    final priority = project.priority;
    final priorityColor = _parseColor(project.priorityColor);

    IconData icon;
    switch (priority) {
      case ProjectPriority.low:
        icon = Icons.low_priority;
        break;
      case ProjectPriority.medium:
        icon = Icons.remove;
        break;
      case ProjectPriority.high:
        icon = Icons.priority_high;
        break;
      case ProjectPriority.critical:
        icon = Icons.report_problem;
        break;
    }

    return Chip(
      avatar: Icon(icon, size: 16, color: priorityColor),
      label: Text(
        project.priorityDisplayName,
        style: TextStyle(color: priorityColor, fontSize: 12),
      ),
      backgroundColor: priorityColor.withOpacity(0.1),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Project'),
        content: Text('Are you sure you want to delete "${project.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDelete?.call();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Color _parseColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    final color = int.parse(hexColor, radix: 16);
    return Color(color | 0xFF000000);
  }

  IconData _getIconData(String? iconName) {
    if (iconName == null) return Icons.folder;

    switch (iconName) {
      case 'software':
        return Icons.code;
      case 'mobile':
        return Icons.phone_android;
      case 'web':
        return Icons.web;
      case 'marketing':
        return Icons.campaign;
      case 'design':
        return Icons.design_services;
      case 'research':
        return Icons.science;
      default:
        return Icons.folder;
    }
  }
}

/// Project progress indicator
class ProjectProgressIndicator extends StatelessWidget {
  final double percentage;
  final String? label;
  final Color? color;

  const ProjectProgressIndicator({
    Key? key,
    required this.percentage,
    this.label,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                '${percentage.toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

/// Budget usage indicator
class BudgetIndicator extends StatelessWidget {
  final int spent;
  final int total;
  final Color? color;

  const BudgetIndicator({
    Key? key,
    required this.spent,
    required this.total,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentage = total > 0 ? (spent / total) * 100 : 0.0;
    final isOverBudget = percentage > 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Budget Usage',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '${percentage.toStringAsFixed(0)}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isOverBudget ? Colors.red : null,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: (percentage / 100).clamp(0.0, 1.0),
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? (isOverBudget ? Colors.red : Colors.green),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$spent / $total',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}
