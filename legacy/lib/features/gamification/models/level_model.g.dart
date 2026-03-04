// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LevelInfoImpl _$$LevelInfoImplFromJson(Map<String, dynamic> json) =>
    _$LevelInfoImpl(
      level: (json['level'] as num).toInt(),
      requiredXP: (json['requiredXP'] as num).toInt(),
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$$LevelInfoImplToJson(_$LevelInfoImpl instance) =>
    <String, dynamic>{
      'level': instance.level,
      'requiredXP': instance.requiredXP,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'color': instance.color,
    };
