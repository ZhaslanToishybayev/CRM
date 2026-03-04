// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationSettingsModel _$NotificationSettingsModelFromJson(
    Map<String, dynamic> json) {
  return _NotificationSettingsModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettingsModel {
  String get userId => throw _privateConstructorUsedError;
  bool get pushEnabled => throw _privateConstructorUsedError;
  bool get emailEnabled => throw _privateConstructorUsedError;
  bool get inAppEnabled => throw _privateConstructorUsedError;
  Map<NotificationType, bool> get typeSettings =>
      throw _privateConstructorUsedError;
  bool get quietHoursEnabled => throw _privateConstructorUsedError;
  DateTime? get quietHoursStart => throw _privateConstructorUsedError;
  DateTime? get quietHoursEnd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationSettingsModelCopyWith<NotificationSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsModelCopyWith<$Res> {
  factory $NotificationSettingsModelCopyWith(NotificationSettingsModel value,
          $Res Function(NotificationSettingsModel) then) =
      _$NotificationSettingsModelCopyWithImpl<$Res, NotificationSettingsModel>;
  @useResult
  $Res call(
      {String userId,
      bool pushEnabled,
      bool emailEnabled,
      bool inAppEnabled,
      Map<NotificationType, bool> typeSettings,
      bool quietHoursEnabled,
      DateTime? quietHoursStart,
      DateTime? quietHoursEnd});
}

/// @nodoc
class _$NotificationSettingsModelCopyWithImpl<$Res,
        $Val extends NotificationSettingsModel>
    implements $NotificationSettingsModelCopyWith<$Res> {
  _$NotificationSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? pushEnabled = null,
    Object? emailEnabled = null,
    Object? inAppEnabled = null,
    Object? typeSettings = null,
    Object? quietHoursEnabled = null,
    Object? quietHoursStart = freezed,
    Object? quietHoursEnd = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      pushEnabled: null == pushEnabled
          ? _value.pushEnabled
          : pushEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailEnabled: null == emailEnabled
          ? _value.emailEnabled
          : emailEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      inAppEnabled: null == inAppEnabled
          ? _value.inAppEnabled
          : inAppEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      typeSettings: null == typeSettings
          ? _value.typeSettings
          : typeSettings // ignore: cast_nullable_to_non_nullable
              as Map<NotificationType, bool>,
      quietHoursEnabled: null == quietHoursEnabled
          ? _value.quietHoursEnabled
          : quietHoursEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      quietHoursStart: freezed == quietHoursStart
          ? _value.quietHoursStart
          : quietHoursStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      quietHoursEnd: freezed == quietHoursEnd
          ? _value.quietHoursEnd
          : quietHoursEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsModelImplCopyWith<$Res>
    implements $NotificationSettingsModelCopyWith<$Res> {
  factory _$$NotificationSettingsModelImplCopyWith(
          _$NotificationSettingsModelImpl value,
          $Res Function(_$NotificationSettingsModelImpl) then) =
      __$$NotificationSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      bool pushEnabled,
      bool emailEnabled,
      bool inAppEnabled,
      Map<NotificationType, bool> typeSettings,
      bool quietHoursEnabled,
      DateTime? quietHoursStart,
      DateTime? quietHoursEnd});
}

/// @nodoc
class __$$NotificationSettingsModelImplCopyWithImpl<$Res>
    extends _$NotificationSettingsModelCopyWithImpl<$Res,
        _$NotificationSettingsModelImpl>
    implements _$$NotificationSettingsModelImplCopyWith<$Res> {
  __$$NotificationSettingsModelImplCopyWithImpl(
      _$NotificationSettingsModelImpl _value,
      $Res Function(_$NotificationSettingsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? pushEnabled = null,
    Object? emailEnabled = null,
    Object? inAppEnabled = null,
    Object? typeSettings = null,
    Object? quietHoursEnabled = null,
    Object? quietHoursStart = freezed,
    Object? quietHoursEnd = freezed,
  }) {
    return _then(_$NotificationSettingsModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      pushEnabled: null == pushEnabled
          ? _value.pushEnabled
          : pushEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailEnabled: null == emailEnabled
          ? _value.emailEnabled
          : emailEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      inAppEnabled: null == inAppEnabled
          ? _value.inAppEnabled
          : inAppEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      typeSettings: null == typeSettings
          ? _value._typeSettings
          : typeSettings // ignore: cast_nullable_to_non_nullable
              as Map<NotificationType, bool>,
      quietHoursEnabled: null == quietHoursEnabled
          ? _value.quietHoursEnabled
          : quietHoursEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      quietHoursStart: freezed == quietHoursStart
          ? _value.quietHoursStart
          : quietHoursStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      quietHoursEnd: freezed == quietHoursEnd
          ? _value.quietHoursEnd
          : quietHoursEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsModelImpl implements _NotificationSettingsModel {
  const _$NotificationSettingsModelImpl(
      {required this.userId,
      required this.pushEnabled,
      required this.emailEnabled,
      required this.inAppEnabled,
      required final Map<NotificationType, bool> typeSettings,
      required this.quietHoursEnabled,
      this.quietHoursStart,
      this.quietHoursEnd})
      : _typeSettings = typeSettings;

  factory _$NotificationSettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingsModelImplFromJson(json);

  @override
  final String userId;
  @override
  final bool pushEnabled;
  @override
  final bool emailEnabled;
  @override
  final bool inAppEnabled;
  final Map<NotificationType, bool> _typeSettings;
  @override
  Map<NotificationType, bool> get typeSettings {
    if (_typeSettings is EqualUnmodifiableMapView) return _typeSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_typeSettings);
  }

  @override
  final bool quietHoursEnabled;
  @override
  final DateTime? quietHoursStart;
  @override
  final DateTime? quietHoursEnd;

  @override
  String toString() {
    return 'NotificationSettingsModel(userId: $userId, pushEnabled: $pushEnabled, emailEnabled: $emailEnabled, inAppEnabled: $inAppEnabled, typeSettings: $typeSettings, quietHoursEnabled: $quietHoursEnabled, quietHoursStart: $quietHoursStart, quietHoursEnd: $quietHoursEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.pushEnabled, pushEnabled) ||
                other.pushEnabled == pushEnabled) &&
            (identical(other.emailEnabled, emailEnabled) ||
                other.emailEnabled == emailEnabled) &&
            (identical(other.inAppEnabled, inAppEnabled) ||
                other.inAppEnabled == inAppEnabled) &&
            const DeepCollectionEquality()
                .equals(other._typeSettings, _typeSettings) &&
            (identical(other.quietHoursEnabled, quietHoursEnabled) ||
                other.quietHoursEnabled == quietHoursEnabled) &&
            (identical(other.quietHoursStart, quietHoursStart) ||
                other.quietHoursStart == quietHoursStart) &&
            (identical(other.quietHoursEnd, quietHoursEnd) ||
                other.quietHoursEnd == quietHoursEnd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      pushEnabled,
      emailEnabled,
      inAppEnabled,
      const DeepCollectionEquality().hash(_typeSettings),
      quietHoursEnabled,
      quietHoursStart,
      quietHoursEnd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsModelImplCopyWith<_$NotificationSettingsModelImpl>
      get copyWith => __$$NotificationSettingsModelImplCopyWithImpl<
          _$NotificationSettingsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsModelImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettingsModel implements NotificationSettingsModel {
  const factory _NotificationSettingsModel(
      {required final String userId,
      required final bool pushEnabled,
      required final bool emailEnabled,
      required final bool inAppEnabled,
      required final Map<NotificationType, bool> typeSettings,
      required final bool quietHoursEnabled,
      final DateTime? quietHoursStart,
      final DateTime? quietHoursEnd}) = _$NotificationSettingsModelImpl;

  factory _NotificationSettingsModel.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsModelImpl.fromJson;

  @override
  String get userId;
  @override
  bool get pushEnabled;
  @override
  bool get emailEnabled;
  @override
  bool get inAppEnabled;
  @override
  Map<NotificationType, bool> get typeSettings;
  @override
  bool get quietHoursEnabled;
  @override
  DateTime? get quietHoursStart;
  @override
  DateTime? get quietHoursEnd;
  @override
  @JsonKey(ignore: true)
  _$$NotificationSettingsModelImplCopyWith<_$NotificationSettingsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
