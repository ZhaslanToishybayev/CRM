// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStatsModel _$UserStatsModelFromJson(Map<String, dynamic> json) =>
    UserStatsModel(
      sId: json['sId'] as String?,
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      xp: (json['xp'] as num?)?.toInt() ?? 0,
      level: (json['level'] as num?)?.toInt() ?? 1,
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      lastTaskDate: json['last_task_date'] == null
          ? null
          : DateTime.parse(json['last_task_date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserStatsModelToJson(UserStatsModel instance) =>
    <String, dynamic>{
      'sId': instance.sId,
      '_id': instance.id,
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'xp': instance.xp,
      'level': instance.level,
      'streak': instance.streak,
      'last_task_date': instance.lastTaskDate?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
