import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
class CompanyModel with _$CompanyModel {
  const factory CompanyModel({
    required String id,
    required String name,
    String? description,

    // Contact information
    String? website,
    String? email,
    String? phone,
    String? fax,

    // Address
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? country,

    // Company details
    String? industry,
    int? employeeCount,
    double? annualRevenue,
    String? taxId,

    // Logo
    String? logoUrl,

    // CRM fields
    CompanyStatus? status,
    CompanySize? size,

    // Relations
    @Default([]) List<String> clientIds,
    @Default([]) List<String> dealIds,

    // Social media
    String? linkedinUrl,
    String? twitterUrl,
    String? facebookUrl,

    // Dates
    DateTime? foundedDate,
    DateTime? createdAt,
    DateTime? updatedAt,

    // Additional info
    String? notes,
    @Default([]) List<String> tags,
    Map<String, dynamic>? customFields,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);
}

enum CompanyStatus {
  active,
  inactive,
  prospect,
  partner,
  vendor,
}

enum CompanySize {
  startup, // 1-10
  small, // 11-50
  medium, // 51-200
  large, // 201-1000
  enterprise, // 1000+
}

extension CompanyStatusExtension on CompanyStatus {
  String get displayName {
    switch (this) {
      case CompanyStatus.active:
        return 'Active';
      case CompanyStatus.inactive:
        return 'Inactive';
      case CompanyStatus.prospect:
        return 'Prospect';
      case CompanyStatus.partner:
        return 'Partner';
      case CompanyStatus.vendor:
        return 'Vendor';
    }
  }

  String get color {
    switch (this) {
      case CompanyStatus.active:
        return '0xFF4CAF50'; // Green
      case CompanyStatus.inactive:
        return '0xFF9E9E9E'; // Grey
      case CompanyStatus.prospect:
        return '0xFFFFB74D'; // Orange
      case CompanyStatus.partner:
        return '0xFF2196F3'; // Blue
      case CompanyStatus.vendor:
        return '0xFF9C27B0'; // Purple
    }
  }
}

extension CompanySizeExtension on CompanySize {
  String get displayName {
    switch (this) {
      case CompanySize.startup:
        return 'Startup (1-10)';
      case CompanySize.small:
        return 'Small (11-50)';
      case CompanySize.medium:
        return 'Medium (51-200)';
      case CompanySize.large:
        return 'Large (201-1000)';
      case CompanySize.enterprise:
        return 'Enterprise (1000+)';
    }
  }
}
