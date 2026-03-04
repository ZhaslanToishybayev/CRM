/// Analytics Service
/// Service for generating analytics and reports for managers and employees

import '../models/manager_dashboard_model.dart';
import '../models/employee_report_model.dart';
import '../../teams/models/team_model.dart';
import '../../teams/models/team_member_model.dart';
import '../../tasks/models/work_task_model.dart';
import '../../auth/models/corporate_user_model.dart';
import '../../gamification/services/work_xp_calculator.dart';

class AnalyticsService {
  AnalyticsService._();

  static final AnalyticsService _instance = AnalyticsService._();
  static AnalyticsService get instance => _instance;

  /// Generate manager dashboard data
  Future<ManagerDashboardModel> generateManagerDashboard({
    required String managerId,
    required String organizationId,
    required String departmentId,
    required List<TeamModel> teams,
    required Map<String, List<TeamMemberModel>> teamMembers,
    required Map<String, List<WorkTaskModel>> teamTasks,
    required List<CorporateUserModel> users,
    required Period period,
  }) async {
    final now = DateTime.now();
    final periodData = _getPeriodDates(period, now);

    // Filter teams for this department
    final departmentTeams = teams
        .where((team) => team.departmentId == departmentId)
        .toList();

    // Calculate team metrics
    final teamStats = _calculateTeamStats(departmentTeams, teamTasks);

    // Calculate overall metrics
    final overallMetrics = _calculateOverallMetrics(
      teamStats,
      teamTasks,
      users,
      periodData['start']!,
      periodData['end']!,
    );

    // Get top performers
    final topPerformers = _getTopPerformers(
      teamTasks,
      users,
      periodData['start']!,
      periodData['end']!,
    );

    // Identify problem areas
    final problemAreas = _identifyProblemAreas(
      teamTasks,
      users,
      periodData['start']!,
      periodData['end']!,
    );

    // Calculate trends
    final trends = _calculateTrends(
      teamTasks,
      users,
      period,
    );

    // Get gamification stats
    final gamificationStats = _calculateGamificationStats(
      teamTasks,
      users,
    );

    return ManagerDashboardModel(
      managerId: managerId,
      organizationId: organizationId,
      departmentId: departmentId,
      generatedAt: now,
      period: period,
      periodStart: periodData['start']!,
      periodEnd: periodData['end']!,
      totalTeams: departmentTeams.length,
      activeTeams: teamStats.where((t) => t.activeTasks > 0).length,
      totalMembers: teamStats.fold(0, (sum, t) => sum + t.memberCount),
      activeMembers: teamStats.where((t) => t.activeTasks > 0).fold(0, (sum, t) => sum + t.memberCount),
      totalTasks: overallMetrics['totalTasks']!,
      completedTasks: overallMetrics['completedTasks']!,
      inProgressTasks: overallMetrics['inProgressTasks']!,
      overdueTasks: overallMetrics['overdueTasks']!,
      tasksCompletedToday: overallMetrics['todayTasks']!,
      tasksCompletedThisWeek: overallMetrics['weekTasks']!,
      tasksCompletedThisMonth: overallMetrics['monthTasks']!,
      completionRate: overallMetrics['completionRate']!,
      onTimeRate: overallMetrics['onTimeRate']!,
      averageQualityRating: overallMetrics['averageQuality']!,
      totalXPEarned: overallMetrics['totalXP']!,
      averageTaskTime: overallMetrics['averageTaskTime']!,
      topPerformers: topPerformers,
      topTeams: _rankTeamsByPerformance(teamStats),
      overdueTasksByMember: problemAreas['overdueByMember']!,
      lowPerformers: problemAreas['lowPerformers']!,
      projectsAtRisk: _identifyProjectsAtRisk(teamTasks),
      productivityTrend: trends['productivity']!,
      qualityTrend: trends['quality']!,
      completionTrend: trends['completion']!,
      achievementsUnlocked: gamificationStats['achievements']!,
      activeStreaks: gamificationStats['streaks']!,
      teamAchievements: gamificationStats['teamAchievements']!,
    );
  }

