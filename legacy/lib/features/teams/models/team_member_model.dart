/// Team Member Model
/// Represents a member of a team with their role and status

import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_member_model.freezed.dart';
part 'team_member_model.g.dart';

/// Role of a team member
enum TeamMemberRole {
  employee,  // Regular employee
  manager,   // Team manager
  admin,     // Team administrator
}

/// Status of team membership
enum TeamMemberStatus {
  active,    // Currently active member
  inactive,  // Temporarily inactive
  pending,   // Invitation sent, waiting for acceptance
}

@freezed
class TeamMemberModel with _$TeamMemberModel {
  const factory TeamMemberModel({
    required String id,
    required String teamId,
    required String userId,
    required TeamMemberRole role,
    required TeamMemberStatus status,
    required DateTime joinedAt,
    DateTime? lastActiveAt,
    String? addedBy, // Who added this member
  }) = _TeamMemberModel;

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMemberModelFromJson(json);

  /// Create a copy with updated fields
  TeamMemberModel copyWith({
    String? id,
    String? teamId,
    String? userId,
    TeamMemberRole? role,
    TeamMemberStatus? status,
    DateTime? joinedAt,
    DateTime? lastActiveAt,
    String? addedBy,
  }) {
    return TeamMemberModel(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      addedBy: addedBy ?? this.addedBy,
    );
  }
}

/// Helper extensions
extension TeamMemberRoleExtensions on TeamMemberRole {
  /// Get display name for UI
  String get displayName {
    switch (this) {
      case TeamMemberRole.employee:
        return 'Employee';
      case TeamMemberRole.manager:
        return 'Manager';
      case TeamMemberRole.admin:
        return 'Administrator';
    }
  }

  /// Get display name in Russian
  String get displayNameRu {
    switch (this) {
      case TeamMemberRole.employee:
        return 'Сотрудник';
      case TeamMemberRole.manager:
        return 'Менеджер';
      case TeamMemberRole.admin:
        return 'Администратор';
    }
  }

  /// Get icon for UI
  String get icon {
    switch (this) {
      case TeamMemberRole.employee:
        return '👤';
      case TeamMemberRole.manager:
        return '👥';
      case TeamMemberRole.admin:
        return '👑';
    }
  }

  /// Check if role has manager privileges
  bool get isManager => this == TeamMemberRole.manager || this == TeamMemberRole.admin;

  /// Check if role has admin privileges
  bool get isAdmin => this == TeamMemberRole.admin;
}
