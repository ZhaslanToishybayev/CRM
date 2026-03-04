// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityModelImpl _$$ActivityModelImplFromJson(Map<String, dynamic> json) =>
    _$ActivityModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String?,
      companyId: json['companyId'] as String?,
      companyName: json['companyName'] as String?,
      dealId: json['dealId'] as String?,
      dealName: json['dealName'] as String?,
      taskId: json['taskId'] as String?,
      direction:
          $enumDecodeNullable(_$ActivityDirectionEnumMap, json['direction']),
      subject: json['subject'] as String?,
      outcome: json['outcome'] as String?,
      participants: (json['participants'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      emailRecipients: (json['emailRecipients'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      callPhoneNumber: json['callPhoneNumber'] as String?,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      scheduledAt: json['scheduledAt'] == null
          ? null
          : DateTime.parse(json['scheduledAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      createdBy: json['createdBy'] as String,
      createdByName: json['createdByName'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$ActivityModelImplToJson(_$ActivityModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$ActivityTypeEnumMap[instance.type]!,
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'dealId': instance.dealId,
      'dealName': instance.dealName,
      'taskId': instance.taskId,
      'direction': _$ActivityDirectionEnumMap[instance.direction],
      'subject': instance.subject,
      'outcome': instance.outcome,
      'participants': instance.participants,
      'emailRecipients': instance.emailRecipients,
      'callPhoneNumber': instance.callPhoneNumber,
      'durationMinutes': instance.durationMinutes,
      'createdAt': instance.createdAt.toIso8601String(),
      'scheduledAt': instance.scheduledAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'createdBy': instance.createdBy,
      'createdByName': instance.createdByName,
      'metadata': instance.metadata,
      'attachments': instance.attachments,
      'tags': instance.tags,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.call: 'call',
  ActivityType.email: 'email',
  ActivityType.meeting: 'meeting',
  ActivityType.note: 'note',
  ActivityType.task: 'task',
  ActivityType.deal: 'deal',
  ActivityType.sms: 'sms',
  ActivityType.videoCall: 'videoCall',
  ActivityType.social: 'social',
  ActivityType.other: 'other',
};

const _$ActivityDirectionEnumMap = {
  ActivityDirection.inbound: 'inbound',
  ActivityDirection.outbound: 'outbound',
};
