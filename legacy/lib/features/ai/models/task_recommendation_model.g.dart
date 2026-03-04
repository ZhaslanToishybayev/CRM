// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskRecommendationImpl _$$TaskRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$TaskRecommendationImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      estimatedDuration: (json['estimatedDuration'] as num).toInt(),
      recommendedDueDate: DateTime.parse(json['recommendedDueDate'] as String),
      suggestedPriority: (json['suggestedPriority'] as num).toInt(),
      suggestedCategory: json['suggestedCategory'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      matchScore: (json['matchScore'] as num).toDouble(),
      context: json['context'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$TaskRecommendationImplToJson(
        _$TaskRecommendationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'estimatedDuration': instance.estimatedDuration,
      'recommendedDueDate': instance.recommendedDueDate.toIso8601String(),
      'suggestedPriority': instance.suggestedPriority,
      'suggestedCategory': instance.suggestedCategory,
      'tags': instance.tags,
      'matchScore': instance.matchScore,
      'context': instance.context,
    };

_$AIInsightImpl _$$AIInsightImplFromJson(Map<String, dynamic> json) =>
    _$AIInsightImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      importance: (json['importance'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      actions: (json['actions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AIInsightImplToJson(_$AIInsightImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'message': instance.message,
      'importance': instance.importance,
      'createdAt': instance.createdAt.toIso8601String(),
      'actions': instance.actions,
      'data': instance.data,
    };
