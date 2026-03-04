/// Organization Model
/// Represents a company/organization in the corporate structure

import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_model.freezed.dart';
part 'organization_model.g.dart';

@freezed
class OrganizationModel with _$OrganizationModel {
  const factory OrganizationModel({
    required String id,
    required String name,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,

    // Optional fields
    String? description,
    String? logoUrl,
    String? industry, // IT, Finance, Healthcare, etc.
    int? employeeCount,
    String? website,
    String? email,
    String? phone,
    String? address,
  }) = _OrganizationModel;

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);

  /// Create a copy with updated fields
  OrganizationModel copyWith({
    String? id,
    String? name,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    String? logoUrl,
    String? industry,
    int? employeeCount,
    String? website,
    String? email,
    String? phone,
    String? address,
  }) {
    return OrganizationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
      industry: industry ?? this.industry,
      employeeCount: employeeCount ?? this.employeeCount,
      website: website ?? this.website,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}
