// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateUserModel _$CorporateUserModelFromJson(Map<String, dynamic> json) {
  return _CorporateUserModel.fromJson(json);
}

/// @nodoc
mixin _$CorporateUserModel {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  int get totalXP => throw _privateConstructorUsedError;
  int get currentLevel => throw _privateConstructorUsedError;
  int get streakCount => throw _privateConstructorUsedError;
  DateTime? get lastTaskDate => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // 🆕 Corporate fields
  String? get organizationId => throw _privateConstructorUsedError;
  String? get departmentId => throw _privateConstructorUsedError;
  String? get teamId => throw _privateConstructorUsedError;
  CorporateUserRole? get corporateRole => throw _privateConstructorUsedError;
  DepartmentRole? get departmentRole =>
      throw _privateConstructorUsedError; // Work information
  String? get jobTitle => throw _privateConstructorUsedError;
  String? get employeeId =>
      throw _privateConstructorUsedError; // Employee number
  DateTime? get hireDate => throw _privateConstructorUsedError;
  String? get managerId =>
      throw _privateConstructorUsedError; // ID of direct manager
  String? get location => throw _privateConstructorUsedError; // Office location
  String? get timezone =>
      throw _privateConstructorUsedError; // Contact information
  String? get phone => throw _privateConstructorUsedError;
  String? get workEmail => throw _privateConstructorUsedError;
  String? get slackId => throw _privateConstructorUsedError;
  String? get teamsId => throw _privateConstructorUsedError; // Status
  bool get isActive => throw _privateConstructorUsedError;
  bool get isOnLeave => throw _privateConstructorUsedError;
  DateTime? get lastActiveAt => throw _privateConstructorUsedError; // Settings
  bool get notificationsEnabled => throw _privateConstructorUsedError;
  bool get emailNotificationsEnabled => throw _privateConstructorUsedError;
  bool get pushNotificationsEnabled => throw _privateConstructorUsedError;
  bool get managerNotificationsEnabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateUserModelCopyWith<CorporateUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateUserModelCopyWith<$Res> {
  factory $CorporateUserModelCopyWith(
          CorporateUserModel value, $Res Function(CorporateUserModel) then) =
      _$CorporateUserModelCopyWithImpl<$Res, CorporateUserModel>;
  @useResult
  $Res call(
      {String id,
      String email,
      String username,
      String? fullName,
      String? avatarUrl,
      int totalXP,
      int currentLevel,
      int streakCount,
      DateTime? lastTaskDate,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? organizationId,
      String? departmentId,
      String? teamId,
      CorporateUserRole? corporateRole,
      DepartmentRole? departmentRole,
      String? jobTitle,
      String? employeeId,
      DateTime? hireDate,
      String? managerId,
      String? location,
      String? timezone,
      String? phone,
      String? workEmail,
      String? slackId,
      String? teamsId,
      bool isActive,
      bool isOnLeave,
      DateTime? lastActiveAt,
      bool notificationsEnabled,
      bool emailNotificationsEnabled,
      bool pushNotificationsEnabled,
      bool managerNotificationsEnabled});
}

/// @nodoc
class _$CorporateUserModelCopyWithImpl<$Res, $Val extends CorporateUserModel>
    implements $CorporateUserModelCopyWith<$Res> {
  _$CorporateUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? username = null,
    Object? fullName = freezed,
    Object? avatarUrl = freezed,
    Object? totalXP = null,
    Object? currentLevel = null,
    Object? streakCount = null,
    Object? lastTaskDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? organizationId = freezed,
    Object? departmentId = freezed,
    Object? teamId = freezed,
    Object? corporateRole = freezed,
    Object? departmentRole = freezed,
    Object? jobTitle = freezed,
    Object? employeeId = freezed,
    Object? hireDate = freezed,
    Object? managerId = freezed,
    Object? location = freezed,
    Object? timezone = freezed,
    Object? phone = freezed,
    Object? workEmail = freezed,
    Object? slackId = freezed,
    Object? teamsId = freezed,
    Object? isActive = null,
    Object? isOnLeave = null,
    Object? lastActiveAt = freezed,
    Object? notificationsEnabled = null,
    Object? emailNotificationsEnabled = null,
    Object? pushNotificationsEnabled = null,
    Object? managerNotificationsEnabled = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      totalXP: null == totalXP
          ? _value.totalXP
          : totalXP // ignore: cast_nullable_to_non_nullable
              as int,
      currentLevel: null == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      streakCount: null == streakCount
          ? _value.streakCount
          : streakCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastTaskDate: freezed == lastTaskDate
          ? _value.lastTaskDate
          : lastTaskDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      departmentId: freezed == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateRole: freezed == corporateRole
          ? _value.corporateRole
          : corporateRole // ignore: cast_nullable_to_non_nullable
              as CorporateUserRole?,
      departmentRole: freezed == departmentRole
          ? _value.departmentRole
          : departmentRole // ignore: cast_nullable_to_non_nullable
              as DepartmentRole?,
      jobTitle: freezed == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String?,
      hireDate: freezed == hireDate
          ? _value.hireDate
          : hireDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      managerId: freezed == managerId
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      timezone: freezed == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      workEmail: freezed == workEmail
          ? _value.workEmail
          : workEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      slackId: freezed == slackId
          ? _value.slackId
          : slackId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamsId: freezed == teamsId
          ? _value.teamsId
          : teamsId // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isOnLeave: null == isOnLeave
          ? _value.isOnLeave
          : isOnLeave // ignore: cast_nullable_to_non_nullable
              as bool,
      lastActiveAt: freezed == lastActiveAt
          ? _value.lastActiveAt
          : lastActiveAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailNotificationsEnabled: null == emailNotificationsEnabled
          ? _value.emailNotificationsEnabled
          : emailNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      pushNotificationsEnabled: null == pushNotificationsEnabled
          ? _value.pushNotificationsEnabled
          : pushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      managerNotificationsEnabled: null == managerNotificationsEnabled
          ? _value.managerNotificationsEnabled
          : managerNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateUserModelImplCopyWith<$Res>
    implements $CorporateUserModelCopyWith<$Res> {
  factory _$$CorporateUserModelImplCopyWith(_$CorporateUserModelImpl value,
          $Res Function(_$CorporateUserModelImpl) then) =
      __$$CorporateUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String username,
      String? fullName,
      String? avatarUrl,
      int totalXP,
      int currentLevel,
      int streakCount,
      DateTime? lastTaskDate,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? organizationId,
      String? departmentId,
      String? teamId,
      CorporateUserRole? corporateRole,
      DepartmentRole? departmentRole,
      String? jobTitle,
      String? employeeId,
      DateTime? hireDate,
      String? managerId,
      String? location,
      String? timezone,
      String? phone,
      String? workEmail,
      String? slackId,
      String? teamsId,
      bool isActive,
      bool isOnLeave,
      DateTime? lastActiveAt,
      bool notificationsEnabled,
      bool emailNotificationsEnabled,
      bool pushNotificationsEnabled,
      bool managerNotificationsEnabled});
}

