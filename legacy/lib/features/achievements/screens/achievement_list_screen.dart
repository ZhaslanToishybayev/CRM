/// Achievement List Screen
/// Educational Project - Gamified Task Management App
///
/// Displays all achievements in a grid with filters

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../models/achievement_model.dart';
import '../models/achievement_stats.dart';
import '../providers/achievement_provider.dart';
import '../widgets/achievement_badge.dart';

class AchievementListScreen extends ConsumerStatefulWidget {
  const AchievementListScreen({super.key});

  @override
  ConsumerState<AchievementListScreen> createState() => _AchievementListScreenState();
}

class _AchievementListScreenState extends ConsumerState<AchievementListScreen> {
  AchievementCategory _selectedCategory = AchievementCategory.streaks;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allAchievements = ref.watch(achievementsListProvider);
    final userAchievements = ref.watch(userAchievementsProvider);
    final stats = ref.watch(achievementStatsProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.achievementColor,
        foregroundColor: AppTheme.onPrimary,
        elevation: 0,
        title: const Text('Achievements'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await ref.read(achievementNotifierProvider.notifier).loadAchievements();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Card
          _buildStatsCard(stats),

          const SizedBox(height: 16),

          // Category Filter Tabs
          _buildCategoryTabs(),

          const SizedBox(height: 16),

          // Achievement Grid
          Expanded(
            child: allAchievements.when(
              data: (achievements) {
                final categoryAchievements = achievements
                    .where((a) => a.category == _selectedCategory)
                    .toList();

                final unlockedIds = userAchievements.when(
                  data: (uas) => uas.where((ua) => ua.isUnlocked).map((ua) => ua.achievementId).toSet(),
                  loading: () => <String>{},
                  error: (_, __) => <String>{},
                );

                return AchievementGrid(
                  achievements: categoryAchievements,
                  scrollController: _scrollController,
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(AsyncValue<AchievementStats> stats) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppTheme.getAchievementGradient(),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.achievementColor.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Title
          const Text(
            'Achievement Progress',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                'Unlocked',
                stats.when(
                  data: (s) => s.unlockedAchievements.toString(),
                  loading: () => '...',
                  error: (_, __) => '0',
                ),
                Icons.unlock,
              ),
              _buildStatItem(
                'Total',
                stats.when(
                  data: (s) => s.totalAchievements.toString(),
                  loading: () => '...',
                  error: (_, __) => '0',
                ),
                Icons.flag,
              ),
              _buildStatItem(
                'Progress',
                stats.when(
                  data: (s) => '${(s.completionPercentage * 100).toInt()}%',
                  loading: () => '...',
                  error: (_, __) => '0%',
                ),
                Icons.trending_up,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    final categories = AchievementCategory.values;

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;

          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(_getCategoryDisplayName(category)),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedCategory = category;
                  });
                }
              },
              selectedColor: AppTheme.achievementColor.withOpacity(0.3),
              checkmarkColor: AppTheme.achievementColor,
              backgroundColor: AppTheme.surface,
              labelStyle: TextStyle(
                color: isSelected ? AppTheme.achievementColor : AppTheme.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  String _getCategoryDisplayName(AchievementCategory category) {
    switch (category) {
      case AchievementCategory.streaks:
        return 'Streaks';
      case AchievementCategory.completions:
        return 'Completions';
      case AchievementCategory.speed:
        return 'Speed';
      case AchievementCategory.special:
        return 'Special';
      case AchievementCategory.levels:
        return 'Levels';
      case AchievementCategory.xp:
        return 'XP';
      case AchievementCategory.tasks:
        return 'Tasks';
      case AchievementCategory.time:
        return 'Time';
    }
  }
}
