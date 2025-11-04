/// Work XP Calculator Service
/// Extended XP calculation system for corporate/work tasks
///
/// This service provides comprehensive XP calculation considering:
/// - Task type (personal, project, team)
/// - Task priority
/// - Completion speed
/// - Quality ratings
/// - Team collaboration
/// - Deadline adherence

import '../models/xp_model.dart';
import '../../tasks/models/work_task_model.dart';
import '../../teams/models/team_model.dart';
import '../../projects/models/project_model.dart';

class WorkXPCalculatorService {
  WorkXPCalculatorService._();

  /// Base XP values for different task priorities
  static const Map<WorkTaskPriority, int> baseXPByPriority = {
    WorkTaskPriority.low: 15,
    WorkTaskPriority.medium: 30,
    WorkTaskPriority.high: 50,
    WorkTaskPriority.urgent: 75,
    WorkTaskPriority.critical: 100,
  };

  /// XP multipliers for different task types
  static const Map<WorkTaskType, double> typeMultipliers = {
    WorkTaskType.personal: 1.0,
    WorkTaskType.project: 1.5,
    WorkTaskType.team: 2.0,
  };

  /// Calculate total XP for a completed work task
  static int calculateTotalXP({
    required WorkTaskModel task,
    int? qualityRating,
    String? managerFeedback,
    List<String>? collaborators,
  }) {
    // Base XP from priority
    int totalXP = baseXPByPriority[task.priority] ?? 30;

    // Apply task type multiplier
    totalXP = (totalXP * typeMultipliers[task.type]!).round();

    // Speed bonus (completing early)
    final speedBonus = _calculateSpeedBonus(task);
    totalXP += speedBonus;

    // Quality bonus (from manager rating)
    final qualityBonus = _calculateQualityBonus(qualityRating);
    totalXP += qualityBonus;

    // Team collaboration bonus
    final teamBonus = _calculateTeamBonus(task, collaborators);
    totalXP += teamBonus;

    // Deadline adherence bonus
    final deadlineBonus = _calculateDeadlineBonus(task);
    totalXP += deadlineBonus;

    // Estimated time accuracy bonus
    final accuracyBonus = _calculateAccuracyBonus(task);
    totalXP += accuracyBonus;

    // Complexity bonus (for tasks with subtasks)
    final complexityBonus = _calculateComplexityBonus(task);
    totalXP += complexityBonus;

    return totalXP;
  }

  /// Calculate speed bonus for completing tasks early
  static int _calculateSpeedBonus(WorkTaskModel task) {
    if (task.completedAt == null || task.dueDate == null) return 0;

    final completedEarly = task.completedAt!.isBefore(task.dueDate!);
    if (!completedEarly) return 0;

    final daysEarly = task.dueDate!.difference(task.completedAt!).inDays;

    // Bonus structure:
    // Same day: +50 XP
    // 1-2 days early: +75 XP
    // 3-7 days early: +100 XP
    // 1-2 weeks early: +150 XP
    // More than 2 weeks: +200 XP

    if (daysEarly == 0) {
      return 50;
    } else if (daysEarly <= 2) {
      return 75;
    } else if (daysEarly <= 7) {
      return 100;
    } else if (daysEarly <= 14) {
      return 150;
    } else {
      return 200;
    }
  }

  /// Calculate quality bonus based on manager rating
  static int _calculateQualityBonus(int? qualityRating) {
    if (qualityRating == null) return 0;

    // Quality bonus structure (1-5 rating scale):
    // Rating 1: +0 XP (poor quality)
    // Rating 2: +10 XP (below average)
    // Rating 3: +25 XP (average)
    // Rating 4: +50 XP (good)
    // Rating 5: +100 XP (excellent)

    switch (qualityRating) {
      case 1:
        return 0;
      case 2:
        return 10;
      case 3:
        return 25;
      case 4:
        return 50;
      case 5:
        return 100;
      default:
        return 0;
    }
  }

  /// Calculate team collaboration bonus
  static int _calculateTeamBonus(WorkTaskModel task, List<String>? collaborators) {
    if (task.type != WorkTaskType.team) return 0;

    // Base team bonus
    int bonus = 50;

    // Extra bonus for collaboration
    if (collaborators != null && collaborators.isNotEmpty) {
      bonus += collaborators.length * 25;
    }

    // Extra bonus if task was assigned to team
    if (task.assignedTo != null && task.assignedTo!.length > 1) {
      bonus += task.assignedTo!.length * 20;
    }

    return bonus;
  }

