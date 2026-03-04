// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkTaskModelImpl _$$WorkTaskModelImplFromJson(Map<String, dynamic> json) =>
    _$WorkTaskModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      xp: (json['xp'] as num).toInt(),
      priority: $enumDecode(_$WorkTaskPriorityEnumMap, json['priority']),
      progress: $enumDecode(_$WorkTaskProgressEnumMap, json['progress']),
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      category: json['category'] as String?,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      organizationId: json['organizationId'] as String,
      projectId: json['projectId'] as String?,
      departmentId: json['departmentId'] as String?,
      teamId: json['teamId'] as String?,
      assignedBy: json['assignedBy'] as String?,
      assignedTo: (json['assignedTo'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      assigneeNote: json['assigneeNote'] as String?,
      type: $enumDecode(_$WorkTaskTypeEnumMap, json['type']),
      source: $enumDecode(_$WorkTaskSourceEnumMap, json['source']),
      estimatedHours: (json['estimatedHours'] as num?)?.toInt(),
      actualHours: (json['actualHours'] as num?)?.toInt(),
      billable: json['billable'] as bool? ?? false,
      parentTaskId: json['parentTaskId'] as String?,
      subtaskIds: (json['subtaskIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      qualityRating: (json['qualityRating'] as num?)?.toInt(),
      managerFeedback: json['managerFeedback'] as String?,
      timeSpent: (json['timeSpent'] as num?)?.toInt() ?? 0,
      lastActivityAt: json['lastActivityAt'] == null
          ? null
          : DateTime.parse(json['lastActivityAt'] as String),
      watcherIds: (json['watcherIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      commentIds: (json['commentIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$WorkTaskModelImplToJson(_$WorkTaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'xp': instance.xp,
      'priority': _$WorkTaskPriorityEnumMap[instance.priority]!,
      'progress': _$WorkTaskProgressEnumMap[instance.progress]!,
      'dueDate': instance.dueDate?.toIso8601String(),
      'startDate': instance.startDate?.toIso8601String(),
      'category': instance.category,
      'completedAt': instance.completedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'organizationId': instance.organizationId,
      'projectId': instance.projectId,
      'departmentId': instance.departmentId,
      'teamId': instance.teamId,
      'assignedBy': instance.assignedBy,
      'assignedTo': instance.assignedTo,
      'assigneeNote': instance.assigneeNote,
      'type': _$WorkTaskTypeEnumMap[instance.type]!,
      'source': _$WorkTaskSourceEnumMap[instance.source]!,
      'estimatedHours': instance.estimatedHours,
      'actualHours': instance.actualHours,
      'billable': instance.billable,
      'parentTaskId': instance.parentTaskId,
      'subtaskIds': instance.subtaskIds,
      'qualityRating': instance.qualityRating,
      'managerFeedback': instance.managerFeedback,
      'timeSpent': instance.timeSpent,
      'lastActivityAt': instance.lastActivityAt?.toIso8601String(),
      'watcherIds': instance.watcherIds,
      'commentIds': instance.commentIds,
    };

const _$WorkTaskPriorityEnumMap = {
  WorkTaskPriority.low: 'low',
  WorkTaskPriority.medium: 'medium',
  WorkTaskPriority.high: 'high',
  WorkTaskPriority.urgent: 'urgent',
  WorkTaskPriority.critical: 'critical',
};

const _$WorkTaskProgressEnumMap = {
  WorkTaskProgress.notStarted: 'notStarted',
  WorkTaskProgress.inProgress: 'inProgress',
  WorkTaskProgress.review: 'review',
  WorkTaskProgress.completed: 'completed',
};

const _$WorkTaskTypeEnumMap = {
  WorkTaskType.personal: 'personal',
  WorkTaskType.project: 'project',
  WorkTaskType.team: 'team',
};

const _$WorkTaskSourceEnumMap = {
  WorkTaskSource.manual: 'manual',
  WorkTaskSource.email: 'email',
  WorkTaskSource.calendar: 'calendar',
  WorkTaskSource.slack: 'slack',
  WorkTaskSource.manager: 'manager',
};
