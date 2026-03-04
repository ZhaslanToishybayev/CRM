// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pipeline_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PipelineModelImpl _$$PipelineModelImplFromJson(Map<String, dynamic> json) =>
    _$PipelineModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      isDefault: json['isDefault'] as bool,
      stages: (json['stages'] as List<dynamic>?)
              ?.map((e) => PipelineStage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalValue: (json['totalValue'] as num?)?.toDouble(),
      totalDeals: (json['totalDeals'] as num?)?.toInt(),
      wonDeals: (json['wonDeals'] as num?)?.toInt(),
      lostDeals: (json['lostDeals'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PipelineModelImplToJson(_$PipelineModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isDefault': instance.isDefault,
      'stages': instance.stages,
      'totalValue': instance.totalValue,
      'totalDeals': instance.totalDeals,
      'wonDeals': instance.wonDeals,
      'lostDeals': instance.lostDeals,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$PipelineStageImpl _$$PipelineStageImplFromJson(Map<String, dynamic> json) =>
    _$PipelineStageImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      order: (json['order'] as num).toInt(),
      probability: (json['probability'] as num).toDouble(),
      description: json['description'] as String?,
      color: (json['color'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PipelineStageImplToJson(_$PipelineStageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'probability': instance.probability,
      'description': instance.description,
      'color': instance.color,
    };
