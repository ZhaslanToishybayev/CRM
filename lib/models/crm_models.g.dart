// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crm_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientImpl _$$ClientImplFromJson(Map<String, dynamic> json) => _$ClientImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      company: json['company'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      status: $enumDecode(_$ClientStatusEnumMap, json['status']),
      source: json['source'] as String,
      assignedTo: json['assignedTo'] as String,
      value: (json['value'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ClientImplToJson(_$ClientImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'company': instance.company,
      'email': instance.email,
      'phone': instance.phone,
      'status': _$ClientStatusEnumMap[instance.status]!,
      'source': instance.source,
      'assignedTo': instance.assignedTo,
      'value': instance.value,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$ClientStatusEnumMap = {
  ClientStatus.lead: 'lead',
  ClientStatus.prospect: 'prospect',
  ClientStatus.active: 'active',
  ClientStatus.inactive: 'inactive',
};

_$DealImpl _$$DealImplFromJson(Map<String, dynamic> json) => _$DealImpl(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      value: (json['value'] as num).toDouble(),
      stage: $enumDecode(_$DealStageEnumMap, json['stage']),
      probability: (json['probability'] as num).toInt(),
      expectedCloseDate: DateTime.parse(json['expectedCloseDate'] as String),
      assignedTo: json['assignedTo'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DealImplToJson(_$DealImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'title': instance.title,
      'description': instance.description,
      'value': instance.value,
      'stage': _$DealStageEnumMap[instance.stage]!,
      'probability': instance.probability,
      'expectedCloseDate': instance.expectedCloseDate.toIso8601String(),
      'assignedTo': instance.assignedTo,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$DealStageEnumMap = {
  DealStage.newLead: 'newLead',
  DealStage.qualified: 'qualified',
  DealStage.proposal: 'proposal',
  DealStage.negotiation: 'negotiation',
  DealStage.closedWon: 'closedWon',
  DealStage.closedLost: 'closedLost',
};

_$ActivityImpl _$$ActivityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityImpl(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      dealId: json['dealId'] as String?,
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
      description: json['description'] as String,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      status: $enumDecode(_$ActivityStatusEnumMap, json['status']),
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$$ActivityImplToJson(_$ActivityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'dealId': instance.dealId,
      'type': _$ActivityTypeEnumMap[instance.type]!,
      'description': instance.description,
      'scheduledAt': instance.scheduledAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'status': _$ActivityStatusEnumMap[instance.status]!,
      'createdBy': instance.createdBy,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.call: 'call',
  ActivityType.email: 'email',
  ActivityType.meeting: 'meeting',
  ActivityType.note: 'note',
  ActivityType.reminder: 'reminder',
};

const _$ActivityStatusEnumMap = {
  ActivityStatus.pending: 'pending',
  ActivityStatus.completed: 'completed',
};

_$SalesStatsImpl _$$SalesStatsImplFromJson(Map<String, dynamic> json) =>
    _$SalesStatsImpl(
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      totalDeals: (json['totalDeals'] as num).toInt(),
      conversionRate: (json['conversionRate'] as num).toDouble(),
      averageDealSize: (json['averageDealSize'] as num).toDouble(),
      stageStats: (json['stageStats'] as List<dynamic>)
          .map((e) => DealStageStats.fromJson(e as Map<String, dynamic>))
          .toList(),
      monthlyRevenue: (json['monthlyRevenue'] as List<dynamic>)
          .map((e) => MonthlyRevenue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SalesStatsImplToJson(_$SalesStatsImpl instance) =>
    <String, dynamic>{
      'totalRevenue': instance.totalRevenue,
      'totalDeals': instance.totalDeals,
      'conversionRate': instance.conversionRate,
      'averageDealSize': instance.averageDealSize,
      'stageStats': instance.stageStats,
      'monthlyRevenue': instance.monthlyRevenue,
    };

_$DealStageStatsImpl _$$DealStageStatsImplFromJson(Map<String, dynamic> json) =>
    _$DealStageStatsImpl(
      stage: $enumDecode(_$DealStageEnumMap, json['stage']),
      count: (json['count'] as num).toInt(),
      totalValue: (json['totalValue'] as num).toDouble(),
    );

Map<String, dynamic> _$$DealStageStatsImplToJson(
        _$DealStageStatsImpl instance) =>
    <String, dynamic>{
      'stage': _$DealStageEnumMap[instance.stage]!,
      'count': instance.count,
      'totalValue': instance.totalValue,
    };

_$MonthlyRevenueImpl _$$MonthlyRevenueImplFromJson(Map<String, dynamic> json) =>
    _$MonthlyRevenueImpl(
      month: json['month'] as String,
      revenue: (json['revenue'] as num).toDouble(),
    );

Map<String, dynamic> _$$MonthlyRevenueImplToJson(
        _$MonthlyRevenueImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'revenue': instance.revenue,
    };
