// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AchievementStatsImpl _$$AchievementStatsImplFromJson(
        Map<String, dynamic> json) =>
    _$AchievementStatsImpl(
      totalAchievements: (json['totalAchievements'] as num).toInt(),
      unlockedAchievements: (json['unlockedAchievements'] as num).toInt(),
      lockedAchievements: (json['lockedAchievements'] as num).toInt(),
      completionPercentage: (json['completionPercentage'] as num).toDouble(),
      categoryStats: (json['categoryStats'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry($enumDecode(_$AchievementCategoryEnumMap, k),
                (e as num).toInt()),
          ) ??
          const {},
    );

Map<String, dynamic> _$$AchievementStatsImplToJson(
        _$AchievementStatsImpl instance) =>
    <String, dynamic>{
      'totalAchievements': instance.totalAchievements,
      'unlockedAchievements': instance.unlockedAchievements,
      'lockedAchievements': instance.lockedAchievements,
      'completionPercentage': instance.completionPercentage,
      'categoryStats': instance.categoryStats
          .map((k, e) => MapEntry(_$AchievementCategoryEnumMap[k]!, e)),
    };

const _$AchievementCategoryEnumMap = {
  AchievementCategory.streaks: 'streaks',
  AchievementCategory.completions: 'completions',
  AchievementCategory.speed: 'speed',
  AchievementCategory.special: 'special',
  AchievementCategory.levels: 'levels',
  AchievementCategory.xp: 'xp',
  AchievementCategory.tasks: 'tasks',
  AchievementCategory.time: 'time',
};