  /// Calculate deadline adherence bonus
  static int _calculateDeadlineBonus(WorkTaskModel task) {
    if (task.dueDate == null || task.completedAt == null) return 0;

    final isOnTime = !task.completedAt!.isAfter(task.dueDate!);

    // Bonus for on-time completion
    if (isOnTime) {
      return 30;
    }

    // No bonus for late completion
    return 0;
  }

  /// Calculate accuracy bonus for estimating time correctly
  static int _calculateAccuracyBonus(WorkTaskModel task) {
    if (task.estimatedHours == null || task.actualHours == null) return 0;

    final estimatedMinutes = task.estimatedHours! * 60;
    final actualMinutes = task.actualHours! * 60;

    // Calculate accuracy percentage
    final accuracy = 1 - ((estimatedMinutes - actualMinutes).abs() / estimatedMinutes);

    // Bonus for good estimates (±20% accuracy = +50 XP)
    // Perfect estimates (±10% accuracy = +100 XP)
    if (accuracy >= 0.9) {
      return 100; // Excellent estimate
    } else if (accuracy >= 0.8) {
      return 50; // Good estimate
    }

    return 0;
  }

  /// Calculate complexity bonus for tasks with subtasks
  static int _calculateComplexityBonus(WorkTaskModel task) {
    int bonus = 0;

    // Bonus for tasks with subtasks
    if (task.hasSubtasks) {
      bonus += task.subtaskIds.length * 15;
    }

    // Bonus for being a subtask (demonstrates organization)
    if (task.isSubtask) {
      bonus += 20;
    }

    return bonus;
  }

  /// Calculate XP for team achievements
  static int calculateTeamXPBonus({
    required String teamId,
    required int teamMemberCount,
    required double teamCompletionRate,
    required int consecutiveOnTimeDays,
  }) {
    int bonus = 0;

    // Bonus for high team completion rate
    if (teamCompletionRate >= 0.9) {
      bonus += 200;
    } else if (teamCompletionRate >= 0.8) {
      bonus += 100;
    } else if (teamCompletionRate >= 0.7) {
      bonus += 50;
    }

    // Bonus for consecutive on-time performance
    if (consecutiveOnTimeDays >= 30) {
      bonus += 300;
    } else if (consecutiveOnTimeDays >= 14) {
      bonus += 150;
    } else if (consecutiveOnTimeDays >= 7) {
      bonus += 75;
    }

    // Bonus for team size (larger teams get slightly less per person)
    if (teamMemberCount >= 10) {
      bonus = (bonus * 0.8).round();
    }

    return bonus;
  }

  /// Calculate XP for project milestones
  static int calculateProjectMilestoneXP({
    required ProjectModel project,
    required double completionPercentage,
    required bool onTime,
    required int teamSize,
  }) {
    int bonus = 0;

    // Major milestone bonuses
    if (completionPercentage >= 100.0) {
      bonus += 500; // Project completion
    } else if (completionPercentage >= 75.0) {
      bonus += 300; // Major milestone
    } else if (completionPercentage >= 50.0) {
      bonus += 200; // Midpoint
    } else if (completionPercentage >= 25.0) {
      bonus += 100; // Early milestone
    }

    // On-time bonus
    if (onTime) {
      bonus += 100;
    }

    // Team size factor
    if (teamSize >= 8) {
      bonus = (bonus * 1.2).round(); // Bonus for larger teams
    }

    return bonus;
  }

  /// Calculate streak XP bonuses
  static int calculateStreakXPBonus({
    required int currentStreak,
    required WorkTaskType? taskType,
  }) {
    // Base streak bonuses
    if (currentStreak >= 100) return 100;
    if (currentStreak >= 30) return 75;
    if (currentStreak >= 14) return 50;
    if (currentStreak >= 7) return 30;
    if (currentStreak >= 3) return 15;

    // Type-specific streak bonuses
    if (taskType == WorkTaskType.team && currentStreak >= 5) {
      return 50; // Team collaboration streak bonus
    } else if (taskType == WorkTaskType.project && currentStreak >= 5) {
      return 40; // Project focus streak bonus
    }

    return 0;
  }

