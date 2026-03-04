// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DealModelImpl _$$DealModelImplFromJson(Map<String, dynamic> json) =>
    _$DealModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String?,
      probability: (json['probability'] as num?)?.toDouble(),
      closeDate: json['closeDate'] == null
          ? null
          : DateTime.parse(json['closeDate'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      clientId: json['clientId'] as String,
      clientName: json['clientName'] as String?,
      companyId: json['companyId'] as String?,
      companyName: json['companyName'] as String?,
      stageId: json['stageId'] as String,
      stageName: json['stageName'] as String?,
      stageOrder: (json['stageOrder'] as num).toInt(),
      status: $enumDecode(_$DealStatusEnumMap, json['status']),
      source: $enumDecodeNullable(_$DealSourceEnumMap, json['source']),
      assignedTo: json['assignedTo'] as String?,
      assignedToName: json['assignedToName'] as String?,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => DealProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      notes: json['notes'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      customFields: json['customFields'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$DealModelImplToJson(_$DealModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'amount': instance.amount,
      'currency': instance.currency,
      'probability': instance.probability,
      'closeDate': instance.closeDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'stageId': instance.stageId,
      'stageName': instance.stageName,
      'stageOrder': instance.stageOrder,
      'status': _$DealStatusEnumMap[instance.status]!,
      'source': _$DealSourceEnumMap[instance.source],
      'assignedTo': instance.assignedTo,
      'assignedToName': instance.assignedToName,
      'products': instance.products,
      'notes': instance.notes,
      'tags': instance.tags,
      'customFields': instance.customFields,
    };

const _$DealStatusEnumMap = {
  DealStatus.open: 'open',
  DealStatus.won: 'won',
  DealStatus.lost: 'lost',
  DealStatus.onHold: 'onHold',
};

const _$DealSourceEnumMap = {
  DealSource.inbound: 'inbound',
  DealSource.outbound: 'outbound',
  DealSource.referral: 'referral',
  DealSource.partner: 'partner',
  DealSource.website: 'website',
  DealSource.coldCall: 'coldCall',
  DealSource.email: 'email',
  DealSource.event: 'event',
  DealSource.advertisement: 'advertisement',
  DealSource.other: 'other',
};

_$DealProductImpl _$$DealProductImplFromJson(Map<String, dynamic> json) =>
    _$DealProductImpl(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$DealProductImplToJson(_$DealProductImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'totalPrice': instance.totalPrice,
    };
