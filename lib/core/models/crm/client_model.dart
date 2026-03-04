import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_model.freezed.dart';
part 'client_model.g.dart';

@freezed
class ClientModel with _$ClientModel {
  const factory ClientModel({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
    String? position,
    String? avatarUrl,

    // Company relation
    String? companyId,
    String? companyName,

    // Contact details
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? country,

    // CRM fields
    ClientSource? source,
    ClientStatus? status,
    int? lifetimeValue,
    DateTime? lastContactDate,
    DateTime? createdAt,
    DateTime? updatedAt,

    // Tags and custom fields
    @Default([]) List<String> tags,
    Map<String, dynamic>? customFields,

    // Notes
    String? notes,
  }) = _ClientModel;

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);
}

enum ClientSource {
  website,
  referral,
  coldCall,
  email,
  socialMedia,
  event,
  advertisement,
  partner,
  other,
}

enum ClientStatus {
  lead,
  prospect,
  active,
  inactive,
  churned,
}

extension ClientSourceExtension on ClientSource {
  String get displayName {
    switch (this) {
      case ClientSource.website:
        return 'Website';
      case ClientSource.referral:
        return 'Referral';
      case ClientSource.coldCall:
        return 'Cold Call';
      case ClientSource.email:
        return 'Email';
      case ClientSource.socialMedia:
        return 'Social Media';
      case ClientSource.event:
        return 'Event';
      case ClientSource.advertisement:
        return 'Advertisement';
      case ClientSource.partner:
        return 'Partner';
      case ClientSource.other:
        return 'Other';
    }
  }
}

extension ClientStatusExtension on ClientStatus {
  String get displayName {
    switch (this) {
      case ClientStatus.lead:
        return 'Lead';
      case ClientStatus.prospect:
        return 'Prospect';
      case ClientStatus.active:
        return 'Active';
      case ClientStatus.inactive:
        return 'Inactive';
      case ClientStatus.churned:
        return 'Churned';
    }
  }

  String get color {
    switch (this) {
      case ClientStatus.lead:
        return '0xFF9E9E9E'; // Grey
      case ClientStatus.prospect:
        return '0xFFFFB74D'; // Orange
      case ClientStatus.active:
        return '0xFF4CAF50'; // Green
      case ClientStatus.inactive:
        return '0xFFFF9800'; // Deep Orange
      case ClientStatus.churned:
        return '0xFFF44336'; // Red
    }
  }
}