/// @nodoc
class __$$CorporateUserModelImplCopyWithImpl<$Res>
    extends _$CorporateUserModelCopyWithImpl<$Res, _$CorporateUserModelImpl>
    implements _$$CorporateUserModelImplCopyWith<$Res> {
  __$$CorporateUserModelImplCopyWithImpl(_$CorporateUserModelImpl _value,
      $Res Function(_$CorporateUserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? username = null,
    Object? fullName = freezed,
    Object? avatarUrl = freezed,
    Object? totalXP = null,
    Object? currentLevel = null,
    Object? streakCount = null,
    Object? lastTaskDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? organizationId = freezed,
    Object? departmentId = freezed,
    Object? teamId = freezed,
    Object? corporateRole = freezed,
    Object? departmentRole = freezed,
    Object? jobTitle = freezed,
    Object? employeeId = freezed,
    Object? hireDate = freezed,
    Object? managerId = freezed,
    Object? location = freezed,
    Object? timezone = freezed,
    Object? phone = freezed,
    Object? workEmail = freezed,
    Object? slackId = freezed,
    Object? teamsId = freezed,
    Object? isActive = null,
    Object? isOnLeave = null,
    Object? lastActiveAt = freezed,
    Object? notificationsEnabled = null,
    Object? emailNotificationsEnabled = null,
    Object? pushNotificationsEnabled = null,
    Object? managerNotificationsEnabled = null,
  }) {
    return _then(_$CorporateUserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      totalXP: null == totalXP
          ? _value.totalXP
          : totalXP // ignore: cast_nullable_to_non_nullable
              as int,
      currentLevel: null == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      streakCount: null == streakCount
          ? _value.streakCount
          : streakCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastTaskDate: freezed == lastTaskDate
          ? _value.lastTaskDate
          : lastTaskDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      departmentId: freezed == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateRole: freezed == corporateRole
          ? _value.corporateRole
          : corporateRole // ignore: cast_nullable_to_non_nullable
              as CorporateUserRole?,
      departmentRole: freezed == departmentRole
          ? _value.departmentRole
          : departmentRole // ignore: cast_nullable_to_non_nullable
              as DepartmentRole?,
      jobTitle: freezed == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String?,
      hireDate: freezed == hireDate
          ? _value.hireDate
          : hireDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      managerId: freezed == managerId
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      timezone: freezed == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      workEmail: freezed == workEmail
          ? _value.workEmail
          : workEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      slackId: freezed == slackId
          ? _value.slackId
          : slackId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamsId: freezed == teamsId
          ? _value.teamsId
          : teamsId // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isOnLeave: null == isOnLeave
          ? _value.isOnLeave
          : isOnLeave // ignore: cast_nullable_to_non_nullable
              as bool,
      lastActiveAt: freezed == lastActiveAt
          ? _value.lastActiveAt
          : lastActiveAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailNotificationsEnabled: null == emailNotificationsEnabled
          ? _value.emailNotificationsEnabled
          : emailNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      pushNotificationsEnabled: null == pushNotificationsEnabled
          ? _value.pushNotificationsEnabled
          : pushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      managerNotificationsEnabled: null == managerNotificationsEnabled
          ? _value.managerNotificationsEnabled
          : managerNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateUserModelImpl implements _CorporateUserModel {
  const _$CorporateUserModelImpl(
      {required this.id,
      required this.email,
      required this.username,
      this.fullName,
      this.avatarUrl,
      required this.totalXP,
      required this.currentLevel,
      required this.streakCount,
      this.lastTaskDate,
      this.createdAt,
      this.updatedAt,
      this.organizationId,
      this.departmentId,
      this.teamId,
      this.corporateRole,
      this.departmentRole,
      this.jobTitle,
      this.employeeId,
      this.hireDate,
      this.managerId,
      this.location,
      this.timezone,
      this.phone,
      this.workEmail,
      this.slackId,
      this.teamsId,
      this.isActive = true,
      this.isOnLeave = false,
      this.lastActiveAt,
      this.notificationsEnabled = true,
      this.emailNotificationsEnabled = true,
      this.pushNotificationsEnabled = true,
      this.managerNotificationsEnabled = false});

  factory _$CorporateUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CorporateUserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String username;
  @override
  final String? fullName;
  @override
  final String? avatarUrl;
  @override
  final int totalXP;
  @override
  final int currentLevel;
  @override
  final int streakCount;
  @override
  final DateTime? lastTaskDate;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
// 🆕 Corporate fields
  @override
  final String? organizationId;
  @override
  final String? departmentId;
  @override
  final String? teamId;
  @override
  final CorporateUserRole? corporateRole;
  @override
  final DepartmentRole? departmentRole;
// Work information
  @override
  final String? jobTitle;
  @override
  final String? employeeId;
// Employee number
  @override
  final DateTime? hireDate;
  @override
  final String? managerId;
// ID of direct manager
  @override
  final String? location;
// Office location
  @override
  final String? timezone;
// Contact information
  @override
  final String? phone;
  @override
  final String? workEmail;
  @override
  final String? slackId;
  @override
  final String? teamsId;
// Status
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isOnLeave;
  @override
  final DateTime? lastActiveAt;
// Settings
  @override
  @JsonKey()
  final bool notificationsEnabled;
  @override
  @JsonKey()
  final bool emailNotificationsEnabled;
  @override
  @JsonKey()
  final bool pushNotificationsEnabled;
  @override
  @JsonKey()
  final bool managerNotificationsEnabled;

  @override
  String toString() {
    return 'CorporateUserModel(id: $id, email: $email, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, totalXP: $totalXP, currentLevel: $currentLevel, streakCount: $streakCount, lastTaskDate: $lastTaskDate, createdAt: $createdAt, updatedAt: $updatedAt, organizationId: $organizationId, departmentId: $departmentId, teamId: $teamId, corporateRole: $corporateRole, departmentRole: $departmentRole, jobTitle: $jobTitle, employeeId: $employeeId, hireDate: $hireDate, managerId: $managerId, location: $location, timezone: $timezone, phone: $phone, workEmail: $workEmail, slackId: $slackId, teamsId: $teamsId, isActive: $isActive, isOnLeave: $isOnLeave, lastActiveAt: $lastActiveAt, notificationsEnabled: $notificationsEnabled, emailNotificationsEnabled: $emailNotificationsEnabled, pushNotificationsEnabled: $pushNotificationsEnabled, managerNotificationsEnabled: $managerNotificationsEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CorporateUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.totalXP, totalXP) || other.totalXP == totalXP) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel) &&
            (identical(other.streakCount, streakCount) ||
                other.streakCount == streakCount) &&
            (identical(other.lastTaskDate, lastTaskDate) ||
                other.lastTaskDate == lastTaskDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.departmentId, departmentId) ||
                other.departmentId == departmentId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.corporateRole, corporateRole) ||
                other.corporateRole == corporateRole) &&
            (identical(other.departmentRole, departmentRole) ||
                other.departmentRole == departmentRole) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.hireDate, hireDate) ||
                other.hireDate == hireDate) &&
            (identical(other.managerId, managerId) ||
                other.managerId == managerId) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.workEmail, workEmail) ||
                other.workEmail == workEmail) &&
            (identical(other.slackId, slackId) || other.slackId == slackId) &&
            (identical(other.teamsId, teamsId) || other.teamsId == teamsId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isOnLeave, isOnLeave) ||
                other.isOnLeave == isOnLeave) &&
            (identical(other.lastActiveAt, lastActiveAt) ||
                other.lastActiveAt == lastActiveAt) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(other.emailNotificationsEnabled,
                    emailNotificationsEnabled) ||
                other.emailNotificationsEnabled == emailNotificationsEnabled) &&
            (identical(
                    other.pushNotificationsEnabled, pushNotificationsEnabled) ||
                other.pushNotificationsEnabled == pushNotificationsEnabled) &&
            (identical(other.managerNotificationsEnabled,
                    managerNotificationsEnabled) ||
                other.managerNotificationsEnabled ==
                    managerNotificationsEnabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        email,
        username,
        fullName,
        avatarUrl,
        totalXP,
        currentLevel,
        streakCount,
        lastTaskDate,
        createdAt,
        updatedAt,
        organizationId,
        departmentId,
        teamId,
        corporateRole,
        departmentRole,
        jobTitle,
        employeeId,
        hireDate,
        managerId,
        location,
        timezone,
        phone,
        workEmail,
        slackId,
        teamsId,
        isActive,
        isOnLeave,
        lastActiveAt,
        notificationsEnabled,
        emailNotificationsEnabled,
        pushNotificationsEnabled,
        managerNotificationsEnabled
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateUserModelImplCopyWith<_$CorporateUserModelImpl> get copyWith =>
      __$$CorporateUserModelImplCopyWithImpl<_$CorporateUserModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateUserModelImplToJson(
      this,
    );
  }
}

