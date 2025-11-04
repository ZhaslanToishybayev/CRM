/// Achievement Detail Screen
/// Educational Project - Gamified Task Management App
///
/// Shows detailed information about a specific achievement

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../models/achievement_model.dart';
import '../providers/achievement_provider.dart';

class AchievementDetailScreen extends ConsumerStatefulWidget {
  final String achievementId;

  const AchievementDetailScreen({
    super.key,
    required this.achievementId,
  });

  @override
  ConsumerState<AchievementDetailScreen> createState() =>
      _AchievementDetailScreenState();
}

class _AchievementDetailScreenState
    extends ConsumerState<AchievementDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final achievementAsync = ref.watch(
      achievementDetailProvider(widget.achievementId),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievement Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
      ),
      body: achievementAsync.when(
        data: (achievement) => _buildContent(context, achievement),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Error loading achievement',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                '$error',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, AchievementModel achievement) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, achievement),
          const SizedBox(height: 24),
          _buildDescription(context, achievement),
          const SizedBox(height: 24),
          _buildProgress(context, achievement),
          const SizedBox(height: 24),
          _buildHistory(context, achievement),
          const SizedBox(height: 24),
          _buildNextAchievement(context, achievement),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AchievementModel achievement) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            achievement.isUnlocked
                ? AppTheme.primary
                : AppTheme.textSecondary.withOpacity(0.3),
            achievement.isUnlocked
                ? AppTheme.accent
                : AppTheme.textSecondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            achievement.isUnlocked ? Icons.emoji_events : Icons.lock,
            size: 80,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          Text(
            achievement.name,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: achievement.isUnlocked
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              achievement.isUnlocked ? 'UNLOCKED' : 'LOCKED',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context, AchievementModel achievement) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              achievement.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgress(BuildContext context, AchievementModel achievement) {
    final progress = achievement.currentProgress;
    final target = achievement.targetProgress;
    final progressPercent = target > 0 ? (progress / target) * 100 : 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progressPercent / 100,
              backgroundColor: Colors.grey.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppTheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$progress / $target',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${progressPercent.toInt()}%',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistory(BuildContext context, AchievementModel achievement) {
    if (achievement.unlockedAt == null) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unlocked On',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${achievement.unlockedAt!.day}.${achievement.unlockedAt!.month}.${achievement.unlockedAt!.year}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextAchievement(
    BuildContext context,
    AchievementModel achievement,
  ) {
    // This would be implemented to show the next achievement in the series
    // For now, we'll show a placeholder
    return Card(
      color: AppTheme.surface.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.trophy,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Unlock the next achievement in this category',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppTheme.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

/// Provider for a single achievement detail
@Riverpod(keepAlive: true)
Future<AchievementModel> achievementDetail(
  AchievementDetailRef ref,
  String achievementId,
) async {
  final repository = ref.read(achievementRepositoryProvider);
  return await repository.getAchievement(achievementId);
}
