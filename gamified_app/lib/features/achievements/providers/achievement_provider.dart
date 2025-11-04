/// Achievement Provider
/// Educational Project - Gamified Task Management App
///
/// Manages achievement state using Riverpod

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/achievement_model.dart';
import '../repositories/achievement_repository.dart';
import '../repositories/achievement_repository_impl.dart';
import '../../gamification/providers/gamification_provider.dart';
import '../../streak/providers/streak_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../tasks/providers/task_provider.dart';
import '../services/achievement_service.dart';

part 'achievement_provider.g.dart';

// Provider for the achievement repository
@Riverpod(keepAlive: true)
AchievementRepository achievementRepository(AchievementRepositoryRef ref) {
  return AchievementRepositoryImpl();
}

// Provider for all achievements
@riverpod
Future<List<AchievementModel>> achievementsList(AchievementsListRef ref) async {
  final repository = ref.read(achievementRepositoryProvider);
  return repository.getAllAchievements();
}

// Provider for user's achievements
@riverpod
Future<List<UserAchievement>> userAchievements(UserAchievementsRef ref) async {
  final authState = ref.watch(authStateNotifierProvider);

  if (authState == null) {
    return Future.value([]);
  }

  final repository = ref.read(achievementRepositoryProvider);
  return repository.getUserAchievements(authState.id);
}

// Provider for achievement statistics
@riverpod
Future<AchievementStats> achievementStats(AchievementStatsRef ref) async {
  final authState = ref.watch(authStateNotifierProvider);

  if (authState == null) {
    return Future.value(const AchievementStats(
      totalAchievements: 0,
      unlockedAchievements: 0,
      lockedAchievements: 0,
      completionPercentage: 0.0,
      categoryStats: {},
    ));
  }

  final repository = ref.read(achievementRepositoryProvider);
  return repository.getStats(authState.id);
}

// Provider for achievements by category
@riverpod
Future<Map<AchievementCategory, List<AchievementModel>>> achievementsByCategory(
  AchievementsByCategoryRef ref,
) async {
  final allAchievements = await ref.watch(achievementsListProvider.future);

  final categorized = <AchievementCategory, List<AchievementModel>>{};
  for (final category in AchievementCategory.values) {
    categorized[category] = allAchievements
        .where((a) => a.category == category)
        .toList();
  }

  return categorized;
}

