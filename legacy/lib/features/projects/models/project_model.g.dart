// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectModelImpl _$$ProjectModelImplFromJson(Map<String, dynamic> json) =>
    _$ProjectModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      organizationId: json['organizationId'] as String,
      createdBy: json['createdBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      color: json['color'] as String?,
      teamId: json['teamId'] as String?,
      departmentId: json['departmentId'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      status: $enumDecodeNullable(_$ProjectStatusEnumMap, json['status']) ??
          ProjectStatus.planning,
      priority:
          $enumDecodeNullable(_$ProjectPriorityEnumMap, json['priority']) ??
              ProjectPriority.medium,
      totalTasks: (json['totalTasks'] as num?)?.toInt() ?? 0,
      completedTasks: (json['completedTasks'] as num?)?.toInt() ?? 0,
      totalBudget: (json['totalBudget'] as num?)?.toInt() ?? 0,
      spentBudget: (json['spentBudget'] as num?)?.toInt() ?? 0,
      memberIds: (json['memberIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      completionPercentage:
          (json['completionPercentage'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ProjectModelImplToJson(_$ProjectModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'organizationId': instance.organizationId,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'description': instance.description,
      'icon': instance.icon,
      'color': instance.color,
      'teamId': instance.teamId,
      'departmentId': instance.departmentId,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'status': _$ProjectStatusEnumMap[instance.status]!,
      'priority': _$ProjectPriorityEnumMap[instance.priority]!,
      'totalTasks': instance.totalTasks,
      'completedTasks': instance.completedTasks,
      'totalBudget': instance.totalBudget,
      'spentBudget': instance.spentBudget,
      'memberIds': instance.memberIds,
      'completionPercentage': instance.completionPercentage,
    };

const _$ProjectStatusEnumMap = {
  ProjectStatus.planning: 'planning',
  ProjectStatus.active: 'active',
  ProjectStatus.onHold: 'onHold',
  ProjectStatus.completed: 'completed',
  ProjectStatus.cancelled: 'cancelled',
};

const _$ProjectPriorityEnumMap = {
  ProjectPriority.low: 'low',
  ProjectPriority.medium: 'medium',
  ProjectPriority.high: 'high',
  ProjectPriority.critical: 'critical',
};
