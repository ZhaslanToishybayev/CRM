/// XP Model
/// Educational Project - Gamified Task Management App
///
/// Represents user XP (Experience Points) data

import 'package:freezed_annotation/freezed_annotation.dart';

part 'xp_model.freezed.dart';
part 'xp_model.g.dart';

@freezed
class XPModel with _$XPModel {
  const XPModel._(); // Added for getters

  const factory XPModel({
    required String userId,
    required int totalXP,
    required int currentLevel,
    required int currentLevelXP,
    required int nextLevelXP,
    required int xpToNextLevel,
    required double progressToNextLevel,
    required DateTime lastUpdated,
  }) = _XPModel;

  factory XPModel.fromJson(Map<String, dynamic> json) =>
      _$XPModelFromJson(json);

  /// Calculate the required XP for a specific level
  static int calculateRequiredXP(int level) {
    // XP formula: Level = floor(sqrt(totalXP / 100))
    // Therefore: totalXP = level^2 * 100
    return (level * level * 100);
  }

  /// Get the maximum XP for the current level
  int get maxXPForCurrentLevel {
    return calculateRequiredXP(currentLevel);
  }

  /// Check if user has leveled up
  bool hasLeveledUp(int oldLevel) {
    return currentLevel > oldLevel;
  }

  /// Get level-up bonus XP
  int get levelUpBonusXP {
    // Bonus XP for level up (10% of next level XP)
    return (nextLevelXP * 0.1).round();
  }

  /// Calculate progress percentage (0.0 to 1.0)
  double get progressPercentage {
    return (currentLevelXP / nextLevelXP).clamp(0.0, 1.0);
  }

  /// Format XP for display
  String get formattedTotalXP {
    if (totalXP >= 1000000) {
      return '${(totalXP / 1000000).toStringAsFixed(1)}M';
    } else if (totalXP >= 1000) {
      return '${(totalXP / 1000).toStringAsFixed(1)}K';
    }
    return totalXP.toString();
  }
}
