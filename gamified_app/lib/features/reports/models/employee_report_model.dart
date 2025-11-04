/// Employee Report Model
/// Data model for individual employee's performance report

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../tasks/models/work_task_model.dart';
import '../../achievements/models/achievement_model.dart';

part 'employee_report_model.freezed.dart';
part 'employee_report_model.g.dart';

@freezed
class EmployeeReportModel with _$EmployeeReportModel {
  const factory EmployeeReportModel({
    required String userId,
    required String organizationId,
    required String departmentId,
    required String teamId,
    required DateTime generatedAt,
    required Period period,
    required DateTime periodStart,
    required DateTime periodEnd,

    // Personal Information
    required String username,
    required String fullName,
    required String email,
    required String? avatarUrl,
    required String jobTitle,
    required DateTime hireDate,

    // Performance Summary
    required int currentLevel,
    required int totalXP,
    required int xpEarnedThisPeriod,
    required int currentStreak,
    required int longestStreak,
    required int tasksCompleted,
    required int tasksCompletedOnTime,
    required int tasksCompletedOverdue,

    // Quality Metrics
    required double averageQualityRating,
    required int fiveStarRatings,
    required int tasksWithoutRevisions,
    required String? managerFeedback,

    // Task Details
    required List<TaskSummary> completedTasks,
    required List<TaskSummary> overdueTasks,
    required List<TaskSummary> upcomingTasks,
    required Map<WorkTaskPriority, int> tasksByPriority,
    required Map<WorkTaskType, int> tasksByType,
    required Map<String, int> tasksByCategory,

    // Time Tracking
    required double averageTaskTime, // in hours
    required int totalTimeSpent, // in minutes
    required int estimatedTime, // in minutes
    required double timeAccuracy, // percentage

    // Achievements
    required List<AchievementModel> unlockedAchievements,
    required List<AchievementModel> nearAchievements,
    required int totalAchievements,

    // Trends
    required double productivityTrend,
    required double qualityTrend,
    required double xpTrend,

    // Goals
    required List<Goal> goals,
    required List<GoalProgress> goalProgress,

    // Recommendations
    required List<String> recommendations,
    required List<String> strengths,
    required List<String> improvements,
  }) = _EmployeeReportModel;

  factory EmployeeReportModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeReportModelFromJson(json);

  /// Calculate completion rate
  double get completionRate {
    final total = tasksCompleted + overdueTasks.length;
    if (total == 0) return 0.0;
    return (tasksCompleted / total) * 100;
  }

  /// Calculate on-time rate
  double get onTimeRate {
    if (tasksCompleted == 0) return 0.0;
    return (tasksCompletedOnTime / tasksCompleted) * 100;
  }

  /// Calculate tenure in months
  int get tenureInMonths {
    final now = DateTime.now();
    final months = (now.year - hireDate.year) * 12 + (now.month - hireDate.month);
    return months;
  }
}

/// Task summary for report
@freezed
class TaskSummary with _$TaskSummary {
  const factory TaskSummary({
    required String taskId,
    required String title,
    required String? description,
    required WorkTaskPriority priority,
    required WorkTaskType type,
    required String? category,
    required DateTime? dueDate,
    required DateTime? completedAt,
    required int xpEarned,
    required int? qualityRating,
    required int timeSpent, // in minutes
    required int? estimatedTime, // in minutes
  }) = _TaskSummary;

  factory TaskSummary.fromJson(Map<String, dynamic> json) =>
      _$TaskSummaryFromJson(json);
}

/// Goal model
@freezed
class Goal with _$Goal {
  const factory Goal({
    required String goalId,
    required String title,
    required String description,
    required GoalType type,
    required int targetValue,
    required int currentValue,
    required DateTime startDate,
    required DateTime? endDate,
    required bool isCompleted,
  }) = _Goal;

  factory Goal.fromJson(Map<String, dynamic> json) =>
      _$GoalFromJson(json);

  /// Get completion percentage
  double get completionPercentage {
    if (targetValue == 0) return 0.0;
    return (currentValue / targetValue) * 100;
  }

  /// Check if goal is on track
  bool get isOnTrack {
    if (endDate == null) return true;
    final now = DateTime.now();
    final totalDuration = endDate!.difference(startDate).inDays;
    final elapsedDuration = now.difference(startDate).inDays;
    final expectedProgress = (elapsedDuration / totalDuration) * 100;
    return completionPercentage >= expectedProgress * 0.8; // 80% of expected progress
  }
}

/// Goal type enum
enum GoalType {
  tasks,      // Complete X tasks
  xp,         // Earn X XP
  quality,    // Maintain quality rating
  streak,     // Maintain X day streak
  onTime,     // Complete X% tasks on time
  time,       // Spend X hours working
}

extension GoalTypeExtension on GoalType {
  String get displayName {
    switch (this) {
      case GoalType.tasks:
        return 'Tasks';
      case GoalType.xp:
        return 'XP';
      case GoalType.quality:
        return 'Quality';
      case GoalType.streak:
        return 'Streak';
      case GoalType.onTime:
        return 'On-Time';
      case GoalType.time:
        return 'Time';
    }
  }

  String get displayNameRu {
    switch (this) {
      case GoalType.tasks:
        return 'Задачи';
      case GoalType.xp:
        return 'Опыт';
      case GoalType.quality:
        return 'Качество';
      case GoalType.streak:
        return 'Серия';
      case GoalType.onTime:
        return 'В срок';
      case GoalType.time:
        return 'Время';
    }
  }
}

/// Goal progress tracking
@freezed
class GoalProgress with _$GoalProgress {
  const factory GoalProgress({
    required String goalId,
    required DateTime date,
    required int value,
    required String? note,
  }) = _GoalProgress;

  factory GoalProgress.fromJson(Map<String, dynamic> json) =>
      _$GoalProgressFromJson(json);
}

import 'package:flutter/material.dart';
