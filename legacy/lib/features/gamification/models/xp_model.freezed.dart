// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'xp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

XPModel _$XPModelFromJson(Map<String, dynamic> json) {
  return _XPModel.fromJson(json);
}

/// @nodoc
mixin _$XPModel {
  String get userId => throw _privateConstructorUsedError;
  int get totalXP => throw _privateConstructorUsedError;
  int get currentLevel => throw _privateConstructorUsedError;
  int get currentLevelXP => throw _privateConstructorUsedError;
  int get nextLevelXP => throw _privateConstructorUsedError;
  int get xpToNextLevel => throw _privateConstructorUsedError;
  double get progressToNextLevel => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $XPModelCopyWith<XPModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $XPModelCopyWith<$Res> {
  factory $XPModelCopyWith(XPModel value, $Res Function(XPModel) then) =
      _$XPModelCopyWithImpl<$Res, XPModel>;
  @useResult
  $Res call(
      {String userId,
      int totalXP,
      int currentLevel,
      int currentLevelXP,
      int nextLevelXP,
      int xpToNextLevel,
      double progressToNextLevel,
      DateTime lastUpdated});
}

/// @nodoc
class _$XPModelCopyWithImpl<$Res, $Val extends XPModel>
    implements $XPModelCopyWith<$Res> {
  _$XPModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? totalXP = null,
    Object? currentLevel = null,
    Object? currentLevelXP = null,
    Object? nextLevelXP = null,
    Object? xpToNextLevel = null,
    Object? progressToNextLevel = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      totalXP: null == totalXP
          ? _value.totalXP
          : totalXP // ignore: cast_nullable_to_non_nullable
              as int,
      currentLevel: null == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      currentLevelXP: null == currentLevelXP
          ? _value.currentLevelXP
          : currentLevelXP // ignore: cast_nullable_to_non_nullable
              as int,
      nextLevelXP: null == nextLevelXP
          ? _value.nextLevelXP
          : nextLevelXP // ignore: cast_nullable_to_non_nullable
              as int,
      xpToNextLevel: null == xpToNextLevel
          ? _value.xpToNextLevel
          : xpToNextLevel // ignore: cast_nullable_to_non_nullable
              as int,
      progressToNextLevel: null == progressToNextLevel
          ? _value.progressToNextLevel
          : progressToNextLevel // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$XPModelImplCopyWith<$Res> implements $XPModelCopyWith<$Res> {
  factory _$$XPModelImplCopyWith(
          _$XPModelImpl value, $Res Function(_$XPModelImpl) then) =
      __$$XPModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      int totalXP,
      int currentLevel,
      int currentLevelXP,
      int nextLevelXP,
      int xpToNextLevel,
      double progressToNextLevel,
      DateTime lastUpdated});
}

/// @nodoc
class __$$XPModelImplCopyWithImpl<$Res>
    extends _$XPModelCopyWithImpl<$Res, _$XPModelImpl>
    implements _$$XPModelImplCopyWith<$Res> {
  __$$XPModelImplCopyWithImpl(
      _$XPModelImpl _value, $Res Function(_$XPModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? totalXP = null,
    Object? currentLevel = null,
    Object? currentLevelXP = null,
    Object? nextLevelXP = null,
    Object? xpToNextLevel = null,
    Object? progressToNextLevel = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$XPModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      totalXP: null == totalXP
          ? _value.totalXP
          : totalXP // ignore: cast_nullable_to_non_nullable
              as int,
      currentLevel: null == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      currentLevelXP: null == currentLevelXP
          ? _value.currentLevelXP
          : currentLevelXP // ignore: cast_nullable_to_non_nullable
              as int,
      nextLevelXP: null == nextLevelXP
          ? _value.nextLevelXP
          : nextLevelXP // ignore: cast_nullable_to_non_nullable
              as int,
      xpToNextLevel: null == xpToNextLevel
          ? _value.xpToNextLevel
          : xpToNextLevel // ignore: cast_nullable_to_non_nullable
              as int,
      progressToNextLevel: null == progressToNextLevel
          ? _value.progressToNextLevel
          : progressToNextLevel // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$XPModelImpl extends _XPModel {
  const _$XPModelImpl(
      {required this.userId,
      required this.totalXP,
      required this.currentLevel,
      required this.currentLevelXP,
      required this.nextLevelXP,
      required this.xpToNextLevel,
      required this.progressToNextLevel,
      required this.lastUpdated})
      : super._();

  factory _$XPModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$XPModelImplFromJson(json);

  @override
  final String userId;
  @override
  final int totalXP;
  @override
  final int currentLevel;
  @override
  final int currentLevelXP;
  @override
  final int nextLevelXP;
  @override
  final int xpToNextLevel;
  @override
  final double progressToNextLevel;
  @override
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'XPModel(userId: $userId, totalXP: $totalXP, currentLevel: $currentLevel, currentLevelXP: $currentLevelXP, nextLevelXP: $nextLevelXP, xpToNextLevel: $xpToNextLevel, progressToNextLevel: $progressToNextLevel, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$XPModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.totalXP, totalXP) || other.totalXP == totalXP) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel) &&
            (identical(other.currentLevelXP, currentLevelXP) ||
                other.currentLevelXP == currentLevelXP) &&
            (identical(other.nextLevelXP, nextLevelXP) ||
                other.nextLevelXP == nextLevelXP) &&
            (identical(other.xpToNextLevel, xpToNextLevel) ||
                other.xpToNextLevel == xpToNextLevel) &&
            (identical(other.progressToNextLevel, progressToNextLevel) ||
                other.progressToNextLevel == progressToNextLevel) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      totalXP,
      currentLevel,
      currentLevelXP,
      nextLevelXP,
      xpToNextLevel,
      progressToNextLevel,
      lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$XPModelImplCopyWith<_$XPModelImpl> get copyWith =>
      __$$XPModelImplCopyWithImpl<_$XPModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$XPModelImplToJson(
      this,
    );
  }
}

abstract class _XPModel extends XPModel {
  const factory _XPModel(
      {required final String userId,
      required final int totalXP,
      required final int currentLevel,
      required final int currentLevelXP,
      required final int nextLevelXP,
      required final int xpToNextLevel,
      required final double progressToNextLevel,
      required final DateTime lastUpdated}) = _$XPModelImpl;
  const _XPModel._() : super._();

  factory _XPModel.fromJson(Map<String, dynamic> json) = _$XPModelImpl.fromJson;

  @override
  String get userId;
  @override
  int get totalXP;
  @override
  int get currentLevel;
  @override
  int get currentLevelXP;
  @override
  int get nextLevelXP;
  @override
  int get xpToNextLevel;
  @override
  double get progressToNextLevel;
  @override
  DateTime get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$XPModelImplCopyWith<_$XPModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