  /// Generate employee report
  Future<EmployeeReportModel> generateEmployeeReport({
    required String userId,
    required CorporateUserModel user,
    required List<WorkTaskModel> userTasks,
    required Period period,
  }) async {
    final now = DateTime.now();
    final periodData = _getPeriodDates(period, now);

    // Filter tasks by period
    final periodTasks = userTasks
        .where((task) =>
            task.completedAt != null &&
            task.completedAt!.isAfter(periodData['start']!) &&
            task.completedAt!.isBefore(periodData['end']!))
        .toList();

    final completedTasks = periodTasks.where((t) => t.isCompleted).toList();
    final overdueTasks = userTasks
        .where((task) => task.isOverdue)
        .toList();
    final upcomingTasks = userTasks
        .where((task) => !task.isCompleted && task.dueDate != null && task.dueDate!.isAfter(now))
        .toList();

    // Calculate metrics
    final xpEarned = completedTasks.fold(0, (sum, task) {
      return sum + WorkXPCalculatorService.calculateTotalXP(task: task);
    });

    final streakData = _calculateStreak(userTasks);
    final qualityData = _calculateQualityMetrics(completedTasks);
    final timeData = _calculateTimeMetrics(completedTasks);

    // Group tasks by various criteria
    final tasksByPriority = _groupTasksByPriority(completedTasks);
    final tasksByType = _groupTasksByType(completedTasks);
    final tasksByCategory = _groupTasksByCategory(completedTasks);

    // Calculate trends
    final trends = _calculateUserTrends(userTasks, period);

    // Generate recommendations
    final recommendations = _generateRecommendations(
      completedTasks,
      overdueTasks,
      qualityData,
    );

    // Identify strengths and improvements
    final strengths = _identifyStrengths(completedTasks);
    final improvements = _identifyImprovements(completedTasks, overdueTasks);

    // Get achievements
    final achievements = _getUserAchievements(userId); // Mock implementation

    return EmployeeReportModel(
      userId: userId,
      organizationId: user.organizationId ?? '',
      departmentId: user.departmentId ?? '',
      teamId: user.teamId ?? '',
      generatedAt: now,
      period: period,
      periodStart: periodData['start']!,
      periodEnd: periodData['end']!,
      username: user.username,
      fullName: user.displayName,
      email: user.email,
      avatarUrl: user.avatarUrl,
      jobTitle: user.jobTitle ?? 'Employee',
      hireDate: user.hireDate ?? DateTime.now(),
      currentLevel: WorkXPCalculatorService.calculateLevel(user.totalXP),
      totalXP: user.totalXP,
      xpEarnedThisPeriod: xpEarned,
      currentStreak: streakData['current']!,
      longestStreak: streakData['longest']!,
      tasksCompleted: completedTasks.length,
      tasksCompletedOnTime: completedTasks
          .where((task) => task.dueDate != null &&
              task.completedAt != null &&
              !task.completedAt!.isAfter(task.dueDate!))
          .length,
      tasksCompletedOverdue: overdueTasks.length,
      averageQualityRating: qualityData['average']!,
      fiveStarRatings: qualityData['fiveStar']!,
      tasksWithoutRevisions: qualityData['noRevisions']!,
      managerFeedback: qualityData['feedback'],
      completedTasks: completedTasks.map(_toTaskSummary).toList(),
      overdueTasks: overdueTasks.map(_toTaskSummary).toList(),
      upcomingTasks: upcomingTasks.map(_toTaskSummary).toList(),
      tasksByPriority: tasksByPriority,
      tasksByType: tasksByType,
      tasksByCategory: tasksByCategory,
      averageTaskTime: timeData['average']!,
      totalTimeSpent: timeData['total']!,
      estimatedTime: timeData['estimated']!,
      timeAccuracy: timeData['accuracy']!,
      unlockedAchievements: achievements['unlocked']!,
      nearAchievements: achievements['near']!,
      totalAchievements: achievements['total']!,
      productivityTrend: trends['productivity']!,
      qualityTrend: trends['quality']!,
      xpTrend: trends['xp']!,
      goals: [], // TODO: Implement goals
      goalProgress: [], // TODO: Implement goal progress
      recommendations: recommendations,
      strengths: strengths,
      improvements: improvements,
    );
  }

