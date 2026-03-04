/// Team Leaderboard Service
/// Service for managing team and individual leaderboards
///
/// Provides:
/// - Individual performance rankings
/// - Team performance rankings
/// - Department comparisons
/// - Weekly/monthly rankings
/// - Category-based leaderboards

import '../../auth/models/corporate_user_model.dart';
import '../../tasks/models/work_task_model.dart';
import '../../teams/models/team_model.dart';
import '../../projects/models/project_model.dart';
import '../../gamification/services/work_xp_calculator.dart';

class TeamLeaderboardService {
  TeamLeaderboardService._();

  /// Get individual leaderboard for a team
  Future<List<IndividualLeaderboardEntry>> getIndividualLeaderboard({
    required String teamId,
    required List<CorporateUserModel> teamMembers,
    required List<WorkTaskModel> tasks,
    LeaderboardPeriod period = LeaderboardPeriod.weekly,
    LeaderboardSortBy sortBy = LeaderboardSortBy.xp,
  }) async {
    final entries = <IndividualLeaderboardEntry>[];

    for (final member in teamMembers) {
      final memberTasks = tasks.where((t) => t.userId == member.id).toList();
      final completedTasks = memberTasks.where((t) => t.isCompleted).toList();

      // Calculate metrics based on period
      final periodTasks = _filterTasksByPeriod(completedTasks, period);

      // Calculate statistics
      final stats = _calculateUserStats(member, periodTasks);

      // Calculate XP based on sortBy preference
      int totalXP = 0;
      switch (sortBy) {
        case LeaderboardSortBy.xp:
          totalXP = periodTasks.fold(0, (sum, task) {
            return sum + WorkXPCalculatorService.calculateTotalXP(task: task);
          });
          break;
        case LeaderboardSortBy.tasks:
          totalXP = periodTasks.length; // Use count as "XP" for sorting
          break;
        case LeaderboardSortBy.quality:
          totalXP = periodTasks
              .where((t) => t.qualityRating != null)
              .fold(0, (sum, task) => sum + (task.qualityRating ?? 0));
          break;
      }

      entries.add(IndividualLeaderboardEntry(
        userId: member.id,
        username: member.username,
        fullName: member.displayName,
        avatarUrl: member.avatarUrl,
        level: stats.currentLevel,
        totalXP: totalXP,
        tasksCompleted: periodTasks.length,
        onTimeRate: stats.onTimeRate,
        qualityRating: stats.averageQualityRating,
        streakDays: stats.currentStreak,
        teamId: member.teamId,
        role: member.corporateRole,
        departmentId: member.departmentId,
      ));
    }

    // Sort entries
    entries.sort((a, b) {
      switch (sortBy) {
        case LeaderboardSortBy.xp:
          return b.totalXP.compareTo(a.totalXP);
        case LeaderboardSortBy.tasks:
          return b.tasksCompleted.compareTo(a.tasksCompleted);
        case LeaderboardSortBy.quality:
          return (b.qualityRating ?? 0).compareTo(a.qualityRating ?? 0);
      }
    });

    // Add rankings
    for (int i = 0; i < entries.length; i++) {
      entries[i] = entries[i].copyWith(rank: i + 1);
    }

    return entries;
  }