  /// Calculate penalty for overdue tasks
  static int calculateOverduePenalty({
    required WorkTaskModel task,
    required DateTime currentTime,
  }) {
    if (task.dueDate == null || task.completedAt != null) return 0;

    final isOverdue = currentTime.isAfter(task.dueDate!);
    if (!isOverdue) return 0;

    final daysOverdue = currentTime.difference(task.dueDate!).inDays;

    // Penalty structure (negative XP):
    // 1 day overdue: -10 XP
    // 2-3 days overdue: -25 XP
    // 4-7 days overdue: -50 XP
    // 1-2 weeks overdue: -100 XP
    // More than 2 weeks: -200 XP

    if (daysOverdue == 1) {
      return -10;
    } else if (daysOverdue <= 3) {
      return -25;
    } else if (daysOverdue <= 7) {
      return -50;
    } else if (daysOverdue <= 14) {
      return -100;
    } else {
      return -200;
    }
  }

  /// Calculate leaderboard bonus XP (for top performers)
  static int calculateLeaderboardBonus({
    required int userRank,
    required int totalUsers,
  }) {
    // Top 10% get bonus
    final topPercentThreshold = (totalUsers * 0.1).ceil();

    if (userRank <= topPercentThreshold) {
      // Rank 1: +500 XP
      // Rank 2: +400 XP
      // Rank 3: +300 XP
      // Rank 4-10: +200 XP
      // Rank 11-20: +100 XP

      if (userRank == 1) {
        return 500;
      } else if (userRank == 2) {
        return 400;
      } else if (userRank == 3) {
        return 300;
      } else if (userRank <= 10) {
        return 200;
      } else if (userRank <= 20) {
        return 100;
      }
    }

    return 0;
  }

  /// Calculate new XP after adding XP (extended version)
  static XPModel calculateNewWorkXP({
    required XPModel currentXP,
    required int additionalXP,
    required WorkTaskModel task,
    int? qualityRating,
    String? managerFeedback,
  }) {
    // Apply overdue penalty if task is overdue
    int finalXP = additionalXP;

    if (task.isOverdue) {
      final penalty = calculateOverduePenalty(
        task: task,
        currentTime: DateTime.now(),
      );
      finalXP += penalty;
    }

    // Ensure XP doesn't go below 0
    finalXP = finalXP.clamp(0, 999999);

    return XPCalculatorService.calculateNewXP(
      currentXP: currentXP,
      additionalXP: finalXP,
    );
  }

  /// Get XP breakdown for display purposes
  static XPBreakdown getXPBreakdown({
    required WorkTaskModel task,
    int? qualityRating,
    List<String>? collaborators,
  }) {
    // Base XP
    int baseXP = baseXPByPriority[task.priority] ?? 30;
    baseXP = (baseXP * typeMultipliers[task.type]!).round();

    // Bonuses
    final speedBonus = _calculateSpeedBonus(task);
    final qualityBonus = _calculateQualityBonus(qualityRating);
    final teamBonus = _calculateTeamBonus(task, collaborators);
    final deadlineBonus = _calculateDeadlineBonus(task);
    final accuracyBonus = _calculateAccuracyBonus(task);
    final complexityBonus = _calculateComplexityBonus(task);

    // Penalties
    final penalty = task.isOverdue
        ? calculateOverduePenalty(task: task, currentTime: DateTime.now())
        : 0;

    // Total
    final totalXP = baseXP +
        speedBonus +
        qualityBonus +
        teamBonus +
        deadlineBonus +
        accuracyBonus +
        complexityBonus +
        penalty;

    return XPBreakdown(
      baseXP: baseXP,
      speedBonus: speedBonus,
      qualityBonus: qualityBonus,
      teamBonus: teamBonus,
      deadlineBonus: deadlineBonus,
      accuracyBonus: accuracyBonus,
      complexityBonus: complexityBonus,
      penalty: penalty,
      totalXP: totalXP,
    );
  }

  /// Get recommended XP for a task before completion
  static int getRecommendedXP(WorkTaskModel task) {
    int recommendedXP = baseXPByPriority[task.priority] ?? 30;
    recommendedXP = (recommendedXP * typeMultipliers[task.type]!).round();

    // Add potential bonuses
    // Speed bonus (assume early completion)
    recommendedXP += 50;

    // Deadline bonus (assume on-time)
    recommendedXP += 30;

    // Team bonus if applicable
    if (task.type == WorkTaskType.team) {
      recommendedXP += 50;
    }

    return recommendedXP;
  }

  /// Format XP for display
  static String formatWorkXP(int xp) {
    return XPCalculatorService.formatXP(xp);
  }

  /// Calculate XP progress percentage
  static double calculateWorkProgress(int totalXP) {
    return XPCalculatorService.calculateProgressPercentage(totalXP);
  }

  /// Get XP needed for next level
  static int getWorkXPForNextLevel(int totalXP) {
    return XPCalculatorService.getXPForNextLevel(totalXP);
  }

