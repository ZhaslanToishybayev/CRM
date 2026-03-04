// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crm_task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CrmTaskModel _$CrmTaskModelFromJson(Map<String, dynamic> json) {
  return _CrmTaskModel.fromJson(json);
}

/// @nodoc
mixin _$CrmTaskModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError; // Relations
  String get clientId => throw _privateConstructorUsedError;
  String? get clientName => throw _privateConstructorUsedError;
  String? get companyId => throw _privateConstructorUsedError;
  String? get companyName => throw _privateConstructorUsedError;
  String? get dealId => throw _privateConstructorUsedError;
  String? get dealName => throw _privateConstructorUsedError; // Task details
  TaskType get type => throw _privateConstructorUsedError;
  TaskPriority? get priority => throw _privateConstructorUsedError;
  TaskStatus? get status => throw _privateConstructorUsedError; // Dates
  DateTime? get dueDate => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError; // Assignment
  String? get assignedTo => throw _privateConstructorUsedError;
  String? get assignedToName => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError; // Reminders
  List<DateTime> get reminders =>
      throw _privateConstructorUsedError; // Notes and tags
  String? get notes => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  Map<String, dynamic>? get customFields => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CrmTaskModelCopyWith<CrmTaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CrmTaskModelCopyWith<$Res> {
  factory $CrmTaskModelCopyWith(
          CrmTaskModel value, $Res Function(CrmTaskModel) then) =
      _$CrmTaskModelCopyWithImpl<$Res, CrmTaskModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String clientId,
      String? clientName,
      String? companyId,
      String? companyName,
      String? dealId,
      String? dealName,
      TaskType type,
      TaskPriority? priority,
      TaskStatus? status,
      DateTime? dueDate,
      DateTime? completedAt,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? assignedTo,
      String? assignedToName,
      String createdBy,
      List<DateTime> reminders,
      String? notes,
      List<String> tags,
      Map<String, dynamic>? customFields});
}

/// @nodoc
class _$CrmTaskModelCopyWithImpl<$Res, $Val extends CrmTaskModel>
    implements $CrmTaskModelCopyWith<$Res> {
  _$CrmTaskModelCopyWithImpl(this._value, this._then);

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
    Object? clientId = null,
    Object? clientName = freezed,
    Object? companyId = freezed,
    Object? companyName = freezed,
    Object? dealId = freezed,
    Object? dealName = freezed,
    Object? type = null,
    Object? priority = freezed,
    Object? status = freezed,
    Object? dueDate = freezed,
    Object? completedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? assignedTo = freezed,
    Object? assignedToName = freezed,
    Object? createdBy = null,
    Object? reminders = null,
    Object? notes = freezed,
    Object? tags = null,
    Object? customFields = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TaskType,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      assignedTo: freezed == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedToName: freezed == assignedToName
          ? _value.assignedToName
          : assignedToName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      reminders: null == reminders
          ? _value.reminders
          : reminders // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customFields: freezed == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CrmTaskModelImplCopyWith<$Res>
    implements $CrmTaskModelCopyWith<$Res> {
  factory _$$CrmTaskModelImplCopyWith(
          _$CrmTaskModelImpl value, $Res Function(_$CrmTaskModelImpl) then) =
      __$$CrmTaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String clientId,
      String? clientName,
      String? companyId,
      String? companyName,
      String? dealId,
      String? dealName,
      TaskType type,
      TaskPriority? priority,
      TaskStatus? status,
      DateTime? dueDate,
      DateTime? completedAt,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? assignedTo,
      String? assignedToName,
      String createdBy,
      List<DateTime> reminders,
      String? notes,
      List<String> tags,
      Map<String, dynamic>? customFields});
}

