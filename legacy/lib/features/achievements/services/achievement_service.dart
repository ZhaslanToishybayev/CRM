/// Achievement Service
/// Educational Project - Gamified Task Management App
///
/// Checks achievement conditions and unlocks achievements

import '../models/achievement_model.dart';

class AchievementService {
  AchievementService._();

  /// Check if an achievement should be unlocked
  static bool checkAchievement({
    required AchievementModel achievement,
    required Map<String, dynamic> userStats,
  }) {
    final condition = achievement.condition;
    final target = achievement.targetValue;
    final current = userStats[condition] ?? 0;

    return current >= target;
  }

  /// Get progress for an achievement (0.0 to 1.0)
  static double getProgress({
    required AchievementModel achievement,
    required Map<String, dynamic> userStats,
  }) {
    final condition = achievement.condition;
    final target = achievement.targetValue;
    final current = userStats[condition] ?? 0;

    if (target <= 0) return 0.0;
    return (current / target).clamp(0.0, 1.0);
  }

  /// Calculate which achievements should be unlocked
  static List<AchievementModel> checkUnlockableAchievements({
    required List<AchievementModel> allAchievements,
    required Map<String, dynamic> userStats,
    required Set<String> unlockedIds,
  }) {
    return allAchievements
        .where((achievement) => !unlockedIds.contains(achievement.id))
        .where((achievement) => checkAchievement(
              achievement: achievement,
              userStats: userStats,
            ))
        .toList();
  }

  /// Get user stats from various sources
  static Map<String, dynamic> getUserStats({
    int? streakDays,
    int? tasksCompleted,
    int? currentLevel,
    int? totalXP,
    DateTime? createdAt,
    int? urgentTasksCompleted,
    int? highTasksCompleted,
    int? mediumTasksCompleted,
    int? lowTasksCompleted,
    DateTime? lastTaskDate,
    Map<String, int>? categoryStats,
    List<int>? tasksPerDay,
    int? tasksPerHour,
  }) {
    return {
      // Streak stats
      'streak_days': streakDays ?? 0,

      // Task completion stats
      'tasks_completed': tasksCompleted ?? 0,
      'urgent_tasks': urgentTasksCompleted ?? 0,
      'high_tasks': highTasksCompleted ?? 0,
      'medium_tasks': mediumTasksCompleted ?? 0,
      'low_tasks': lowTasksCompleted ?? 0,

      // Level and XP stats
      'current_level': currentLevel ?? 1,
      'total_xp': totalXP ?? 0,

      // Speed stats
      'quick_completion': _calculateQuickCompletions(
        tasksCompleted,
        createdAt,
        lastTaskDate,
      ),
      'tasks_per_day': _calculateMaxTasksPerDay(tasksPerDay),
      'tasks_per_hour': tasksPerHour ?? 0,
      'no_break': _calculateConsecutiveTasks(tasksPerDay),

      // Time-based stats
      'early_completion': _calculateEarlyCompletions(),
      'late_completion': _calculateLateCompletions(),
      'weekend_tasks': _calculateWeekendTasks(),
      'monday_tasks': _calculateMondayTasks(),
      'afternoon_tasks': _calculateAfternoonTasks(),
      'midnight_completion': _calculateMidnightCompletions(),
      'all_time_periods': _calculateTimePeriods(),
      'rush_hour_tasks': _calculateRushHourTasks(),

      // Special stats
      'perfect_day': _calculatePerfectDays(tasksPerDay),
      'streak_recovery': _calculateStreakRecovery(streakDays, lastTaskDate),
      'tasks_created': tasksCompleted ?? 0, // Assuming created = completed for now
      'categories_created': categoryStats?.length ?? 0,

      // XP stats
      'bonus_xp': _calculateBonusXP(totalXP),
      'xp_per_day': _calculateXPPerDay(totalXP, createdAt),
      'xp_per_week': _calculateXPPerWeek(totalXP, createdAt),
      'xp_per_month': _calculateXPPerMonth(totalXP, createdAt),

      // Category stats
      'work_tasks': categoryStats?['work'] ?? 0,
      'personal_tasks': categoryStats?['personal'] ?? 0,
      'health_tasks': categoryStats?['health'] ?? 0,
      'shopping_tasks': categoryStats?['shopping'] ?? 0,
      'education_tasks': categoryStats?['education'] ?? 0,

      // Special calculations
      'all_priorities': _calculateAllPriorities(
        urgentTasksCompleted,
        highTasksCompleted,
        mediumTasksCompleted,
        lowTasksCompleted,
      ),
      'urgent_per_day': _calculateUrgentPerDay(),
      'all_urgent_in_week': _calculateAllUrgentInWeek(),
      'priority_master': _calculatePriorityMaster(
        urgentTasksCompleted,
        highTasksCompleted,
        mediumTasksCompleted,
        lowTasksCompleted,
      ),
      'category_variety': categoryStats?.length ?? 0,
      'custom_category': _calculateCustomCategory(categoryStats),
      'all_predefined': _calculateAllPredefined(categoryStats),
    };
  }

