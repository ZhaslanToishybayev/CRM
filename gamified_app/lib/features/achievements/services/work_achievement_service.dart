/// Work Achievement Service
/// Service for managing work-related achievements and progress tracking

import '../models/achievement_model.dart';
import '../models/achievement_stats.dart';
import '../models/work_achievement_definitions.dart';
import '../../tasks/models/work_task_model.dart';
import '../../teams/models/team_model.dart';
import '../../projects/models/project_model.dart';
import '../../organizations/models/organization_model.dart';

class WorkAchievementService {
  /// Check for new work achievements based on user activity
  Future<List<AchievementModel>> checkWorkAchievements({
    required String userId,
    required List<WorkTaskModel> tasks,
    required String teamId,
    required String organizationId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final newAchievements = <AchievementModel>[];

    // Check each achievement category
    newAchievements.addAll(await _checkProductivityAchievements(userId, tasks));
    newAchievements.addAll(await _checkDeadlineAchievements(userId, tasks));
    newAchievements.addAll(await _checkTeamworkAchievements(userId, tasks, teamId));
    newAchievements.addAll(await _checkQualityAchievements(userId, tasks));
    newAchievements.addAll(await _checkLeadershipAchievements(userId, tasks));
    newAchievements.addAll(await _checkInnovationAchievements(userId, tasks));
    newAchievements.addAll(await _checkGrowthAchievements(userId, tasks));
    newAchievements.addAll(await _checkCommunicationAchievements(userId, tasks));

    return newAchievements;
  }

  /// Check productivity-related achievements
  Future<List<AchievementModel>> _checkProductivityAchievements(
    String userId,
    List<WorkTaskModel> tasks,
  ) async {
    final achievements = <AchievementModel>[];

    // Get completed tasks
    final completedTasks = tasks
        .where((t) => t.isCompleted)
        .toList();

    // Daily productivity (5 tasks in one day)
    final dailyTaskCounts = <String, int>{};
    for (final task in completedTasks) {
      if (task.completedAt != null) {
        final dateKey = _formatDate(task.completedAt!);
        dailyTaskCounts[dateKey] = (dailyTaskCounts[dateKey] ?? 0) + 1;
      }
    }

    for (final entry in dailyTaskCounts.entries) {
      if (entry.value >= 5) {
        final achievement = WorkAchievementDefinitions.getById('work_productivity_daily_5');
        if (achievement != null) {
          achievements.add(achievement);
        }
      }
    }

    // Weekly productivity (25 tasks in one week)
    final weeklyTaskCounts = <String, int>{};
    for (final task in completedTasks) {
      if (task.completedAt != null) {
        final weekKey = _formatWeek(task.completedAt!);
        weeklyTaskCounts[weekKey] = (weeklyTaskCounts[weekKey] ?? 0) + 1;
      }
    }

    for (final entry in weeklyTaskCounts.entries) {
      if (entry.value >= 25) {
        final achievement = WorkAchievementDefinitions.getById('work_productivity_weekly_25');
        if (achievement != null) {
          achievements.add(achievement);
        }
      }
    }

    // Monthly productivity (100 tasks in one month)
    final monthlyTaskCounts = <String, int>{};
    for (final task in completedTasks) {
      if (task.completedAt != null) {
        final monthKey = _formatMonth(task.completedAt!);
        monthlyTaskCounts[monthKey] = (monthlyTaskCounts[monthKey] ?? 0) + 1;
      }
    }

    for (final entry in monthlyTaskCounts.entries) {
      if (entry.value >= 100) {
        final achievement = WorkAchievementDefinitions.getById('work_productivity_monthly_100');
        if (achievement != null) {
          achievements.add(achievement);
        }
      }
    }

    // Quick finish (complete before due date)
    final earlyCompletions = completedTasks
        .where((task) => task.completedAt != null &&
            task.dueDate != null &&
            task.completedAt!.isBefore(task.dueDate!))
        .length;

    if (earlyCompletions >= 3) {
      final achievement = WorkAchievementDefinitions.getById('work_productivity_quick_finish');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    // High priority tasks
    final highPriorityTasks = completedTasks
        .where((task) => task.priority == WorkTaskPriority.high)
        .length;

    if (highPriorityTasks >= 20) {
      final achievement = WorkAchievementDefinitions.getById('work_productivity_high_priority');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    // Consistency (3+ tasks every day for 7 days)
    final hasConsistentPerformance = _checkConsistentPerformance(completedTasks, 7, 3);
    if (hasConsistentPerformance) {
      final achievement = WorkAchievementDefinitions.getById('work_productivity_consistency');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    return achievements;
  }

  /// Check deadline-related achievements
  Future<List<AchievementModel>> _checkDeadlineAchievements(
    String userId,
    List<WorkTaskModel> tasks,
  ) async {
    final achievements = <AchievementModel>[];

    final completedTasks = tasks.where((t) => t.isCompleted).toList();

    // On-time submissions
    final onTimeCompletions = completedTasks
        .where((task) => task.dueDate != null &&
            task.completedAt != null &&
            !task.completedAt!.isAfter(task.dueDate!))
        .length;

    if (onTimeCompletions >= 10) {
      final achievement = WorkAchievementDefinitions.getById('work_deadline_punctual_10');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    // Early submissions
    final earlyCompletions = completedTasks
        .where((task) => task.dueDate != null &&
            task.completedAt != null &&
            task.completedAt!.isBefore(task.dueDate!))
        .length;

    if (earlyCompletions >= 5) {
      final achievement = WorkAchievementDefinitions.getById('work_deadline_early_5');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    // Zero overdue streak
    final hasNoOverdue = _checkNoOverdueStreak(tasks, 14);
    if (hasNoOverdue) {
      final achievement = WorkAchievementDefinitions.getById('work_deadline_zero_overdue');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    // Deadline crusher (50 early completions)
    if (earlyCompletions >= 50) {
      final achievement = WorkAchievementDefinitions.getById('work_deadline_crusher');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    // Overdue completion recovery
    final overdueCompletions = completedTasks
        .where((task) => task.dueDate != null &&
            task.completedAt != null &&
            task.completedAt!.isAfter(task.dueDate!))
        .isNotEmpty;

    if (overdueCompletions) {
      final achievement = WorkAchievementDefinitions.getById('work_deadline_recovery');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    // Urgent tasks completed on time
    final urgentOnTime = completedTasks
        .where((task) => task.priority == WorkTaskPriority.urgent &&
            task.dueDate != null &&
            task.completedAt != null &&
            !task.completedAt!.isAfter(task.dueDate!))
        .length;

    if (urgentOnTime >= 15) {
      final achievement = WorkAchievementDefinitions.getById('work_deadline_urgent_handle');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    return achievements;
  }

  /// Check teamwork-related achievements
  Future<List<AchievementModel>> _checkTeamworkAchievements(
    String userId,
    List<WorkTaskModel> tasks,
    String teamId,
  ) async {
    final achievements = <AchievementModel>[];

    final completedTasks = tasks.where((t) => t.isCompleted).toList();

    // Team tasks completed
    final teamTasks = completedTasks
        .where((task) => task.type == WorkTaskType.team)
        .length;

    if (teamTasks >= 10) {
      final achievement = WorkAchievementDefinitions.getById('work_teamwork_collab_10');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    // Group tasks completed (tasks with multiple assignees)
    final groupTasks = completedTasks
        .where((task) => task.assignedTo != null && task.assignedTo!.length > 1)
        .length;

    if (groupTasks >= 20) {
      final achievement = WorkAchievementDefinitions.getById('work_teamwork_group_task');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    return achievements;
  }

  /// Check quality-related achievements
  Future<List<AchievementModel>> _checkQualityAchievements(
    String userId,
    List<WorkTaskModel> tasks,
  ) async {
    final achievements = <AchievementModel>[];

    final completedTasks = tasks.where((t) => t.isCompleted).toList();

    // Five star rating
    final fiveStarTasks = completedTasks
        .where((task) => task.qualityRating != null && task.qualityRating == 5)
        .isNotEmpty;

    if (fiveStarTasks) {
      final achievement = WorkAchievementDefinitions.getById('work_quality_rating_5');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    // High ratings (4-5 stars)
    final highRatedTasks = completedTasks
        .where((task) => task.qualityRating != null && task.qualityRating! >= 4)
        .length;

    if (highRatedTasks >= 10) {
      final achievement = WorkAchievementDefinitions.getById('work_quality_ratings_10');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    // First-time right (no revisions)
    final firstTimeRight = completedTasks
        .where((task) => task.managerFeedback == null || task.managerFeedback!.isEmpty)
        .length;

    if (firstTimeRight >= 15) {
      final achievement = WorkAchievementDefinitions.getById('work_quality_zero_revisions');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    return achievements;
  }

  /// Check leadership-related achievements
  Future<List<AchievementModel>> _checkLeadershipAchievements(
    String userId,
    List<WorkTaskModel> tasks,
  ) async {
    final achievements = <AchievementModel>[];

    final completedTasks = tasks.where((t) => t.isCompleted).toList();

    // Tasks assigned to others (delegation)
    final delegatedTasks = completedTasks
        .where((task) => task.assignedBy == userId && task.assignedTo != null)
        .length;

    if (delegatedTasks >= 20) {
      final achievement = WorkAchievementDefinitions.getById('work_leadership_delegate');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    return achievements;
  }

  /// Check innovation-related achievements
  Future<List<AchievementModel>> _checkInnovationAchievements(
    String userId,
    List<WorkTaskModel> tasks,
  ) async {
    final achievements = <AchievementModel>[];

    // Innovation is tracked through task categories or tags
    final innovativeTasks = tasks
        .where((task) => task.category != null &&
            (task.category!.toLowerCase().contains('innov') ||
             task.category!.toLowerCase().contains('improve')))
        .length;

    if (innovativeTasks >= 5) {
      final achievement = WorkAchievementDefinitions.getById('work_innovation_idea');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    return achievements;
  }

  /// Check growth-related achievements
  Future<List<AchievementModel>> _checkGrowthAchievements(
    String userId,
    List<WorkTaskModel> tasks,
  ) async {
    final achievements = <AchievementModel>[];

    // Growth is tracked through learning tasks
    final learningTasks = tasks
        .where((task) => task.category != null &&
            (task.category!.toLowerCase().contains('learn') ||
             task.category!.toLowerCase().contains('training') ||
             task.category!.toLowerCase().contains('cert')))
        .length;

    if (learningTasks >= 5) {
      final achievement = WorkAchievementDefinitions.getById('work_growth_skill_5');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    return achievements;
  }

  /// Check communication-related achievements
  Future<List<AchievementModel>> _checkCommunicationAchievements(
    String userId,
    List<WorkTaskModel> tasks,
  ) async {
    final achievements = <AchievementModel>[];

    // Communication is tracked through tasks with comments or feedback
    final communicativeTasks = tasks
        .where((task) => task.commentIds.isNotEmpty)
        .length;

    if (communicativeTasks >= 10) {
      final achievement = WorkAchievementDefinitions.getById('work_communication_clear');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    return achievements;
  }

  /// Check team achievements
  Future<List<AchievementModel>> checkTeamAchievements({
    required String teamId,
    required List<WorkTaskModel> teamTasks,
    required List<String> teamMemberIds,
  }) async {
    final achievements = <AchievementModel>[];

    final completedTasks = teamTasks.where((t) => t.isCompleted).toList();

    // Synchronized - entire team completes daily tasks
    final dailyCompletion = _checkTeamDailySync(teamTasks, teamMemberIds);
    if (dailyCompletion) {
      final achievement = WorkAchievementDefinitions.getById('work_team_synchronized');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    // Zero debt - no overdue tasks for a week
    final hasNoOverdue = _checkTeamNoOverdue(teamTasks, 7);
    if (hasNoOverdue) {
      final achievement = WorkAchievementDefinitions.getById('work_team_zero_debt');
      if (achievement != null) {
        achievements.add(achievement);
      }
    }

    return achievements;
  }

  /// Get achievement progress for a user
  Future<AchievementProgress> getAchievementProgress({
    required String userId,
    required List<WorkTaskModel> tasks,
    required AchievementModel achievement,
  }) async {
    int progress = 0;
    int target = achievement.targetValue;

    switch (achievement.condition) {
      case 'work_tasks_per_day':
        progress = _getTasksPerDay(tasks);
        break;
      case 'work_tasks_per_week':
        progress = _getTasksPerWeek(tasks);
        break;
      case 'work_tasks_per_month':
        progress = _getTasksPerMonth(tasks);
        break;
      case 'on_time_submissions':
        progress = _getOnTimeSubmissions(tasks);
        break;
      case 'early_completions':
        progress = _getEarlyCompletions(tasks);
        break;
      case 'team_collaborations':
        progress = _getTeamCollaborations(tasks);
        break;
      case 'high_ratings':
        progress = _getHighRatedTasks(tasks);
        break;
      case 'no_revisions':
        progress = _getFirstTimeRight(tasks);
        break;
      // Add more conditions as needed
      default:
        progress = 0;
    }

    final percentage = target > 0 ? (progress / target * 100).clamp(0.0, 100.0) : 0.0;
    final isUnlocked = progress >= target;

    return AchievementProgress(
      progress: progress,
      target: target,
      percentage: percentage,
      isUnlocked: isUnlocked,
    );
  }

  // ===== HELPER METHODS =====

  bool _checkConsistentPerformance(List<WorkTaskModel> tasks, int days, int minTasksPerDay) {
    // Implementation for checking consistent daily performance
    final dailyCounts = <String, int>{};
    for (final task in tasks) {
      if (task.completedAt != null) {
        final dateKey = _formatDate(task.completedAt!);
        dailyCounts[dateKey] = (dailyCounts[dateKey] ?? 0) + 1;
      }
    }

    // Check if user has minTasksPerDay for consecutive days
    // This is a simplified version - would need more complex logic in real implementation
    return dailyCounts.values.where((count) => count >= minTasksPerDay).length >= days;
  }

  bool _checkNoOverdueStreak(List<WorkTaskModel> tasks, int days) {
    // Check if user has no overdue tasks for specified days
    // Simplified implementation
    final overdueTasks = tasks.where((t) => t.isOverdue).isEmpty;
    return overdueTasks;
  }

  bool _checkTeamDailySync(List<WorkTaskModel> teamTasks, List<String> teamMemberIds) {
    // Check if all team members completed tasks today
    final todayTasks = teamTasks.where((task) {
      if (task.completedAt == null) return false;
      final today = DateTime.now();
      return task.completedAt!.year == today.year &&
          task.completedAt!.month == today.month &&
          task.completedAt!.day == today.day;
    }).toList();

    final activeMembers = todayTasks.map((t) => t.userId).toSet();
    return activeMembers.length == teamMemberIds.length;
  }

  bool _checkTeamNoOverdue(List<WorkTaskModel> teamTasks, int days) {
    // Check if team has no overdue tasks for specified period
    final overdueTasks = teamTasks.where((t) => t.isOverdue).isEmpty;
    return overdueTasks;
  }

  // ===== PROGRESS CALCULATION HELPERS =====

  int _getTasksPerDay(List<WorkTaskModel> tasks) {
    final today = DateTime.now();
    return tasks
        .where((task) => task.isCompleted &&
            task.completedAt != null &&
            task.completedAt!.year == today.year &&
            task.completedAt!.month == today.month &&
            task.completedAt!.day == today.day)
        .length;
  }

  int _getTasksPerWeek(List<WorkTaskModel> tasks) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(Duration(days: 7));

    return tasks
        .where((task) => task.isCompleted &&
            task.completedAt != null &&
            task.completedAt!.isAfter(weekStart) &&
            task.completedAt!.isBefore(weekEnd))
        .length;
  }

  int _getTasksPerMonth(List<WorkTaskModel> tasks) {
    final now = DateTime.now();
    return tasks
        .where((task) => task.isCompleted &&
            task.completedAt != null &&
            task.completedAt!.year == now.year &&
            task.completedAt!.month == now.month)
        .length;
  }

  int _getOnTimeSubmissions(List<WorkTaskModel> tasks) {
    return tasks
        .where((task) => task.isCompleted &&
            task.dueDate != null &&
            task.completedAt != null &&
            !task.completedAt!.isAfter(task.dueDate!))
        .length;
  }

  int _getEarlyCompletions(List<WorkTaskModel> tasks) {
    return tasks
        .where((task) => task.isCompleted &&
            task.dueDate != null &&
            task.completedAt != null &&
            task.completedAt!.isBefore(task.dueDate!))
        .length;
  }

  int _getTeamCollaborations(List<WorkTaskModel> tasks) {
    return tasks
        .where((task) => task.isCompleted && task.type == WorkTaskType.team)
        .length;
  }

  int _getHighRatedTasks(List<WorkTaskModel> tasks) {
    return tasks
        .where((task) => task.isCompleted &&
            task.qualityRating != null &&
            task.qualityRating! >= 4)
        .length;
  }

  int _getFirstTimeRight(List<WorkTaskModel> tasks) {
    return tasks
        .where((task) => task.isCompleted &&
            (task.managerFeedback == null || task.managerFeedback!.isEmpty))
        .length;
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatWeek(DateTime date) {
    // Simplified week formatting
    final weekNumber = ((date.dayOfYear - 1) ~/ 7) + 1;
    return '${date.year}-W$weekNumber';
  }

  String _formatMonth(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}';
  }
}

/// Achievement progress model
class AchievementProgress {
  final int progress;
  final int target;
  final double percentage;
  final bool isUnlocked;

  const AchievementProgress({
    required this.progress,
    required this.target,
    required this.percentage,
    required this.isUnlocked,
  });
}

/// Extension to get day of year
extension DateTimeExtension on DateTime {
  int get dayOfYear {
    final startOfYear = DateTime(year, 1, 1);
    return difference(startOfYear).inDays + 1;
  }
}
