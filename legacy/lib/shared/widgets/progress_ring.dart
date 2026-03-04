/// Progress Ring Widget
/// Educational Project - Gamified Task Management App
///
/// A circular progress indicator with center text display
/// Used for XP display, level progress, and achievement progress

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.progress,
    required this.value,
    required this.maxValue,
    required this.label,
    this.size = 120,
    this.strokeWidth = 8,
    this.color,
    this.showCenterText = true,
    this.animate = true,
  });

  /// Progress value (0.0 to 1.0)
  final double progress;

  /// Current value (e.g., current XP)
  final int value;

  /// Maximum value (e.g., XP needed for next level)
  final int maxValue;

  /// Label to display (e.g., "XP", "Level")
  final String label;

  /// Size of the ring (diameter)
  final double size;

  /// Stroke width of the ring
  final double strokeWidth;

  /// Color of the progress (defaults to theme primary)
  final Color? color;

  /// Whether to show center text
  final bool showCenterText;

  /// Whether to animate progress changes
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final ringColor = color ?? AppTheme.primary;
    final gradient = _getGradient(ringColor);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(
              ringColor.withOpacity(0.2),
            ),
            backgroundColor: Colors.transparent,
          ),

          // Progress circle with animation
          animate
              ? CircularProgressIndicator(
                  value: progress,
                  strokeWidth: strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(ringColor),
                  backgroundColor: Colors.transparent,
                ).animate(onPlay: (controller) => controller.repeat())
              : CircularProgressIndicator(
                  value: progress,
                  strokeWidth: strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(ringColor),
                  backgroundColor: Colors.transparent,
                ),

          // Center content
          if (showCenterText)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$value',
                  style: TextStyle(
                    fontSize: size * 0.25,
                    fontWeight: FontWeight.bold,
                    color: ringColor,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: size * 0.12,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  /// Get gradient based on color
  LinearGradient _getGradient(Color baseColor) {
    if (baseColor == AppTheme.xpColor) {
      return AppTheme.getXPGradient();
    } else if (baseColor == AppTheme.levelColor) {
      return AppTheme.getLevelGradient();
    } else if (baseColor == AppTheme.achievementColor) {
      return AppTheme.getAchievementGradient();
    }
    return LinearGradient(
      colors: [baseColor, baseColor.withOpacity(0.7)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

/// Animated Progress Ring
/// Automatically animates when progress changes
class AnimatedProgressRing extends StatefulWidget {
  const AnimatedProgressRing({
    super.key,
    required this.progress,
    required this.value,
    required this.maxValue,
    required this.label,
    this.size = 120,
    this.strokeWidth = 8,
    this.color,
  });

  final double progress;
  final int value;
  final int maxValue;
  final String label;
  final double size;
  final double strokeWidth;
  final Color? color;

  @override
  State<AnimatedProgressRing> createState() => _AnimatedProgressRingState();
}

class _AnimatedProgressRingState extends State<AnimatedProgressRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double _currentProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _animateToProgress(widget.progress);
  }

  @override
  void didUpdateWidget(AnimatedProgressRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != oldWidget.progress) {
      _animateToProgress(widget.progress);
    }
  }

  void _animateToProgress(double target) {
    setState(() {
      _currentProgress = target;
    });
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ringColor = widget.color ?? AppTheme.primary;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: widget.strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(
              ringColor.withOpacity(0.2),
            ),
            backgroundColor: Colors.transparent,
          ),

          // Animated progress circle
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CircularProgressIndicator(
                value: _animation.value * widget.progress,
                strokeWidth: widget.strokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(ringColor),
                backgroundColor: Colors.transparent,
              );
            },
          ),

          // Center content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: widget.value),
                duration: const Duration(milliseconds: 1000),
                builder: (context, value, child) {
                  return Text(
                    '$value',
                    style: TextStyle(
                      fontSize: widget.size * 0.25,
                      fontWeight: FontWeight.bold,
                      color: ringColor,
                    ),
                  );
                },
              ),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: widget.size * 0.12,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
