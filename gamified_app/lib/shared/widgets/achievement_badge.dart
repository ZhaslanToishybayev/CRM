/// Achievement Badge Widget
/// Educational Project - Gamified Task Management App
///
/// Displays achievement badges with different states:
/// - Locked (grayscale with lock icon)
/// - Unlocked (full color)
/// - New (glowing border with "NEW" tag)

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class AchievementBadge extends StatelessWidget {
  const AchievementBadge({
    super.key,
    required this.icon,
    required this.name,
    this.isUnlocked = false,
    this.unlockedAt,
    this.isNew = false,
    this.size = 64,
    this.showName = false,
  });

  /// Badge icon (emoji or icon name)
  final String icon;

  /// Badge name
  final String name;

  /// Whether badge is unlocked
  final bool isUnlocked;

  /// Unlock date
  final DateTime? unlockedAt;

  /// Whether badge is newly unlocked
  final bool isNew;

  /// Badge size
  final double size;

  /// Whether to show badge name
  final bool showName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Badge container
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isUnlocked
                ? AppTheme.getAchievementGradient()
                : null,
            color: isUnlocked ? null : AppTheme.surfaceVariant,
            border: isNew
                ? Border.all(
                    color: AppTheme.achievementColor,
                    width: 3,
                  )
                : null,
            boxShadow: [
              if (isNew)
                BoxShadow(
                  color: AppTheme.achievementColor.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              if (isUnlocked && !isNew)
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Badge icon
              Text(
                icon,
                style: TextStyle(
                  fontSize: size * 0.5,
                  filter: isUnlocked
                      ? null
                      : const FilterMatrix.grayscale(),
                ),
              ),

              // Lock overlay for locked badges
              if (!isUnlocked)
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock,
                      size: size * 0.25,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),

              // "NEW" tag for newly unlocked badges
              if (isNew)
                Positioned(
                  top: -8,
                  right: -8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppTheme.getAchievementGradient(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'NEW',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ).animate(
          onPlay: (controller) => controller.repeat(),
        ).shimmer(
          duration: const Duration(milliseconds: 1500),
          color: Colors.white.withOpacity(0.5),
        ),

        // Badge name (optional)
        if (showName && name.isNotEmpty) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: size * 1.5,
            child: Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isUnlocked
                    ? AppTheme.textPrimary
                    : AppTheme.textSecondary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Achievement badge with tap animation
class AnimatedAchievementBadge extends StatefulWidget {
  const AnimatedAchievementBadge({
    super.key,
    required this.icon,
    required this.name,
    this.isUnlocked = false,
    this.unlockedAt,
    this.isNew = false,
    this.size = 64,
    this.showName = false,
    this.onTap,
  });

  final String icon;
  final String name;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final bool isNew;
  final double size;
  final bool showName;
  final VoidCallback? onTap;

  @override
  State<AnimatedAchievementBadge> createState() =>
      _AnimatedAchievementBadgeState();
}

class _AnimatedAchievementBadgeState extends State<AnimatedAchievementBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Auto-show "NEW" animation for new badges
    if (widget.isNew) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _controller.forward().then((_) {
            _controller.reverse();
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
        _controller.forward().then((_) {
          _controller.reverse();
        });
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Badge container
            Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: widget.isUnlocked
                    ? AppTheme.getAchievementGradient()
                    : null,
                color: widget.isUnlocked ? null : AppTheme.surfaceVariant,
                border: widget.isNew
                    ? Border.all(
                        color: AppTheme.achievementColor,
                        width: 3,
                      )
                    : null,
                boxShadow: [
                  if (widget.isNew)
                    BoxShadow(
                      color: AppTheme.achievementColor.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  if (widget.isUnlocked && !widget.isNew)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Badge icon
                  Text(
                    widget.icon,
                    style: TextStyle(
                      fontSize: widget.size * 0.5,
                      filter: widget.isUnlocked
                          ? null
                          : const FilterMatrix.grayscale(),
                    ),
                  ),

                  // Lock overlay for locked badges
                  if (!widget.isUnlocked)
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.lock,
                          size: widget.size * 0.25,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),

                  // "NEW" tag for newly unlocked badges
                  if (widget.isNew)
                    Positioned(
                      top: -8,
                      right: -8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppTheme.getAchievementGradient(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'NEW',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Badge name (optional)
            if (widget.showName && widget.name.isNotEmpty) ...[
              const SizedBox(height: 8),
              SizedBox(
                width: widget.size * 1.5,
                child: Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: widget.isUnlocked
                        ? AppTheme.textPrimary
                        : AppTheme.textSecondary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Achievement grid for displaying multiple badges
class AchievementGrid extends StatelessWidget {
  const AchievementGrid({
    super.key,
    required this.achievements,
    this.columns = 3,
    this.badgeSize = 64,
    this.showNames = false,
  });

  /// List of achievements
  final List<AchievementData> achievements;

  /// Number of columns in grid
  final int columns;

  /// Badge size
  final double badgeSize;

  /// Whether to show badge names
  final bool showNames;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        return AnimatedAchievementBadge(
          icon: achievement.icon,
          name: achievement.name,
          isUnlocked: achievement.isUnlocked,
          unlockedAt: achievement.unlockedAt,
          isNew: achievement.isNew,
          size: badgeSize,
          showName: showNames,
        );
      },
    );
  }
}

class AchievementData {
  final String icon;
  final String name;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final bool isNew;

  AchievementData({
    required this.icon,
    required this.name,
    this.isUnlocked = false,
    this.unlockedAt,
    this.isNew = false,
  });
}
