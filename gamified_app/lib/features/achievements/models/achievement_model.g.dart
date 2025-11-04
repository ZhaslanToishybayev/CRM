// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AchievementModelImpl _$$AchievementModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AchievementModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$AchievementCategoryEnumMap, json['category']),
      rarity: $enumDecode(_$AchievementRarityEnumMap, json['rarity']),
      icon: json['icon'] as String,
      color: json['color'] as String,
      condition: json['condition'] as String,
      targetValue: (json['targetValue'] as num).toInt(),
      xpReward: (json['xpReward'] as num).toInt(),
      hint: json['hint'] as String?,
      isHidden: json['isHidden'] as bool? ?? false,
    );

Map<String, dynamic> _$$AchievementModelImplToJson(
        _$AchievementModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': _$AchievementCategoryEnumMap[instance.category]!,
      'rarity': _$AchievementRarityEnumMap[instance.rarity]!,
      'icon': instance.icon,
      'color': instance.color,
      'condition': instance.condition,
      'targetValue': instance.targetValue,
      'xpReward': instance.xpReward,
      'hint': instance.hint,
      'isHidden': instance.isHidden,
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

const _$AchievementRarityEnumMap = {
  AchievementRarity.common: 'common',
  AchievementRarity.rare: 'rare',
  AchievementRarity.epic: 'epic',
  AchievementRarity.legendary: 'legendary',
  AchievementRarity.mythic: 'mythic',
};

_$UserAchievementImpl _$$UserAchievementImplFromJson(
        Map<String, dynamic> json) =>
    _$UserAchievementImpl(
      id: json['id'] as String,
      achievementId: json['achievementId'] as String,
      userId: json['userId'] as String,
      unlockedAt: DateTime.parse(json['unlockedAt'] as String),
      progress: (json['progress'] as num).toInt(),
      isUnlocked: json['isUnlocked'] as bool,
    );

Map<String, dynamic> _$$UserAchievementImplToJson(
        _$UserAchievementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'achievementId': instance.achievementId,
      'userId': instance.userId,
      'unlockedAt': instance.unlockedAt.toIso8601String(),
      'progress': instance.progress,
      'isUnlocked': instance.isUnlocked,
    };
