// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorkTaskModel _$WorkTaskModelFromJson(Map<String, dynamic> json) {
  return _WorkTaskModel.fromJson(json);
}

/// @nodoc
mixin _$WorkTaskModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get xp => throw _privateConstructorUsedError;
  WorkTaskPriority get priority => throw _privateConstructorUsedError;
  WorkTaskProgress get progress => throw _privateConstructorUsedError;
  DateTime? get dueDate => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt =>
      throw _privateConstructorUsedError; // 🆕 Corporate fields
  String get organizationId => throw _privateConstructorUsedError;
  String? get projectId =>
      throw _privateConstructorUsedError; // Associated project
  String? get departmentId => throw _privateConstructorUsedError; // Department
  String? get teamId => throw _privateConstructorUsedError; // Team responsible
// Assignment
  String? get assignedBy =>
      throw _privateConstructorUsedError; // Who assigned this task
  List<String>? get assignedTo =>
      throw _privateConstructorUsedError; // Who should complete this (multiple people)
  String? get assigneeNote =>
      throw _privateConstructorUsedError; // Note from assignee
// Task metadata
  WorkTaskType get type => throw _privateConstructorUsedError; // Type of task
  WorkTaskSource get source =>
      throw _privateConstructorUsedError; // How task was created
  int? get estimatedHours =>
      throw _privateConstructorUsedError; // Estimated time to complete
  int? get actualHours =>
      throw _privateConstructorUsedError; // Actual time spent
  bool get billable =>
      throw _privateConstructorUsedError; // Whether task is billable
  String? get parentTaskId =>
      throw _privateConstructorUsedError; // For subtasks
  List<String> get subtaskIds =>
      throw _privateConstructorUsedError; // IDs of subtasks
// Quality and rating
  int? get qualityRating =>
      throw _privateConstructorUsedError; // Rating 1-5 from manager
  String? get managerFeedback =>
      throw _privateConstructorUsedError; // Feedback from manager
// Tracking
  int get timeSpent => throw _privateConstructorUsedError; // Minutes spent
  DateTime? get lastActivityAt =>
      throw _privateConstructorUsedError; // Last time someone worked on this
// Collaboration
  List<String> get watcherIds =>
      throw _privateConstructorUsedError; // People to notify of changes
  List<String> get commentIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkTaskModelCopyWith<WorkTaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkTaskModelCopyWith<$Res> {
  factory $WorkTaskModelCopyWith(
          WorkTaskModel value, $Res Function(WorkTaskModel) then) =
      _$WorkTaskModelCopyWithImpl<$Res, WorkTaskModel>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String? description,
      int xp,
      WorkTaskPriority priority,
      WorkTaskProgress progress,
      DateTime? dueDate,
      DateTime? startDate,
      String? category,
      DateTime? completedAt,
      DateTime createdAt,
      DateTime updatedAt,
      String organizationId,
      String? projectId,
      String? departmentId,
      String? teamId,
      String? assignedBy,
      List<String>? assignedTo,
      String? assigneeNote,
      WorkTaskType type,
      WorkTaskSource source,
      int? estimatedHours,
      int? actualHours,
      bool billable,
      String? parentTaskId,
      List<String> subtaskIds,
      int? qualityRating,
      String? managerFeedback,
      int timeSpent,
      DateTime? lastActivityAt,
      List<String> watcherIds,
      List<String> commentIds});
}

