/// Streak Counter Widget
/// Educational Project - Gamified Task Management App
///
/// Displays daily task completion streak with fire emoji animation
/// Used in dashboard and profile screens

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class StreakCounter extends StatelessWidget {
  const StreakCounter({
    super.key,
    required this.streakCount,
    this.size = 120,
    this.showLabel = true,
  });

  /// Current streak count
  final int streakCount;

  /// Size of the counter
  final double size;

  /// Whether to show "day streak" label
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppTheme.getStreakGradient(),
        boxShadow: [
          BoxShadow(
            color: AppTheme.streakColor.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Fire emoji with animation
          Text(
            '🔥',
            style: TextStyle(
              fontSize: size * 0.4,
            ),
          )
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .shimmer(
                duration: const Duration(milliseconds: 1500),
                color: Colors.orange.shade300,
              )
              .scale(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
              ),
          const SizedBox(height: 8),

          // Streak count
          Text(
            '$streakCount',
            style: TextStyle(
              fontSize: size * 0.35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),

          // Label
          if (showLabel)
            Text(
              'day streak',
              style: TextStyle(
                fontSize: size * 0.12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}

/// Streak calendar grid showing completion history
class StreakCalendar extends StatelessWidget {
  const StreakCalendar({
    super.key,
    required this.completedDays,
    this.weeks = 5, // Show last 5 weeks
    this.showLabels = true,
  });

  /// Set of completed day indexes (0 = today)
  final Set<int> completedDays;

  /// Number of weeks to display
  final int weeks;

  /// Whether to show day labels
  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    // Calculate total days to show
    final totalDays = weeks * 7;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Calendar grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: totalDays,
          itemBuilder: (context, index) {
            final dayIndex = index;
            final isCompleted = completedDays.contains(dayIndex);
            final isToday = dayIndex == 0;

            return Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? AppTheme.completed
                    : AppTheme.surfaceVariant,
                border: isToday
                    ? Border.all(
                        color: AppTheme.primary,
                        width: 2,
                      )
                    : null,
                boxShadow: isCompleted
                    ? [
                        BoxShadow(
                          color: AppTheme.completed.withOpacity(0.3),
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            );
          },
        ),

        // Labels
        if (showLabels) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'S',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                'M',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                'T',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                'W',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                'T',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                'F',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                'S',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

/// Streak counter with milestone celebration
class MilestoneStreakCounter extends StatefulWidget {
  const MilestoneStreakCounter({
    super.key,
    required this.streakCount,
    this.size = 120,
  });

  final int streakCount;
  final double size;

  @override
  State<MilestoneStreakCounter> createState() =>
      _MilestoneStreakCounterState();
}

class _MilestoneStreakCounterState extends State<MilestoneStreakCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  bool _showMilestone = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _checkMilestone();
  }

  void _checkMilestone() {
    final milestones = [3, 7, 14, 30, 60, 100];
    if (milestones.contains(widget.streakCount)) {
      setState(() {
        _showMilestone = true;
      });
      _controller.forward().then((_) {
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Main streak counter
        ScaleTransition(
          scale: _scaleAnimation,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: StreakCounter(
              streakCount: widget.streakCount,
              size: widget.size,
            ),
          ),
        ),

        // Milestone celebration overlay
        if (_showMilestone)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '🎉',
                    style: TextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.streakCount} Day Streak!',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
