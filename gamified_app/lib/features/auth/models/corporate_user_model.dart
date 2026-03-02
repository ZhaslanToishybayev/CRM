/// Corporate User Model
/// Extended UserModel for corporate/organizational use
/// Represents an authenticated user with corporate information

import 'package:freezed_annotation/freezed_annotation.dart';

part 'corporate_user_model.freezed.dart';
part 'corporate_user_model.g.dart';

/// Corporate role of a user
enum CorporateUserRole {
  employee,    // Regular employee
  manager,     // Team/Department manager
  admin,       // Organization administrator
  superAdmin,  // System super administrator
}

/// Department role
enum DepartmentRole {
  member,      // Regular member
  lead,        // Department lead
  head,        // Department head
}

@freezed
class CorporateUserModel with _$CorporateUserModel {
  const factory CorporateUserModel({
    required String id,
    required String email,
    required String username,
    String? fullName,
    String? avatarUrl,
    required int totalXP,
    required int currentLevel,
    required int streakCount,
    DateTime? lastTaskDate,
    DateTime? createdAt,
    DateTime? updatedAt,

    // 🆕 Corporate fields
    String? organizationId,
    String? departmentId,
    String? teamId,

    CorporateUserRole? corporateRole,
    DepartmentRole? departmentRole,

    // Work information
    String? jobTitle,
    String? employeeId, // Employee number
    DateTime? hireDate,
    String? managerId, // ID of direct manager
    String? location, // Office location
    String? timezone,

    // Contact information
    String? phone,
    String? workEmail,
    String? slackId,
    String? teamsId,

    // Status
    @Default(true) bool isActive,
    @Default(false) bool isOnLeave,
    DateTime? lastActiveAt,

    // Settings
    @Default(true) bool notificationsEnabled,
    @Default(true) bool emailNotificationsEnabled,
    @Default(true) bool pushNotificationsEnabled,
    @Default(false) bool managerNotificationsEnabled, // Get notified of team activities
  }) = _CorporateUserModel;

  factory CorporateUserModel.fromJson(Map<String, dynamic> json) =>
      _$CorporateUserModelFromJson(json);
}

/// Helper extensions for CorporateUserModel
extension CorporateUserModelExtensions on CorporateUserModel {
  /// Check if user is an employee
  bool get isEmployee => corporateRole == CorporateUserRole.employee;

  /// Check if user is a manager
  bool get isManager => corporateRole == CorporateUserRole.manager;

  /// Check if user is an admin
  bool get isAdmin => corporateRole == CorporateUserRole.admin;

  /// Check if user is a super admin
  bool get isSuperAdmin => corporateRole == CorporateUserRole.superAdmin;

  /// Check if user has management privileges
  bool get hasManagementPrivileges => isManager || isAdmin || isSuperAdmin;

  /// Check if user has admin privileges
  bool get hasAdminPrivileges => isAdmin || isSuperAdmin;

  /// Check if user has super admin privileges
  bool get hasSuperAdminPrivileges => isSuperAdmin;

  /// Check if user is on a team
  bool get isOnTeam => teamId != null;

  /// Check if user is in a department
  bool get isInDepartment => departmentId != null;

  /// Check if user is in an organization
  bool get isInOrganization => organizationId != null;

  /// Check if user can manage the given team
  bool canManageTeam(String teamId) {
    if (hasSuperAdminPrivileges) return true;
    if (hasAdminPrivileges) return true;
    if (isManager && this.teamId == teamId) return true;
    return false;
  }

  /// Check if user can manage the given department
  bool canManageDepartment(String departmentId) {
    if (hasSuperAdminPrivileges) return true;
    if (hasAdminPrivileges) return true;
    if (isManager && this.departmentId == departmentId) return true;
    if (departmentRole == DepartmentRole.head || departmentRole == DepartmentRole.lead) {
      return true;
    }
    return false;
  }

  /// Check if user can manage the given organization
  bool canManageOrganization(String organizationId) {
    if (hasSuperAdminPrivileges) return true;
    if (hasAdminPrivileges && this.organizationId == organizationId) return true;
    return false;
  }

  /// Get display name
  String get displayName => fullName ?? username;

  /// Get corporate role display name
  String get corporateRoleDisplayName {
    switch (corporateRole) {
      case CorporateUserRole.employee:
        return 'Employee';
      case CorporateUserRole.manager:
        return 'Manager';
      case CorporateUserRole.admin:
        return 'Administrator';
      case CorporateUserRole.superAdmin:
        return 'Super Administrator';
      default:
        return 'User';
    }
  }

  /// Get corporate role display name in Russian
  String get corporateRoleDisplayNameRu {
    switch (corporateRole) {
      case CorporateUserRole.employee:
        return 'Сотрудник';
      case CorporateUserRole.manager:
        return 'Менеджер';
      case CorporateUserRole.admin:
        return 'Администратор';
      case CorporateUserRole.superAdmin:
        return 'Супер Администратор';
      default:
        return 'Пользователь';
    }
  }

  /// Get department role display name
  String get departmentRoleDisplayName {
    switch (departmentRole) {
      case DepartmentRole.member:
        return 'Member';
      case DepartmentRole.lead:
        return 'Team Lead';
      case DepartmentRole.head:
        return 'Department Head';
      default:
        return 'Member';
    }
  }

  /// Get department role display name in Russian
  String get departmentRoleDisplayNameRu {
    switch (departmentRole) {
      case DepartmentRole.member:
        return 'Участник';
      case DepartmentRole.lead:
        return 'Руководитель команды';
      case DepartmentRole.head:
        return 'Руководитель отдела';
      default:
        return 'Участник';
    }
  }

  /// Check if user is active
  bool get isUserActive => isActive && !isOnLeave;

  /// Get tenure in company (in months)
  int get tenureInMonths {
    if (hireDate == null) return 0;
    final now = DateTime.now();
    final months = (now.year - hireDate!.year) * 12 + (now.month - hireDate!.month);
    return months;
  }

  /// Check if user should receive manager notifications
  bool get shouldReceiveManagerNotifications => managerNotificationsEnabled && hasManagementPrivileges;

  /// Check if notifications are enabled
  bool get areNotificationsEnabled => notificationsEnabled;
}
