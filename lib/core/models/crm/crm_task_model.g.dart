// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crm_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CrmTaskModelImpl _$$CrmTaskModelImplFromJson(Map<String, dynamic> json) =>
    _$CrmTaskModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String?,
      companyId: json['companyId'] as String?,
      companyName: json['companyName'] as String?,
      dealId: json['dealId'] as String?,
      dealName: json['dealName'] as String?,
      type: $enumDecode(_$TaskTypeEnumMap, json['type']),
      priority: $enumDecodeNullable(_$TaskPriorityEnumMap, json['priority']),
      status: $enumDecodeNullable(_$TaskStatusEnumMap, json['status']),
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      assignedTo: json['assignedTo'] as String?,
      assignedToName: json['assignedToName'] as String?,
      createdBy: json['createdBy'] as String,
      reminders: (json['reminders'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
      notes: json['notes'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      customFields: json['customFields'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CrmTaskModelImplToJson(_$CrmTaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'dealId': instance.dealId,
      'dealName': instance.dealName,
      'type': _$TaskTypeEnumMap[instance.type]!,
      'priority': _$TaskPriorityEnumMap[instance.priority],
      'status': _$TaskStatusEnumMap[instance.status],
      'dueDate': instance.dueDate?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'assignedTo': instance.assignedTo,
      'assignedToName': instance.assignedToName,
      'createdBy': instance.createdBy,
      'reminders': instance.reminders.map((e) => e.toIso8601String()).toList(),
      'notes': instance.notes,
      'tags': instance.tags,
      'customFields': instance.customFields,
    };

const _$TaskTypeEnumMap = {
  TaskType.call: 'call',
  TaskType.email: 'email',
  TaskType.meeting: 'meeting',
  TaskType.followUp: 'followUp',
  TaskType.demo: 'demo',
  TaskType.proposal: 'proposal',
  TaskType.contract: 'contract',
  TaskType.support: 'support',
  TaskType.other: 'other',
};

const _$TaskPriorityEnumMap = {
  TaskPriority.low: 'low',
  TaskPriority.medium: 'medium',
  TaskPriority.high: 'high',
  TaskPriority.urgent: 'urgent',
};

const _$TaskStatusEnumMap = {
  TaskStatus.pending: 'pending',
  TaskStatus.inProgress: 'inProgress',
  TaskStatus.completed: 'completed',
  TaskStatus.cancelled: 'cancelled',
  TaskStatus.overdue: 'overdue',
};
