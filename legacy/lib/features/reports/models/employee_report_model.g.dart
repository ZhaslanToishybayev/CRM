// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeReportModelImpl _$$EmployeeReportModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeeReportModelImpl(
      userId: json['userId'] as String,
      organizationId: json['organizationId'] as String,
      departmentId: json['departmentId'] as String,
      teamId: json['teamId'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      period: $enumDecode(_$PeriodEnumMap, json['period']),
      periodStart: DateTime.parse(json['periodStart'] as String),
      periodEnd: DateTime.parse(json['periodEnd'] as String),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      jobTitle: json['jobTitle'] as String,
      hireDate: DateTime.parse(json['hireDate'] as String),
      currentLevel: (json['currentLevel'] as num).toInt(),
      totalXP: (json['totalXP'] as num).toInt(),
      xpEarnedThisPeriod: (json['xpEarnedThisPeriod'] as num).toInt(),
      currentStreak: (json['currentStreak'] as num).toInt(),
      longestStreak: (json['longestStreak'] as num).toInt(),
      tasksCompleted: (json['tasksCompleted'] as num).toInt(),
      tasksCompletedOnTime: (json['tasksCompletedOnTime'] as num).toInt(),
      tasksCompletedOverdue: (json['tasksCompletedOverdue'] as num).toInt(),
      averageQualityRating: (json['averageQualityRating'] as num).toDouble(),
      fiveStarRatings: (json['fiveStarRatings'] as num).toInt(),
      tasksWithoutRevisions: (json['tasksWithoutRevisions'] as num).toInt(),
      managerFeedback: json['managerFeedback'] as String?,
      completedTasks: (json['completedTasks'] as List<dynamic>)
          .map((e) => TaskSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      overdueTasks: (json['overdueTasks'] as List<dynamic>)
          .map((e) => TaskSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      upcomingTasks: (json['upcomingTasks'] as List<dynamic>)
          .map((e) => TaskSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      tasksByPriority: (json['tasksByPriority'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            $enumDecode(_$WorkTaskPriorityEnumMap, k), (e as num).toInt()),
      ),
      tasksByType: (json['tasksByType'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry($enumDecode(_$WorkTaskTypeEnumMap, k), (e as num).toInt()),
      ),
      tasksByCategory: Map<String, int>.from(json['tasksByCategory'] as Map),
      averageTaskTime: (json['averageTaskTime'] as num).toDouble(),
      totalTimeSpent: (json['totalTimeSpent'] as num).toInt(),
      estimatedTime: (json['estimatedTime'] as num).toInt(),
      timeAccuracy: (json['timeAccuracy'] as num).toDouble(),
      unlockedAchievements: (json['unlockedAchievements'] as List<dynamic>)
          .map((e) => AchievementModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nearAchievements: (json['nearAchievements'] as List<dynamic>)
          .map((e) => AchievementModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAchievements: (json['totalAchievements'] as num).toInt(),
      productivityTrend: (json['productivityTrend'] as num).toDouble(),
      qualityTrend: (json['qualityTrend'] as num).toDouble(),
      xpTrend: (json['xpTrend'] as num).toDouble(),
      goals: (json['goals'] as List<dynamic>)
          .map((e) => Goal.fromJson(e as Map<String, dynamic>))
          .toList(),
      goalProgress: (json['goalProgress'] as List<dynamic>)
          .map((e) => GoalProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      strengths:
          (json['strengths'] as List<dynamic>).map((e) => e as String).toList(),
      improvements: (json['improvements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$EmployeeReportModelImplToJson(
        _$EmployeeReportModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'organizationId': instance.organizationId,
      'departmentId': instance.departmentId,
      'teamId': instance.teamId,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'period': _$PeriodEnumMap[instance.period]!,
      'periodStart': instance.periodStart.toIso8601String(),
      'periodEnd': instance.periodEnd.toIso8601String(),
      'username': instance.username,
      'fullName': instance.fullName,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'jobTitle': instance.jobTitle,
      'hireDate': instance.hireDate.toIso8601String(),
      'currentLevel': instance.currentLevel,
      'totalXP': instance.totalXP,
      'xpEarnedThisPeriod': instance.xpEarnedThisPeriod,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'tasksCompleted': instance.tasksCompleted,
      'tasksCompletedOnTime': instance.tasksCompletedOnTime,
      'tasksCompletedOverdue': instance.tasksCompletedOverdue,
      'averageQualityRating': instance.averageQualityRating,
      'fiveStarRatings': instance.fiveStarRatings,
      'tasksWithoutRevisions': instance.tasksWithoutRevisions,
      'managerFeedback': instance.managerFeedback,
      'completedTasks': instance.completedTasks,
      'overdueTasks': instance.overdueTasks,
      'upcomingTasks': instance.upcomingTasks,
      'tasksByPriority': instance.tasksByPriority
          .map((k, e) => MapEntry(_$WorkTaskPriorityEnumMap[k]!, e)),
      'tasksByType': instance.tasksByType
          .map((k, e) => MapEntry(_$WorkTaskTypeEnumMap[k]!, e)),
      'tasksByCategory': instance.tasksByCategory,
      'averageTaskTime': instance.averageTaskTime,
      'totalTimeSpent': instance.totalTimeSpent,
      'estimatedTime': instance.estimatedTime,
      'timeAccuracy': instance.timeAccuracy,
      'unlockedAchievements': instance.unlockedAchievements,
      'nearAchievements': instance.nearAchievements,
      'totalAchievements': instance.totalAchievements,
      'productivityTrend': instance.productivityTrend,
      'qualityTrend': instance.qualityTrend,
      'xpTrend': instance.xpTrend,
      'goals': instance.goals,
      'goalProgress': instance.goalProgress,
      'recommendations': instance.recommendations,
      'strengths': instance.strengths,
      'improvements': instance.improvements,
    };

const _$PeriodEnumMap = {
  Period.daily: 'daily',
  Period.weekly: 'weekly',
  Period.monthly: 'monthly',
  Period.quarterly: 'quarterly',
  Period.yearly: 'yearly',
};

const _$WorkTaskPriorityEnumMap = {
  WorkTaskPriority.low: 'low',
  WorkTaskPriority.medium: 'medium',
  WorkTaskPriority.high: 'high',
  WorkTaskPriority.urgent: 'urgent',
  WorkTaskPriority.critical: 'critical',
};

const _$WorkTaskTypeEnumMap = {
  WorkTaskType.personal: 'personal',
  WorkTaskType.project: 'project',
  WorkTaskType.team: 'team',
};

_$TaskSummaryImpl _$$TaskSummaryImplFromJson(Map<String, dynamic> json) =>
    _$TaskSummaryImpl(
      taskId: json['taskId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      priority: $enumDecode(_$WorkTaskPriorityEnumMap, json['priority']),
      type: $enumDecode(_$WorkTaskTypeEnumMap, json['type']),
      category: json['category'] as String?,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      xpEarned: (json['xpEarned'] as num).toInt(),
      qualityRating: (json['qualityRating'] as num?)?.toInt(),
      timeSpent: (json['timeSpent'] as num).toInt(),
      estimatedTime: (json['estimatedTime'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TaskSummaryImplToJson(_$TaskSummaryImpl instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'title': instance.title,
      'description': instance.description,
      'priority': _$WorkTaskPriorityEnumMap[instance.priority]!,
      'type': _$WorkTaskTypeEnumMap[instance.type]!,
      'category': instance.category,
      'dueDate': instance.dueDate?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'xpEarned': instance.xpEarned,
      'qualityRating': instance.qualityRating,
      'timeSpent': instance.timeSpent,
      'estimatedTime': instance.estimatedTime,
    };

_$GoalImpl _$$GoalImplFromJson(Map<String, dynamic> json) => _$GoalImpl(
      goalId: json['goalId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$GoalTypeEnumMap, json['type']),
      targetValue: (json['targetValue'] as num).toInt(),
      currentValue: (json['currentValue'] as num).toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$$GoalImplToJson(_$GoalImpl instance) =>
    <String, dynamic>{
      'goalId': instance.goalId,
      'title': instance.title,
      'description': instance.description,
      'type': _$GoalTypeEnumMap[instance.type]!,
      'targetValue': instance.targetValue,
      'currentValue': instance.currentValue,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isCompleted': instance.isCompleted,
    };

const _$GoalTypeEnumMap = {
  GoalType.tasks: 'tasks',
  GoalType.xp: 'xp',
  GoalType.quality: 'quality',
  GoalType.streak: 'streak',
  GoalType.onTime: 'onTime',
  GoalType.time: 'time',
};

_$GoalProgressImpl _$$GoalProgressImplFromJson(Map<String, dynamic> json) =>
    _$GoalProgressImpl(
      goalId: json['goalId'] as String,
      date: DateTime.parse(json['date'] as String),
      value: (json['value'] as num).toInt(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$GoalProgressImplToJson(_$GoalProgressImpl instance) =>
    <String, dynamic>{
      'goalId': instance.goalId,
      'date': instance.date.toIso8601String(),
      'value': instance.value,
      'note': instance.note,
    };