/// @nodoc
class _$WorkTaskModelCopyWithImpl<$Res, $Val extends WorkTaskModel>
    implements $WorkTaskModelCopyWith<$Res> {
  _$WorkTaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = freezed,
    Object? xp = null,
    Object? priority = null,
    Object? progress = null,
    Object? dueDate = freezed,
    Object? startDate = freezed,
    Object? category = freezed,
    Object? completedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? organizationId = null,
    Object? projectId = freezed,
    Object? departmentId = freezed,
    Object? teamId = freezed,
    Object? assignedBy = freezed,
    Object? assignedTo = freezed,
    Object? assigneeNote = freezed,
    Object? type = null,
    Object? source = null,
    Object? estimatedHours = freezed,
    Object? actualHours = freezed,
    Object? billable = null,
    Object? parentTaskId = freezed,
    Object? subtaskIds = null,
    Object? qualityRating = freezed,
    Object? managerFeedback = freezed,
    Object? timeSpent = null,
    Object? lastActivityAt = freezed,
    Object? watcherIds = null,
    Object? commentIds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      xp: null == xp
          ? _value.xp
          : xp // ignore: cast_nullable_to_non_nullable
              as int,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as WorkTaskPriority,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as WorkTaskProgress,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: freezed == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String?,
      departmentId: freezed == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedBy: freezed == assignedBy
          ? _value.assignedBy
          : assignedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedTo: freezed == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      assigneeNote: freezed == assigneeNote
          ? _value.assigneeNote
          : assigneeNote // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WorkTaskType,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as WorkTaskSource,
      estimatedHours: freezed == estimatedHours
          ? _value.estimatedHours
          : estimatedHours // ignore: cast_nullable_to_non_nullable
              as int?,
      actualHours: freezed == actualHours
          ? _value.actualHours
          : actualHours // ignore: cast_nullable_to_non_nullable
              as int?,
      billable: null == billable
          ? _value.billable
          : billable // ignore: cast_nullable_to_non_nullable
              as bool,
      parentTaskId: freezed == parentTaskId
          ? _value.parentTaskId
          : parentTaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      subtaskIds: null == subtaskIds
          ? _value.subtaskIds
          : subtaskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      qualityRating: freezed == qualityRating
          ? _value.qualityRating
          : qualityRating // ignore: cast_nullable_to_non_nullable
              as int?,
      managerFeedback: freezed == managerFeedback
          ? _value.managerFeedback
          : managerFeedback // ignore: cast_nullable_to_non_nullable
              as String?,
      timeSpent: null == timeSpent
          ? _value.timeSpent
          : timeSpent // ignore: cast_nullable_to_non_nullable
              as int,
      lastActivityAt: freezed == lastActivityAt
          ? _value.lastActivityAt
          : lastActivityAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      watcherIds: null == watcherIds
          ? _value.watcherIds
          : watcherIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      commentIds: null == commentIds
          ? _value.commentIds
          : commentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkTaskModelImplCopyWith<$Res>
    implements $WorkTaskModelCopyWith<$Res> {
  factory _$$WorkTaskModelImplCopyWith(
          _$WorkTaskModelImpl value, $Res Function(_$WorkTaskModelImpl) then) =
      __$$WorkTaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String? description,
      int xp,
      WorkTaskPriority priority,
      WorkTaskProgress progress,
      DateTime? dueDate,
      DateTime? startDate,
      String? category,
      DateTime? completedAt,
      DateTime createdAt,
      DateTime updatedAt,
      String organizationId,
      String? projectId,
      String? departmentId,
      String? teamId,
      String? assignedBy,
      List<String>? assignedTo,
      String? assigneeNote,
      WorkTaskType type,
      WorkTaskSource source,
      int? estimatedHours,
      int? actualHours,
      bool billable,
      String? parentTaskId,
      List<String> subtaskIds,
      int? qualityRating,
      String? managerFeedback,
      int timeSpent,
      DateTime? lastActivityAt,
      List<String> watcherIds,
      List<String> commentIds});
}