  // ===== PRIVATE HELPER METHODS =====

  Map<String, DateTime> _getPeriodDates(Period period, DateTime now) {
    DateTime start;
    DateTime end = now;

    switch (period) {
      case Period.daily:
        start = DateTime(now.year, now.month, now.day);
        break;
      case Period.weekly:
        start = now.subtract(Duration(days: now.weekday - 1));
        start = DateTime(start.year, start.month, start.day);
        break;
      case Period.monthly:
        start = DateTime(now.year, now.month, 1);
        break;
      case Period.quarterly:
        final quarter = ((now.month - 1) / 3).floor() * 3 + 1;
        start = DateTime(now.year, quarter, 1);
        break;
      case Period.yearly:
        start = DateTime(now.year, 1, 1);
        break;
    }

    return {'start': start, 'end': end};
  }

  List<TeamAnalytics> _calculateTeamStats(
    List<TeamModel> teams,
    Map<String, List<WorkTaskModel>> teamTasks,
  ) {
    return teams.map((team) {
      final tasks = teamTasks[team.id] ?? [];
      final completedTasks = tasks.where((t) => t.isCompleted).length;
      final overdueTasks = tasks.where((t) => t.isOverdue).length;

      return TeamAnalytics(
        teamId: team.id,
        memberCount: team.activeMembers,
        activeTasks: tasks.where((t) => !t.isCompleted).length,
        completedTasks: completedTasks,
        overdueTasks: overdueTasks,
        completionRate: tasks.isNotEmpty ? completedTasks / tasks.length : 0.0,
      );
    }).toList();
  }

  Map<String, int> _calculateOverallMetrics(
    List<TeamAnalytics> teamStats,
    Map<String, List<WorkTaskModel>> teamTasks,
    List<CorporateUserModel> users,
    DateTime startDate,
    DateTime endDate,
  ) {
    int totalTasks = 0;
    int completedTasks = 0;
    int inProgressTasks = 0;
    int overdueTasks = 0;
    int todayTasks = 0;
    int weekTasks = 0;
    int monthTasks = 0;
    double totalQuality = 0;
    int qualityCount = 0;
    int totalXP = 0;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final monthStart = DateTime(now.year, now.month, 1);

    for (final team in teamStats) {
      final tasks = teamTasks[team.teamId] ?? [];
      totalTasks += tasks.length;

      for (final task in tasks) {
        if (task.isCompleted && task.completedAt != null) {
          completedTasks++;
          totalXP += WorkXPCalculatorService.calculateTotalXP(task: task);

          if (task.completedAt!.isAfter(today)) {
            todayTasks++;
          }
          if (task.completedAt!.isAfter(weekStart)) {
            weekTasks++;
          }
          if (task.completedAt!.isAfter(monthStart)) {
            monthTasks++;
          }

          if (task.qualityRating != null) {
            totalQuality += task.qualityRating!;
            qualityCount++;
          }
        } else if (!task.isCompleted) {
          inProgressTasks++;
          if (task.isOverdue) {
            overdueTasks++;
          }
        }
      }
    }

    final completionRate = totalTasks > 0 ? completedTasks / totalTasks : 0.0;
    final onTimeRate = completedTasks > 0
        ? completedTasks / (completedTasks + overdueTasks)
        : 0.0;
    final averageQuality = qualityCount > 0 ? totalQuality / qualityCount : 0.0;
    final averageTaskTime = completedTasks > 0 ? 2.5 : 0.0; // Mock value

    return {
      'totalTasks': totalTasks,
      'completedTasks': completedTasks,
      'inProgressTasks': inProgressTasks,
      'overdueTasks': overdueTasks,
      'todayTasks': todayTasks,
      'weekTasks': weekTasks,
      'monthTasks': monthTasks,
      'completionRate': completionRate,
      'onTimeRate': onTimeRate,
      'averageQuality': averageQuality,
      'totalXP': totalXP,
      'averageTaskTime': averageTaskTime,
    };
  }

