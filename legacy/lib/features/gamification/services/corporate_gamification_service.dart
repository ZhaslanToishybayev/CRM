/// Corporate Gamification Service
/// Main service integrating all gamification features with corporate functions
///
/// This service:
/// - Manages XP calculation and distribution
/// - Tracks and awards achievements
/// - Maintains leaderboards
/// - Provides gamification insights
/// - Integrates with team/project systems

import '../models/xp_model.dart';
import '../models/level_model.dart';
import '../services/work_xp_calculator.dart';
import '../../achievements/services/work_achievement_service.dart';
import '../../achievements/models/work_achievement_definitions.dart';
import '../../achievements/models/achievement_model.dart';
import '../../leaderboard/services/team_leaderboard_service.dart';
import '../../tasks/models/work_task_model.dart';
import '../../teams/models/team_model.dart';
import '../../teams/models/team_member_model.dart';
import '../../projects/models/project_model.dart';
import '../../auth/models/corporate_user_model.dart';

class CorporateGamificationService {
  CorporateGamificationService._();

  static final CorporateGamificationService _instance = CorporateGamificationService._();
  static CorporateGamificationService get instance => _instance;

  final WorkAchievementService _achievementService = WorkAchievementService();
  final TeamLeaderboardService _leaderboardService = TeamLeaderboardService();

  /// Process task completion and award XP/achievements
  Future<GamificationResult> processTaskCompletion({
    required WorkTaskModel task,
    required XPModel currentXP,
    required CorporateUserModel user,
    int? qualityRating,
    String? managerFeedback,
    List<String>? collaborators,
    List<WorkTaskModel>? allUserTasks,
    String? teamId,
  }) async {
    // Calculate XP
    final totalXP = WorkXPCalculatorService.calculateTotalXP(
      task: task,
      qualityRating: qualityRating,
      managerFeedback: managerFeedback,
      collaborators: collaborators,
    );

    // Calculate new XP model
    final newXP = WorkXPCalculatorService.calculateNewWorkXP(
      currentXP: currentXP,
      additionalXP: totalXP,
      task: task,
      qualityRating: qualityRating,
      managerFeedback: managerFeedback,
    );

    // Check for level up
    final isLevelUp = newXP.currentLevel > currentXP.currentLevel;

    // Get XP breakdown for detailed feedback
    final xpBreakdown = WorkXPCalculatorService.getXPBreakdown(
      task: task,
      qualityRating: qualityRating,
      collaborators: collaborators,
    );

    // Check for achievements
    if (allUserTasks != null) {
      final newAchievements = await _achievementService.checkWorkAchievements(
        userId: user.id,
        tasks: allUserTasks,
        teamId: teamId ?? user.teamId ?? '',
        organizationId: user.organizationId ?? '',
      );

      return GamificationResult(
        taskId: task.id,
        awardedXP: totalXP,
        newXPModel: newXP,
        isLevelUp: isLevelUp,
        levelUpBonus: isLevelUp ? WorkXPCalculatorService.getLevelUpBonusXP(newXP.currentLevel) : 0,
        xpBreakdown: xpBreakdown,
        newAchievements: newAchievements,
      );
    }

    return GamificationResult(
      taskId: task.id,
      awardedXP: totalXP,
      newXPModel: newXP,
      isLevelUp: isLevelUp,
      levelUpBonus: isLevelUp ? WorkXPCalculatorService.getLevelUpBonusXP(newXP.currentLevel) : 0,
      xpBreakdown: xpBreakdown,
      newAchievements: [],
    );
  }

