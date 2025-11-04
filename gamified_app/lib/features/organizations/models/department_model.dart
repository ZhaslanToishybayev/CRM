/// Department Model
/// Represents a department within an organization

import 'package:freezed_annotation/freezed_annotation.dart';

part 'department_model.freezed.dart';
part 'department_model.g.dart';

@freezed
class DepartmentModel with _$DepartmentModel {
  const factory DepartmentModel({
    required String id,
    required String organizationId,
    required String name,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,

    // Optional fields
    String? description,
    String? icon, // Icon name or URL
    int? memberCount,
    String? color, // Hex color for UI
  }) = _DepartmentModel;

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentModelFromJson(json);

  /// Create a copy with updated fields
  DepartmentModel copyWith({
    String? id,
    String? organizationId,
    String? name,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    String? icon,
    int? memberCount,
    String? color,
  }) {
    return DepartmentModel(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      memberCount: memberCount ?? this.memberCount,
      color: color ?? this.color,
    );
  }
}