/// @nodoc
class __$$WorkTaskModelImplCopyWithImpl<$Res>
    extends _$WorkTaskModelCopyWithImpl<$Res, _$WorkTaskModelImpl>
    implements _$$WorkTaskModelImplCopyWith<$Res> {
  __$$WorkTaskModelImplCopyWithImpl(
      _$WorkTaskModelImpl _value, $Res Function(_$WorkTaskModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = freezed,
    Object? xp = null,
    Object? priority = null,
    Object? progress = null,
    Object? dueDate = freezed,
    Object? startDate = freezed,
    Object? category = freezed,
    Object? completedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? organizationId = null,
    Object? projectId = freezed,
    Object? departmentId = freezed,
    Object? teamId = freezed,
    Object? assignedBy = freezed,
    Object? assignedTo = freezed,
    Object? assigneeNote = freezed,
    Object? type = null,
    Object? source = null,
    Object? estimatedHours = freezed,
    Object? actualHours = freezed,
    Object? billable = null,
    Object? parentTaskId = freezed,
    Object? subtaskIds = null,
    Object? qualityRating = freezed,
    Object? managerFeedback = freezed,
    Object? timeSpent = null,
    Object? lastActivityAt = freezed,
    Object? watcherIds = null,
    Object? commentIds = null,
  }) {
    return _then(_$WorkTaskModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      xp: null == xp
          ? _value.xp
          : xp // ignore: cast_nullable_to_non_nullable
              as int,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as WorkTaskPriority,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as WorkTaskProgress,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: freezed == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String?,
      departmentId: freezed == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedBy: freezed == assignedBy
          ? _value.assignedBy
          : assignedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedTo: freezed == assignedTo
          ? _value._assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      assigneeNote: freezed == assigneeNote
          ? _value.assigneeNote
          : assigneeNote // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WorkTaskType,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as WorkTaskSource,
      estimatedHours: freezed == estimatedHours
          ? _value.estimatedHours
          : estimatedHours // ignore: cast_nullable_to_non_nullable
              as int?,
      actualHours: freezed == actualHours
          ? _value.actualHours
          : actualHours // ignore: cast_nullable_to_non_nullable
              as int?,
      billable: null == billable
          ? _value.billable
          : billable // ignore: cast_nullable_to_non_nullable
              as bool,
      parentTaskId: freezed == parentTaskId
          ? _value.parentTaskId
          : parentTaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      subtaskIds: null == subtaskIds
          ? _value._subtaskIds
          : subtaskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      qualityRating: freezed == qualityRating
          ? _value.qualityRating
          : qualityRating // ignore: cast_nullable_to_non_nullable
              as int?,
      managerFeedback: freezed == managerFeedback
          ? _value.managerFeedback
          : managerFeedback // ignore: cast_nullable_to_non_nullable
              as String?,
      timeSpent: null == timeSpent
          ? _value.timeSpent
          : timeSpent // ignore: cast_nullable_to_non_nullable
              as int,
      lastActivityAt: freezed == lastActivityAt
          ? _value.lastActivityAt
          : lastActivityAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      watcherIds: null == watcherIds
          ? _value._watcherIds
          : watcherIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      commentIds: null == commentIds
          ? _value._commentIds
          : commentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkTaskModelImpl implements _WorkTaskModel {
  const _$WorkTaskModelImpl(
      {required this.id,
      required this.userId,
      required this.title,
      this.description,
      required this.xp,
      required this.priority,
      required this.progress,
      this.dueDate,
      this.startDate,
      this.category,
      this.completedAt,
      required this.createdAt,
      required this.updatedAt,
      required this.organizationId,
      this.projectId,
      this.departmentId,
      this.teamId,
      this.assignedBy,
      final List<String>? assignedTo,
      this.assigneeNote,
      required this.type,
      required this.source,
      this.estimatedHours,
      this.actualHours,
      this.billable = false,
      this.parentTaskId,
      final List<String> subtaskIds = const [],
      this.qualityRating,
      this.managerFeedback,
      this.timeSpent = 0,
      this.lastActivityAt,
      final List<String> watcherIds = const [],
      final List<String> commentIds = const []})
      : _assignedTo = assignedTo,
        _subtaskIds = subtaskIds,
        _watcherIds = watcherIds,
        _commentIds = commentIds;

  factory _$WorkTaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkTaskModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final int xp;
  @override
  final WorkTaskPriority priority;
  @override
  final WorkTaskProgress progress;
  @override
  final DateTime? dueDate;
  @override
  final DateTime? startDate;
  @override
  final String? category;
  @override
  final DateTime? completedAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
// 🆕 Corporate fields
  @override
  final String organizationId;
  @override
  final String? projectId;
// Associated project
  @override
  final String? departmentId;
// Department
  @override
  final String? teamId;
// Team responsible
// Assignment
  @override
  final String? assignedBy;
// Who assigned this task
  final List<String>? _assignedTo;
// Who assigned this task
  @override
  List<String>? get assignedTo {
    final value = _assignedTo;
    if (value == null) return null;
    if (_assignedTo is EqualUnmodifiableListView) return _assignedTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Who should complete this (multiple people)
  @override
  final String? assigneeNote;
// Note from assignee
// Task metadata
  @override
  final WorkTaskType type;
// Type of task
  @override
  final WorkTaskSource source;
// How task was created
  @override
  final int? estimatedHours;
// Estimated time to complete
  @override
  final int? actualHours;
// Actual time spent
  @override
  @JsonKey()
  final bool billable;
// Whether task is billable
  @override
  final String? parentTaskId;
// For subtasks
  final List<String> _subtaskIds;
// For subtasks
  @override
  @JsonKey()
  List<String> get subtaskIds {
    if (_subtaskIds is EqualUnmodifiableListView) return _subtaskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subtaskIds);
  }

// IDs of subtasks
// Quality and rating
  @override
  final int? qualityRating;
// Rating 1-5 from manager
  @override
  final String? managerFeedback;
// Feedback from manager
// Tracking
  @override
  @JsonKey()
  final int timeSpent;
// Minutes spent
  @override
  final DateTime? lastActivityAt;
// Last time someone worked on this
// Collaboration
  final List<String> _watcherIds;
// Last time someone worked on this
// Collaboration
  @override
  @JsonKey()
  List<String> get watcherIds {
    if (_watcherIds is EqualUnmodifiableListView) return _watcherIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_watcherIds);
  }

// People to notify of changes
  final List<String> _commentIds;
// People to notify of changes
  @override
  @JsonKey()
  List<String> get commentIds {
    if (_commentIds is EqualUnmodifiableListView) return _commentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commentIds);
  }

  @override
  String toString() {
    return 'WorkTaskModel(id: $id, userId: $userId, title: $title, description: $description, xp: $xp, priority: $priority, progress: $progress, dueDate: $dueDate, startDate: $startDate, category: $category, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt, organizationId: $organizationId, projectId: $projectId, departmentId: $departmentId, teamId: $teamId, assignedBy: $assignedBy, assignedTo: $assignedTo, assigneeNote: $assigneeNote, type: $type, source: $source, estimatedHours: $estimatedHours, actualHours: $actualHours, billable: $billable, parentTaskId: $parentTaskId, subtaskIds: $subtaskIds, qualityRating: $qualityRating, managerFeedback: $managerFeedback, timeSpent: $timeSpent, lastActivityAt: $lastActivityAt, watcherIds: $watcherIds, commentIds: $commentIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkTaskModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.xp, xp) || other.xp == xp) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.departmentId, departmentId) ||
                other.departmentId == departmentId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.assignedBy, assignedBy) ||
                other.assignedBy == assignedBy) &&
            const DeepCollectionEquality()
                .equals(other._assignedTo, _assignedTo) &&
            (identical(other.assigneeNote, assigneeNote) ||
                other.assigneeNote == assigneeNote) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.estimatedHours, estimatedHours) ||
                other.estimatedHours == estimatedHours) &&
            (identical(other.actualHours, actualHours) ||
                other.actualHours == actualHours) &&
            (identical(other.billable, billable) ||
                other.billable == billable) &&
            (identical(other.parentTaskId, parentTaskId) ||
                other.parentTaskId == parentTaskId) &&
            const DeepCollectionEquality()
                .equals(other._subtaskIds, _subtaskIds) &&
            (identical(other.qualityRating, qualityRating) ||
                other.qualityRating == qualityRating) &&
            (identical(other.managerFeedback, managerFeedback) ||
                other.managerFeedback == managerFeedback) &&
            (identical(other.timeSpent, timeSpent) ||
                other.timeSpent == timeSpent) &&
            (identical(other.lastActivityAt, lastActivityAt) ||
                other.lastActivityAt == lastActivityAt) &&
            const DeepCollectionEquality()
                .equals(other._watcherIds, _watcherIds) &&
            const DeepCollectionEquality()
                .equals(other._commentIds, _commentIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        title,
        description,
        xp,
        priority,
        progress,
        dueDate,
        startDate,
        category,
        completedAt,
        createdAt,
        updatedAt,
        organizationId,
        projectId,
        departmentId,
        teamId,
        assignedBy,
        const DeepCollectionEquality().hash(_assignedTo),
        assigneeNote,
        type,
        source,
        estimatedHours,
        actualHours,
        billable,
        parentTaskId,
        const DeepCollectionEquality().hash(_subtaskIds),
        qualityRating,
        managerFeedback,
        timeSpent,
        lastActivityAt,
        const DeepCollectionEquality().hash(_watcherIds),
        const DeepCollectionEquality().hash(_commentIds)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkTaskModelImplCopyWith<_$WorkTaskModelImpl> get copyWith =>
      __$$WorkTaskModelImplCopyWithImpl<_$WorkTaskModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkTaskModelImplToJson(
      this,
    );
  }
}

