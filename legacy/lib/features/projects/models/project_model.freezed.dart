// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) {
  return _ProjectModel.fromJson(json);
}

/// @nodoc
mixin _$ProjectModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt =>
      throw _privateConstructorUsedError; // Project details
  String? get description => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError; // Hex color for UI
// Team and department
  String? get teamId => throw _privateConstructorUsedError;
  String? get departmentId => throw _privateConstructorUsedError; // Dates
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  DateTime? get dueDate =>
      throw _privateConstructorUsedError; // Status and priority
  ProjectStatus get status => throw _privateConstructorUsedError;
  ProjectPriority get priority => throw _privateConstructorUsedError; // Metrics
  int get totalTasks => throw _privateConstructorUsedError;
  int get completedTasks => throw _privateConstructorUsedError;
  int get totalBudget => throw _privateConstructorUsedError;
  int get spentBudget => throw _privateConstructorUsedError; // Team members
  List<String> get memberIds =>
      throw _privateConstructorUsedError; // Completion percentage (calculated)
  int get completionPercentage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectModelCopyWith<ProjectModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectModelCopyWith<$Res> {
  factory $ProjectModelCopyWith(
          ProjectModel value, $Res Function(ProjectModel) then) =
      _$ProjectModelCopyWithImpl<$Res, ProjectModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String organizationId,
      String createdBy,
      DateTime createdAt,
      DateTime updatedAt,
      String? description,
      String? icon,
      String? color,
      String? teamId,
      String? departmentId,
      DateTime? startDate,
      DateTime? endDate,
      DateTime? dueDate,
      ProjectStatus status,
      ProjectPriority priority,
      int totalTasks,
      int completedTasks,
      int totalBudget,
      int spentBudget,
      List<String> memberIds,
      int completionPercentage});
}

/// @nodoc
class _$ProjectModelCopyWithImpl<$Res, $Val extends ProjectModel>
    implements $ProjectModelCopyWith<$Res> {
  _$ProjectModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? organizationId = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? color = freezed,
    Object? teamId = freezed,
    Object? departmentId = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? dueDate = freezed,
    Object? status = null,
    Object? priority = null,
    Object? totalTasks = null,
    Object? completedTasks = null,
    Object? totalBudget = null,
    Object? spentBudget = null,
    Object? memberIds = null,
    Object? completionPercentage = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      departmentId: freezed == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProjectStatus,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as ProjectPriority,
      totalTasks: null == totalTasks
          ? _value.totalTasks
          : totalTasks // ignore: cast_nullable_to_non_nullable
              as int,
      completedTasks: null == completedTasks
          ? _value.completedTasks
          : completedTasks // ignore: cast_nullable_to_non_nullable
              as int,
      totalBudget: null == totalBudget
          ? _value.totalBudget
          : totalBudget // ignore: cast_nullable_to_non_nullable
              as int,
      spentBudget: null == spentBudget
          ? _value.spentBudget
          : spentBudget // ignore: cast_nullable_to_non_nullable
              as int,
      memberIds: null == memberIds
          ? _value.memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      completionPercentage: null == completionPercentage
          ? _value.completionPercentage
          : completionPercentage // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectModelImplCopyWith<$Res>
    implements $ProjectModelCopyWith<$Res> {
  factory _$$ProjectModelImplCopyWith(
          _$ProjectModelImpl value, $Res Function(_$ProjectModelImpl) then) =
      __$$ProjectModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String organizationId,
      String createdBy,
      DateTime createdAt,
      DateTime updatedAt,
      String? description,
      String? icon,
      String? color,
      String? teamId,
      String? departmentId,
      DateTime? startDate,
      DateTime? endDate,
      DateTime? dueDate,
      ProjectStatus status,
      ProjectPriority priority,
      int totalTasks,
      int completedTasks,
      int totalBudget,
      int spentBudget,
      List<String> memberIds,
      int completionPercentage});
}

