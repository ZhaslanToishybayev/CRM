/// Task Card Widget
/// Educational Project - Gamified Task Management App
///
/// Displays a task with priority indicator, XP value, and completion state
/// Used in task lists and dashboards

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.title,
    required this.dueDate,
    required this.priority,
    required this.xp,
    this.isCompleted = false,
    this.onTap,
    this.onComplete,
    this.category,
  });

  /// Task title
  final String title;

  /// Due date text
  final String dueDate;

  /// Task priority (low, medium, high, urgent)
  final String priority;

  /// XP value for completing this task
  final int xp;

  /// Whether task is completed
  final bool isCompleted;

  /// Tap callback
  final VoidCallback? onTap;

  /// Complete callback
  final VoidCallback? onComplete;

  /// Task category
  final String? category;

  @override
  Widget build(BuildContext context) {
    final priorityColor = AppTheme.getPriorityColor(priority);
    final statusColor = isCompleted ? AppTheme.completed : AppTheme.pending;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: isCompleted
                ? Border.all(color: AppTheme.completed, width: 2)
                : null,
          ),
          child: Row(
            children: [
              // Priority indicator bar
              Container(
                width: 4,
                height: 60,
                decoration: BoxDecoration(
                  color: priorityColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        decoration:
                            isCompleted ? TextDecoration.lineThrough : null,
                        color: isCompleted
                            ? AppTheme.textSecondary
                            : AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Due date and category
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_outlined,
                          size: 16,
                          color: statusColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          dueDate,
                          style: TextStyle(
                            fontSize: 14,
                            color: statusColor,
                          ),
                        ),
                        if (category != null) ...[
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              category!,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Right side: Checkbox and XP
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Completion checkbox
                  GestureDetector(
                    onTap: onComplete,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppTheme.completed
                            : AppTheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isCompleted
                              ? AppTheme.completed
                              : AppTheme.textDisabled,
                          width: 2,
                        ),
                      ),
                      child: isCompleted
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // XP value
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppTheme.getXPGradient(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '+$xp XP',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Task card with animation on completion
class AnimatedTaskCard extends StatefulWidget {
  const AnimatedTaskCard({
    super.key,
    required this.title,
    required this.dueDate,
    required this.priority,
    required this.xp,
    this.isCompleted = false,
    this.onTap,
    this.onComplete,
    this.category,
  });

  final String title;
  final String dueDate;
  final String priority;
  final int xp;
  final bool isCompleted;
  final VoidCallback? onTap;
  final VoidCallback? onComplete;
  final String? category;

  @override
  State<AnimatedTaskCard> createState() => _AnimatedTaskCardState();
}

class _AnimatedTaskCardState extends State<AnimatedTaskCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool _wasCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void didUpdateWidget(AnimatedTaskCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCompleted != oldWidget.isCompleted) {
      _wasCompleted = oldWidget.isCompleted;
      if (widget.isCompleted) {
        _controller.forward().then((_) {
          _controller.reverse();
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final priorityColor = AppTheme.getPriorityColor(widget.priority);
    final statusColor =
        widget.isCompleted ? AppTheme.completed : AppTheme.pending;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: widget.isCompleted
                  ? Border.all(color: AppTheme.completed, width: 2)
                  : null,
            ),
            child: Row(
              children: [
                // Priority indicator bar
                Container(
                  width: 4,
                  height: 60,
                  decoration: BoxDecoration(
                    color: priorityColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 16),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: widget.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: widget.isCompleted
                              ? AppTheme.textSecondary
                              : AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Due date and category
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_outlined,
                            size: 16,
                            color: statusColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.dueDate,
                            style: TextStyle(
                              fontSize: 14,
                              color: statusColor,
                            ),
                          ),
                          if (widget.category != null) ...[
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceVariant,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                widget.category!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Right side: Checkbox and XP
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Completion checkbox
                    GestureDetector(
                      onTap: () {
                        widget.onComplete?.call();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: widget.isCompleted
                              ? AppTheme.completed
                              : AppTheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: widget.isCompleted
                                ? AppTheme.completed
                                : AppTheme.textDisabled,
                            width: 2,
                          ),
                        ),
                        child: widget.isCompleted
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // XP value
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppTheme.getXPGradient(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '+${widget.xp} XP',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
