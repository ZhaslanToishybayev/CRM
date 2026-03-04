// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) {
  return _ActivityModel.fromJson(json);
}

/// @nodoc
mixin _$ActivityModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description =>
      throw _privateConstructorUsedError; // Type of activity
  ActivityType get type => throw _privateConstructorUsedError; // Relations
  String get clientId => throw _privateConstructorUsedError;
  String? get clientName => throw _privateConstructorUsedError;
  String? get companyId => throw _privateConstructorUsedError;
  String? get companyName => throw _privateConstructorUsedError;
  String? get dealId => throw _privateConstructorUsedError;
  String? get dealName => throw _privateConstructorUsedError;
  String? get taskId => throw _privateConstructorUsedError; // Activity details
  ActivityDirection? get direction => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  String? get outcome => throw _privateConstructorUsedError; // Participants
  List<String> get participants => throw _privateConstructorUsedError;
  List<String> get emailRecipients => throw _privateConstructorUsedError;
  String? get callPhoneNumber => throw _privateConstructorUsedError; // Duration
  int? get durationMinutes =>
      throw _privateConstructorUsedError; // for calls, meetings
// Date and time
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get scheduledAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError; // User
  String get createdBy => throw _privateConstructorUsedError;
  String? get createdByName => throw _privateConstructorUsedError; // Metadata
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  List<String> get attachments => throw _privateConstructorUsedError; // Tags
  List<String> get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivityModelCopyWith<ActivityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityModelCopyWith<$Res> {
  factory $ActivityModelCopyWith(
          ActivityModel value, $Res Function(ActivityModel) then) =
      _$ActivityModelCopyWithImpl<$Res, ActivityModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      ActivityType type,
      String clientId,
      String? clientName,
      String? companyId,
      String? companyName,
      String? dealId,
      String? dealName,
      String? taskId,
      ActivityDirection? direction,
      String? subject,
      String? outcome,
      List<String> participants,
      List<String> emailRecipients,
      String? callPhoneNumber,
      int? durationMinutes,
      DateTime createdAt,
      DateTime? scheduledAt,
      DateTime? completedAt,
      String createdBy,
      String? createdByName,
      Map<String, dynamic>? metadata,
      List<String> attachments,
      List<String> tags});
}

/// @nodoc
class _$ActivityModelCopyWithImpl<$Res, $Val extends ActivityModel>
    implements $ActivityModelCopyWith<$Res> {
  _$ActivityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? clientId = null,
    Object? clientName = freezed,
    Object? companyId = freezed,
    Object? companyName = freezed,
    Object? dealId = freezed,
    Object? dealName = freezed,
    Object? taskId = freezed,
    Object? direction = freezed,
    Object? subject = freezed,
    Object? outcome = freezed,
    Object? participants = null,
    Object? emailRecipients = null,
    Object? callPhoneNumber = freezed,
    Object? durationMinutes = freezed,
    Object? createdAt = null,
    Object? scheduledAt = freezed,
    Object? completedAt = freezed,
    Object? createdBy = null,
    Object? createdByName = freezed,
    Object? metadata = freezed,
    Object? attachments = null,
    Object? tags = null,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: freezed == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      dealId: freezed == dealId
          ? _value.dealId
          : dealId // ignore: cast_nullable_to_non_nullable
              as String?,
      dealName: freezed == dealName
          ? _value.dealName
          : dealName // ignore: cast_nullable_to_non_nullable
              as String?,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as ActivityDirection?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      outcome: freezed == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as String?,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      emailRecipients: null == emailRecipients
          ? _value.emailRecipients
          : emailRecipients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      callPhoneNumber: freezed == callPhoneNumber
          ? _value.callPhoneNumber
          : callPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      durationMinutes: freezed == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdByName: freezed == createdByName
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityModelImplCopyWith<$Res>
    implements $ActivityModelCopyWith<$Res> {
  factory _$$ActivityModelImplCopyWith(
          _$ActivityModelImpl value, $Res Function(_$ActivityModelImpl) then) =
      __$$ActivityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      ActivityType type,
      String clientId,
      String? clientName,
      String? companyId,
      String? companyName,
      String? dealId,
      String? dealName,
      String? taskId,
      ActivityDirection? direction,
      String? subject,
      String? outcome,
      List<String> participants,
      List<String> emailRecipients,
      String? callPhoneNumber,
      int? durationMinutes,
      DateTime createdAt,
      DateTime? scheduledAt,
      DateTime? completedAt,
      String createdBy,
      String? createdByName,
      Map<String, dynamic>? metadata,
      List<String> attachments,
      List<String> tags});
}

