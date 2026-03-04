// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientModelImpl _$$ClientModelImplFromJson(Map<String, dynamic> json) =>
    _$ClientModelImpl(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      position: json['position'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      companyId: json['companyId'] as String?,
      companyName: json['companyName'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zipCode'] as String?,
      country: json['country'] as String?,
      source: $enumDecodeNullable(_$ClientSourceEnumMap, json['source']),
      status: $enumDecodeNullable(_$ClientStatusEnumMap, json['status']),
      lifetimeValue: (json['lifetimeValue'] as num?)?.toInt(),
      lastContactDate: json['lastContactDate'] == null
          ? null
          : DateTime.parse(json['lastContactDate'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      customFields: json['customFields'] as Map<String, dynamic>?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$ClientModelImplToJson(_$ClientModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'position': instance.position,
      'avatarUrl': instance.avatarUrl,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'country': instance.country,
      'source': _$ClientSourceEnumMap[instance.source],
      'status': _$ClientStatusEnumMap[instance.status],
      'lifetimeValue': instance.lifetimeValue,
      'lastContactDate': instance.lastContactDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'tags': instance.tags,
      'customFields': instance.customFields,
      'notes': instance.notes,
    };

const _$ClientSourceEnumMap = {
  ClientSource.website: 'website',
  ClientSource.referral: 'referral',
  ClientSource.coldCall: 'coldCall',
  ClientSource.email: 'email',
  ClientSource.socialMedia: 'socialMedia',
  ClientSource.event: 'event',
  ClientSource.advertisement: 'advertisement',
  ClientSource.partner: 'partner',
  ClientSource.other: 'other',
};

const _$ClientStatusEnumMap = {
  ClientStatus.lead: 'lead',
  ClientStatus.prospect: 'prospect',
  ClientStatus.active: 'active',
  ClientStatus.inactive: 'inactive',
  ClientStatus.churned: 'churned',
};
