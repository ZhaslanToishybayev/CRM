// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ManagerDashboardModelImpl _$$ManagerDashboardModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ManagerDashboardModelImpl(
      managerId: json['managerId'] as String,
      organizationId: json['organizationId'] as String,
      departmentId: json['departmentId'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      period: $enumDecode(_$PeriodEnumMap, json['period']),
      periodStart: DateTime.parse(json['periodStart'] as String),
      periodEnd: DateTime.parse(json['periodEnd'] as String),
      totalTeams: (json['totalTeams'] as num).toInt(),
      activeTeams: (json['activeTeams'] as num).toInt(),
      totalMembers: (json['totalMembers'] as num).toInt(),
      activeMembers: (json['activeMembers'] as num).toInt(),
      totalTasks: (json['totalTasks'] as num).toInt(),
      completedTasks: (json['completedTasks'] as num).toInt(),
      inProgressTasks: (json['inProgressTasks'] as num).toInt(),
      overdueTasks: (json['overdueTasks'] as num).toInt(),
      tasksCompletedToday: (json['tasksCompletedToday'] as num).toInt(),
      tasksCompletedThisWeek: (json['tasksCompletedThisWeek'] as num).toInt(),
      tasksCompletedThisMonth: (json['tasksCompletedThisMonth'] as num).toInt(),
      completionRate: (json['completionRate'] as num).toDouble(),
      onTimeRate: (json['onTimeRate'] as num).toDouble(),
      averageQualityRating: (json['averageQualityRating'] as num).toDouble(),
      totalXPEarned: (json['totalXPEarned'] as num).toInt(),
      averageTaskTime: (json['averageTaskTime'] as num).toInt(),
      topPerformers: (json['topPerformers'] as List<dynamic>)
          .map((e) => TopPerformer.fromJson(e as Map<String, dynamic>))
          .toList(),
      topTeams:
          (json['topTeams'] as List<dynamic>).map((e) => e as String).toList(),
      overdueTasksByMember: (json['overdueTasksByMember'] as List<dynamic>)
          .map((e) => PerformanceIssue.fromJson(e as Map<String, dynamic>))
          .toList(),
      lowPerformers: (json['lowPerformers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      projectsAtRisk: (json['projectsAtRisk'] as List<dynamic>)
          .map((e) => ProjectAtRisk.fromJson(e as Map<String, dynamic>))
          .toList(),
      productivityTrend: (json['productivityTrend'] as num).toDouble(),
      qualityTrend: (json['qualityTrend'] as num).toDouble(),
      completionTrend: (json['completionTrend'] as num).toDouble(),
      achievementsUnlocked: (json['achievementsUnlocked'] as num).toInt(),
      activeStreaks: (json['activeStreaks'] as num).toInt(),
      teamAchievements: (json['teamAchievements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ManagerDashboardModelImplToJson(
        _$ManagerDashboardModelImpl instance) =>
    <String, dynamic>{
      'managerId': instance.managerId,
      'organizationId': instance.organizationId,
      'departmentId': instance.departmentId,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'period': _$PeriodEnumMap[instance.period]!,
      'periodStart': instance.periodStart.toIso8601String(),
      'periodEnd': instance.periodEnd.toIso8601String(),
      'totalTeams': instance.totalTeams,
      'activeTeams': instance.activeTeams,
      'totalMembers': instance.totalMembers,
      'activeMembers': instance.activeMembers,
      'totalTasks': instance.totalTasks,
      'completedTasks': instance.completedTasks,
      'inProgressTasks': instance.inProgressTasks,
      'overdueTasks': instance.overdueTasks,
      'tasksCompletedToday': instance.tasksCompletedToday,
      'tasksCompletedThisWeek': instance.tasksCompletedThisWeek,
      'tasksCompletedThisMonth': instance.tasksCompletedThisMonth,
      'completionRate': instance.completionRate,
      'onTimeRate': instance.onTimeRate,
      'averageQualityRating': instance.averageQualityRating,
      'totalXPEarned': instance.totalXPEarned,
      'averageTaskTime': instance.averageTaskTime,
      'topPerformers': instance.topPerformers,
      'topTeams': instance.topTeams,
      'overdueTasksByMember': instance.overdueTasksByMember,
      'lowPerformers': instance.lowPerformers,
      'projectsAtRisk': instance.projectsAtRisk,
      'productivityTrend': instance.productivityTrend,
      'qualityTrend': instance.qualityTrend,
      'completionTrend': instance.completionTrend,
      'achievementsUnlocked': instance.achievementsUnlocked,
      'activeStreaks': instance.activeStreaks,
      'teamAchievements': instance.teamAchievements,
    };

const _$PeriodEnumMap = {
  Period.daily: 'daily',
  Period.weekly: 'weekly',
  Period.monthly: 'monthly',
  Period.quarterly: 'quarterly',
  Period.yearly: 'yearly',
};

_$TopPerformerImpl _$$TopPerformerImplFromJson(Map<String, dynamic> json) =>
    _$TopPerformerImpl(
      userId: json['userId'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      teamId: json['teamId'] as String,
      xpEarned: (json['xpEarned'] as num).toInt(),
      tasksCompleted: (json['tasksCompleted'] as num).toInt(),
      qualityRating: (json['qualityRating'] as num).toDouble(),
      rank: (json['rank'] as num).toInt(),
    );

Map<String, dynamic> _$$TopPerformerImplToJson(_$TopPerformerImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'fullName': instance.fullName,
      'teamId': instance.teamId,
      'xpEarned': instance.xpEarned,
      'tasksCompleted': instance.tasksCompleted,
      'qualityRating': instance.qualityRating,
      'rank': instance.rank,
    };

_$PerformanceIssueImpl _$$PerformanceIssueImplFromJson(
        Map<String, dynamic> json) =>
    _$PerformanceIssueImpl(
      userId: json['userId'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      teamId: json['teamId'] as String,
      overdueTasksCount: (json['overdueTasksCount'] as num).toInt(),
      daysOverdue: (json['daysOverdue'] as num).toInt(),
    );

Map<String, dynamic> _$$PerformanceIssueImplToJson(
        _$PerformanceIssueImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'fullName': instance.fullName,
      'teamId': instance.teamId,
      'overdueTasksCount': instance.overdueTasksCount,
      'daysOverdue': instance.daysOverdue,
    };

_$ProjectAtRiskImpl _$$ProjectAtRiskImplFromJson(Map<String, dynamic> json) =>
    _$ProjectAtRiskImpl(
      projectId: json['projectId'] as String,
      projectName: json['projectName'] as String,
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String,
      completionPercentage: (json['completionPercentage'] as num).toDouble(),
      dueDate: DateTime.parse(json['dueDate'] as String),
      daysUntilDue: (json['daysUntilDue'] as num).toInt(),
      riskLevel: $enumDecode(_$RiskLevelEnumMap, json['riskLevel']),
    );

Map<String, dynamic> _$$ProjectAtRiskImplToJson(_$ProjectAtRiskImpl instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'completionPercentage': instance.completionPercentage,
      'dueDate': instance.dueDate.toIso8601String(),
      'daysUntilDue': instance.daysUntilDue,
      'riskLevel': _$RiskLevelEnumMap[instance.riskLevel]!,
    };

const _$RiskLevelEnumMap = {
  RiskLevel.low: 'low',
  RiskLevel.medium: 'medium',
  RiskLevel.high: 'high',
  RiskLevel.critical: 'critical',
};
