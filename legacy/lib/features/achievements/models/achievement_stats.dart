/// Achievement Statistics
/// Educational Project - Gamified Task Management App
///
/// Represents user's achievement statistics

import 'package:freezed_annotation/freezed_annotation.dart';
import 'achievement_model.dart';

part 'achievement_stats.freezed.dart';
part 'achievement_stats.g.dart';

@freezed
class AchievementStats with _$AchievementStats {
  const factory AchievementStats({
    required int totalAchievements,
    required int unlockedAchievements,
    required int lockedAchievements,
    required double completionPercentage,
    @Default({}) Map<AchievementCategory, int> categoryStats,
  }) = _AchievementStats;

  factory AchievementStats.fromJson(Map<String, dynamic> json) =>
      _$AchievementStatsFromJson(json);
}
