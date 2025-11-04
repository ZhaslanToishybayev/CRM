/// XP Calculator Service
/// Educational Project - Gamified Task Management App
///
/// Calculates XP rewards based on task completion and various factors

import '../models/xp_model.dart';
import '../models/level_model.dart';

class XPCalculatorService {
  XPCalculatorService._();

  /// Base XP values for different task priorities
  static const Map<String, int> baseXPByPriority = {
    'low': 10,
    'medium': 25,
    'high': 40,
    'urgent': 50,
  };

  /// Calculate XP for task completion
  static int calculateTaskXP({
    required String priority,
    DateTime? dueDate,
    DateTime? completedAt,
  }) {
    // Get base XP from priority
    final baseXP = baseXPByPriority[priority.toLowerCase()] ?? 25;

    // Calculate completion time factor
    final timeBonus = _calculateTimeBonus(
      dueDate: dueDate,
      completedAt: completedAt,
    );

    // Calculate final XP
    final finalXP = (baseXP * timeBonus).round();

    return finalXP;
  }

  /// Calculate time-based bonus multiplier
  static double _calculateTimeBonus({
    DateTime? dueDate,
    DateTime? completedAt,
  }) {
    // If no due date, no bonus
    if (dueDate == null) {
      return 1.0;
    }

    // If not completed yet, no bonus
    if (completedAt == null) {
      return 1.0;
    }

    // Calculate time difference
    final difference = dueDate.difference(completedAt).inMilliseconds;
    final oneHour = const Duration(hours: 1).inMilliseconds;

    // On-time bonus (1.5x) for completing before due date
    if (difference > 0) {
      return 1.5;
    }

    // Late completion, no bonus
    return 1.0;
  }

  /// Calculate new XP after adding XP
  static XPModel calculateNewXP({
    required XPModel currentXP,
    required int additionalXP,
  }) {
    final newTotalXP = currentXP.totalXP + additionalXP;
    final newLevel = calculateLevel(newTotalXP);

    // Check if level changed
    if (newLevel == currentXP.currentLevel) {
      // Same level, just add XP
      return currentXP.copyWith(
        totalXP: newTotalXP,
        currentLevelXP: currentXP.currentLevelXP + additionalXP,
        lastUpdated: DateTime.now(),
      );
    } else {
      // Level up! Calculate new XP distribution
      final previousLevel = currentXP.currentLevel;
      final newCurrentLevelXP = newTotalXP - LevelBadgeConfig.calculateRequiredXP(newLevel);
      final newNextLevelXP = LevelBadgeConfig.calculateRequiredXP(newLevel + 1) - LevelBadgeConfig.calculateRequiredXP(newLevel);
      final newXPToNextLevel = newNextLevelXP - newCurrentLevelXP;
      final newProgress = newCurrentLevelXP / newNextLevelXP;

      return XPModel(
        userId: currentXP.userId,
        totalXP: newTotalXP,
        currentLevel: newLevel,
        currentLevelXP: newCurrentLevelXP,
        nextLevelXP: newNextLevelXP,
        xpToNextLevel: newXPToNextLevel,
        progressToNextLevel: newProgress,
        lastUpdated: DateTime.now(),
      );
    }
  }

  /// Calculate level from total XP
  static int calculateLevel(int totalXP) {
    // Level = floor(sqrt(totalXP / 100))
    final level = (totalXP / 100).sqrt().floor();
    return level.clamp(1, 999); // Max level 999
  }

  /// Calculate XP for specific level
  static int calculateXPForLevel(int level) {
    return LevelBadgeConfig.calculateXPForLevel(level);
  }

  /// Get XP needed for next level
  static int getXPForNextLevel(int totalXP) {
    final currentLevel = calculateLevel(totalXP);
    final currentLevelMinXP = LevelBadgeConfig.calculateRequiredXP(currentLevel);
    final nextLevelMinXP = LevelBadgeConfig.calculateRequiredXP(currentLevel + 1);
    return nextLevelMinXP - currentLevelMinXP;
  }

  /// Calculate XP progress percentage
  static double calculateProgressPercentage(int totalXP) {
    final currentLevel = calculateLevel(totalXP);
    final currentLevelMinXP = LevelBadgeConfig.calculateRequiredXP(currentLevel);
    final nextLevelMinXP = LevelBadgeConfig.calculateRequiredXP(currentLevel + 1);

    final currentLevelXP = totalXP - currentLevelMinXP;
    final xpForLevel = nextLevelMinXP - currentLevelMinXP;

    return currentLevelXP / xpForLevel;
  }

  /// Check if user has achieved a milestone level
  static bool isMilestoneLevel(int level) {
    return LevelBadgeConfig.isMilestone(level);
  }

  /// Get level-up bonus XP
  static int getLevelUpBonusXP(int newLevel) {
    // Bonus is 5% of XP needed for the new level
    final levelXP = calculateXPForLevel(newLevel);
    return (levelXP * 0.05).round();
  }

  /// Estimate days to next level based on current pace
  static int estimateDaysToNextLevel({
    required int currentTotalXP,
    required int daysActive,
    required int xpPerDay,
  }) {
    if (daysActive == 0 || xpPerDay == 0) return 999;

    final currentLevel = calculateLevel(currentTotalXP);
    final nextLevelMinXP = LevelBadgeConfig.calculateRequiredXP(currentLevel + 1);
    final remainingXP = nextLevelMinXP - currentTotalXP;

    return (remainingXP / xpPerDay).ceil();
  }

  /// Format XP for display
  static String formatXP(int xp) {
    if (xp >= 1000000) {
      return '${(xp / 1000000).toStringAsFixed(1)}M';
    } else if (xp >= 1000) {
      return '${(xp / 1000).toStringAsFixed(1)}K';
    }
    return xp.toString();
  }

  /// Calculate streaks bonus XP (to be used with streak system)
  static int calculateStreakBonusXP(int streakCount) {
    // Bonus increases with longer streaks
    if (streakCount >= 100) return 50;
    if (streakCount >= 30) return 25;
    if (streakCount >= 7) return 15;
    if (streakCount >= 3) return 10;
    return 0;
  }
}

/// Extension to add copyWith method to XPModel
extension XPModelCopyWith on XPModel {
  XPModel copyWith({
    String? userId,
    int? totalXP,
    int? currentLevel,
    int? currentLevelXP,
    int? nextLevelXP,
    int? xpToNextLevel,
    double? progressToNextLevel,
    DateTime? lastUpdated,
  }) {
    return XPModel(
      userId: userId ?? this.userId,
      totalXP: totalXP ?? this.totalXP,
      currentLevel: currentLevel ?? this.currentLevel,
      currentLevelXP: currentLevelXP ?? this.currentLevelXP,
      nextLevelXP: nextLevelXP ?? this.nextLevelXP,
      xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
      progressToNextLevel: progressToNextLevel ?? this.progressToNextLevel,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