/// @nodoc
class __$$ActivityModelImplCopyWithImpl<$Res>
    extends _$ActivityModelCopyWithImpl<$Res, _$ActivityModelImpl>
    implements _$$ActivityModelImplCopyWith<$Res> {
  __$$ActivityModelImplCopyWithImpl(
      _$ActivityModelImpl _value, $Res Function(_$ActivityModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? clientId = null,
    Object? clientName = freezed,
    Object? companyId = freezed,
    Object? companyName = freezed,
    Object? dealId = freezed,
    Object? dealName = freezed,
    Object? taskId = freezed,
    Object? direction = freezed,
    Object? subject = freezed,
    Object? outcome = freezed,
    Object? participants = null,
    Object? emailRecipients = null,
    Object? callPhoneNumber = freezed,
    Object? durationMinutes = freezed,
    Object? createdAt = null,
    Object? scheduledAt = freezed,
    Object? completedAt = freezed,
    Object? createdBy = null,
    Object? createdByName = freezed,
    Object? metadata = freezed,
    Object? attachments = null,
    Object? tags = null,
  }) {
    return _then(_$ActivityModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: freezed == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      dealId: freezed == dealId
          ? _value.dealId
          : dealId // ignore: cast_nullable_to_non_nullable
              as String?,
      dealName: freezed == dealName
          ? _value.dealName
          : dealName // ignore: cast_nullable_to_non_nullable
              as String?,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as ActivityDirection?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      outcome: freezed == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as String?,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      emailRecipients: null == emailRecipients
          ? _value._emailRecipients
          : emailRecipients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      callPhoneNumber: freezed == callPhoneNumber
          ? _value.callPhoneNumber
          : callPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      durationMinutes: freezed == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdByName: freezed == createdByName
          ? _value.createdByName
          : createdByName // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityModelImpl implements _ActivityModel {
  const _$ActivityModelImpl(
      {required this.id,
      required this.title,
      this.description,
      required this.type,
      required this.clientId,
      this.clientName,
      this.companyId,
      this.companyName,
      this.dealId,
      this.dealName,
      this.taskId,
      this.direction,
      this.subject,
      this.outcome,
      final List<String> participants = const [],
      final List<String> emailRecipients = const [],
      this.callPhoneNumber,
      this.durationMinutes,
      required this.createdAt,
      this.scheduledAt,
      this.completedAt,
      required this.createdBy,
      this.createdByName,
      final Map<String, dynamic>? metadata,
      final List<String> attachments = const [],
      final List<String> tags = const []})
      : _participants = participants,
        _emailRecipients = emailRecipients,
        _metadata = metadata,
        _attachments = attachments,
        _tags = tags;

  factory _$ActivityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
// Type of activity
  @override
  final ActivityType type;
// Relations
  @override
  final String clientId;
  @override
  final String? clientName;
  @override
  final String? companyId;
  @override
  final String? companyName;
  @override
  final String? dealId;
  @override
  final String? dealName;
  @override
  final String? taskId;
// Activity details
  @override
  final ActivityDirection? direction;
  @override
  final String? subject;
  @override
  final String? outcome;
// Participants
  final List<String> _participants;
// Participants
  @override
  @JsonKey()
  List<String> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  final List<String> _emailRecipients;
  @override
  @JsonKey()
  List<String> get emailRecipients {
    if (_emailRecipients is EqualUnmodifiableListView) return _emailRecipients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_emailRecipients);
  }

  @override
  final String? callPhoneNumber;
// Duration
  @override
  final int? durationMinutes;
// for calls, meetings
// Date and time
  @override
  final DateTime createdAt;
  @override
  final DateTime? scheduledAt;
  @override
  final DateTime? completedAt;
// User
  @override
  final String createdBy;
  @override
  final String? createdByName;
// Metadata
  final Map<String, dynamic>? _metadata;
// Metadata
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String> _attachments;
  @override
  @JsonKey()
  List<String> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

// Tags
  final List<String> _tags;
// Tags
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'ActivityModel(id: $id, title: $title, description: $description, type: $type, clientId: $clientId, clientName: $clientName, companyId: $companyId, companyName: $companyName, dealId: $dealId, dealName: $dealName, taskId: $taskId, direction: $direction, subject: $subject, outcome: $outcome, participants: $participants, emailRecipients: $emailRecipients, callPhoneNumber: $callPhoneNumber, durationMinutes: $durationMinutes, createdAt: $createdAt, scheduledAt: $scheduledAt, completedAt: $completedAt, createdBy: $createdBy, createdByName: $createdByName, metadata: $metadata, attachments: $attachments, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.dealId, dealId) || other.dealId == dealId) &&
            (identical(other.dealName, dealName) ||
                other.dealName == dealName) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.outcome, outcome) || other.outcome == outcome) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            const DeepCollectionEquality()
                .equals(other._emailRecipients, _emailRecipients) &&
            (identical(other.callPhoneNumber, callPhoneNumber) ||
                other.callPhoneNumber == callPhoneNumber) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdByName, createdByName) ||
                other.createdByName == createdByName) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        type,
        clientId,
        clientName,
        companyId,
        companyName,
        dealId,
        dealName,
        taskId,
        direction,
        subject,
        outcome,
        const DeepCollectionEquality().hash(_participants),
        const DeepCollectionEquality().hash(_emailRecipients),
        callPhoneNumber,
        durationMinutes,
        createdAt,
        scheduledAt,
        completedAt,
        createdBy,
        createdByName,
        const DeepCollectionEquality().hash(_metadata),
        const DeepCollectionEquality().hash(_attachments),
        const DeepCollectionEquality().hash(_tags)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityModelImplCopyWith<_$ActivityModelImpl> get copyWith =>
      __$$ActivityModelImplCopyWithImpl<_$ActivityModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityModelImplToJson(
      this,
    );
  }
}

