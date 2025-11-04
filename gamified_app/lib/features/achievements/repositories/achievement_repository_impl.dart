/// Achievement Repository Implementation
/// Educational Project - Gamified Task Management App
///
/// Concrete implementation of AchievementRepository

import '../models/achievement_model.dart';
import '../services/achievement_service.dart';
import 'achievement_repository.dart';

class AchievementRepositoryImpl implements AchievementRepository {
  // In-memory storage for demo purposes
  // In production, this would use Supabase
  final Map<String, List<UserAchievement>> _userAchievements = {};

  @override
  Future<List<AchievementModel>> getAllAchievements() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));
    return AchievementDefinitions.all;
  }

  @override
  Future<List<AchievementModel>> getAchievementsByCategory(
    AchievementCategory category,
  ) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return AchievementDefinitions.getByCategory(category);
  }

  @override
  Future<List<UserAchievement>> getUserAchievements(
    String userId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _userAchievements[userId] ?? [];
  }

  @override
  Future<UserAchievement> unlockAchievement({
    required String userId,
    required String achievementId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final achievement = AchievementDefinitions.getById(achievementId);
    if (achievement == null) {
      throw Exception('Achievement not found');
    }

    final userAchievement = UserAchievement(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      achievementId: achievementId,
      userId: userId,
      unlockedAt: DateTime.now(),
      progress: achievement.targetValue,
      isUnlocked: true,
    );

    final userAchievements = _userAchievements[userId] ?? [];
    userAchievements.add(userAchievement);
    _userAchievements[userId] = userAchievements;

    return userAchievement;
  }

  @override
  Future<List<UserAchievement>> checkAndUnlockAchievements({
    required String userId,
    required Map<String, dynamic> userStats,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final allAchievements = await getAllAchievements();
    final userAchievements = _userAchievements[userId] ?? [];
    final unlockedIds = userAchievements
        .where((ua) => ua.isUnlocked)
        .map((ua) => ua.achievementId)
        .toSet();

    // Check which achievements can be unlocked
    final unlockable = AchievementService.checkUnlockableAchievements(
      allAchievements: allAchievements,
      userStats: userStats,
      unlockedIds: unlockedIds,
    );

    final newlyUnlocked = <UserAchievement>[];

    for (final achievement in unlockable) {
      final userAchievement = await unlockAchievement(
        userId: userId,
        achievementId: achievement.id,
      );
      newlyUnlocked.add(userAchievement);
    }

    return newlyUnlocked;
  }

  @override
  Future<Map<String, UserAchievement>> getAchievementProgress(
    String userId,
  ) async {
    final userAchievements = await getUserAchievements(userId);

    final progressMap = <String, UserAchievement>{};
    for (final ua in userAchievements) {
      progressMap[ua.achievementId] = ua;
    }

    return progressMap;
  }

  @override
  Future<AchievementStats> getStats(String userId) async {
    final userAchievements = await getUserAchievements(userId);
    final unlockedAchievements = userAchievements.where((ua) => ua.isUnlocked).length;
    final totalAchievements = AchievementDefinitions.totalCount;

    // Calculate category stats
    final categoryStats = <AchievementCategory, int>{};
    for (final category in AchievementCategory.values) {
      final categoryAchievements = AchievementDefinitions.getByCategory(category);
      final unlockedInCategory = userAchievements
          .where((ua) =>
              ua.isUnlocked &&
              categoryAchievements.any((ca) => ca.id == ua.achievementId))
          .length;
      categoryStats[category] = unlockedInCategory;
    }

    return AchievementStats(
      totalAchievements: totalAchievements,
      unlockedAchievements: unlockedAchievements,
      lockedAchievements: totalAchievements - unlockedAchievements,
      completionPercentage: totalAchievements > 0
          ? unlockedAchievements / totalAchievements
          : 0.0,
      categoryStats: categoryStats,
    );
  }
}
