// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateUserModelImpl _$$CorporateUserModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateUserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      totalXP: (json['totalXP'] as num).toInt(),
      currentLevel: (json['currentLevel'] as num).toInt(),
      streakCount: (json['streakCount'] as num).toInt(),
      lastTaskDate: json['lastTaskDate'] == null
          ? null
          : DateTime.parse(json['lastTaskDate'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      organizationId: json['organizationId'] as String?,
      departmentId: json['departmentId'] as String?,
      teamId: json['teamId'] as String?,
      corporateRole: $enumDecodeNullable(
          _$CorporateUserRoleEnumMap, json['corporateRole']),
      departmentRole:
          $enumDecodeNullable(_$DepartmentRoleEnumMap, json['departmentRole']),
      jobTitle: json['jobTitle'] as String?,
      employeeId: json['employeeId'] as String?,
      hireDate: json['hireDate'] == null
          ? null
          : DateTime.parse(json['hireDate'] as String),
      managerId: json['managerId'] as String?,
      location: json['location'] as String?,
      timezone: json['timezone'] as String?,
      phone: json['phone'] as String?,
      workEmail: json['workEmail'] as String?,
      slackId: json['slackId'] as String?,
      teamsId: json['teamsId'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      isOnLeave: json['isOnLeave'] as bool? ?? false,
      lastActiveAt: json['lastActiveAt'] == null
          ? null
          : DateTime.parse(json['lastActiveAt'] as String),
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      emailNotificationsEnabled:
          json['emailNotificationsEnabled'] as bool? ?? true,
      pushNotificationsEnabled:
          json['pushNotificationsEnabled'] as bool? ?? true,
      managerNotificationsEnabled:
          json['managerNotificationsEnabled'] as bool? ?? false,
    );

Map<String, dynamic> _$$CorporateUserModelImplToJson(
        _$CorporateUserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'totalXP': instance.totalXP,
      'currentLevel': instance.currentLevel,
      'streakCount': instance.streakCount,
      'lastTaskDate': instance.lastTaskDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'organizationId': instance.organizationId,
      'departmentId': instance.departmentId,
      'teamId': instance.teamId,
      'corporateRole': _$CorporateUserRoleEnumMap[instance.corporateRole],
      'departmentRole': _$DepartmentRoleEnumMap[instance.departmentRole],
      'jobTitle': instance.jobTitle,
      'employeeId': instance.employeeId,
      'hireDate': instance.hireDate?.toIso8601String(),
      'managerId': instance.managerId,
      'location': instance.location,
      'timezone': instance.timezone,
      'phone': instance.phone,
      'workEmail': instance.workEmail,
      'slackId': instance.slackId,
      'teamsId': instance.teamsId,
      'isActive': instance.isActive,
      'isOnLeave': instance.isOnLeave,
      'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
      'notificationsEnabled': instance.notificationsEnabled,
      'emailNotificationsEnabled': instance.emailNotificationsEnabled,
      'pushNotificationsEnabled': instance.pushNotificationsEnabled,
      'managerNotificationsEnabled': instance.managerNotificationsEnabled,
    };

const _$CorporateUserRoleEnumMap = {
  CorporateUserRole.employee: 'employee',
  CorporateUserRole.manager: 'manager',
  CorporateUserRole.admin: 'admin',
  CorporateUserRole.superAdmin: 'superAdmin',
};

const _$DepartmentRoleEnumMap = {
  DepartmentRole.member: 'member',
  DepartmentRole.lead: 'lead',
  DepartmentRole.head: 'head',
};
