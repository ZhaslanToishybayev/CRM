/// Manager Dashboard Model
/// Data model for manager's dashboard view

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../teams/models/team_model.dart';
import '../../tasks/models/work_task_model.dart';

part 'manager_dashboard_model.freezed.dart';
part 'manager_dashboard_model.g.dart';

@freezed
class ManagerDashboardModel with _$ManagerDashboardModel {
  const factory ManagerDashboardModel({
    required String managerId,
    required String organizationId,
    required String departmentId,
    required DateTime generatedAt,
    required Period period,
    required DateTime periodStart,
    required DateTime periodEnd,

    // Team Overview
    required int totalTeams,
    required int activeTeams,
    required int totalMembers,
    required int activeMembers,

    // Task Statistics
    required int totalTasks,
    required int completedTasks,
    required int inProgressTasks,
    required int overdueTasks,
    required int tasksCompletedToday,
    required int tasksCompletedThisWeek,
    required int tasksCompletedThisMonth,

    // Performance Metrics
    required double completionRate,
    required double onTimeRate,
    required double averageQualityRating,
    required int totalXPEarned,
    required int averageTaskTime, // in hours

    // Top Performers
    required List<TopPerformer> topPerformers,
    required List<String> topTeams,

    // Problem Areas
    required List<PerformanceIssue> overdueTasksByMember,
    required List<String> lowPerformers,
    required List<ProjectAtRisk> projectsAtRisk,

    // Trends
    required double productivityTrend, // percentage change
    required double qualityTrend,
    required double completionTrend,

    // Gamification
    required int achievementsUnlocked,
    required int activeStreaks,
    required List<String> teamAchievements,
  }) = _ManagerDashboardModel;

  factory ManagerDashboardModel.fromJson(Map<String, dynamic> json) =>
      _$ManagerDashboardModelFromJson(json);
}

/// Period enum
enum Period {
  daily,
  weekly,
  monthly,
  quarterly,
  yearly,
}

extension PeriodExtension on Period {
  String get displayName {
    switch (this) {
      case Period.daily:
        return 'Daily';
      case Period.weekly:
        return 'Weekly';
      case Period.monthly:
        return 'Monthly';
      case Period.quarterly:
        return 'Quarterly';
      case Period.yearly:
        return 'Yearly';
    }
  }

  String get displayNameRu {
    switch (this) {
      case Period.daily:
        return 'Ежедневно';
      case Period.weekly:
        return 'Еженедельно';
      case Period.monthly:
        return 'Ежемесячно';
      case Period.quarterly:
        return 'Ежеквартально';
      case Period.yearly:
        return 'Ежегодно';
    }
  }
}

/// Top performer model
@freezed
class TopPerformer with _$TopPerformer {
  const factory TopPerformer({
    required String userId,
    required String username,
    required String fullName,
    required String teamId,
    required int xpEarned,
    required int tasksCompleted,
    required double qualityRating,
    required int rank,
  }) = _TopPerformer;

  factory TopPerformer.fromJson(Map<String, dynamic> json) =>
      _$TopPerformerFromJson(json);
}

/// Performance issue model
@freezed
class PerformanceIssue with _$PerformanceIssue {
  const factory PerformanceIssue({
    required String userId,
    required String username,
    required String fullName,
    required String teamId,
    required int overdueTasksCount,
    required int daysOverdue,
  }) = _PerformanceIssue;

  factory PerformanceIssue.fromJson(Map<String, dynamic> json) =>
      _$PerformanceIssueFromJson(json);
}

/// Project at risk model
@freezed
class ProjectAtRisk with _$ProjectAtRisk {
  const factory ProjectAtRisk({
    required String projectId,
    required String projectName,
    required String teamId,
    required String teamName,
    required double completionPercentage,
    required DateTime dueDate,
    required int daysUntilDue,
    required RiskLevel riskLevel,
  }) = _ProjectAtRisk;

  factory ProjectAtRisk.fromJson(Map<String, dynamic> json) =>
      _$ProjectAtRiskFromJson(json);
}

/// Risk level enum
enum RiskLevel {
  low,
  medium,
  high,
  critical,
}

extension RiskLevelExtension on RiskLevel {
  String get displayName {
    switch (this) {
      case RiskLevel.low:
        return 'Low';
      case RiskLevel.medium:
        return 'Medium';
      case RiskLevel.high:
        return 'High';
      case RiskLevel.critical:
        return 'Critical';
    }
  }

  String get displayNameRu {
    switch (this) {
      case RiskLevel.low:
        return 'Низкий';
      case RiskLevel.medium:
        return 'Средний';
      case RiskLevel.high:
        return 'Высокий';
      case RiskLevel.critical:
        return 'Критический';
    }
  }

  Color get color {
    switch (this) {
      case RiskLevel.low:
        return Colors.green;
      case RiskLevel.medium:
        return Colors.orange;
      case RiskLevel.high:
        return Colors.red;
      case RiskLevel.critical:
        return Colors.purple;
    }
  }

  IconData get icon {
    switch (this) {
      case RiskLevel.low:
        return Icons.check_circle;
      case RiskLevel.medium:
        return Icons.warning;
      case RiskLevel.high:
        return Icons.error;
      case RiskLevel.critical:
        return Icons.dangerous;
    }
  }
}

import 'package:flutter/material.dart';