abstract class _CorporateUserModel implements CorporateUserModel {
  const factory _CorporateUserModel(
      {required final String id,
      required final String email,
      required final String username,
      final String? fullName,
      final String? avatarUrl,
      required final int totalXP,
      required final int currentLevel,
      required final int streakCount,
      final DateTime? lastTaskDate,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final String? organizationId,
      final String? departmentId,
      final String? teamId,
      final CorporateUserRole? corporateRole,
      final DepartmentRole? departmentRole,
      final String? jobTitle,
      final String? employeeId,
      final DateTime? hireDate,
      final String? managerId,
      final String? location,
      final String? timezone,
      final String? phone,
      final String? workEmail,
      final String? slackId,
      final String? teamsId,
      final bool isActive,
      final bool isOnLeave,
      final DateTime? lastActiveAt,
      final bool notificationsEnabled,
      final bool emailNotificationsEnabled,
      final bool pushNotificationsEnabled,
      final bool managerNotificationsEnabled}) = _$CorporateUserModelImpl;

  factory _CorporateUserModel.fromJson(Map<String, dynamic> json) =
      _$CorporateUserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get username;
  @override
  String? get fullName;
  @override
  String? get avatarUrl;
  @override
  int get totalXP;
  @override
  int get currentLevel;
  @override
  int get streakCount;
  @override
  DateTime? get lastTaskDate;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override // 🆕 Corporate fields
  String? get organizationId;
  @override
  String? get departmentId;
  @override
  String? get teamId;
  @override
  CorporateUserRole? get corporateRole;
  @override
  DepartmentRole? get departmentRole;
  @override // Work information
  String? get jobTitle;
  @override
  String? get employeeId;
  @override // Employee number
  DateTime? get hireDate;
  @override
  String? get managerId;
  @override // ID of direct manager
  String? get location;
  @override // Office location
  String? get timezone;
  @override // Contact information
  String? get phone;
  @override
  String? get workEmail;
  @override
  String? get slackId;
  @override
  String? get teamsId;
  @override // Status
  bool get isActive;
  @override
  bool get isOnLeave;
  @override
  DateTime? get lastActiveAt;
  @override // Settings
  bool get notificationsEnabled;
  @override
  bool get emailNotificationsEnabled;
  @override
  bool get pushNotificationsEnabled;
  @override
  bool get managerNotificationsEnabled;
  @override
  @JsonKey(ignore: true)
  _$$CorporateUserModelImplCopyWith<_$CorporateUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