  /// Get user's current gamification status
  Future<UserGamificationStatus> getUserGamificationStatus({
    required String userId,
    required CorporateUserModel user,
    required List<WorkTaskModel> userTasks,
    String? teamId,
    String? organizationId,
  }) async {
    final completedTasks = userTasks.where((t) => t.isCompleted).toList();

    // Calculate stats
    final totalXP = completedTasks.fold(0, (sum, task) {
      return sum + WorkXPCalculatorService.calculateTotalXP(task: task);
    });

    final currentLevel = WorkXPCalculatorService.calculateLevel(totalXP);
    final progress = WorkXPCalculatorService.calculateWorkProgress(totalXP);
    final xpToNext = WorkXPCalculatorService.getWorkXPForNextLevel(totalXP);

    // Calculate streak
    final streak = _calculateStreak(completedTasks);

    // Calculate on-time rate
    final onTimeTasks = completedTasks.where((task) {
      return task.dueDate != null &&
          task.completedAt != null &&
          !task.completedAt!.isAfter(task.dueDate!);
    }).length;
    final onTimeRate = completedTasks.isNotEmpty ? onTimeTasks / completedTasks.length : 0.0;

    // Calculate average quality
    final qualityTasks = completedTasks.where((t) => t.qualityRating != null).toList();
    final averageQuality = qualityTasks.isNotEmpty
        ? qualityTasks.fold(0.0, (sum, task) => sum + (task.qualityRating ?? 0)) / qualityTasks.length
        : null;

    // Get achievements
    final userAchievements = await _getUserAchievements(userId);

    // Get leaderboard rank
    int? rank;
    if (teamId != null) {
      // TODO: Get team members and tasks
      // rank = await _leaderboardService.getUserRankInTeam(...);
    }

    return UserGamificationStatus(
      userId: userId,
      currentLevel: currentLevel,
      totalXP: totalXP,
      xpToNextLevel: xpToNext,
      progressPercentage: (progress * 100).round(),
      currentStreak: streak,
      onTimeRate: onTimeRate,
      averageQualityRating: averageQuality,
      tasksCompleted: completedTasks.length,
      achievementsUnlocked: userAchievements.length,
      leaderboardRank: rank,
      workTier: user.getWorkTier(),
    );
  }

  /// Get team's gamification status
  Future<TeamGamificationStatus> getTeamGamificationStatus({
    required String teamId,
    required TeamModel team,
    required List<TeamMemberModel> members,
    required List<WorkTaskModel> teamTasks,
  }) async {
    final completedTasks = teamTasks.where((t) => t.isCompleted).toList();

    // Calculate team stats
    final totalXP = completedTasks.fold(0, (sum, task) {
      return sum + WorkXPCalculatorService.calculateTotalXP(task: task);
    });

    final completionRate = teamTasks.isNotEmpty ? completedTasks.length / teamTasks.length : 0.0;

    // Calculate team streak
    final teamStreak = _calculateTeamStreak(completedTasks);

    // Calculate member statistics
    final memberStats = <String, MemberStats>{};
    for (final member in members) {
      final memberTasks = completedTasks.where((t) => t.userId == member.userId).toList();
      final memberXP = memberTasks.fold(0, (sum, task) {
        return sum + WorkXPCalculatorService.calculateTotalXP(task: task);
      });

      memberStats[member.userId] = MemberStats(
        userId: member.userId,
        totalXP: memberXP,
        tasksCompleted: memberTasks.length,
        level: WorkXPCalculatorService.calculateLevel(memberXP),
      );
    }

    // Get team achievements
    final teamAchievements = await _achievementService.checkTeamAchievements(
      teamId: teamId,
      teamTasks: teamTasks,
      teamMemberIds: members.map((m) => m.userId).toList(),
    );

    return TeamGamificationStatus(
      teamId: teamId,
      teamName: team.name,
      totalXP: totalXP,
      completionRate: completionRate,
      activeStreak: teamStreak,
      memberStats: memberStats,
      teamAchievements: teamAchievements,
      averageMemberLevel: memberStats.isNotEmpty
          ? memberStats.values.fold(0.0, (sum, stats) => sum + stats.level) / memberStats.length
          : 0.0,
    );
  }

  /// Get gamification insights and recommendations
  Future<GamificationInsights> getGamificationInsights({
    required String userId,
    required CorporateUserModel user,
    required List<WorkTaskModel> userTasks,
    String? teamId,
  }) async {
    final completedTasks = userTasks.where((t) => t.isCompleted).toList();

    // Analyze patterns
    final insights = <String>[];

    // Check for improvement opportunities
    final onTimeRate = completedTasks.isNotEmpty
        ? completedTasks.where((t) {
            return t.dueDate != null &&
                t.completedAt != null &&
                !t.completedAt!.isAfter(t.dueDate!);
          }).length / completedTasks.length
        : 1.0;

    if (onTimeRate < 0.8) {
      insights.add('Try to improve your on-time completion rate to earn more XP bonuses');
    }

    // Check quality rating
    final qualityTasks = completedTasks.where((t) => t.qualityRating != null).toList();
    if (qualityTasks.isNotEmpty) {
      final avgQuality = qualityTasks.fold(0.0, (sum, t) => sum + (t.qualityRating ?? 0)) / qualityTasks.length;
      if (avgQuality < 3.5) {
        insights.add('Focus on quality to earn higher XP rewards from manager ratings');
      }
    }

    // Check team participation
    final teamTasks = completedTasks.where((t) => t.type == WorkTaskType.team).length;
    if (teamTasks < completedTasks.length * 0.3) {
      insights.add('Participate more in team tasks to earn collaboration bonuses');
    }

    // Check streak
    final streak = _calculateStreak(completedTasks);
    if (streak < 7) {
      insights.add('Maintain a daily task completion streak to earn streak bonuses');
    }

    // Check for upcoming achievements
    final nearAchievements = await _getNearAchievements(userId, userTasks);
    final upcomingAchievements = nearAchievements.take(3).toList();

    return GamificationInsights(
      insights: insights,
      upcomingAchievements: upcomingAchievements,
      strengths: _identifyStrengths(completedTasks),
      improvements: _identifyImprovements(completedTasks),
    );
  }

