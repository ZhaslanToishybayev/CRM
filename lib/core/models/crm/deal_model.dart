import 'package:freezed_annotation/freezed_annotation.dart';

part 'deal_model.freezed.dart';
part 'deal_model.g.dart';

@freezed
class DealModel with _$DealModel {
  const factory DealModel({
    required String id,
    required String title,
    String? description,

    // Financial details
    required double amount,
    String? currency,
    double? probability, // 0-100

    // Dates
    DateTime? closeDate,
    DateTime? createdAt,
    DateTime? updatedAt,

    // Relations
    required String clientId,
    String? clientName,
    String? companyId,
    String? companyName,

    // Pipeline
    required String stageId,
    String? stageName,
    required int stageOrder,

    // Status
    required DealStatus status,
    DealSource? source,

    // Assigned user
    String? assignedTo,
    String? assignedToName,

    // Products/Services
    @Default([]) List<DealProduct> products,

    // Tracking
    String? notes,
    @Default([]) List<String> tags,
    Map<String, dynamic>? customFields,
  }) = _DealModel;

  factory DealModel.fromJson(Map<String, dynamic> json) =>
      _$DealModelFromJson(json);
}

enum DealStatus {
  open,
  won,
  lost,
  onHold,
}

enum DealSource {
  inbound,
  outbound,
  referral,
  partner,
  website,
  coldCall,
  email,
  event,
  advertisement,
  other,
}

@freezed
class DealProduct with _$DealProduct {
  const factory DealProduct({
    required String productId,
    required String productName,
    required double quantity,
    required double unitPrice,
    required double totalPrice,
  }) = _DealProduct;

  factory DealProduct.fromJson(Map<String, dynamic> json) =>
      _$DealProductFromJson(json);
}

extension DealStatusExtension on DealStatus {
  String get displayName {
    switch (this) {
      case DealStatus.open:
        return 'Open';
      case DealStatus.won:
        return 'Won';
      case DealStatus.lost:
        return 'Lost';
      case DealStatus.onHold:
        return 'On Hold';
    }
  }

  String get color {
    switch (this) {
      case DealStatus.open:
        return '0xFF2196F3'; // Blue
      case DealStatus.won:
        return '0xFF4CAF50'; // Green
      case DealStatus.lost:
        return '0xFFF44336'; // Red
      case DealStatus.onHold:
        return '0xFFFF9800'; // Orange
    }
  }
}

extension DealSourceExtension on DealSource {
  String get displayName {
    switch (this) {
      case DealSource.inbound:
        return 'Inbound';
      case DealSource.outbound:
        return 'Outbound';
      case DealSource.referral:
        return 'Referral';
      case DealSource.partner:
        return 'Partner';
      case DealSource.website:
        return 'Website';
      case DealSource.coldCall:
        return 'Cold Call';
      case DealSource.email:
        return 'Email';
      case DealSource.event:
        return 'Event';
      case DealSource.advertisement:
        return 'Advertisement';
      case DealSource.other:
        return 'Other';
    }
  }
}