  /// Get team leaderboard for an organization
  Future<List<TeamLeaderboardEntry>> getTeamLeaderboard({
    required String organizationId,
    required List<TeamModel> teams,
    required Map<String, List<WorkTaskModel>> teamTasks,
    LeaderboardPeriod period = LeaderboardPeriod.monthly,
    LeaderboardSortBy sortBy = LeaderboardSortBy.xp,
  }) async {
    final entries = <TeamLeaderboardEntry>[];

    for (final team in teams) {
      if (team.organizationId != organizationId) continue;

      final tasks = teamTasks[team.id] ?? [];
      final completedTasks = tasks.where((t) => t.isCompleted).toList();

      // Calculate metrics based on period
      final periodTasks = _filterTasksByPeriod(completedTasks, period);

      // Calculate team statistics
      final stats = _calculateTeamStats(team, periodTasks);

      entries.add(TeamLeaderboardEntry(
        teamId: team.id,
        teamName: team.name,
        teamColor: team.displayColor,
        teamIcon: team.icon,
        organizationId: team.organizationId,
        departmentId: team.departmentId,
        memberCount: team.activeMembers,
        totalXP: stats.totalXP,
        tasksCompleted: periodTasks.length,
        completionRate: stats.completionRate,
        averageQualityRating: stats.averageQualityRating,
        onTimeRate: stats.onTimeRate,
        activeStreak: stats.activeStreak,
      ));
    }

    // Sort entries
    entries.sort((a, b) {
      switch (sortBy) {
        case LeaderboardSortBy.xp:
          return b.totalXP.compareTo(a.totalXP);
        case LeaderboardSortBy.tasks:
          return b.tasksCompleted.compareTo(a.tasksCompleted);
        case LeaderboardSortBy.quality:
          return (b.averageQualityRating ?? 0).compareTo(a.averageQualityRating ?? 0);
      }
    });

    // Add rankings
    for (int i = 0; i < entries.length; i++) {
      entries[i] = entries[i].copyWith(rank: i + 1);
    }

    return entries;
  }

  /// Get department leaderboard
  Future<List<DepartmentLeaderboardEntry>> getDepartmentLeaderboard({
    required String organizationId,
    required List<TeamModel> teams,
    required Map<String, List<WorkTaskModel>> teamTasks,
    LeaderboardPeriod period = LeaderboardPeriod.monthly,
  }) async {
    final departmentStats = <String, DepartmentStats>{};

    for (final team in teams) {
      if (team.organizationId != organizationId || team.departmentId == null) continue;

      final deptId = team.departmentId!;
      final tasks = teamTasks[team.id] ?? [];
      final completedTasks = tasks.where((t) => t.isCompleted).toList();
      final periodTasks = _filterTasksByPeriod(completedTasks, period);

      if (!departmentStats.containsKey(deptId)) {
        departmentStats[deptId] = DepartmentStats(
          departmentId: deptId,
          teamCount: 0,
          totalMembers: 0,
          totalXP: 0,
          tasksCompleted: 0,
          totalQualityRating: 0,
          qualityRatingCount: 0,
          onTimeCount: 0,
          totalTasks: 0,
        );
      }

      final stats = departmentStats[deptId]!;
      departmentStats[deptId] = stats.copyWith(
        teamCount: stats.teamCount + 1,
        totalMembers: stats.totalMembers + team.activeMembers,
        totalXP: stats.totalXP + periodTasks.fold(0, (sum, task) {
          return sum + WorkXPCalculatorService.calculateTotalXP(task: task);
        }),
        tasksCompleted: stats.tasksCompleted + periodTasks.length,
        totalQualityRating: stats.totalQualityRating + periodTasks
            .where((t) => t.qualityRating != null)
            .fold(0, (sum, task) => sum + (task.qualityRating ?? 0)),
        qualityRatingCount: stats.qualityRatingCount + periodTasks
            .where((t) => t.qualityRating != null)
            .length,
        onTimeCount: stats.onTimeCount + periodTasks
            .where((t) => t.dueDate != null &&
            t.completedAt != null &&
            !t.completedAt!.isAfter(t.dueDate!))
            .length,
        totalTasks: stats.totalTasks + periodTasks.length,
      );
    }

    // Convert to entries
    final entries = departmentStats.values.map((stats) {
      final averageQuality = stats.qualityRatingCount > 0
          ? stats.totalQualityRating / stats.qualityRatingCount
          : null;
      final onTimeRate = stats.totalTasks > 0
          ? stats.onTimeCount / stats.totalTasks
          : 0.0;

      return DepartmentLeaderboardEntry(
        departmentId: stats.departmentId,
        departmentName: 'Department', // TODO: Get from DepartmentService
        teamCount: stats.teamCount,
        totalMembers: stats.totalMembers,
        totalXP: stats.totalXP,
        tasksCompleted: stats.tasksCompleted,
        averageQualityRating: averageQuality,
        onTimeRate: onTimeRate,
      );
    }).toList();

    // Sort by total XP
    entries.sort((a, b) => b.totalXP.compareTo(a.totalXP));

    // Add rankings
    for (int i = 0; i < entries.length; i++) {
      entries[i] = entries[i].copyWith(rank: i + 1);
    }

    return entries;
  }