  /// Get leaderboard for a specific user
  Future<UserLeaderboardPosition> getUserLeaderboardPosition({
    required String userId,
    String? teamId,
    String? organizationId,
    LeaderboardPeriod period = LeaderboardPeriod.monthly,
  }) async {
    // This would require actual data in real implementation
    // Returning mock data for demonstration
    return UserLeaderboardPosition(
      userId: userId,
      individualRank: 5,
      teamRank: 2,
      organizationRank: 15,
      totalUsersInTeam: 8,
      totalUsersInOrg: 150,
      percentileInTeam: 62.5,
      percentileInOrg: 90.0,
      trending: TrendingDirection.up,
      rankChange: 3,
    );
  }

  /// Calculate streak for user
  int _calculateStreak(List<WorkTaskModel> tasks) {
    if (tasks.isEmpty) return 0;

    final sortedTasks = [...tasks]
      ..sort((a, b) => b.completedAt!.compareTo(a.completedAt!));

    final dates = <String>{};
    for (final task in sortedTasks) {
      if (task.completedAt != null) {
        final dateKey = '${task.completedAt!.year}-${task.completedAt!.month}-${task.completedAt!.day}';
        dates.add(dateKey);
      }
    }

    return dates.length;
  }

  /// Calculate team streak
  int _calculateTeamStreak(List<WorkTaskModel> tasks) {
    // Simplified - would need more complex logic in real implementation
    return _calculateStreak(tasks);
  }

  /// Get user's achievements
  Future<List<AchievementModel>> _getUserAchievements(String userId) async {
    // Mock implementation - would query database in real app
    return [];
  }

  /// Get near-completion achievements
  Future<List<AchievementModel>> _getNearAchievements(
    String userId,
    List<WorkTaskModel> tasks,
  ) async {
    final achievements = <AchievementModel>[];

    // Check progress for key achievements
    final workAchievements = WorkAchievementDefinitions.allWork;

    for (final achievement in workAchievements) {
      final progress = await _achievementService.getAchievementProgress(
        userId: userId,
        tasks: tasks,
        achievement: achievement,
      );

      if (progress.percentage >= 70 && progress.percentage < 100) {
        achievements.add(achievement);
      }
    }

    return achievements;
  }

  /// Identify user strengths
  List<String> _identifyStrengths(List<WorkTaskModel> tasks) {
    final strengths = <String>[];

    // Analyze completed tasks
    final completedTasks = tasks.where((t) => t.isCompleted).toList();

    if (completedTasks.isEmpty) return strengths;

    // On-time rate
    final onTimeTasks = completedTasks.where((t) {
      return t.dueDate != null &&
          t.completedAt != null &&
          !t.completedAt!.isAfter(t.dueDate!);
    }).length;

    if (onTimeTasks / completedTasks.length > 0.9) {
      strengths.add('Excellent at meeting deadlines');
    }

    // Quality
    final qualityTasks = completedTasks.where((t) => t.qualityRating != null).toList();
    if (qualityTasks.isNotEmpty) {
      final avgQuality = qualityTasks.fold(0.0, (sum, t) => sum + (t.qualityRating ?? 0)) / qualityTasks.length;
      if (avgQuality > 4.0) {
        strengths.add('Consistently high quality work');
      }
    }

    // Team collaboration
    final teamTasks = completedTasks.where((t) => t.type == WorkTaskType.team).length;
    if (teamTasks / completedTasks.length > 0.5) {
      strengths.add('Strong team player');
    }

    return strengths;
  }

