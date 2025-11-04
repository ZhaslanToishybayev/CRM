/// Achievement Badge Widget
/// Educational Project - Gamified Task Management App
///
/// Displays an achievement badge with locked/unlocked states

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_theme.dart';
import '../models/achievement_model.dart';
import '../providers/achievement_provider.dart';

class AchievementBadge extends ConsumerStatefulWidget {
  final AchievementModel achievement;
  final double size;
  final bool showName;
  final bool showProgress;
  final VoidCallback? onTap;

  const AchievementBadge({
    super.key,
    required this.achievement,
    this.size = 64,
    this.showName = true,
    this.showProgress = false,
    this.onTap,
  });

  @override
  ConsumerState<AchievementBadge> createState() => _AchievementBadgeState();
}

class _AchievementBadgeState extends ConsumerState<AchievementBadge> {
  bool _isUnlocked = false;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _loadAchievementState();
  }

  void _loadAchievementState() {
    final notifier = ref.read(achievementNotifierProvider.notifier);
    _isUnlocked = notifier.isUnlocked(widget.achievement.id);
    _progress = notifier.getProgress(widget.achievement);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(achievementNotifierProvider);
    _isUnlocked = notifier?.isUnlocked(widget.achievement.id) ?? false;

    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Badge Icon
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: _isUnlocked
                  ? LinearGradient(
                      colors: [
                        Color(int.parse(
                          widget.achievement.color.replaceAll('#', '0xFF'),
                        )),
                        AppTheme.getAchievementGradient().colors.last,
                      ],
                    )
                  : null,
              color: _isUnlocked ? null : AppTheme.surfaceVariant,
              border: Border.all(
                color: _isUnlocked
                    ? Color(int.parse(
                        widget.achievement.color.replaceAll('#', '0xFF'),
                      ))
                    : AppTheme.textDisabled,
                width: 2,
              ),
              boxShadow: _isUnlocked
                  ? [
                      BoxShadow(
                        color: Color(int.parse(
                          widget.achievement.color.replaceAll('#', '0xFF'),
                        )).withOpacity(0.5),
                        blurRadius: 15,
                        spreadRadius: 3,
                      ),
                    ]
                  : null,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Icon
                Text(
                  widget.achievement.icon,
                  style: TextStyle(
                    fontSize: widget.size * 0.5,
                  ),
                ).animate(
                  onPlay: (controller) => controller.repeat(),
                ).shimmer(
                  duration: Duration(
                    milliseconds: _isUnlocked ? 1500 : 0,
                  ),
                  color: _isUnlocked ? Colors.white : Colors.transparent,
                ),

                // Lock overlay
                if (!_isUnlocked)
                  Icon(
                    Icons.lock_outline,
                    color: AppTheme.textDisabled,
                    size: widget.size * 0.3,
                  ),

                // Rarity indicator
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: widget.size * 0.25,
                    height: widget.size * 0.25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _getRarityColor(),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      _getRarityIcon(),
                      color: Colors.white,
                      size: widget.size * 0.15,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Name
          if (widget.showName) ...[
            Text(
              widget.achievement.name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _isUnlocked
                    ? AppTheme.textPrimary
                    : AppTheme.textDisabled,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Progress bar
            if (widget.showProgress && !_isUnlocked)
              Container(
                width: widget.size,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: AppTheme.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(int.parse(
                      widget.achievement.color.replaceAll('#', '0xFF'),
                    )),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Color _getRarityColor() {
    switch (widget.achievement.rarity) {
      case AchievementRarity.common:
        return AppTheme.textSecondary;
      case AchievementRarity.rare:
        return AppTheme.info;
      case AchievementRarity.epic:
        return AppTheme.accent;
      case AchievementRarity.legendary:
        return AppTheme.warning;
      case AchievementRarity.mythic:
        return AppTheme.xpColor;
    }
  }

  IconData _getRarityIcon() {
    switch (widget.achievement.rarity) {
      case AchievementRarity.common:
        return Icons.circle_outlined;
      case AchievementRarity.rare:
        return Icons.diamond_outlined;
      case AchievementRarity.epic:
        return Icons.star_outline;
      case AchievementRarity.legendary:
        return Icons.workspace_premium;
      case AchievementRarity.mythic:
        return Icons.auto_awesome;
    }
  }
}

/// Achievement Grid Widget
class AchievementGrid extends ConsumerWidget {
  final List<AchievementModel> achievements;
  final ScrollController? scrollController;

  const AchievementGrid({
    super.key,
    required this.achievements,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(achievementNotifierProvider.notifier);

    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        return AchievementBadge(
          achievement: achievement,
          size: 80,
          showProgress: true,
          onTap: () {
            // TODO: Navigate to achievement detail
          },
        );
      },
    );
  }
}