abstract class _ActivityModel implements ActivityModel {
  const factory _ActivityModel(
      {required final String id,
      required final String title,
      final String? description,
      required final ActivityType type,
      required final String clientId,
      final String? clientName,
      final String? companyId,
      final String? companyName,
      final String? dealId,
      final String? dealName,
      final String? taskId,
      final ActivityDirection? direction,
      final String? subject,
      final String? outcome,
      final List<String> participants,
      final List<String> emailRecipients,
      final String? callPhoneNumber,
      final int? durationMinutes,
      required final DateTime createdAt,
      final DateTime? scheduledAt,
      final DateTime? completedAt,
      required final String createdBy,
      final String? createdByName,
      final Map<String, dynamic>? metadata,
      final List<String> attachments,
      final List<String> tags}) = _$ActivityModelImpl;

  factory _ActivityModel.fromJson(Map<String, dynamic> json) =
      _$ActivityModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override // Type of activity
  ActivityType get type;
  @override // Relations
  String get clientId;
  @override
  String? get clientName;
  @override
  String? get companyId;
  @override
  String? get companyName;
  @override
  String? get dealId;
  @override
  String? get dealName;
  @override
  String? get taskId;
  @override // Activity details
  ActivityDirection? get direction;
  @override
  String? get subject;
  @override
  String? get outcome;
  @override // Participants
  List<String> get participants;
  @override
  List<String> get emailRecipients;
  @override
  String? get callPhoneNumber;
  @override // Duration
  int? get durationMinutes;
  @override // for calls, meetings
// Date and time
  DateTime get createdAt;
  @override
  DateTime? get scheduledAt;
  @override
  DateTime? get completedAt;
  @override // User
  String get createdBy;
  @override
  String? get createdByName;
  @override // Metadata
  Map<String, dynamic>? get metadata;
  @override
  List<String> get attachments;
  @override // Tags
  List<String> get tags;
  @override
  @JsonKey(ignore: true)
  _$$ActivityModelImplCopyWith<_$ActivityModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