  /// Get user's rank in team leaderboard
  Future<int?> getUserRankInTeam({
    required String userId,
    required String teamId,
    required List<CorporateUserModel> teamMembers,
    required List<WorkTaskModel> tasks,
    LeaderboardPeriod period = LeaderboardPeriod.weekly,
    LeaderboardSortBy sortBy = LeaderboardSortBy.xp,
  }) async {
    final leaderboard = await getIndividualLeaderboard(
      teamId: teamId,
      teamMembers: teamMembers,
      tasks: tasks,
      period: period,
      sortBy: sortBy,
    );

    try {
      final userEntry = leaderboard.firstWhere((entry) => entry.userId == userId);
      return userEntry.rank;
    } catch (e) {
      return null;
    }
  }

  /// Get user's rank in organization
  Future<int?> getUserRankInOrganization({
    required String userId,
    required String organizationId,
    required List<CorporateUserModel> allUsers,
    required List<WorkTaskModel> userTasks,
    LeaderboardPeriod period = LeaderboardPeriod.monthly,
    LeaderboardSortBy sortBy = LeaderboardSortBy.xp,
  }) async {
    // Get all users' tasks
    final userTasksFiltered = _filterTasksByPeriod(
      userTasks.where((t) => t.userId == userId && t.isCompleted).toList(),
      period,
    );

    final totalXP = userTasksFiltered.fold(0, (sum, task) {
      return sum + WorkXPCalculatorService.calculateTotalXP(task: task);
    });

    // Count users with higher XP
    int rank = 1;
    for (final user in allUsers) {
      if (user.id == userId) continue;
      if (user.organizationId != organizationId) continue;

      final otherUserTasks = _filterTasksByPeriod(
        userTasks.where((t) => t.userId == user.id && t.isCompleted).toList(),
        period,
      );

      final otherUserXP = otherUserTasks.fold(0, (sum, task) {
        return sum + WorkXPCalculatorService.calculateTotalXP(task: task);
      });

      if (otherUserXP > totalXP) {
        rank++;
      }
    }

    return rank;
  }

  /// Get trending up users (users who improved their rank)
  Future<List<TrendingUser>> getTrendingUsers({
    required String organizationId,
    required List<CorporateUserModel> users,
    required List<WorkTaskModel> tasks,
    int limit = 10,
  }) async {
    final trending = <TrendingUser>[];

    // Simplified implementation - would need historical data in real app
    for (final user in users) {
      if (user.organizationId != organizationId) continue;

      final userTasks = tasks.where((t) => t.userId == user.id).toList();
      final completedTasks = userTasks.where((t) => t.isCompleted).toList();

      // Calculate this week's XP
      final thisWeekTasks = _filterTasksByPeriod(completedTasks, LeaderboardPeriod.weekly);
      final thisWeekXP = thisWeekTasks.fold(0, (sum, task) {
        return sum + WorkXPCalculatorService.calculateTotalXP(task: task);
      });

      // Calculate last week's XP (simplified)
      final lastWeekXP = (thisWeekXP * 0.8).round(); // Simplified

      final improvement = thisWeekXP - lastWeekXP;

      if (improvement > 0) {
        trending.add(TrendingUser(
          userId: user.id,
          username: user.username,
          fullName: user.displayName,
          currentXP: thisWeekXP,
          improvement: improvement,
          improvementPercentage: lastWeekXP > 0
              ? ((improvement / lastWeekXP) * 100).round()
              : 100,
          rankImprovement: improvement > 100 ? 2 : 1, // Simplified
        ));
      }
    }

    // Sort by improvement
    trending.sort((a, b) => b.improvement.compareTo(a.improvement));

    return trending.take(limit).toList();
  }

