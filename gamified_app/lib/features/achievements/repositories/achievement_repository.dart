/// Achievement Repository Interface
/// Educational Project - Gamified Task Management App
///
/// Abstract repository for achievement operations

import '../models/achievement_model.dart';

abstract class AchievementRepository {
  /// Get all achievements
  Future<List<AchievementModel>> getAllAchievements();

  /// Get achievements by category
  Future<List<AchievementModel>> getAchievementsByCategory(
    AchievementCategory category,
  );

  /// Get user's unlocked achievements
  Future<List<UserAchievement>> getUserAchievements(String userId);

  /// Unlock an achievement
  Future<UserAchievement> unlockAchievement({
    required String userId,
    required String achievementId,
  });

  /// Check and unlock achievements based on user stats
  Future<List<UserAchievement>> checkAndUnlockAchievements({
    required String userId,
    required Map<String, dynamic> userStats,
  });

  /// Get achievement progress for user
  Future<Map<String, UserAchievement>> getAchievementProgress(
    String userId,
  );

  /// Get statistics
  Future<AchievementStats> getStats(String userId);
}

/// Achievement Statistics
class AchievementStats {
  final int totalAchievements;
  final int unlockedAchievements;
  final int lockedAchievements;
  final double completionPercentage;
  final Map<AchievementCategory, int> categoryStats;

  const AchievementStats({
    required this.totalAchievements,
    required this.unlockedAchievements,
    required this.lockedAchievements,
    required this.completionPercentage,
    required this.categoryStats,
  });

  int get progressToNext => totalAchievements - unlockedAchievements;
}