abstract class _WorkTaskModel implements WorkTaskModel {
  const factory _WorkTaskModel(
      {required final String id,
      required final String userId,
      required final String title,
      final String? description,
      required final int xp,
      required final WorkTaskPriority priority,
      required final WorkTaskProgress progress,
      final DateTime? dueDate,
      final DateTime? startDate,
      final String? category,
      final DateTime? completedAt,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final String organizationId,
      final String? projectId,
      final String? departmentId,
      final String? teamId,
      final String? assignedBy,
      final List<String>? assignedTo,
      final String? assigneeNote,
      required final WorkTaskType type,
      required final WorkTaskSource source,
      final int? estimatedHours,
      final int? actualHours,
      final bool billable,
      final String? parentTaskId,
      final List<String> subtaskIds,
      final int? qualityRating,
      final String? managerFeedback,
      final int timeSpent,
      final DateTime? lastActivityAt,
      final List<String> watcherIds,
      final List<String> commentIds}) = _$WorkTaskModelImpl;

  factory _WorkTaskModel.fromJson(Map<String, dynamic> json) =
      _$WorkTaskModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  String? get description;
  @override
  int get xp;
  @override
  WorkTaskPriority get priority;
  @override
  WorkTaskProgress get progress;
  @override
  DateTime? get dueDate;
  @override
  DateTime? get startDate;
  @override
  String? get category;
  @override
  DateTime? get completedAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override // 🆕 Corporate fields
  String get organizationId;
  @override
  String? get projectId;
  @override // Associated project
  String? get departmentId;
  @override // Department
  String? get teamId;
  @override // Team responsible
// Assignment
  String? get assignedBy;
  @override // Who assigned this task
  List<String>? get assignedTo;
  @override // Who should complete this (multiple people)
  String? get assigneeNote;
  @override // Note from assignee
// Task metadata
  WorkTaskType get type;
  @override // Type of task
  WorkTaskSource get source;
  @override // How task was created
  int? get estimatedHours;
  @override // Estimated time to complete
  int? get actualHours;
  @override // Actual time spent
  bool get billable;
  @override // Whether task is billable
  String? get parentTaskId;
  @override // For subtasks
  List<String> get subtaskIds;
  @override // IDs of subtasks
// Quality and rating
  int? get qualityRating;
  @override // Rating 1-5 from manager
  String? get managerFeedback;
  @override // Feedback from manager
// Tracking
  int get timeSpent;
  @override // Minutes spent
  DateTime? get lastActivityAt;
  @override // Last time someone worked on this
// Collaboration
  List<String> get watcherIds;
  @override // People to notify of changes
  List<String> get commentIds;
  @override
  @JsonKey(ignore: true)
  _$$WorkTaskModelImplCopyWith<_$WorkTaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