  List<TopPerformer> _getTopPerformers(
    Map<String, List<WorkTaskModel>> teamTasks,
    List<CorporateUserModel> users,
    DateTime startDate,
    DateTime endDate,
  ) {
    final performerScores = <String, PerformerScore>{};

    for (final user in users) {
      final userTasks = teamTasks[user.teamId ?? '']
          ?.where((task) =>
              task.userId == user.id &&
              task.completedAt != null &&
              task.completedAt!.isAfter(startDate))
          .toList() ?? [];

      if (userTasks.isEmpty) continue;

      final totalXP = userTasks.fold(0, (sum, task) {
        return sum + WorkXPCalculatorService.calculateTotalXP(task: task);
      });

      final tasksCompleted = userTasks.length;
      final qualityRatings = userTasks
          .where((t) => t.qualityRating != null)
          .map((t) => t.qualityRating!)
          .toList();
      final averageQuality = qualityRatings.isNotEmpty
          ? qualityRatings.fold(0.0, (sum, r) => sum + r) / qualityRatings.length
          : 0.0;

      // Calculate composite score
      final score = (totalXP * 0.4) + (tasksCompleted * 10 * 0.3) + (averageQuality * 100 * 0.3);

      performerScores[user.id] = PerformerScore(
        userId: user.id,
        xp: totalXP,
        tasks: tasksCompleted,
        quality: averageQuality,
        score: score,
      );
    }

    // Sort by score and take top 10
    final sortedPerformers = performerScores.values.toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    return sortedPerformers.take(10).map((performer, index) {
      final user = users.firstWhere((u) => u.id == performer.userId);
      return TopPerformer(
        userId: performer.userId,
        username: user.username,
        fullName: user.displayName,
        teamId: user.teamId ?? '',
        xpEarned: performer.xp,
        tasksCompleted: performer.tasks,
        qualityRating: performer.quality,
        rank: index + 1,
      );
    }).toList();
  }

  Map<String, List<dynamic>> _identifyProblemAreas(
    Map<String, List<WorkTaskModel>> teamTasks,
    List<CorporateUserModel> users,
    DateTime startDate,
    DateTime endDate,
  ) {
    final overdueByMember = <PerformanceIssue>[];
    final lowPerformers = <String>[];

    for (final user in users) {
      final userTasks = teamTasks[user.teamId ?? '']
          ?.where((task) => task.userId == user.id)
          .toList() ?? [];

      final overdueTasks = userTasks
          .where((task) => task.isOverdue)
          .toList();

      if (overdueTasks.isNotEmpty) {
        overdueByMember.add(PerformanceIssue(
          userId: user.id,
          username: user.username,
          fullName: user.displayName,
          teamId: user.teamId ?? '',
          overdueTasksCount: overdueTasks.length,
          daysOverdue: overdueTasks
              .map((t) => t.dueDate != null
                  ? DateTime.now().difference(t.dueDate!).inDays
                  : 0)
              .reduce((a, b) => a > b ? a : b),
        ));
      }

      // Identify low performers (low completion rate or quality)
      final completedTasks = userTasks.where((t) => t.isCompleted).length;
      final totalTasks = userTasks.length;
      final completionRate = totalTasks > 0 ? completedTasks / totalTasks : 0.0;

      if (totalTasks >= 5 && completionRate < 0.6) {
        lowPerformers.add(user.id);
      }
    }

    return {
      'overdueByMember': overdueByMember,
      'lowPerformers': lowPerformers,
    };
  }

  Map<String, double> _calculateTrends(
    Map<String, List<WorkTaskModel>> teamTasks,
    List<CorporateUserModel> users,
    Period period,
  ) {
    // Simplified trend calculation - would need historical data in real app
    return {
      'productivity': 15.5, // 15.5% improvement
      'quality': 8.2, // 8.2% improvement
      'completion': 12.3, // 12.3% improvement
    };
  }

