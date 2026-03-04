// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyModelImpl _$$CompanyModelImplFromJson(Map<String, dynamic> json) =>
    _$CompanyModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      website: json['website'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      fax: json['fax'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zipCode'] as String?,
      country: json['country'] as String?,
      industry: json['industry'] as String?,
      employeeCount: (json['employeeCount'] as num?)?.toInt(),
      annualRevenue: (json['annualRevenue'] as num?)?.toDouble(),
      taxId: json['taxId'] as String?,
      logoUrl: json['logoUrl'] as String?,
      status: $enumDecodeNullable(_$CompanyStatusEnumMap, json['status']),
      size: $enumDecodeNullable(_$CompanySizeEnumMap, json['size']),
      clientIds: (json['clientIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      dealIds: (json['dealIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      linkedinUrl: json['linkedinUrl'] as String?,
      twitterUrl: json['twitterUrl'] as String?,
      facebookUrl: json['facebookUrl'] as String?,
      foundedDate: json['foundedDate'] == null
          ? null
          : DateTime.parse(json['foundedDate'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      notes: json['notes'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      customFields: json['customFields'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CompanyModelImplToJson(_$CompanyModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'website': instance.website,
      'email': instance.email,
      'phone': instance.phone,
      'fax': instance.fax,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'country': instance.country,
      'industry': instance.industry,
      'employeeCount': instance.employeeCount,
      'annualRevenue': instance.annualRevenue,
      'taxId': instance.taxId,
      'logoUrl': instance.logoUrl,
      'status': _$CompanyStatusEnumMap[instance.status],
      'size': _$CompanySizeEnumMap[instance.size],
      'clientIds': instance.clientIds,
      'dealIds': instance.dealIds,
      'linkedinUrl': instance.linkedinUrl,
      'twitterUrl': instance.twitterUrl,
      'facebookUrl': instance.facebookUrl,
      'foundedDate': instance.foundedDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'notes': instance.notes,
      'tags': instance.tags,
      'customFields': instance.customFields,
    };

const _$CompanyStatusEnumMap = {
  CompanyStatus.active: 'active',
  CompanyStatus.inactive: 'inactive',
  CompanyStatus.prospect: 'prospect',
  CompanyStatus.partner: 'partner',
  CompanyStatus.vendor: 'vendor',
};

const _$CompanySizeEnumMap = {
  CompanySize.startup: 'startup',
  CompanySize.small: 'small',
  CompanySize.medium: 'medium',
  CompanySize.large: 'large',
  CompanySize.enterprise: 'enterprise',
};
