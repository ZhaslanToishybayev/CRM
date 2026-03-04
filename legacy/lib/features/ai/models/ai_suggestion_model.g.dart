// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_suggestion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AISuggestionImpl _$$AISuggestionImplFromJson(Map<String, dynamic> json) =>
    _$AISuggestionImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$AISuggestionTypeEnumMap, json['type']),
      priority: (json['priority'] as num).toInt(),
      confidence: (json['confidence'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      reasons: (json['reasons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AISuggestionImplToJson(_$AISuggestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$AISuggestionTypeEnumMap[instance.type]!,
      'priority': instance.priority,
      'confidence': instance.confidence,
      'createdAt': instance.createdAt.toIso8601String(),
      'reasons': instance.reasons,
      'metadata': instance.metadata,
    };

const _$AISuggestionTypeEnumMap = {
  AISuggestionType.taskCreation: 'taskCreation',
  AISuggestionType.taskScheduling: 'taskScheduling',
  AISuggestionType.priorityAdjustment: 'priorityAdjustment',
  AISuggestionType.taskGrouping: 'taskGrouping',
  AISuggestionType.deadlineOptimization: 'deadlineOptimization',
  AISuggestionType.workloadBalancing: 'workloadBalancing',
  AISuggestionType.skillMatching: 'skillMatching',
  AISuggestionType.timeEstimation: 'timeEstimation',
  AISuggestionType.delegation: 'delegation',
  AISuggestionType.resourceOptimization: 'resourceOptimization',
};
