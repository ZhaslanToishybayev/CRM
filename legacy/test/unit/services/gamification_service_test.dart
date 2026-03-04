import 'package:flutter_test/flutter_test.dart';
import 'dart:math' as math;

// Import your actual gamification service
// Assuming it exists in lib/features/gamification/services/

class GamificationService {
  // XP values for different task priorities
  static const Map<String, int> taskXP = {
    'low': 15,
    'medium': 30,
    'high': 50,
    'urgent': 75,
    'critical': 100,
  };

  // Multipliers for task types
  static const Map<String, double> taskMultipliers = {
    'personal': 1.0,
    'project': 1.5,
    'team': 2.0,
  };

  /// Calculate XP earned for completing a task
  static int calculateTaskXP({
    required String priority,
    String type = 'personal',
    bool completedOnTime = true,
    bool isHighQuality = false,
  }) {
    int baseXP = taskXP[priority] ?? 15;

    double multiplier = taskMultipliers[type] ?? 1.0;
    int earnedXP = (baseXP * multiplier).round();

    // Bonus for completing on time
    if (completedOnTime) {
      earnedXP += (earnedXP * 0.2).round(); // +20% XP
    }

    // Bonus for high quality
    if (isHighQuality) {
      earnedXP += 50; // +50 XP flat bonus
    }

    return earnedXP;
  }

  /// Calculate level based on total XP
  static int calculateLevel(int totalXP) {
    // Level formula: Level = floor(sqrt(totalXP / 100))
    return math.sqrt(totalXP / 100).floor();
  }

  /// Calculate XP needed for next level
  static int xpNeededForNextLevel(int currentXP) {
    int currentLevel = calculateLevel(currentXP);
    int nextLevelXP = (currentLevel + 1) * (currentLevel + 1) * 100;
    return nextLevelXP - currentXP;
  }

  /// Determine if user qualifies for achievement
  static bool checkStreakAchievement(int streakDays) {
    const streakMilestones = [3, 7, 14, 30, 60, 100];
    return streakMilestones.any((milestone) => streakDays >= milestone);
  }

  /// Calculate completion rate
  static double calculateCompletionRate(int completed, int total) {
    if (total == 0) return 0.0;
    return (completed / total) * 100;
  }
}

void main() {
  group('GamificationService', () {
    test('should calculate correct XP for low priority task', () {
      final xp = GamificationService.calculateTaskXP(
        priority: 'low',
        type: 'personal',
      );

      expect(xp, 18); // 15 * 1.0 + 20% bonus
    });

    test('should calculate correct XP for high priority team task', () {
      final xp = GamificationService.calculateTaskXP(
        priority: 'high',
        type: 'team',
        completedOnTime: true,
        isHighQuality: true,
      );

      // 50 * 2.0 = 100, +20% = 120, +50 bonus = 170
      expect(xp, 170);
    });

    test('should calculate XP without bonuses', () {
      final xp = GamificationService.calculateTaskXP(
        priority: 'critical',
        type: 'project',
        completedOnTime: false,
        isHighQuality: false,
      );

      // 100 * 1.5 = 150, no bonuses
      expect(xp, 150);
    });

    test('should calculate level from XP', () {
      // Level 0: 0-99 XP
      expect(GamificationService.calculateLevel(0), 0);
      expect(GamificationService.calculateLevel(99), 0);

      // Level 1: 100-399 XP
      expect(GamificationService.calculateLevel(100), 1);
      expect(GamificationService.calculateLevel(399), 1);

      // Level 2: 400-899 XP
      expect(GamificationService.calculateLevel(400), 2);
      expect(GamificationService.calculateLevel(899), 2);

      // Level 10: at least 10000 XP
      expect(GamificationService.calculateLevel(10000), 10);
    });

    test('should calculate XP needed for next level', () {
      // At level 0 (99 XP), need 1 XP to reach level 1
      expect(GamificationService.xpNeededForNextLevel(99), 1);

      // At level 2 (400 XP), need 500 XP for level 3
      expect(GamificationService.xpNeededForNextLevel(400), 500);

      // At level 2 (899 XP), need 1 XP for level 3
      expect(GamificationService.xpNeededForNextLevel(899), 1);

      // At level 6 (3600 XP), need 1300 XP for level 7
      expect(GamificationService.xpNeededForNextLevel(3600), 1300);
    });

    test('should check streak achievements', () {
      expect(GamificationService.checkStreakAchievement(2), false);
      expect(GamificationService.checkStreakAchievement(3), true);
      expect(GamificationService.checkStreakAchievement(7), true);
      expect(GamificationService.checkStreakAchievement(14), true);
      expect(GamificationService.checkStreakAchievement(30), true);
      expect(GamificationService.checkStreakAchievement(100), true);
      expect(GamificationService.checkStreakAchievement(150), true);
    });

    test('should calculate completion rate', () {
      expect(GamificationService.calculateCompletionRate(0, 0), 0.0);

      expect(GamificationService.calculateCompletionRate(5, 10), 50.0);

      expect(GamificationService.calculateCompletionRate(10, 10), 100.0);

      expect(GamificationService.calculateCompletionRate(7, 10), 70.0);
    });

    test('should handle edge cases for XP calculation', () {
      // Unknown priority defaults to 15 XP
      final xp1 = GamificationService.calculateTaskXP(
        priority: 'unknown',
        type: 'personal',
      );
      expect(xp1, 18); // 15 + 20%

      // Unknown type defaults to personal multiplier
      final xp2 = GamificationService.calculateTaskXP(
        priority: 'high',
        type: 'unknown',
      );
      expect(xp2, 60); // 50 * 1.0 + 20%
    });

    test('should accumulate XP correctly', () {
      int totalXP = 0;

      // Complete multiple tasks
      totalXP += GamificationService.calculateTaskXP(
        priority: 'low',
        type: 'personal',
      );
      totalXP += GamificationService.calculateTaskXP(
        priority: 'high',
        type: 'team',
        completedOnTime: true,
      );
      totalXP += GamificationService.calculateTaskXP(
        priority: 'critical',
        type: 'project',
        completedOnTime: true,
        isHighQuality: true,
      );

      // 18 + 120 + 230 = 368 XP
      expect(totalXP, 368);

      // floor(sqrt(368 / 100)) == 1
      expect(GamificationService.calculateLevel(totalXP), 1);
    });
  });
}