  /// Estimate days to next level based on work pace
  static int estimateDaysToNextWorkLevel({
    required int currentTotalXP,
    required int daysActive,
    required int workXPPerDay,
  }) {
    if (daysActive == 0 || workXPPerDay == 0) return 999;

    return XPCalculatorService.estimateDaysToNextLevel(
      currentTotalXP: currentTotalXP,
      daysActive: daysActive,
      xpPerDay: workXPPerDay,
    );
  }
}

/// XP breakdown model for detailed display
class XPBreakdown {
  final int baseXP;
  final int speedBonus;
  final int qualityBonus;
  final int teamBonus;
  final int deadlineBonus;
  final int accuracyBonus;
  final int complexityBonus;
  final int penalty;
  final int totalXP;

  const XPBreakdown({
    required this.baseXP,
    required this.speedBonus,
    required this.qualityBonus,
    required this.teamBonus,
    required this.deadlineBonus,
    required this.accuracyBonus,
    required this.complexityBonus,
    required this.penalty,
    required this.totalXP,
  });

  /// Get total bonuses
  int get totalBonuses {
    return speedBonus + qualityBonus + teamBonus + deadlineBonus + accuracyBonus + complexityBonus;
  }

  /// Check if has penalty
  bool get hasPenalty => penalty < 0;

  /// Get penalty amount (positive value)
  int get penaltyAmount => penalty.abs();
}

/// Extension to add work-specific methods to XPModel
extension WorkXPModelExtension on XPModel {
  /// Calculate work-specific progress
  WorkXPProgress getWorkProgress() {
    return WorkXPProgress(
      currentLevel: currentLevel,
      currentLevelXP: currentLevelXP,
      nextLevelXP: nextLevelXP,
      xpToNextLevel: xpToNextLevel,
      progressPercentage: (progressToNextLevel * 100).round(),
    );
  }

  /// Check if user is eligible for work achievements
  bool isEligibleForWorkAchievements() {
    // Need at least level 5 and 1000 XP to be eligible
    return currentLevel >= 5 && totalXP >= 1000;
  }

  /// Get work tier (for leaderboards)
  WorkTier getWorkTier() {
    if (currentLevel >= 50) return WorkTier.expert;
    if (currentLevel >= 25) return WorkTier.advanced;
    if (currentLevel >= 10) return WorkTier.intermediate;
    if (currentLevel >= 5) return WorkTier.beginner;
    return WorkTier.novice;
  }
}

/// Work progress model
class WorkXPProgress {
  final int currentLevel;
  final int currentLevelXP;
  final int nextLevelXP;
  final int xpToNextLevel;
  final int progressPercentage;

  const WorkXPProgress({
    required this.currentLevel,
    required this.currentLevelXP,
    required this.nextLevelXP,
    required this.xpToNextLevel,
    required this.progressPercentage,
  });
}

/// Work tier enum for categorization
enum WorkTier {
  novice,
  beginner,
  intermediate,
  advanced,
  expert,
}

extension WorkTierExtension on WorkTier {
  String get displayName {
    switch (this) {
      case WorkTier.novice:
        return 'Novice';
      case WorkTier.beginner:
        return 'Beginner';
      case WorkTier.intermediate:
        return 'Intermediate';
      case WorkTier.advanced:
        return 'Advanced';
      case WorkTier.expert:
        return 'Expert';
    }
  }

  String get displayNameRu {
    switch (this) {
      case WorkTier.novice:
        return 'Новичок';
      case WorkTier.beginner:
        return 'Начинающий';
      case WorkTier.intermediate:
        return 'Средний';
      case WorkTier.advanced:
        return 'Продвинутый';
      case WorkTier.expert:
        return 'Эксперт';
    }
  }

  String get icon {
    switch (this) {
      case WorkTier.novice:
        return '🌱';
      case WorkTier.beginner:
        return '⭐';
      case WorkTier.intermediate:
        return '⭐⭐';
      case WorkTier.advanced:
        return '⭐⭐⭐';
      case WorkTier.expert:
        return '⭐⭐⭐⭐⭐';
    }
  }

  Color get color {
    switch (this) {
      case WorkTier.novice:
        return Colors.grey;
      case WorkTier.beginner:
        return Colors.green;
      case WorkTier.intermediate:
        return Colors.blue;
      case WorkTier.advanced:
        return Colors.purple;
      case WorkTier.expert:
        return Colors.orange;
    }
  }
}

import 'package:flutter/material.dart';
