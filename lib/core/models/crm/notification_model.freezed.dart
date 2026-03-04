// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CrmNotificationModel _$CrmNotificationModelFromJson(Map<String, dynamic> json) {
  return _CrmNotificationModel.fromJson(json);
}

/// @nodoc
mixin _$CrmNotificationModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  CrmNotificationType get type => throw _privateConstructorUsedError;
  CrmNotificationPriority get priority => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  String? get clientId => throw _privateConstructorUsedError;
  String? get dealId => throw _privateConstructorUsedError;
  String? get taskId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CrmNotificationModelCopyWith<CrmNotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CrmNotificationModelCopyWith<$Res> {
  factory $CrmNotificationModelCopyWith(CrmNotificationModel value,
          $Res Function(CrmNotificationModel) then) =
      _$CrmNotificationModelCopyWithImpl<$Res, CrmNotificationModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String message,
      CrmNotificationType type,
      CrmNotificationPriority priority,
      DateTime createdAt,
      bool isRead,
      DateTime? readAt,
      Map<String, dynamic>? metadata,
      String? clientId,
      String? dealId,
      String? taskId,
      String? userId});
}

/// @nodoc
class _$CrmNotificationModelCopyWithImpl<$Res,
        $Val extends CrmNotificationModel>
    implements $CrmNotificationModelCopyWith<$Res> {
  _$CrmNotificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? message = null,
    Object? type = null,
    Object? priority = null,
    Object? createdAt = null,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? metadata = freezed,
    Object? clientId = freezed,
    Object? dealId = freezed,
    Object? taskId = freezed,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CrmNotificationType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as CrmNotificationPriority,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      dealId: freezed == dealId
          ? _value.dealId
          : dealId // ignore: cast_nullable_to_non_nullable
              as String?,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CrmNotificationModelImplCopyWith<$Res>
    implements $CrmNotificationModelCopyWith<$Res> {
  factory _$$CrmNotificationModelImplCopyWith(_$CrmNotificationModelImpl value,
          $Res Function(_$CrmNotificationModelImpl) then) =
      __$$CrmNotificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String message,
      CrmNotificationType type,
      CrmNotificationPriority priority,
      DateTime createdAt,
      bool isRead,
      DateTime? readAt,
      Map<String, dynamic>? metadata,
      String? clientId,
      String? dealId,
      String? taskId,
      String? userId});
}

/// @nodoc
class __$$CrmNotificationModelImplCopyWithImpl<$Res>
    extends _$CrmNotificationModelCopyWithImpl<$Res, _$CrmNotificationModelImpl>
    implements _$$CrmNotificationModelImplCopyWith<$Res> {
  __$$CrmNotificationModelImplCopyWithImpl(_$CrmNotificationModelImpl _value,
      $Res Function(_$CrmNotificationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? message = null,
    Object? type = null,
    Object? priority = null,
    Object? createdAt = null,
    Object? isRead = null,
    Object? readAt = freezed,
    Object? metadata = freezed,
    Object? clientId = freezed,
    Object? dealId = freezed,
    Object? taskId = freezed,
    Object? userId = freezed,
  }) {
    return _then(_$CrmNotificationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CrmNotificationType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as CrmNotificationPriority,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      dealId: freezed == dealId
          ? _value.dealId
          : dealId // ignore: cast_nullable_to_non_nullable
              as String?,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CrmNotificationModelImpl implements _CrmNotificationModel {
  const _$CrmNotificationModelImpl(
      {required this.id,
      required this.title,
      required this.message,
      required this.type,
      required this.priority,
      required this.createdAt,
      required this.isRead,
      this.readAt,
      final Map<String, dynamic>? metadata,
      this.clientId,
      this.dealId,
      this.taskId,
      this.userId})
      : _metadata = metadata;

  factory _$CrmNotificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CrmNotificationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String message;
  @override
  final CrmNotificationType type;
  @override
  final CrmNotificationPriority priority;
  @override
  final DateTime createdAt;
  @override
  final bool isRead;
  @override
  final DateTime? readAt;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? clientId;
  @override
  final String? dealId;
  @override
  final String? taskId;
  @override
  final String? userId;

  @override
  String toString() {
    return 'CrmNotificationModel(id: $id, title: $title, message: $message, type: $type, priority: $priority, createdAt: $createdAt, isRead: $isRead, readAt: $readAt, metadata: $metadata, clientId: $clientId, dealId: $dealId, taskId: $taskId, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CrmNotificationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.dealId, dealId) || other.dealId == dealId) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      message,
      type,
      priority,
      createdAt,
      isRead,
      readAt,
      const DeepCollectionEquality().hash(_metadata),
      clientId,
      dealId,
      taskId,
      userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CrmNotificationModelImplCopyWith<_$CrmNotificationModelImpl>
      get copyWith =>
          __$$CrmNotificationModelImplCopyWithImpl<_$CrmNotificationModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CrmNotificationModelImplToJson(
      this,
    );
  }
}

abstract class _CrmNotificationModel implements CrmNotificationModel {
  const factory _CrmNotificationModel(
      {required final String id,
      required final String title,
      required final String message,
      required final CrmNotificationType type,
      required final CrmNotificationPriority priority,
      required final DateTime createdAt,
      required final bool isRead,
      final DateTime? readAt,
      final Map<String, dynamic>? metadata,
      final String? clientId,
      final String? dealId,
      final String? taskId,
      final String? userId}) = _$CrmNotificationModelImpl;

  factory _CrmNotificationModel.fromJson(Map<String, dynamic> json) =
      _$CrmNotificationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get message;
  @override
  CrmNotificationType get type;
  @override
  CrmNotificationPriority get priority;
  @override
  DateTime get createdAt;
  @override
  bool get isRead;
  @override
  DateTime? get readAt;
  @override
  Map<String, dynamic>? get metadata;
  @override
  String? get clientId;
  @override
  String? get dealId;
  @override
  String? get taskId;
  @override
  String? get userId;
  @override
  @JsonKey(ignore: true)
  _$$CrmNotificationModelImplCopyWith<_$CrmNotificationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
