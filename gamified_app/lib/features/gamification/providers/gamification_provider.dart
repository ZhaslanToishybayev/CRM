/// Gamification Provider
/// Educational Project - Gamified Task Management App
///
/// Manages XP and Level state using Riverpod

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/xp_model.dart';
import '../models/level_model.dart';
import '../services/xp_calculator.dart';
import '../../auth/providers/auth_provider.dart';

part 'gamification_provider.g.dart';

/// Provider for the current user's XP
@Riverpod(keepAlive: true)
XPModel? currentXP(CurrentXPRef ref) {
  final authState = ref.watch(authStateNotifierProvider);

  if (authState == null) return null;

  // Create XP model from user data
  final xp = XPModel(
    userId: authState.id,
    totalXP: authState.totalXP,
    currentLevel: authState.currentLevel,
    currentLevelXP: _getCurrentLevelXP(authState.totalXP, authState.currentLevel),
    nextLevelXP: _getNextLevelXP(authState.currentLevel),
    xpToNextLevel: _getXPToNextLevel(authState.totalXP, authState.currentLevel),
    progressToNextLevel: _getProgress(authState.totalXP, authState.currentLevel),
    lastUpdated: DateTime.now(),
  );

  return xp;
}

/// Provider for the current level info
@Riverpod(keepAlive: true)
LevelInfo currentLevelInfo(CurrentLevelInfoRef ref) {
  final xp = ref.watch(currentXPProvider);

  if (xp == null) {
    return LevelBadgeConfig.getLevelInfo(1);
  }

  return LevelBadgeConfig.getLevelInfo(xp.currentLevel);
}

/// Provider for next level info
@Riverpod(keepAlive: true)
LevelInfo nextLevelInfo(NextLevelInfoRef ref) {
  final xp = ref.watch(currentXPProvider);

  if (xp == null) {
    return LevelBadgeConfig.getLevelInfo(2);
  }

  return LevelBadgeConfig.getLevelInfo(xp.currentLevel + 1);
}

/// Provider for gamification state
@Riverpod(keepAlive: true)
class GamificationNotifier extends _$GamificationNotifier {
  @override
  void build() {
    // Initialize empty state
  }

  /// Award XP for task completion
  Future<XPModel> awardXP({
    required String priority,
    DateTime? dueDate,
    DateTime? completedAt,
    int streakCount = 0,
  }) async {
    final currentUser = ref.read(authStateNotifierProvider);
    if (currentUser == null) {
      throw Exception('User not authenticated');
    }

    // Calculate XP reward
    final baseXP = XPCalculatorService.calculateTaskXP(
      priority: priority,
      dueDate: dueDate,
      completedAt: completedAt,
    );

    // Add streak bonus
    final streakBonus = XPCalculatorService.calculateStreakBonusXP(streakCount);
    final totalXP = baseXP + streakBonus;

    // Calculate new XP model
    final newXP = XPCalculatorService.calculateNewXP(
      currentXP: ref.read(currentXPProvider)!,
      additionalXP: totalXP,
    );

    // Update state
    state = newXP;

    // TODO: Save to database
    // In production, you would:
    // 1. Update the user profile in Supabase
    // 2. Trigger level-up celebration if level changed

    return newXP;
  }

  /// Reset XP stats (for logout)
  void reset() {
    state = const UserStats();
    // TODO: Clear from database
  }

  /// Check if user has leveled up
  bool hasLeveledUp(XPModel oldXP, XPModel newXP) {
    return newXP.currentLevel > oldXP.currentLevel;
  }

  /// Get formatted XP display
  String getFormattedXP(int xp) {
    return XPCalculatorService.formatXP(xp);
  }

  /// Get level badge configuration
  LevelInfo getLevelInfo(int level) {
    return LevelBadgeConfig.getLevelInfo(level);
  }

  /// Check if level is a milestone
  bool isMilestoneLevel(int level) {
    return LevelBadgeConfig.isMilestone(level);
  }

  /// Get milestone levels
  List<int> getMilestoneLevels() {
    return LevelBadgeConfig.getMilestoneLevels();
  }

  /// Calculate XP for task priority
  int calculateTaskXP(String priority) {
    return XPCalculatorService.calculateTaskXP(priority: priority);
  }

  /// Get estimated days to next level
  int estimateDaysToNextLevel({
    required int currentTotalXP,
    required int daysActive,
    required int xpPerDay,
  }) {
    return XPCalculatorService.estimateDaysToNextLevel(
      currentTotalXP: currentTotalXP,
      daysActive: daysActive,
      xpPerDay: xpPerDay,
    );
  }
}

/// Helper functions
int _getCurrentLevelXP(int totalXP, int currentLevel) {
  final currentLevelMinXP = LevelBadgeConfig.calculateRequiredXP(currentLevel);
  return totalXP - currentLevelMinXP;
}

int _getNextLevelXP(int currentLevel) {
  final currentLevelMinXP = LevelBadgeConfig.calculateRequiredXP(currentLevel);
  final nextLevelMinXP = LevelBadgeConfig.calculateRequiredXP(currentLevel + 1);
  return nextLevelMinXP - currentLevelMinXP;
}

int _getXPToNextLevel(int totalXP, int currentLevel) {
  final nextLevelMinXP = LevelBadgeConfig.calculateRequiredXP(currentLevel + 1);
  return nextLevelMinXP - totalXP;
}

double _getProgress(int totalXP, int currentLevel) {
  final currentLevelMinXP = LevelBadgeConfig.calculateRequiredXP(currentLevel);
  final nextLevelMinXP = LevelBadgeConfig.calculateRequiredXP(currentLevel + 1);
  final currentLevelXP = totalXP - currentLevelMinXP;
  final xpForLevel = nextLevelMinXP - currentLevelMinXP;
  return currentLevelXP / xpForLevel;
}
