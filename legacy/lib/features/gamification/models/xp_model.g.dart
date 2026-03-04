// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$XPModelImpl _$$XPModelImplFromJson(Map<String, dynamic> json) =>
    _$XPModelImpl(
      userId: json['userId'] as String,
      totalXP: (json['totalXP'] as num).toInt(),
      currentLevel: (json['currentLevel'] as num).toInt(),
      currentLevelXP: (json['currentLevelXP'] as num).toInt(),
      nextLevelXP: (json['nextLevelXP'] as num).toInt(),
      xpToNextLevel: (json['xpToNextLevel'] as num).toInt(),
      progressToNextLevel: (json['progressToNextLevel'] as num).toDouble(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$XPModelImplToJson(_$XPModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'totalXP': instance.totalXP,
      'currentLevel': instance.currentLevel,
      'currentLevelXP': instance.currentLevelXP,
      'nextLevelXP': instance.nextLevelXP,
      'xpToNextLevel': instance.xpToNextLevel,
      'progressToNextLevel': instance.progressToNextLevel,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };
