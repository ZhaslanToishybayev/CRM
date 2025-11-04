/// Team Model
/// Represents a team within a department

import 'package:freezed_annotation/freezed_annotation.dart';
import 'team_member_model.dart';

part 'team_model.freezed.dart';
part 'team_model.g.dart';

@freezed
class TeamModel with _$TeamModel {
  const factory TeamModel({
    required String id,
    required String name,
    required String departmentId,
    required String organizationId,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,

    // Team metadata
    String? description,
    String? icon, // Icon name or URL
    String? color, // Hex color for UI
    int? memberLimit, // Maximum number of members

    // Current state
    @Default(0) int activeMembers,
    @Default(0) int totalTasks,
    @Default(0) int completedTasks,
  }) = _TeamModel;

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);

  /// Create a copy with updated fields
  TeamModel copyWith({
    String? id,
    String? name,
    String? departmentId,
    String? organizationId,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    String? icon,
    String? color,
    int? memberLimit,
    int? activeMembers,
    int? totalTasks,
    int? completedTasks,
  }) {
    return TeamModel(
      id: id ?? this.id,
      name: name ?? this.name,
      departmentId: departmentId ?? this.departmentId,
      organizationId: organizationId ?? this.organizationId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      memberLimit: memberLimit ?? this.memberLimit,
      activeMembers: activeMembers ?? this.activeMembers,
      totalTasks: totalTasks ?? this.totalTasks,
      completedTasks: completedTasks ?? this.completedTasks,
    );
  }

  /// Calculate completion percentage
  double get completionPercentage {
    if (totalTasks == 0) return 0.0;
    return (completedTasks / totalTasks) * 100;
  }

  /// Check if team is at capacity
  bool get isAtCapacity {
    if (memberLimit == null) return false;
    return activeMembers >= memberLimit!;
  }
}

/// Helper extensions for TeamModel
extension TeamModelExtensions on TeamModel {
  /// Get display name for team
  String get displayName => name;

  /// Get team status based on activity
  String get status {
    if (completedTasks == 0 && totalTasks == 0) return 'Planning';
    if (completedTasks == totalTasks) return 'Completed';
    if (completedTasks > 0) return 'Active';
    return 'Inactive';
  }

  /// Get team color or default
  String get displayColor => color ?? '#2196F3'; // Default blue
}