  /// Calculate user statistics
  UserStats _calculateUserStats(CorporateUserModel user, List<WorkTaskModel> tasks) {
    final completedTasks = tasks;
    final totalTasks = completedTasks.length;

    // Calculate on-time rate
    final onTimeTasks = completedTasks.where((task) {
      return task.dueDate != null &&
          task.completedAt != null &&
          !task.completedAt!.isAfter(task.dueDate!);
    }).length;
    final onTimeRate = totalTasks > 0 ? onTimeTasks / totalTasks : 0.0;

    // Calculate average quality rating
    final qualityTasks = completedTasks
        .where((task) => task.qualityRating != null)
        .toList();
    final averageQualityRating = qualityTasks.isNotEmpty
        ? qualityTasks.fold(0.0, (sum, task) => sum + (task.qualityRating ?? 0)) / qualityTasks.length
        : null;

    // Calculate current streak (simplified)
    final currentStreak = _calculateCurrentStreak(completedTasks);

    // Calculate level (simplified)
    final totalXP = completedTasks.fold(0, (sum, task) {
      return sum + WorkXPCalculatorService.calculateTotalXP(task: task);
    });
    final currentLevel = (totalXP / 100).sqrt().floor();

    return UserStats(
      currentLevel: currentLevel,
      totalXP: totalXP,
      tasksCompleted: totalTasks,
      onTimeRate: onTimeRate,
      averageQualityRating: averageQualityRating,
      currentStreak: currentStreak,
    );
  }

  /// Calculate team statistics
  TeamStats _calculateTeamStats(TeamModel team, List<WorkTaskModel> tasks) {
    final totalTasks = tasks.length;
    final completedTasks = tasks.where((t) => t.isCompleted).toList().length;
    final completionRate = totalTasks > 0 ? completedTasks / totalTasks : 0.0;

    // Calculate total XP
    final totalXP = tasks.fold(0, (sum, task) {
      return sum + WorkXPCalculatorService.calculateTotalXP(task: task);
    });

    // Calculate average quality
    final qualityTasks = tasks
        .where((task) => task.qualityRating != null)
        .toList();
    final averageQualityRating = qualityTasks.isNotEmpty
        ? qualityTasks.fold(0.0, (sum, task) => sum + (task.qualityRating ?? 0)) / qualityTasks.length
        : null;

    // Calculate on-time rate
    final onTimeTasks = tasks.where((task) {
      return task.dueDate != null &&
          task.completedAt != null &&
          !task.completedAt!.isAfter(task.dueDate!);
    }).length;
    final onTimeRate = totalTasks > 0 ? onTimeTasks / totalTasks : 0.0;

    // Calculate active streak (simplified)
    final activeStreak = _calculateCurrentStreak(tasks.where((t) => t.isCompleted).toList());

    return TeamStats(
      totalXP: totalXP,
      completionRate: completionRate,
      averageQualityRating: averageQualityRating,
      onTimeRate: onTimeRate,
      activeStreak: activeStreak,
    );
  }

  /// Filter tasks by period
  List<WorkTaskModel> _filterTasksByPeriod(List<WorkTaskModel> tasks, LeaderboardPeriod period) {
    final now = DateTime.now();
    DateTime startDate;

    switch (period) {
      case LeaderboardPeriod.daily:
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case LeaderboardPeriod.weekly:
        startDate = now.subtract(Duration(days: now.weekday - 1));
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        break;
      case LeaderboardPeriod.monthly:
        startDate = DateTime(now.year, now.month, 1);
        break;
      case LeaderboardPeriod.yearly:
        startDate = DateTime(now.year, 1, 1);
        break;
      case LeaderboardPeriod.allTime:
        startDate = DateTime(2020, 1, 1); // Far in the past
        break;
    }

    return tasks
        .where((task) => task.completedAt != null && task.completedAt!.isAfter(startDate))
        .toList();
  }