  /// Identify improvement areas
  List<String> _identifyImprovements(List<WorkTaskModel> tasks) {
    final improvements = <String>[];

    final completedTasks = tasks.where((t) => t.isCompleted).toList();
    if (completedTasks.isEmpty) return improvements;

    // Check for late completions
    final lateTasks = completedTasks.where((t) {
      return t.dueDate != null &&
          t.completedAt != null &&
          t.completedAt!.isAfter(t.dueDate!);
    }).length;

    if (lateTasks / completedTasks.length > 0.2) {
      improvements.add('Work on meeting deadlines');
    }

    // Check for low quality
    final qualityTasks = completedTasks.where((t) => t.qualityRating != null).toList();
    if (qualityTasks.isNotEmpty) {
      final avgQuality = qualityTasks.fold(0.0, (sum, t) => sum + (t.qualityRating ?? 0)) / qualityTasks.length;
      if (avgQuality < 3.0) {
        improvements.add('Focus on quality of deliverables');
      }
    }

    return improvements;
  }
}

/// ===== GAMIFICATION RESULT MODELS =====

/// Result of processing task completion
class GamificationResult {
  final String taskId;
  final int awardedXP;
  final XPModel newXPModel;
  final bool isLevelUp;
  final int levelUpBonus;
  final XPBreakdown xpBreakdown;
  final List<AchievementModel> newAchievements;

  const GamificationResult({
    required this.taskId,
    required this.awardedXP,
    required this.newXPModel,
    required this.isLevelUp,
    required this.levelUpBonus,
    required this.xpBreakdown,
    required this.newAchievements,
  });
}

/// User's overall gamification status
class UserGamificationStatus {
  final String userId;
  final int currentLevel;
  final int totalXP;
  final int xpToNextLevel;
  final int progressPercentage;
  final int currentStreak;
  final double onTimeRate;
  final double? averageQualityRating;
  final int tasksCompleted;
  final int achievementsUnlocked;
  final int? leaderboardRank;
  final WorkTier workTier;

  const UserGamificationStatus({
    required this.userId,
    required this.currentLevel,
    required this.totalXP,
    required this.xpToNextLevel,
    required this.progressPercentage,
    required this.currentStreak,
    required this.onTimeRate,
    required this.averageQualityRating,
    required this.tasksCompleted,
    required this.achievementsUnlocked,
    required this.leaderboardRank,
    required this.workTier,
  });
}

/// Team's gamification status
class TeamGamificationStatus {
  final String teamId;
  final String teamName;
  final int totalXP;
  final double completionRate;
  final int activeStreak;
  final Map<String, MemberStats> memberStats;
  final List<AchievementModel> teamAchievements;
  final double averageMemberLevel;

  const TeamGamificationStatus({
    required this.teamId,
    required this.teamName,
    required this.totalXP,
    required this.completionRate,
    required this.activeStreak,
    required this.memberStats,
    required this.teamAchievements,
    required this.averageMemberLevel,
  });
}

/// Member statistics within a team
class MemberStats {
  final String userId;
  final int totalXP;
  final int tasksCompleted;
  final int level;

  const MemberStats({
    required this.userId,
    required this.totalXP,
    required this.tasksCompleted,
    required this.level,
  });
}

/// Gamification insights and recommendations
class GamificationInsights {
  final List<String> insights;
  final List<AchievementModel> upcomingAchievements;
  final List<String> strengths;
  final List<String> improvements;

  const GamificationInsights({
    required this.insights,
    required this.upcomingAchievements,
    required this.strengths,
    required this.improvements,
  });
}

/// User's leaderboard position
class UserLeaderboardPosition {
  final String userId;
  final int individualRank;
  final int teamRank;
  final int organizationRank;
  final int totalUsersInTeam;
  final int totalUsersInOrg;
  final double percentileInTeam;
  final double percentileInOrg;
  final TrendingDirection trending;
  final int rankChange;

  const UserLeaderboardPosition({
    required this.userId,
    required this.individualRank,
    required this.teamRank,
    required this.organizationRank,
    required this.totalUsersInTeam,
    required this.totalUsersInOrg,
    required this.percentileInTeam,
    required this.percentileInOrg,
    required this.trending,
    required this.rankChange,
  });
}

/// Trending direction enum
enum TrendingDirection {
  up,
  down,
  stable,
}

extension TrendingDirectionExtension on TrendingDirection {
  String get displayName {
    switch (this) {
      case TrendingDirection.up:
        return 'Trending Up';
      case TrendingDirection.down:
        return 'Trending Down';
      case TrendingDirection.stable:
        return 'Stable';
    }
  }

  String get icon {
    switch (this) {
      case TrendingDirection.up:
        return '📈';
      case TrendingDirection.down:
        return '📉';
      case TrendingDirection.stable:
        return '➡️';
    }
  }

  Color get color {
    switch (this) {
      case TrendingDirection.up:
        return Colors.green;
      case TrendingDirection.down:
        return Colors.red;
      case TrendingDirection.stable:
        return Colors.grey;
    }
  }
}
