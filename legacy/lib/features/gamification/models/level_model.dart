/// Level Model
/// Educational Project - Gamified Task Management App
///
/// Represents level information and milestones

import 'package:freezed_annotation/freezed_annotation.dart';

part 'level_model.freezed.dart';
part 'level_model.g.dart';

@freezed
class LevelInfo with _$LevelInfo {
  const factory LevelInfo({
    required int level,
    required int requiredXP,
    required String title,
    required String subtitle,
    required String color,
  }) = _LevelInfo;

  factory LevelInfo.fromJson(Map<String, dynamic> json) =>
      _$LevelInfoFromJson(json);
}

/// Level badge configuration
class LevelBadgeConfig {
  static const Map<int, LevelInfo> levels = {
    1: LevelInfo(
      level: 1,
      requiredXP: 0,
      title: 'Beginner',
      subtitle: 'Just Getting Started',
      color: '#81C784',
    ),
    2: LevelInfo(
      level: 2,
      requiredXP: 400,
      title: 'Learner',
      subtitle: 'Making Progress',
      color: '#64B5F6',
    ),
    3: LevelInfo(
      level: 3,
      requiredXP: 900,
      title: 'Achiever',
      subtitle: 'Conquering Tasks',
      color: '#FFB74D',
    ),
    4: LevelInfo(
      level: 4,
      requiredXP: 1600,
      title: 'Dedicated',
      subtitle: 'Staying Committed',
      color: '#BA68C8',
    ),
    5: LevelInfo(
      level: 5,
      requiredXP: 2500,
      title: 'Pro',
      subtitle: 'Task Master',
      color: '#4DB6AC',
    ),
    6: LevelInfo(
      level: 6,
      requiredXP: 3600,
      title: 'Expert',
      subtitle: 'Highly Skilled',
      color: '#7986CB',
    ),
    7: LevelInfo(
      level: 7,
      requiredXP: 4900,
      title: 'Champion',
      subtitle: 'Top Performer',
      color: '#FF8A65',
    ),
    8: LevelInfo(
      level: 8,
      requiredXP: 6400,
      title: 'Virtuoso',
      subtitle: 'Exceptional Talent',
      color: '#AED581',
    ),
    9: LevelInfo(
      level: 9,
      requiredXP: 8100,
      title: 'Legend',
      subtitle: 'Outstanding Achievement',
      color: '#9575CD',
    ),
    10: LevelInfo(
      level: 10,
      requiredXP: 10000,
      title: 'Master',
      subtitle: 'Ultimate Task Slayer',
      color: '#FFD54F',
    ),
  };

  /// Get level info by level number
  static LevelInfo getLevelInfo(int level) {
    if (level <= 10) {
      return levels[level] ?? levels[10]!;
    }

    // For levels beyond 10, create dynamic info
    final title = level < 20 ? 'Grandmaster' : 'Mythic';
    final subtitle = level < 20 ? 'Beyond Expectations' : 'Unstoppable Force';

    return LevelInfo(
      level: level,
      requiredXP: level * level * 100,
      title: title,
      subtitle: subtitle,
      color: '#FFD700', // Gold for high levels
    );
  }

  /// Get the next milestone level
  static List<int> getMilestoneLevels() {
    return [5, 10, 15, 20, 25, 50, 75, 100];
  }

  /// Check if level is a milestone
  static bool isMilestone(int level) {
    return getMilestoneLevels().contains(level);
  }

  /// Get XP needed for next milestone
  static int getXPForNextMilestone(int currentLevel) {
    final milestones = getMilestoneLevels();
    for (final milestone in milestones) {
      if (milestone > currentLevel) {
        return calculateRequiredXP(milestone);
      }
    }
    // If all milestones passed, use next multiple of 10
    final nextTen = ((currentLevel ~/ 10) + 1) * 10;
    return calculateRequiredXP(nextTen);
  }

  /// Calculate required XP for a level
  static int calculateRequiredXP(int level) {
    return (level * level * 100);
  }

  /// Calculate XP for a specific level
  static int calculateXPForLevel(int level) {
    if (level <= 1) return 0;

    // XP needed for a specific level
    final previousLevel = level - 1;
    return calculateRequiredXP(level) - calculateRequiredXP(previousLevel);
  }
}