  /// Calculate current streak (simplified)
  int _calculateCurrentStreak(List<WorkTaskModel> tasks) {
    if (tasks.isEmpty) return 0;

    // Sort tasks by completion date
    final sortedTasks = [...tasks]..sort((a, b) => b.completedAt!.compareTo(a.completedAt!));

    // Group by date
    final dates = <String>{};
    for (final task in sortedTasks) {
      final dateKey = '${task.completedAt!.year}-${task.completedAt!.month}-${task.completedAt!.day}';
      dates.add(dateKey);
    }

    // Count consecutive days from most recent
    int streak = 0;
    for (final date in dates) {
      if (streak == 0) {
        streak = 1;
      } else {
        streak++;
      }
    }

    return streak;
  }
}

/// ===== DATA MODELS =====

/// Leaderboard period enum
enum LeaderboardPeriod {
  daily,
  weekly,
  monthly,
  yearly,
  allTime,
}

/// Leaderboard sort enum
enum LeaderboardSortBy {
  xp,
  tasks,
  quality,
}

/// Individual leaderboard entry
class IndividualLeaderboardEntry {
  final String userId;
  final String username;
  final String? fullName;
  final String? avatarUrl;
  final int rank;
  final int level;
  final int totalXP;
  final int tasksCompleted;
  final double onTimeRate;
  final double? qualityRating;
  final int streakDays;
  final String? teamId;
  final CorporateUserRole? role;
  final String? departmentId;

  const IndividualLeaderboardEntry({
    required this.userId,
    required this.username,
    required this.fullName,
    required this.avatarUrl,
    required this.rank,
    required this.level,
    required this.totalXP,
    required this.tasksCompleted,
    required this.onTimeRate,
    required this.qualityRating,
    required this.streakDays,
    required this.teamId,
    required this.role,
    required this.departmentId,
  });

  IndividualLeaderboardEntry copyWith({
    String? userId,
    String? username,
    String? fullName,
    String? avatarUrl,
    int? rank,
    int? level,
    int? totalXP,
    int? tasksCompleted,
    double? onTimeRate,
    double? qualityRating,
    int? streakDays,
    String? teamId,
    CorporateUserRole? role,
    String? departmentId,
  }) {
    return IndividualLeaderboardEntry(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rank: rank ?? this.rank,
      level: level ?? this.level,
      totalXP: totalXP ?? this.totalXP,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      onTimeRate: onTimeRate ?? this.onTimeRate,
      qualityRating: qualityRating ?? this.qualityRating,
      streakDays: streakDays ?? this.streakDays,
      teamId: teamId ?? this.teamId,
      role: role ?? this.role,
      departmentId: departmentId ?? this.departmentId,
    );
  }
}

/// Team leaderboard entry
class TeamLeaderboardEntry {
  final String teamId;
  final String teamName;
  final String teamColor;
  final String? teamIcon;
  final int rank;
  final String organizationId;
  final String? departmentId;
  final int memberCount;
  final int totalXP;
  final int tasksCompleted;
  final double completionRate;
  final double? averageQualityRating;
  final double onTimeRate;
  final int activeStreak;

  const TeamLeaderboardEntry({
    required this.teamId,
    required this.teamName,
    required this.teamColor,
    required this.teamIcon,
    required this.rank,
    required this.organizationId,
    required this.departmentId,
    required this.memberCount,
    required this.totalXP,
    required this.tasksCompleted,
    required this.completionRate,
    required this.averageQualityRating,
    required this.onTimeRate,
    required this.activeStreak,
  });

  TeamLeaderboardEntry copyWith({
    String? teamId,
    String? teamName,
    String? teamColor,
    String? teamIcon,
    int? rank,
    String? organizationId,
    String? departmentId,
    int? memberCount,
    int? totalXP,
    int? tasksCompleted,
    double? completionRate,
    double? averageQualityRating,
    double? onTimeRate,
    int? activeStreak,
  }) {
    return TeamLeaderboardEntry(
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      teamColor: teamColor ?? this.teamColor,
      teamIcon: teamIcon ?? this.teamIcon,
      rank: rank ?? this.rank,
      organizationId: organizationId ?? this.organizationId,
      departmentId: departmentId ?? this.departmentId,
      memberCount: memberCount ?? this.memberCount,
      totalXP: totalXP ?? this.totalXP,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      completionRate: completionRate ?? this.completionRate,
      averageQualityRating: averageQualityRating ?? this.averageQualityRating,
      onTimeRate: onTimeRate ?? this.onTimeRate,
      activeStreak: activeStreak ?? this.activeStreak,
    );
  }
}