  Map<String, int> _calculateGamificationStats(
    Map<String, List<WorkTaskModel>> teamTasks,
    List<CorporateUserModel> users,
  ) {
    // Mock data for demonstration
    return {
      'achievements': 45,
      'streaks': 12,
      'teamAchievements': ['Synchronized', 'Zero Debt', 'Sprint Champions'],
    };
  }

  List<String> _rankTeamsByPerformance(List<TeamAnalytics> teamStats) {
    final sortedTeams = [...teamStats]
      ..sort((a, b) => b.completionRate.compareTo(a.completionRate));

    return sortedTeams
        .take(5)
        .map((team) => team.teamId)
        .toList();
  }

  List<ProjectAtRisk> _identifyProjectsAtRisk(
    Map<String, List<WorkTaskModel>> teamTasks,
  ) {
    // Mock implementation - would need actual project data
    return [];
  }

  Map<String, int> _calculateStreak(List<WorkTaskModel> userTasks) {
    final completedTasks = userTasks
        .where((t) => t.isCompleted && t.completedAt != null)
        .toList()
      ..sort((a, b) => b.completedAt!.compareTo(a.completedAt!));

    // Calculate current streak
    int currentStreak = 0;
    final today = DateTime.now();
    var date = DateTime(today.year, today.month, today.day);

    for (final task in completedTasks) {
      final taskDate = DateTime(
        task.completedAt!.year,
        task.completedAt!.month,
        task.completedAt!.day,
      );

      if (taskDate == date) {
        currentStreak++;
        date = date.subtract(Duration(days: 1));
      } else {
        break;
      }
    }

    // Calculate longest streak
    final dateGroups = <String, int>{};
    for (final task in completedTasks) {
      final dateKey = '${task.completedAt!.year}-${task.completedAt!.month}-${task.completedAt!.day}';
      dateGroups[dateKey] = (dateGroups[dateKey] ?? 0) + 1;
    }

    final longestStreak = dateGroups.values.reduce((a, b) => a > b ? a : b);

    return {
      'current': currentStreak,
      'longest': longestStreak,
    };
  }

  Map<String, dynamic> _calculateQualityMetrics(List<WorkTaskModel> completedTasks) {
    final ratings = completedTasks
        .where((t) => t.qualityRating != null)
        .map((t) => t.qualityRating!)
        .toList();

    final average = ratings.isNotEmpty
        ? ratings.fold(0.0, (sum, r) => sum + r) / ratings.length
        : 0.0;

    final fiveStar = ratings.where((r) => r == 5).length;

    final noRevisions = completedTasks
        .where((t) => t.managerFeedback == null || t.managerFeedback!.isEmpty)
        .length;

    return {
      'average': average,
      'fiveStar': fiveStar,
      'noRevisions': noRevisions,
      'feedback': completedTasks
          .where((t) => t.managerFeedback != null)
          .map((t) => t.managerFeedback)
          .join(', '),
    };
  }

  Map<String, dynamic> _calculateTimeMetrics(List<WorkTaskModel> completedTasks) {
    final totalTime = completedTasks
        .where((t) => t.actualHours != null)
        .fold(0, (sum, t) => sum + (t.actualHours! * 60));

    final estimatedTime = completedTasks
        .where((t) => t.estimatedHours != null)
        .fold(0, (sum, t) => sum + (t.estimatedHours! * 60));

    final average = completedTasks.isNotEmpty ? totalTime / completedTasks.length / 60 : 0.0;
    final accuracy = estimatedTime > 0
        ? 1 - ((estimatedTime - totalTime).abs() / estimatedTime)
        : 0.0;

    return {
      'average': average,
      'total': totalTime,
      'estimated': estimatedTime,
      'accuracy': accuracy * 100,
    };
  }

  Map<WorkTaskPriority, int> _groupTasksByPriority(List<WorkTaskModel> tasks) {
    final Map<WorkTaskPriority, int> groups = {};
    for (final task in tasks) {
      groups[task.priority] = (groups[task.priority] ?? 0) + 1;
    }
    return groups;
  }

