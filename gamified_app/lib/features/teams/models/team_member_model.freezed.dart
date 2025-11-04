// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TeamMemberModel _$TeamMemberModelFromJson(Map<String, dynamic> json) {
  return _TeamMemberModel.fromJson(json);
}

/// @nodoc
mixin _$TeamMemberModel {
  String get id => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  TeamMemberRole get role => throw _privateConstructorUsedError;
  TeamMemberStatus get status => throw _privateConstructorUsedError;
  DateTime get joinedAt => throw _privateConstructorUsedError;
  DateTime? get lastActiveAt => throw _privateConstructorUsedError;
  String? get addedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamMemberModelCopyWith<TeamMemberModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamMemberModelCopyWith<$Res> {
  factory $TeamMemberModelCopyWith(
          TeamMemberModel value, $Res Function(TeamMemberModel) then) =
      _$TeamMemberModelCopyWithImpl<$Res, TeamMemberModel>;
  @useResult
  $Res call(
      {String id,
      String teamId,
      String userId,
      TeamMemberRole role,
      TeamMemberStatus status,
      DateTime joinedAt,
      DateTime? lastActiveAt,
      String? addedBy});
}

/// @nodoc
class _$TeamMemberModelCopyWithImpl<$Res, $Val extends TeamMemberModel>
    implements $TeamMemberModelCopyWith<$Res> {
  _$TeamMemberModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? teamId = null,
    Object? userId = null,
    Object? role = null,
    Object? status = null,
    Object? joinedAt = null,
    Object? lastActiveAt = freezed,
    Object? addedBy = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as TeamMemberRole,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TeamMemberStatus,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastActiveAt: freezed == lastActiveAt
          ? _value.lastActiveAt
          : lastActiveAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      addedBy: freezed == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamMemberModelImplCopyWith<$Res>
    implements $TeamMemberModelCopyWith<$Res> {
  factory _$$TeamMemberModelImplCopyWith(_$TeamMemberModelImpl value,
          $Res Function(_$TeamMemberModelImpl) then) =
      __$$TeamMemberModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String teamId,
      String userId,
      TeamMemberRole role,
      TeamMemberStatus status,
      DateTime joinedAt,
      DateTime? lastActiveAt,
      String? addedBy});
}

/// @nodoc
class __$$TeamMemberModelImplCopyWithImpl<$Res>
    extends _$TeamMemberModelCopyWithImpl<$Res, _$TeamMemberModelImpl>
    implements _$$TeamMemberModelImplCopyWith<$Res> {
  __$$TeamMemberModelImplCopyWithImpl(
      _$TeamMemberModelImpl _value, $Res Function(_$TeamMemberModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? teamId = null,
    Object? userId = null,
    Object? role = null,
    Object? status = null,
    Object? joinedAt = null,
    Object? lastActiveAt = freezed,
    Object? addedBy = freezed,
  }) {
    return _then(_$TeamMemberModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as TeamMemberRole,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TeamMemberStatus,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastActiveAt: freezed == lastActiveAt
          ? _value.lastActiveAt
          : lastActiveAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      addedBy: freezed == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamMemberModelImpl implements _TeamMemberModel {
  const _$TeamMemberModelImpl(
      {required this.id,
      required this.teamId,
      required this.userId,
      required this.role,
      required this.status,
      required this.joinedAt,
      this.lastActiveAt,
      this.addedBy});

  factory _$TeamMemberModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamMemberModelImplFromJson(json);

  @override
  final String id;
  @override
  final String teamId;
  @override
  final String userId;
  @override
  final TeamMemberRole role;
  @override
  final TeamMemberStatus status;
  @override
  final DateTime joinedAt;
  @override
  final DateTime? lastActiveAt;
  @override
  final String? addedBy;

  @override
  String toString() {
    return 'TeamMemberModel(id: $id, teamId: $teamId, userId: $userId, role: $role, status: $status, joinedAt: $joinedAt, lastActiveAt: $lastActiveAt, addedBy: $addedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMemberModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.lastActiveAt, lastActiveAt) ||
                other.lastActiveAt == lastActiveAt) &&
            (identical(other.addedBy, addedBy) || other.addedBy == addedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, teamId, userId, role, status,
      joinedAt, lastActiveAt, addedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamMemberModelImplCopyWith<_$TeamMemberModelImpl> get copyWith =>
      __$$TeamMemberModelImplCopyWithImpl<_$TeamMemberModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamMemberModelImplToJson(
      this,
    );
  }
}

abstract class _TeamMemberModel implements TeamMemberModel {
  const factory _TeamMemberModel(
      {required final String id,
      required final String teamId,
      required final String userId,
      required final TeamMemberRole role,
      required final TeamMemberStatus status,
      required final DateTime joinedAt,
      final DateTime? lastActiveAt,
      final String? addedBy}) = _$TeamMemberModelImpl;

  factory _TeamMemberModel.fromJson(Map<String, dynamic> json) =
      _$TeamMemberModelImpl.fromJson;

  @override
  String get id;
  @override
  String get teamId;
  @override
  String get userId;
  @override
  TeamMemberRole get role;
  @override
  TeamMemberStatus get status;
  @override
  DateTime get joinedAt;
  @override
  DateTime? get lastActiveAt;
  @override
  String? get addedBy;
  @override
  @JsonKey(ignore: true)
  _$$TeamMemberModelImplCopyWith<_$TeamMemberModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