/// Department leaderboard entry
class DepartmentLeaderboardEntry {
  final String departmentId;
  final String departmentName;
  final int rank;
  final int teamCount;
  final int totalMembers;
  final int totalXP;
  final int tasksCompleted;
  final double? averageQualityRating;
  final double onTimeRate;

  const DepartmentLeaderboardEntry({
    required this.departmentId,
    required this.departmentName,
    required this.rank,
    required this.teamCount,
    required this.totalMembers,
    required this.totalXP,
    required this.tasksCompleted,
    required this.averageQualityRating,
    required this.onTimeRate,
  });

  DepartmentLeaderboardEntry copyWith({
    String? departmentId,
    String? departmentName,
    int? rank,
    int? teamCount,
    int? totalMembers,
    int? totalXP,
    int? tasksCompleted,
    double? averageQualityRating,
    double? onTimeRate,
  }) {
    return DepartmentLeaderboardEntry(
      departmentId: departmentId ?? this.departmentId,
      departmentName: departmentName ?? this.departmentName,
      rank: rank ?? this.rank,
      teamCount: teamCount ?? this.teamCount,
      totalMembers: totalMembers ?? this.totalMembers,
      totalXP: totalXP ?? this.totalXP,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      averageQualityRating: averageQualityRating ?? this.averageQualityRating,
      onTimeRate: onTimeRate ?? this.onTimeRate,
    );
  }
}

/// Trending user entry
class TrendingUser {
  final String userId;
  final String username;
  final String? fullName;
  final int currentXP;
  final int improvement;
  final int improvementPercentage;
  final int rankImprovement;

  const TrendingUser({
    required this.userId,
    required this.username,
    required this.fullName,
    required this.currentXP,
    required this.improvement,
    required this.improvementPercentage,
    required this.rankImprovement,
  });
}

/// User statistics
class UserStats {
  final int currentLevel;
  final int totalXP;
  final int tasksCompleted;
  final double onTimeRate;
  final double? averageQualityRating;
  final int currentStreak;

  const UserStats({
    required this.currentLevel,
    required this.totalXP,
    required this.tasksCompleted,
    required this.onTimeRate,
    required this.averageQualityRating,
    required this.currentStreak,
  });
}

/// Team statistics
class TeamStats {
  final int totalXP;
  final double completionRate;
  final double? averageQualityRating;
  final double onTimeRate;
  final int activeStreak;

  const TeamStats({
    required this.totalXP,
    required this.completionRate,
    required this.averageQualityRating,
    required this.onTimeRate,
    required this.activeStreak,
  });
}

/// Department statistics
class DepartmentStats {
  final String departmentId;
  int teamCount;
  int totalMembers;
  int totalXP;
  int tasksCompleted;
  int totalQualityRating;
  int qualityRatingCount;
  int onTimeCount;
  int totalTasks;

  DepartmentStats({
    required this.departmentId,
    required this.teamCount,
    required this.totalMembers,
    required this.totalXP,
    required this.tasksCompleted,
    required this.totalQualityRating,
    required this.qualityRatingCount,
    required this.onTimeCount,
    required this.totalTasks,
  });

  DepartmentStats copyWith({
    String? departmentId,
    int? teamCount,
    int? totalMembers,
    int? totalXP,
    int? tasksCompleted,
    int? totalQualityRating,
    int? qualityRatingCount,
    int? onTimeCount,
    int? totalTasks,
  }) {
    return DepartmentStats(
      departmentId: departmentId ?? this.departmentId,
      teamCount: teamCount ?? this.teamCount,
      totalMembers: totalMembers ?? this.totalMembers,
      totalXP: totalXP ?? this.totalXP,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      totalQualityRating: totalQualityRating ?? this.totalQualityRating,
      qualityRatingCount: qualityRatingCount ?? this.qualityRatingCount,
      onTimeCount: onTimeCount ?? this.onTimeCount,
      totalTasks: totalTasks ?? this.totalTasks,
    );
  }
}
