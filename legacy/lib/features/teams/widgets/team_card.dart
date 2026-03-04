/// Team Card Widget
/// Displays team information in a card format

import 'package:flutter/material.dart';
import '../models/team_model.dart';
import '../models/team_member_model.dart';

class TeamCard extends StatelessWidget {
  final TeamModel team;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TeamCard({
    Key? key,
    required this.team,
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
              // Header with icon, name, and menu
              Row(
                children: [
                  // Team icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _parseColor(team.displayColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getIconData(team.icon),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Team name and status
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          team.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _buildStatusChip(context),
                            const SizedBox(width: 8),
                            _buildCapacityChip(context),
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

              // Team description
              if (team.description != null) ...[
                Text(
                  team.description!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
              ],

              // Stats row
              Row(
                children: [
                  _buildStat(
                    context,
                    icon: Icons.people_outline,
                    label: 'Members',
                    value: '${team.activeMembers}',
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 16),
                  _buildStat(
                    context,
                    icon: Icons.task_alt_outlined,
                    label: 'Tasks',
                    value: '${team.completedTasks}/${team.totalTasks}',
                    color: Colors.green,
                  ),
                  const SizedBox(width: 16),
                  _buildStat(
                    context,
                    icon: Icons.percent,
                    label: 'Complete',
                    value: '${team.completionPercentage.toStringAsFixed(0)}%',
                    color: Colors.orange,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Progress bar
              LinearProgressIndicator(
                value: team.completionPercentage / 100,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _parseColor(team.displayColor),
                ),
              ),
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
    return Expanded(
      child: Column(
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
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    final status = team.status;
    Color color;
    IconData icon;

    switch (status) {
      case 'Planning':
        color = Colors.grey;
        icon = Icons.planning;
        break;
      case 'Active':
        color = Colors.blue;
        icon = Icons.play_circle_outline;
        break;
      case 'Completed':
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      default:
        color = Colors.grey;
        icon = Icons.help;
    }

    return Chip(
      avatar: Icon(icon, size: 16, color: color),
      label: Text(
        status,
        style: TextStyle(color: color, fontSize: 12),
      ),
      backgroundColor: color.withOpacity(0.1),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildCapacityChip(BuildContext context) {
    if (team.memberLimit == null) {
      return const SizedBox.shrink();
    }

    final isAtCapacity = team.isAtCapacity;
    final color = isAtCapacity ? Colors.red : Colors.green;

    return Chip(
      label: Text(
        '${team.activeMembers}/${team.memberLimit}',
        style: TextStyle(color: color, fontSize: 12),
      ),
      backgroundColor: color.withOpacity(0.1),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Team'),
        content: Text('Are you sure you want to delete "${team.name}"?'),
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
    // Remove # if present
    hexColor = hexColor.replaceAll('#', '');

    // Convert to integer
    final color = int.parse(hexColor, radix: 16);

    // Return color with alpha
    return Color(color | 0xFF000000);
  }

  IconData _getIconData(String? iconName) {
    if (iconName == null) return Icons.group;

    switch (iconName) {
      case 'developers':
        return Icons.code;
      case 'designers':
        return Icons.design_services;
      case 'marketing':
        return Icons.campaign;
      case 'sales':
        return Icons.sales;
      case 'support':
        return Icons.support_agent;
      default:
        return Icons.group;
    }
  }
}

/// Team member avatar widget
class TeamMemberAvatar extends StatelessWidget {
  final String userId;
  final String? avatarUrl;
  final String? fullName;
  final double size;

  const TeamMemberAvatar({
    Key? key,
    required this.userId,
    this.avatarUrl,
    this.fullName,
    this.size = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initials = (fullName ?? 'User').split(' ').map((e) => e[0]).take(2).join();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _getColorFromId(userId),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          initials.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Color _getColorFromId(String id) {
    final hash = id.hashCode;
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
    ];
    return colors[hash.abs() % colors.length];
  }
}

/// Team member avatars row
class TeamMemberAvatarsRow extends StatelessWidget {
  final List<TeamMemberModel> members;
  final int maxDisplay;

  const TeamMemberAvatarsRow({
    Key? key,
    required this.members,
    this.maxDisplay = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayMembers = members.take(maxDisplay).toList();
    final remainingCount = members.length - maxDisplay;

    return Row(
      children: [
        for (int i = 0; i < displayMembers.length; i++)
          Padding(
            padding: EdgeInsets.only(left: i > 0 ? -8.0 : 0),
            child: TeamMemberAvatar(
              userId: displayMembers[i].userId,
              fullName: displayMembers[i].userId, // TODO: Get from user service
            ),
          ),
        if (remainingCount > 0)
          Padding(
            padding: const EdgeInsets.only(left: -8.0),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  '+$remainingCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