/// @nodoc
class __$$CrmTaskModelImplCopyWithImpl<$Res>
    extends _$CrmTaskModelCopyWithImpl<$Res, _$CrmTaskModelImpl>
    implements _$$CrmTaskModelImplCopyWith<$Res> {
  __$$CrmTaskModelImplCopyWithImpl(
      _$CrmTaskModelImpl _value, $Res Function(_$CrmTaskModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? clientId = null,
    Object? clientName = freezed,
    Object? companyId = freezed,
    Object? companyName = freezed,
    Object? dealId = freezed,
    Object? dealName = freezed,
    Object? type = null,
    Object? priority = freezed,
    Object? status = freezed,
    Object? dueDate = freezed,
    Object? completedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? assignedTo = freezed,
    Object? assignedToName = freezed,
    Object? createdBy = null,
    Object? reminders = null,
    Object? notes = freezed,
    Object? tags = null,
    Object? customFields = freezed,
  }) {
    return _then(_$CrmTaskModelImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TaskType,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      assignedTo: freezed == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedToName: freezed == assignedToName
          ? _value.assignedToName
          : assignedToName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      reminders: null == reminders
          ? _value._reminders
          : reminders // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customFields: freezed == customFields
          ? _value._customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CrmTaskModelImpl implements _CrmTaskModel {
  const _$CrmTaskModelImpl(
      {required this.id,
      required this.title,
      this.description,
      required this.clientId,
      this.clientName,
      this.companyId,
      this.companyName,
      this.dealId,
      this.dealName,
      required this.type,
      this.priority,
      this.status,
      this.dueDate,
      this.completedAt,
      this.createdAt,
      this.updatedAt,
      this.assignedTo,
      this.assignedToName,
      required this.createdBy,
      final List<DateTime> reminders = const [],
      this.notes,
      final List<String> tags = const [],
      final Map<String, dynamic>? customFields})
      : _reminders = reminders,
        _tags = tags,
        _customFields = customFields;

  factory _$CrmTaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CrmTaskModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
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
// Task details
  @override
  final TaskType type;
  @override
  final TaskPriority? priority;
  @override
  final TaskStatus? status;
// Dates
  @override
  final DateTime? dueDate;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
// Assignment
  @override
  final String? assignedTo;
  @override
  final String? assignedToName;
  @override
  final String createdBy;
// Reminders
  final List<DateTime> _reminders;
// Reminders
  @override
  @JsonKey()
  List<DateTime> get reminders {
    if (_reminders is EqualUnmodifiableListView) return _reminders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reminders);
  }

// Notes and tags
  @override
  final String? notes;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final Map<String, dynamic>? _customFields;
  @override
  Map<String, dynamic>? get customFields {
    final value = _customFields;
    if (value == null) return null;
    if (_customFields is EqualUnmodifiableMapView) return _customFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'CrmTaskModel(id: $id, title: $title, description: $description, clientId: $clientId, clientName: $clientName, companyId: $companyId, companyName: $companyName, dealId: $dealId, dealName: $dealName, type: $type, priority: $priority, status: $status, dueDate: $dueDate, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt, assignedTo: $assignedTo, assignedToName: $assignedToName, createdBy: $createdBy, reminders: $reminders, notes: $notes, tags: $tags, customFields: $customFields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CrmTaskModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
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
            (identical(other.type, type) || other.type == type) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.assignedTo, assignedTo) ||
                other.assignedTo == assignedTo) &&
            (identical(other.assignedToName, assignedToName) ||
                other.assignedToName == assignedToName) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            const DeepCollectionEquality()
                .equals(other._reminders, _reminders) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._customFields, _customFields));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        clientId,
        clientName,
        companyId,
        companyName,
        dealId,
        dealName,
        type,
        priority,
        status,
        dueDate,
        completedAt,
        createdAt,
        updatedAt,
        assignedTo,
        assignedToName,
        createdBy,
        const DeepCollectionEquality().hash(_reminders),
        notes,
        const DeepCollectionEquality().hash(_tags),
        const DeepCollectionEquality().hash(_customFields)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CrmTaskModelImplCopyWith<_$CrmTaskModelImpl> get copyWith =>
      __$$CrmTaskModelImplCopyWithImpl<_$CrmTaskModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CrmTaskModelImplToJson(
      this,
    );
  }
}

abstract class _CrmTaskModel implements CrmTaskModel {
  const factory _CrmTaskModel(
      {required final String id,
      required final String title,
      final String? description,
      required final String clientId,
      final String? clientName,
      final String? companyId,
      final String? companyName,
      final String? dealId,
      final String? dealName,
      required final TaskType type,
      final TaskPriority? priority,
      final TaskStatus? status,
      final DateTime? dueDate,
      final DateTime? completedAt,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final String? assignedTo,
      final String? assignedToName,
      required final String createdBy,
      final List<DateTime> reminders,
      final String? notes,
      final List<String> tags,
      final Map<String, dynamic>? customFields}) = _$CrmTaskModelImpl;

  factory _CrmTaskModel.fromJson(Map<String, dynamic> json) =
      _$CrmTaskModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
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
  @override // Task details
  TaskType get type;
  @override
  TaskPriority? get priority;
  @override
  TaskStatus? get status;
  @override // Dates
  DateTime? get dueDate;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override // Assignment
  String? get assignedTo;
  @override
  String? get assignedToName;
  @override
  String get createdBy;
  @override // Reminders
  List<DateTime> get reminders;
  @override // Notes and tags
  String? get notes;
  @override
  List<String> get tags;
  @override
  Map<String, dynamic>? get customFields;
  @override
  @JsonKey(ignore: true)
  _$$CrmTaskModelImplCopyWith<_$CrmTaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