/// @nodoc
class __$$ProjectModelImplCopyWithImpl<$Res>
    extends _$ProjectModelCopyWithImpl<$Res, _$ProjectModelImpl>
    implements _$$ProjectModelImplCopyWith<$Res> {
  __$$ProjectModelImplCopyWithImpl(
      _$ProjectModelImpl _value, $Res Function(_$ProjectModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? organizationId = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? color = freezed,
    Object? teamId = freezed,
    Object? departmentId = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? dueDate = freezed,
    Object? status = null,
    Object? priority = null,
    Object? totalTasks = null,
    Object? completedTasks = null,
    Object? totalBudget = null,
    Object? spentBudget = null,
    Object? memberIds = null,
    Object? completionPercentage = null,
  }) {
    return _then(_$ProjectModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      departmentId: freezed == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProjectStatus,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as ProjectPriority,
      totalTasks: null == totalTasks
          ? _value.totalTasks
          : totalTasks // ignore: cast_nullable_to_non_nullable
              as int,
      completedTasks: null == completedTasks
          ? _value.completedTasks
          : completedTasks // ignore: cast_nullable_to_non_nullable
              as int,
      totalBudget: null == totalBudget
          ? _value.totalBudget
          : totalBudget // ignore: cast_nullable_to_non_nullable
              as int,
      spentBudget: null == spentBudget
          ? _value.spentBudget
          : spentBudget // ignore: cast_nullable_to_non_nullable
              as int,
      memberIds: null == memberIds
          ? _value._memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      completionPercentage: null == completionPercentage
          ? _value.completionPercentage
          : completionPercentage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectModelImpl extends _ProjectModel {
  const _$ProjectModelImpl(
      {required this.id,
      required this.name,
      required this.organizationId,
      required this.createdBy,
      required this.createdAt,
      required this.updatedAt,
      this.description,
      this.icon,
      this.color,
      this.teamId,
      this.departmentId,
      this.startDate,
      this.endDate,
      this.dueDate,
      this.status = ProjectStatus.planning,
      this.priority = ProjectPriority.medium,
      this.totalTasks = 0,
      this.completedTasks = 0,
      this.totalBudget = 0,
      this.spentBudget = 0,
      final List<String> memberIds = const [],
      this.completionPercentage = 0})
      : _memberIds = memberIds,
        super._();

  factory _$ProjectModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String organizationId;
  @override
  final String createdBy;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
// Project details
  @override
  final String? description;
  @override
  final String? icon;
  @override
  final String? color;
// Hex color for UI
// Team and department
  @override
  final String? teamId;
  @override
  final String? departmentId;
// Dates
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final DateTime? dueDate;
// Status and priority
  @override
  @JsonKey()
  final ProjectStatus status;
  @override
  @JsonKey()
  final ProjectPriority priority;
// Metrics
  @override
  @JsonKey()
  final int totalTasks;
  @override
  @JsonKey()
  final int completedTasks;
  @override
  @JsonKey()
  final int totalBudget;
  @override
  @JsonKey()
  final int spentBudget;
// Team members
  final List<String> _memberIds;
// Team members
  @override
  @JsonKey()
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

// Completion percentage (calculated)
  @override
  @JsonKey()
  final int completionPercentage;

  @override
  String toString() {
    return 'ProjectModel(id: $id, name: $name, organizationId: $organizationId, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, icon: $icon, color: $color, teamId: $teamId, departmentId: $departmentId, startDate: $startDate, endDate: $endDate, dueDate: $dueDate, status: $status, priority: $priority, totalTasks: $totalTasks, completedTasks: $completedTasks, totalBudget: $totalBudget, spentBudget: $spentBudget, memberIds: $memberIds, completionPercentage: $completionPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.departmentId, departmentId) ||
                other.departmentId == departmentId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.totalTasks, totalTasks) ||
                other.totalTasks == totalTasks) &&
            (identical(other.completedTasks, completedTasks) ||
                other.completedTasks == completedTasks) &&
            (identical(other.totalBudget, totalBudget) ||
                other.totalBudget == totalBudget) &&
            (identical(other.spentBudget, spentBudget) ||
                other.spentBudget == spentBudget) &&
            const DeepCollectionEquality()
                .equals(other._memberIds, _memberIds) &&
            (identical(other.completionPercentage, completionPercentage) ||
                other.completionPercentage == completionPercentage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        organizationId,
        createdBy,
        createdAt,
        updatedAt,
        description,
        icon,
        color,
        teamId,
        departmentId,
        startDate,
        endDate,
        dueDate,
        status,
        priority,
        totalTasks,
        completedTasks,
        totalBudget,
        spentBudget,
        const DeepCollectionEquality().hash(_memberIds),
        completionPercentage
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectModelImplCopyWith<_$ProjectModelImpl> get copyWith =>
      __$$ProjectModelImplCopyWithImpl<_$ProjectModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectModelImplToJson(
      this,
    );
  }
}

abstract class _ProjectModel extends ProjectModel {
  const factory _ProjectModel(
      {required final String id,
      required final String name,
      required final String organizationId,
      required final String createdBy,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? description,
      final String? icon,
      final String? color,
      final String? teamId,
      final String? departmentId,
      final DateTime? startDate,
      final DateTime? endDate,
      final DateTime? dueDate,
      final ProjectStatus status,
      final ProjectPriority priority,
      final int totalTasks,
      final int completedTasks,
      final int totalBudget,
      final int spentBudget,
      final List<String> memberIds,
      final int completionPercentage}) = _$ProjectModelImpl;
  const _ProjectModel._() : super._();

  factory _ProjectModel.fromJson(Map<String, dynamic> json) =
      _$ProjectModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get organizationId;
  @override
  String get createdBy;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override // Project details
  String? get description;
  @override
  String? get icon;
  @override
  String? get color;
  @override // Hex color for UI
// Team and department
  String? get teamId;
  @override
  String? get departmentId;
  @override // Dates
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  DateTime? get dueDate;
  @override // Status and priority
  ProjectStatus get status;
  @override
  ProjectPriority get priority;
  @override // Metrics
  int get totalTasks;
  @override
  int get completedTasks;
  @override
  int get totalBudget;
  @override
  int get spentBudget;
  @override // Team members
  List<String> get memberIds;
  @override // Completion percentage (calculated)
  int get completionPercentage;
  @override
  @JsonKey(ignore: true)
  _$$ProjectModelImplCopyWith<_$ProjectModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