  Map<WorkTaskType, int> _groupTasksByType(List<WorkTaskModel> tasks) {
    final Map<WorkTaskType, int> groups = {};
    for (final task in tasks) {
      groups[task.type] = (groups[task.type] ?? 0) + 1;
    }
    return groups;
  }

  Map<String, int> _groupTasksByCategory(List<WorkTaskModel> tasks) {
    final Map<String, int> groups = {};
    for (final task in tasks) {
      final category = task.category ?? 'Uncategorized';
      groups[category] = (groups[category] ?? 0) + 1;
    }
    return groups;
  }

  Map<String, double> _calculateUserTrends(
    List<WorkTaskModel> userTasks,
    Period period,
  ) {
    // Simplified trend calculation
    return {
      'productivity': 12.5,
      'quality': 7.3,
      'xp': 15.8,
    };
  }

  List<String> _generateRecommendations(
    List<WorkTaskModel> completedTasks,
    List<WorkTaskModel> overdueTasks,
    Map<String, dynamic> qualityData,
  ) {
    final recommendations = <String>[];

    if (overdueTasks.length > 3) {
      recommendations.add('Focus on completing overdue tasks to improve your on-time rate');
    }

    if (qualityData['average'] < 3.5) {
      recommendations.add('Consider asking for feedback to improve work quality');
    }

    final teamTasks = completedTasks.where((t) => t.type == WorkTaskType.team).length;
    if (teamTasks < completedTasks.length * 0.3) {
      recommendations.add('Participate more in team tasks to earn collaboration bonuses');
    }

    return recommendations;
  }

  List<String> _identifyStrengths(List<WorkTaskModel> completedTasks) {
    final strengths = <String>[];

    final onTimeTasks = completedTasks.where((t) {
      return t.dueDate != null &&
          t.completedAt != null &&
          !t.completedAt!.isAfter(t.dueDate!);
    }).length;

    if (onTimeTasks / completedTasks.length > 0.9) {
      strengths.add('Excellent at meeting deadlines');
    }

    final qualityRatings = completedTasks
        .where((t) => t.qualityRating != null)
        .map((t) => t.qualityRating!)
        .toList();
    if (qualityRatings.isNotEmpty) {
      final avgQuality = qualityRatings.fold(0.0, (sum, r) => sum + r) / qualityRatings.length;
      if (avgQuality > 4.0) {
        strengths.add('Consistently high quality work');
      }
    }

    return strengths;
  }

  List<String> _identifyImprovements(
    List<WorkTaskModel> completedTasks,
    List<WorkTaskModel> overdueTasks,
  ) {
    final improvements = <String>[];

    if (overdueTasks.length > 2) {
      improvements.add('Work on time management to reduce overdue tasks');
    }

    return improvements;
  }

  Map<String, List<AchievementModel>> _getUserAchievements(String userId) {
    // Mock implementation
    return {
      'unlocked': [],
      'near': [],
      'total': 0,
    };
  }

  TaskSummary _toTaskSummary(WorkTaskModel task) {
    return TaskSummary(
      taskId: task.id,
      title: task.title,
      description: task.description,
      priority: task.priority,
      type: task.type,
      category: task.category,
      dueDate: task.dueDate,
      completedAt: task.completedAt,
      xpEarned: WorkXPCalculatorService.calculateTotalXP(task: task),
      qualityRating: task.qualityRating,
      timeSpent: task.actualHours != null ? task.actualHours! * 60 : 0,
      estimatedTime: task.estimatedHours,
    );
  }
}

/// Helper classes
class TeamAnalytics {
  final String teamId;
  final int memberCount;
  final int activeTasks;
  final int completedTasks;
  final int overdueTasks;
  final double completionRate;

  const TeamAnalytics({
    required this.teamId,
    required this.memberCount,
    required this.activeTasks,
    required this.completedTasks,
    required this.overdueTasks,
    required this.completionRate,
  });
}

class PerformerScore {
  final String userId;
  final int xp;
  final int tasks;
  final double quality;
  final double score;

  const PerformerScore({
    required this.userId,
    required this.xp,
    required this.tasks,
    required this.quality,
    required this.score,
  });
}