  // Helper methods for calculations
  static int _calculateQuickCompletions(int? tasksCompleted, DateTime? createdAt, DateTime? lastTaskDate) {
    // Placeholder - would calculate based on actual task timestamps
    return 0;
  }

  static int _calculateMaxTasksPerDay(List<int>? tasksPerDay) {
    if (tasksPerDay == null || tasksPerDay.isEmpty) return 0;
    return tasksPerDay.reduce((a, b) => a > b ? a : b);
  }

  static int _calculateConsecutiveTasks(List<int>? tasksPerDay) {
    // Placeholder - would calculate consecutive days with tasks
    return 0;
  }

  static int _calculateEarlyCompletions() {
    // Placeholder - would calculate tasks completed before 9 AM
    return 0;
  }

  static int _calculateLateCompletions() {
    // Placeholder - would calculate tasks completed after 9 PM
    return 0;
  }

  static int _calculateWeekendTasks() {
    // Placeholder - would calculate tasks completed on weekends
    return 0;
  }

  static int _calculateMondayTasks() {
    // Placeholder - would calculate tasks completed on Mondays
    return 0;
  }

  static int _calculateAfternoonTasks() {
    // Placeholder - would calculate tasks completed between 12-5 PM
    return 0;
  }

  static int _calculateMidnightCompletions() {
    // Placeholder - would calculate tasks completed at midnight
    return 0;
  }

  static int _calculateTimePeriods() {
    // Placeholder - would check if tasks completed in all time periods
    return 0;
  }

  static int _calculateRushHourTasks() {
    // Placeholder - would calculate tasks completed during rush hours
    return 0;
  }

  static int _calculatePerfectDays(List<int>? tasksPerDay) {
    // Placeholder - would calculate days with all tasks completed
    return 0;
  }

  static int _calculateStreakRecovery(int? streakDays, DateTime? lastTaskDate) {
    // Placeholder - would calculate streak recovery
    return 0;
  }

  static int _calculateBonusXP(int? totalXP) {
    // Placeholder - would calculate bonus XP earned
    return (totalXP ?? 0) ~/ 10; // Rough estimate
  }

  static int _calculateXPPerDay(int? totalXP, DateTime? createdAt) {
    if (totalXP == null || createdAt == null) return 0;
    final daysSinceStart = DateTime.now().difference(createdAt).inDays;
    if (daysSinceStart <= 0) return totalXP;
    return (totalXP / daysSinceStart).round();
  }

  static int _calculateXPPerWeek(int? totalXP, DateTime? createdAt) {
    final dailyXP = _calculateXPPerDay(totalXP, createdAt);
    return dailyXP * 7;
  }

  static int _calculateXPPerMonth(int? totalXP, DateTime? createdAt) {
    final dailyXP = _calculateXPPerDay(totalXP, createdAt);
    return dailyXP * 30;
  }

  static int _calculateAllPriorities(
    int? urgent,
    int? high,
    int? medium,
    int? low,
  ) {
    int count = 0;
    if ((urgent ?? 0) > 0) count++;
    if ((high ?? 0) > 0) count++;
    if ((medium ?? 0) > 0) count++;
    if ((low ?? 0) > 0) count++;
    return count;
  }

  static int _calculateUrgentPerDay() {
    // Placeholder - would calculate max urgent tasks in one day
    return 0;
  }

  static int _calculateAllUrgentInWeek() {
    // Placeholder - would check if all urgent tasks completed in a week
    return 0;
  }

  static int _calculatePriorityMaster(
    int? urgent,
    int? high,
    int? medium,
    int? low,
  ) {
    // Total tasks across all priorities
    return (urgent ?? 0) + (high ?? 0) + (medium ?? 0) + (low ?? 0);
  }

  static int _calculateCustomCategory(Map<String, int>? categoryStats) {
    // Placeholder - would identify custom categories
    return 0;
  }

  static int _calculateAllPredefined(Map<String, int>? categoryStats) {
    const predefined = ['work', 'personal', 'health', 'shopping', 'education'];
    if (categoryStats == null) return 0;

    int count = 0;
    for (final category in predefined) {
      if ((categoryStats[category] ?? 0) > 0) count++;
    }
    return count;
  }

  /// Format achievement progress for display
  static String formatProgress(double progress) {
    if (progress >= 1.0) return '100%';
    return '${(progress * 100).toInt()}%';
  }

  /// Get next achievement in a category
  static AchievementModel? getNextAchievement(
    AchievementCategory category,
    int currentProgress,
    List<AchievementModel> unlockedAchievements,
  ) {
    final categoryAchievements = AchievementDefinitions.getByCategory(category)
        .where((a) => !unlockedAchievements.any((ua) => ua.id == a.id))
        .toList();

    if (categoryAchievements.isEmpty) return null;

    // Sort by target value and return the next one
    categoryAchievements.sort((a, b) => a.targetValue.compareTo(b.targetValue));

    for (final achievement in categoryAchievements) {
      if (currentProgress < achievement.targetValue) {
        return achievement;
      }
    }

    return null;
  }
}