// Provider for unlocked achievements
@riverpod
List<UserAchievement> unlockedAchievements(UnlockedAchievementsRef ref) {
  final userAchievements = ref.watch(userAchievementsProvider);
  return userAchievements.when(
    data: (achievements) => achievements.where((a) => a.isUnlocked).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
}

// Provider for locked achievements
@riverpod
List<AchievementModel> lockedAchievements(LockedAchievementsRef ref) {
  final allAchievements = ref.watch(achievementsListProvider);
  final unlockedAchievements = ref.watch(unlockedAchievementsProvider);

  final unlockedIds = unlockedAchievements.map((ua) => ua.achievementId).toSet();

  return allAchievements.when(
    data: (achievements) => achievements
        .where((a) => !unlockedIds.contains(a.id))
        .toList(),
    loading: () => [],
    error: (_, __) => [],
  );
}

/// Achievement Notifier
@riverpod
class AchievementNotifier extends _$AchievementNotifier {
  @override
  void build() {
    // Initialize with empty state
  }

  /// Load all achievements for user
  Future<void> loadAchievements() async {
    final repository = ref.read(achievementRepositoryProvider);
    final authState = ref.read(authStateNotifierProvider);

    if (authState == null) return;

    final userAchievements = await repository.getUserAchievements(authState.id);
    state = userAchievements;
  }

  /// Unlock an achievement
  Future<UserAchievement> unlockAchievement(String achievementId) async {
    final repository = ref.read(achievementRepositoryProvider);
    final authState = ref.read(authStateNotifierProvider);

    if (authState == null) {
      throw Exception('User not authenticated');
    }

    final userAchievement = await repository.unlockAchievement(
      userId: authState.id,
      achievementId: achievementId,
    );

    // Update state
    state = [...state, userAchievement];

    return userAchievement;
  }

  /// Check and unlock achievements based on user stats
  Future<List<UserAchievement>> checkAndUnlockAchievements() async {
    final repository = ref.read(achievementRepositoryProvider);
    final authState = ref.read(authStateNotifierProvider);
    final currentXP = ref.read(currentXPProvider);

    if (authState == null) {
      throw Exception('User not authenticated');
    }

    // Get user stats from various sources
    final userStats = AchievementService.getUserStats(
      streakDays: ref.read(streakNotifierProvider).currentStreak,
      tasksCompleted: ref.read(taskNotifierProvider).length,
      currentLevel: currentXP?.currentLevel ?? 1,
      totalXP: currentXP?.totalXP ?? 0,
      createdAt: authState.createdAt,
    );

    final newlyUnlocked = await repository.checkAndUnlockAchievements(
      userId: authState.id,
      userStats: userStats,
    );

    // Update state
    state = [...state, ...newlyUnlocked];

    return newlyUnlocked;
  }

  /// Get achievement progress
  Future<Map<String, UserAchievement>> getAchievementProgress() async {
    final repository = ref.read(achievementRepositoryProvider);
    final authState = ref.read(authStateNotifierProvider);

    if (authState == null) {
      return {};
    }

    return await repository.getAchievementProgress(authState.id);
  }

  /// Get achievements by category
  Future<Map<AchievementCategory, List<AchievementModel>>>
      getAchievementsByCategory() async {
    final repository = ref.read(achievementRepositoryProvider);
    final categorized = <AchievementCategory, List<AchievementModel>>{};

    for (final category in AchievementCategory.values) {
      final achievements = await repository.getAchievementsByCategory(category);
      categorized[category] = achievements;
    }

    return categorized;
  }

  /// Get unlocked achievements count
  int getUnlockedCount() {
    return state.where((ua) => ua.isUnlocked).length;
  }

  /// Get total achievements count
  int getTotalCount() {
    return AchievementDefinitions.totalCount;
  }

  /// Get completion percentage
  double getCompletionPercentage() {
    final total = getTotalCount();
    if (total == 0) return 0.0;
    return getUnlockedCount() / total;
  }

  /// Check if achievement is unlocked
  bool isUnlocked(String achievementId) {
    return state.any((ua) => ua.achievementId == achievementId && ua.isUnlocked);
  }

  /// Get achievement progress (0.0 to 1.0)
  double getProgress(AchievementModel achievement) {
    final userStats = _getUserStats();
    return AchievementService.getProgress(
      achievement: achievement,
      userStats: userStats,
    );
  }

  /// Get next achievement to unlock
  AchievementModel? getNextAchievement(AchievementCategory category) {
    final userStats = _getUserStats();
    final unlockedIds = state.map((ua) => ua.achievementId).toSet();

    final categoryAchievements = AchievementDefinitions.getByCategory(category);
    final unlockable = categoryAchievements
        .where((a) => !unlockedIds.contains(a.id))
        .toList();

    if (unlockable.isEmpty) return null;

    unlockable.sort((a, b) => a.targetValue.compareTo(b.targetValue));

    for (final achievement in unlockable) {
      final progress = AchievementService.getProgress(
        achievement: achievement,
        userStats: userStats,
      );
      if (progress < 1.0) {
        return achievement;
      }
    }

    return null;
  }

  /// Get user statistics
  Future<AchievementStats> getStats() async {
    final repository = ref.read(achievementRepositoryProvider);
    final authState = ref.read(authStateNotifierProvider);

    if (authState == null) {
      return const AchievementStats(
        totalAchievements: 0,
        unlockedAchievements: 0,
        lockedAchievements: 0,
        completionPercentage: 0.0,
        categoryStats: {},
      );
    }

    return await repository.getStats(authState.id);
  }

  /// Get user stats (helper method)
  Map<String, dynamic> _getUserStats() {
    final currentXP = ref.read(currentXPProvider);
    final tasks = ref.read(taskNotifierProvider);

    return AchievementService.getUserStats(
      streakDays: ref.read(streakNotifierProvider).currentStreak,
      tasksCompleted: tasks.length,
      currentLevel: currentXP?.currentLevel ?? 1,
      totalXP: currentXP?.totalXP ?? 0,
      createdAt: ref.read(authStateNotifierProvider)?.createdAt,
    );
  }
}
