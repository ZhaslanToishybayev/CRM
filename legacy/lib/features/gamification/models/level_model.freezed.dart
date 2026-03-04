// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LevelInfo _$LevelInfoFromJson(Map<String, dynamic> json) {
  return _LevelInfo.fromJson(json);
}

/// @nodoc
mixin _$LevelInfo {
  int get level => throw _privateConstructorUsedError;
  int get requiredXP => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LevelInfoCopyWith<LevelInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelInfoCopyWith<$Res> {
  factory $LevelInfoCopyWith(LevelInfo value, $Res Function(LevelInfo) then) =
      _$LevelInfoCopyWithImpl<$Res, LevelInfo>;
  @useResult
  $Res call(
      {int level, int requiredXP, String title, String subtitle, String color});
}

/// @nodoc
class _$LevelInfoCopyWithImpl<$Res, $Val extends LevelInfo>
    implements $LevelInfoCopyWith<$Res> {
  _$LevelInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? requiredXP = null,
    Object? title = null,
    Object? subtitle = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      requiredXP: null == requiredXP
          ? _value.requiredXP
          : requiredXP // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LevelInfoImplCopyWith<$Res>
    implements $LevelInfoCopyWith<$Res> {
  factory _$$LevelInfoImplCopyWith(
          _$LevelInfoImpl value, $Res Function(_$LevelInfoImpl) then) =
      __$$LevelInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int level, int requiredXP, String title, String subtitle, String color});
}

/// @nodoc
class __$$LevelInfoImplCopyWithImpl<$Res>
    extends _$LevelInfoCopyWithImpl<$Res, _$LevelInfoImpl>
    implements _$$LevelInfoImplCopyWith<$Res> {
  __$$LevelInfoImplCopyWithImpl(
      _$LevelInfoImpl _value, $Res Function(_$LevelInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? requiredXP = null,
    Object? title = null,
    Object? subtitle = null,
    Object? color = null,
  }) {
    return _then(_$LevelInfoImpl(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      requiredXP: null == requiredXP
          ? _value.requiredXP
          : requiredXP // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LevelInfoImpl implements _LevelInfo {
  const _$LevelInfoImpl(
      {required this.level,
      required this.requiredXP,
      required this.title,
      required this.subtitle,
      required this.color});

  factory _$LevelInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LevelInfoImplFromJson(json);

  @override
  final int level;
  @override
  final int requiredXP;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String color;

  @override
  String toString() {
    return 'LevelInfo(level: $level, requiredXP: $requiredXP, title: $title, subtitle: $subtitle, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LevelInfoImpl &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.requiredXP, requiredXP) ||
                other.requiredXP == requiredXP) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, level, requiredXP, title, subtitle, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LevelInfoImplCopyWith<_$LevelInfoImpl> get copyWith =>
      __$$LevelInfoImplCopyWithImpl<_$LevelInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LevelInfoImplToJson(
      this,
    );
  }
}

abstract class _LevelInfo implements LevelInfo {
  const factory _LevelInfo(
      {required final int level,
      required final int requiredXP,
      required final String title,
      required final String subtitle,
      required final String color}) = _$LevelInfoImpl;

  factory _LevelInfo.fromJson(Map<String, dynamic> json) =
      _$LevelInfoImpl.fromJson;

  @override
  int get level;
  @override
  int get requiredXP;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get color;
  @override
  @JsonKey(ignore: true)
  _$$LevelInfoImplCopyWith<_$LevelInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
