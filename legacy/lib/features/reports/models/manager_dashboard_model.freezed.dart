// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manager_dashboard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ManagerDashboardModel _$ManagerDashboardModelFromJson(
    Map<String, dynamic> json) {
  return _ManagerDashboardModel.fromJson(json);
}

/// @nodoc
mixin _$ManagerDashboardModel {
  String get managerId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get departmentId => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  Period get period => throw _privateConstructorUsedError;
  DateTime get periodStart => throw _privateConstructorUsedError;
  DateTime get periodEnd => throw _privateConstructorUsedError; // Team Overview
  int get totalTeams => throw _privateConstructorUsedError;
  int get activeTeams => throw _privateConstructorUsedError;
  int get totalMembers => throw _privateConstructorUsedError;
  int get activeMembers =>
      throw _privateConstructorUsedError; // Task Statistics
  int get totalTasks => throw _privateConstructorUsedError;
  int get completedTasks => throw _privateConstructorUsedError;
  int get inProgressTasks => throw _privateConstructorUsedError;
  int get overdueTasks => throw _privateConstructorUsedError;
  int get tasksCompletedToday => throw _privateConstructorUsedError;
  int get tasksCompletedThisWeek => throw _privateConstructorUsedError;
  int get tasksCompletedThisMonth =>
      throw _privateConstructorUsedError; // Performance Metrics
  double get completionRate => throw _privateConstructorUsedError;
  double get onTimeRate => throw _privateConstructorUsedError;
  double get averageQualityRating => throw _privateConstructorUsedError;
  int get totalXPEarned => throw _privateConstructorUsedError;
  int get averageTaskTime => throw _privateConstructorUsedError; // in hours
// Top Performers
  List<TopPerformer> get topPerformers => throw _privateConstructorUsedError;
  List<String> get topTeams =>
      throw _privateConstructorUsedError; // Problem Areas
  List<PerformanceIssue> get overdueTasksByMember =>
      throw _privateConstructorUsedError;
  List<String> get lowPerformers => throw _privateConstructorUsedError;
  List<ProjectAtRisk> get projectsAtRisk =>
      throw _privateConstructorUsedError; // Trends
  double get productivityTrend =>
      throw _privateConstructorUsedError; // percentage change
  double get qualityTrend => throw _privateConstructorUsedError;
  double get completionTrend =>
      throw _privateConstructorUsedError; // Gamification
  int get achievementsUnlocked => throw _privateConstructorUsedError;
  int get activeStreaks => throw _privateConstructorUsedError;
  List<String> get teamAchievements => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ManagerDashboardModelCopyWith<ManagerDashboardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManagerDashboardModelCopyWith<$Res> {
  factory $ManagerDashboardModelCopyWith(ManagerDashboardModel value,
          $Res Function(ManagerDashboardModel) then) =
      _$ManagerDashboardModelCopyWithImpl<$Res, ManagerDashboardModel>;
  @useResult
  $Res call(
      {String managerId,
      String organizationId,
      String departmentId,
      DateTime generatedAt,
      Period period,
      DateTime periodStart,
      DateTime periodEnd,
      int totalTeams,
      int activeTeams,
      int totalMembers,
      int activeMembers,
      int totalTasks,
      int completedTasks,
      int inProgressTasks,
      int overdueTasks,
      int tasksCompletedToday,
      int tasksCompletedThisWeek,
      int tasksCompletedThisMonth,
      double completionRate,
      double onTimeRate,
      double averageQualityRating,
      int totalXPEarned,
      int averageTaskTime,
      List<TopPerformer> topPerformers,
      List<String> topTeams,
      List<PerformanceIssue> overdueTasksByMember,
      List<String> lowPerformers,
      List<ProjectAtRisk> projectsAtRisk,
      double productivityTrend,
      double qualityTrend,
      double completionTrend,
      int achievementsUnlocked,
      int activeStreaks,
      List<String> teamAchievements});
}

/// @nodoc
class _$ManagerDashboardModelCopyWithImpl<$Res,
        $Val extends ManagerDashboardModel>
    implements $ManagerDashboardModelCopyWith<$Res> {
  _$ManagerDashboardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? managerId = null,
    Object? organizationId = null,
    Object? departmentId = null,
    Object? generatedAt = null,
    Object? period = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? totalTeams = null,
    Object? activeTeams = null,
    Object? totalMembers = null,
    Object? activeMembers = null,
    Object? totalTasks = null,
    Object? completedTasks = null,
    Object? inProgressTasks = null,
    Object? overdueTasks = null,
    Object? tasksCompletedToday = null,
    Object? tasksCompletedThisWeek = null,
    Object? tasksCompletedThisMonth = null,
    Object? completionRate = null,
    Object? onTimeRate = null,
    Object? averageQualityRating = null,
    Object? totalXPEarned = null,
    Object? averageTaskTime = null,
    Object? topPerformers = null,
    Object? topTeams = null,
    Object? overdueTasksByMember = null,
    Object? lowPerformers = null,
    Object? projectsAtRisk = null,
    Object? productivityTrend = null,
    Object? qualityTrend = null,
    Object? completionTrend = null,
    Object? achievementsUnlocked = null,
    Object? activeStreaks = null,
    Object? teamAchievements = null,
  }) {
    return _then(_value.copyWith(
      managerId: null == managerId
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      departmentId: null == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as Period,
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalTeams: null == totalTeams
          ? _value.totalTeams
          : totalTeams // ignore: cast_nullable_to_non_nullable
              as int,
      activeTeams: null == activeTeams
          ? _value.activeTeams
          : activeTeams // ignore: cast_nullable_to_non_nullable
              as int,
      totalMembers: null == totalMembers
          ? _value.totalMembers
          : totalMembers // ignore: cast_nullable_to_non_nullable
              as int,
      activeMembers: null == activeMembers
          ? _value.activeMembers
          : activeMembers // ignore: cast_nullable_to_non_nullable
              as int,
      totalTasks: null == totalTasks
          ? _value.totalTasks
          : totalTasks // ignore: cast_nullable_to_non_nullable
              as int,
      completedTasks: null == completedTasks
          ? _value.completedTasks
          : completedTasks // ignore: cast_nullable_to_non_nullable
              as int,
      inProgressTasks: null == inProgressTasks
          ? _value.inProgressTasks
          : inProgressTasks // ignore: cast_nullable_to_non_nullable
              as int,
      overdueTasks: null == overdueTasks
          ? _value.overdueTasks
          : overdueTasks // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompletedToday: null == tasksCompletedToday
          ? _value.tasksCompletedToday
          : tasksCompletedToday // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompletedThisWeek: null == tasksCompletedThisWeek
          ? _value.tasksCompletedThisWeek
          : tasksCompletedThisWeek // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompletedThisMonth: null == tasksCompletedThisMonth
          ? _value.tasksCompletedThisMonth
          : tasksCompletedThisMonth // ignore: cast_nullable_to_non_nullable
              as int,
      completionRate: null == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double,
      onTimeRate: null == onTimeRate
          ? _value.onTimeRate
          : onTimeRate // ignore: cast_nullable_to_non_nullable
              as double,
      averageQualityRating: null == averageQualityRating
          ? _value.averageQualityRating
          : averageQualityRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalXPEarned: null == totalXPEarned
          ? _value.totalXPEarned
          : totalXPEarned // ignore: cast_nullable_to_non_nullable
              as int,
      averageTaskTime: null == averageTaskTime
          ? _value.averageTaskTime
          : averageTaskTime // ignore: cast_nullable_to_non_nullable
              as int,
      topPerformers: null == topPerformers
          ? _value.topPerformers
          : topPerformers // ignore: cast_nullable_to_non_nullable
              as List<TopPerformer>,
      topTeams: null == topTeams
          ? _value.topTeams
          : topTeams // ignore: cast_nullable_to_non_nullable
              as List<String>,
      overdueTasksByMember: null == overdueTasksByMember
          ? _value.overdueTasksByMember
          : overdueTasksByMember // ignore: cast_nullable_to_non_nullable
              as List<PerformanceIssue>,
      lowPerformers: null == lowPerformers
          ? _value.lowPerformers
          : lowPerformers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      projectsAtRisk: null == projectsAtRisk
          ? _value.projectsAtRisk
          : projectsAtRisk // ignore: cast_nullable_to_non_nullable
              as List<ProjectAtRisk>,
      productivityTrend: null == productivityTrend
          ? _value.productivityTrend
          : productivityTrend // ignore: cast_nullable_to_non_nullable
              as double,
      qualityTrend: null == qualityTrend
          ? _value.qualityTrend
          : qualityTrend // ignore: cast_nullable_to_non_nullable
              as double,
      completionTrend: null == completionTrend
          ? _value.completionTrend
          : completionTrend // ignore: cast_nullable_to_non_nullable
              as double,
      achievementsUnlocked: null == achievementsUnlocked
          ? _value.achievementsUnlocked
          : achievementsUnlocked // ignore: cast_nullable_to_non_nullable
              as int,
      activeStreaks: null == activeStreaks
          ? _value.activeStreaks
          : activeStreaks // ignore: cast_nullable_to_non_nullable
              as int,
      teamAchievements: null == teamAchievements
          ? _value.teamAchievements
          : teamAchievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ManagerDashboardModelImplCopyWith<$Res>
    implements $ManagerDashboardModelCopyWith<$Res> {
  factory _$$ManagerDashboardModelImplCopyWith(
          _$ManagerDashboardModelImpl value,
          $Res Function(_$ManagerDashboardModelImpl) then) =
      __$$ManagerDashboardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String managerId,
      String organizationId,
      String departmentId,
      DateTime generatedAt,
      Period period,
      DateTime periodStart,
      DateTime periodEnd,
      int totalTeams,
      int activeTeams,
      int totalMembers,
      int activeMembers,
      int totalTasks,
      int completedTasks,
      int inProgressTasks,
      int overdueTasks,
      int tasksCompletedToday,
      int tasksCompletedThisWeek,
      int tasksCompletedThisMonth,
      double completionRate,
      double onTimeRate,
      double averageQualityRating,
      int totalXPEarned,
      int averageTaskTime,
      List<TopPerformer> topPerformers,
      List<String> topTeams,
      List<PerformanceIssue> overdueTasksByMember,
      List<String> lowPerformers,
      List<ProjectAtRisk> projectsAtRisk,
      double productivityTrend,
      double qualityTrend,
      double completionTrend,
      int achievementsUnlocked,
      int activeStreaks,
      List<String> teamAchievements});
}

/// @nodoc
class __$$ManagerDashboardModelImplCopyWithImpl<$Res>
    extends _$ManagerDashboardModelCopyWithImpl<$Res,
        _$ManagerDashboardModelImpl>
    implements _$$ManagerDashboardModelImplCopyWith<$Res> {
  __$$ManagerDashboardModelImplCopyWithImpl(_$ManagerDashboardModelImpl _value,
      $Res Function(_$ManagerDashboardModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? managerId = null,
    Object? organizationId = null,
    Object? departmentId = null,
    Object? generatedAt = null,
    Object? period = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? totalTeams = null,
    Object? activeTeams = null,
    Object? totalMembers = null,
    Object? activeMembers = null,
    Object? totalTasks = null,
    Object? completedTasks = null,
    Object? inProgressTasks = null,
    Object? overdueTasks = null,
    Object? tasksCompletedToday = null,
    Object? tasksCompletedThisWeek = null,
    Object? tasksCompletedThisMonth = null,
    Object? completionRate = null,
    Object? onTimeRate = null,
    Object? averageQualityRating = null,
    Object? totalXPEarned = null,
    Object? averageTaskTime = null,
    Object? topPerformers = null,
    Object? topTeams = null,
    Object? overdueTasksByMember = null,
    Object? lowPerformers = null,
    Object? projectsAtRisk = null,
    Object? productivityTrend = null,
    Object? qualityTrend = null,
    Object? completionTrend = null,
    Object? achievementsUnlocked = null,
    Object? activeStreaks = null,
    Object? teamAchievements = null,
  }) {
    return _then(_$ManagerDashboardModelImpl(
      managerId: null == managerId
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      departmentId: null == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as Period,
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalTeams: null == totalTeams
          ? _value.totalTeams
          : totalTeams // ignore: cast_nullable_to_non_nullable
              as int,
      activeTeams: null == activeTeams
          ? _value.activeTeams
          : activeTeams // ignore: cast_nullable_to_non_nullable
              as int,
      totalMembers: null == totalMembers
          ? _value.totalMembers
          : totalMembers // ignore: cast_nullable_to_non_nullable
              as int,
      activeMembers: null == activeMembers
          ? _value.activeMembers
          : activeMembers // ignore: cast_nullable_to_non_nullable
              as int,
      totalTasks: null == totalTasks
          ? _value.totalTasks
          : totalTasks // ignore: cast_nullable_to_non_nullable
              as int,
      completedTasks: null == completedTasks
          ? _value.completedTasks
          : completedTasks // ignore: cast_nullable_to_non_nullable
              as int,
      inProgressTasks: null == inProgressTasks
          ? _value.inProgressTasks
          : inProgressTasks // ignore: cast_nullable_to_non_nullable
              as int,
      overdueTasks: null == overdueTasks
          ? _value.overdueTasks
          : overdueTasks // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompletedToday: null == tasksCompletedToday
          ? _value.tasksCompletedToday
          : tasksCompletedToday // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompletedThisWeek: null == tasksCompletedThisWeek
          ? _value.tasksCompletedThisWeek
          : tasksCompletedThisWeek // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompletedThisMonth: null == tasksCompletedThisMonth
          ? _value.tasksCompletedThisMonth
          : tasksCompletedThisMonth // ignore: cast_nullable_to_non_nullable
              as int,
      completionRate: null == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double,
      onTimeRate: null == onTimeRate
          ? _value.onTimeRate
          : onTimeRate // ignore: cast_nullable_to_non_nullable
              as double,
      averageQualityRating: null == averageQualityRating
          ? _value.averageQualityRating
          : averageQualityRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalXPEarned: null == totalXPEarned
          ? _value.totalXPEarned
          : totalXPEarned // ignore: cast_nullable_to_non_nullable
              as int,
      averageTaskTime: null == averageTaskTime
          ? _value.averageTaskTime
          : averageTaskTime // ignore: cast_nullable_to_non_nullable
              as int,
      topPerformers: null == topPerformers
          ? _value._topPerformers
          : topPerformers // ignore: cast_nullable_to_non_nullable
              as List<TopPerformer>,
      topTeams: null == topTeams
          ? _value._topTeams
          : topTeams // ignore: cast_nullable_to_non_nullable
              as List<String>,
      overdueTasksByMember: null == overdueTasksByMember
          ? _value._overdueTasksByMember
          : overdueTasksByMember // ignore: cast_nullable_to_non_nullable
              as List<PerformanceIssue>,
      lowPerformers: null == lowPerformers
          ? _value._lowPerformers
          : lowPerformers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      projectsAtRisk: null == projectsAtRisk
          ? _value._projectsAtRisk
          : projectsAtRisk // ignore: cast_nullable_to_non_nullable
              as List<ProjectAtRisk>,
      productivityTrend: null == productivityTrend
          ? _value.productivityTrend
          : productivityTrend // ignore: cast_nullable_to_non_nullable
              as double,
      qualityTrend: null == qualityTrend
          ? _value.qualityTrend
          : qualityTrend // ignore: cast_nullable_to_non_nullable
              as double,
      completionTrend: null == completionTrend
          ? _value.completionTrend
          : completionTrend // ignore: cast_nullable_to_non_nullable
              as double,
      achievementsUnlocked: null == achievementsUnlocked
          ? _value.achievementsUnlocked
          : achievementsUnlocked // ignore: cast_nullable_to_non_nullable
              as int,
      activeStreaks: null == activeStreaks
          ? _value.activeStreaks
          : activeStreaks // ignore: cast_nullable_to_non_nullable
              as int,
      teamAchievements: null == teamAchievements
          ? _value._teamAchievements
          : teamAchievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ManagerDashboardModelImpl implements _ManagerDashboardModel {
  const _$ManagerDashboardModelImpl(
      {required this.managerId,
      required this.organizationId,
      required this.departmentId,
      required this.generatedAt,
      required this.period,
      required this.periodStart,
      required this.periodEnd,
      required this.totalTeams,
      required this.activeTeams,
      required this.totalMembers,
      required this.activeMembers,
      required this.totalTasks,
      required this.completedTasks,
      required this.inProgressTasks,
      required this.overdueTasks,
      required this.tasksCompletedToday,
      required this.tasksCompletedThisWeek,
      required this.tasksCompletedThisMonth,
      required this.completionRate,
      required this.onTimeRate,
      required this.averageQualityRating,
      required this.totalXPEarned,
      required this.averageTaskTime,
      required final List<TopPerformer> topPerformers,
      required final List<String> topTeams,
      required final List<PerformanceIssue> overdueTasksByMember,
      required final List<String> lowPerformers,
      required final List<ProjectAtRisk> projectsAtRisk,
      required this.productivityTrend,
      required this.qualityTrend,
      required this.completionTrend,
      required this.achievementsUnlocked,
      required this.activeStreaks,
      required final List<String> teamAchievements})
      : _topPerformers = topPerformers,
        _topTeams = topTeams,
        _overdueTasksByMember = overdueTasksByMember,
        _lowPerformers = lowPerformers,
        _projectsAtRisk = projectsAtRisk,
        _teamAchievements = teamAchievements;

  factory _$ManagerDashboardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ManagerDashboardModelImplFromJson(json);

  @override
  final String managerId;
  @override
  final String organizationId;
  @override
  final String departmentId;
  @override
  final DateTime generatedAt;
  @override
  final Period period;
  @override
  final DateTime periodStart;
  @override
  final DateTime periodEnd;
// Team Overview
  @override
  final int totalTeams;
  @override
  final int activeTeams;
  @override
  final int totalMembers;
  @override
  final int activeMembers;
// Task Statistics
  @override
  final int totalTasks;
  @override
  final int completedTasks;
  @override
  final int inProgressTasks;
  @override
  final int overdueTasks;
  @override
  final int tasksCompletedToday;
  @override
  final int tasksCompletedThisWeek;
  @override
  final int tasksCompletedThisMonth;
// Performance Metrics
  @override
  final double completionRate;
  @override
  final double onTimeRate;
  @override
  final double averageQualityRating;
  @override
  final int totalXPEarned;
  @override
  final int averageTaskTime;
// in hours
// Top Performers
  final List<TopPerformer> _topPerformers;
// in hours
// Top Performers
  @override
  List<TopPerformer> get topPerformers {
    if (_topPerformers is EqualUnmodifiableListView) return _topPerformers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topPerformers);
  }

  final List<String> _topTeams;
  @override
  List<String> get topTeams {
    if (_topTeams is EqualUnmodifiableListView) return _topTeams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topTeams);
  }

// Problem Areas
  final List<PerformanceIssue> _overdueTasksByMember;
// Problem Areas
  @override
  List<PerformanceIssue> get overdueTasksByMember {
    if (_overdueTasksByMember is EqualUnmodifiableListView)
      return _overdueTasksByMember;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_overdueTasksByMember);
  }

  final List<String> _lowPerformers;
  @override
  List<String> get lowPerformers {
    if (_lowPerformers is EqualUnmodifiableListView) return _lowPerformers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lowPerformers);
  }

  final List<ProjectAtRisk> _projectsAtRisk;
  @override
  List<ProjectAtRisk> get projectsAtRisk {
    if (_projectsAtRisk is EqualUnmodifiableListView) return _projectsAtRisk;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projectsAtRisk);
  }

// Trends
  @override
  final double productivityTrend;
// percentage change
  @override
  final double qualityTrend;
  @override
  final double completionTrend;
// Gamification
  @override
  final int achievementsUnlocked;
  @override
  final int activeStreaks;
  final List<String> _teamAchievements;
  @override
  List<String> get teamAchievements {
    if (_teamAchievements is EqualUnmodifiableListView)
      return _teamAchievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamAchievements);
  }

  @override
  String toString() {
    return 'ManagerDashboardModel(managerId: $managerId, organizationId: $organizationId, departmentId: $departmentId, generatedAt: $generatedAt, period: $period, periodStart: $periodStart, periodEnd: $periodEnd, totalTeams: $totalTeams, activeTeams: $activeTeams, totalMembers: $totalMembers, activeMembers: $activeMembers, totalTasks: $totalTasks, completedTasks: $completedTasks, inProgressTasks: $inProgressTasks, overdueTasks: $overdueTasks, tasksCompletedToday: $tasksCompletedToday, tasksCompletedThisWeek: $tasksCompletedThisWeek, tasksCompletedThisMonth: $tasksCompletedThisMonth, completionRate: $completionRate, onTimeRate: $onTimeRate, averageQualityRating: $averageQualityRating, totalXPEarned: $totalXPEarned, averageTaskTime: $averageTaskTime, topPerformers: $topPerformers, topTeams: $topTeams, overdueTasksByMember: $overdueTasksByMember, lowPerformers: $lowPerformers, projectsAtRisk: $projectsAtRisk, productivityTrend: $productivityTrend, qualityTrend: $qualityTrend, completionTrend: $completionTrend, achievementsUnlocked: $achievementsUnlocked, activeStreaks: $activeStreaks, teamAchievements: $teamAchievements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ManagerDashboardModelImpl &&
            (identical(other.managerId, managerId) ||
                other.managerId == managerId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.departmentId, departmentId) ||
                other.departmentId == departmentId) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            (identical(other.totalTeams, totalTeams) ||
                other.totalTeams == totalTeams) &&
            (identical(other.activeTeams, activeTeams) ||
                other.activeTeams == activeTeams) &&
            (identical(other.totalMembers, totalMembers) ||
                other.totalMembers == totalMembers) &&
            (identical(other.activeMembers, activeMembers) ||
                other.activeMembers == activeMembers) &&
            (identical(other.totalTasks, totalTasks) ||
                other.totalTasks == totalTasks) &&
            (identical(other.completedTasks, completedTasks) ||
                other.completedTasks == completedTasks) &&
            (identical(other.inProgressTasks, inProgressTasks) ||
                other.inProgressTasks == inProgressTasks) &&
            (identical(other.overdueTasks, overdueTasks) ||
                other.overdueTasks == overdueTasks) &&
            (identical(other.tasksCompletedToday, tasksCompletedToday) ||
                other.tasksCompletedToday == tasksCompletedToday) &&
            (identical(other.tasksCompletedThisWeek, tasksCompletedThisWeek) ||
                other.tasksCompletedThisWeek == tasksCompletedThisWeek) &&
            (identical(
                    other.tasksCompletedThisMonth, tasksCompletedThisMonth) ||
                other.tasksCompletedThisMonth == tasksCompletedThisMonth) &&
            (identical(other.completionRate, completionRate) ||
                other.completionRate == completionRate) &&
            (identical(other.onTimeRate, onTimeRate) ||
                other.onTimeRate == onTimeRate) &&
            (identical(other.averageQualityRating, averageQualityRating) ||
                other.averageQualityRating == averageQualityRating) &&
            (identical(other.totalXPEarned, totalXPEarned) ||
                other.totalXPEarned == totalXPEarned) &&
            (identical(other.averageTaskTime, averageTaskTime) ||
                other.averageTaskTime == averageTaskTime) &&
            const DeepCollectionEquality()
                .equals(other._topPerformers, _topPerformers) &&
            const DeepCollectionEquality().equals(other._topTeams, _topTeams) &&
            const DeepCollectionEquality()
                .equals(other._overdueTasksByMember, _overdueTasksByMember) &&
            const DeepCollectionEquality()
                .equals(other._lowPerformers, _lowPerformers) &&
            const DeepCollectionEquality()
                .equals(other._projectsAtRisk, _projectsAtRisk) &&
            (identical(other.productivityTrend, productivityTrend) ||
                other.productivityTrend == productivityTrend) &&
            (identical(other.qualityTrend, qualityTrend) ||
                other.qualityTrend == qualityTrend) &&
            (identical(other.completionTrend, completionTrend) ||
                other.completionTrend == completionTrend) &&
            (identical(other.achievementsUnlocked, achievementsUnlocked) ||
                other.achievementsUnlocked == achievementsUnlocked) &&
            (identical(other.activeStreaks, activeStreaks) ||
                other.activeStreaks == activeStreaks) &&
            const DeepCollectionEquality()
                .equals(other._teamAchievements, _teamAchievements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        managerId,
        organizationId,
        departmentId,
        generatedAt,
        period,
        periodStart,
        periodEnd,
        totalTeams,
        activeTeams,
        totalMembers,
        activeMembers,
        totalTasks,
        completedTasks,
        inProgressTasks,
        overdueTasks,
        tasksCompletedToday,
        tasksCompletedThisWeek,
        tasksCompletedThisMonth,
        completionRate,
        onTimeRate,
        averageQualityRating,
        totalXPEarned,
        averageTaskTime,
        const DeepCollectionEquality().hash(_topPerformers),
        const DeepCollectionEquality().hash(_topTeams),
        const DeepCollectionEquality().hash(_overdueTasksByMember),
        const DeepCollectionEquality().hash(_lowPerformers),
        const DeepCollectionEquality().hash(_projectsAtRisk),
        productivityTrend,
        qualityTrend,
        completionTrend,
        achievementsUnlocked,
        activeStreaks,
        const DeepCollectionEquality().hash(_teamAchievements)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ManagerDashboardModelImplCopyWith<_$ManagerDashboardModelImpl>
      get copyWith => __$$ManagerDashboardModelImplCopyWithImpl<
          _$ManagerDashboardModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ManagerDashboardModelImplToJson(
      this,
    );
  }
}

abstract class _ManagerDashboardModel implements ManagerDashboardModel {
  const factory _ManagerDashboardModel(
          {required final String managerId,
          required final String organizationId,
          required final String departmentId,
          required final DateTime generatedAt,
          required final Period period,
          required final DateTime periodStart,
          required final DateTime periodEnd,
          required final int totalTeams,
          required final int activeTeams,
          required final int totalMembers,
          required final int activeMembers,
          required final int totalTasks,
          required final int completedTasks,
          required final int inProgressTasks,
          required final int overdueTasks,
          required final int tasksCompletedToday,
          required final int tasksCompletedThisWeek,
          required final int tasksCompletedThisMonth,
          required final double completionRate,
          required final double onTimeRate,
          required final double averageQualityRating,
          required final int totalXPEarned,
          required final int averageTaskTime,
          required final List<TopPerformer> topPerformers,
          required final List<String> topTeams,
          required final List<PerformanceIssue> overdueTasksByMember,
          required final List<String> lowPerformers,
          required final List<ProjectAtRisk> projectsAtRisk,
          required final double productivityTrend,
          required final double qualityTrend,
          required final double completionTrend,
          required final int achievementsUnlocked,
          required final int activeStreaks,
          required final List<String> teamAchievements}) =
      _$ManagerDashboardModelImpl;

  factory _ManagerDashboardModel.fromJson(Map<String, dynamic> json) =
      _$ManagerDashboardModelImpl.fromJson;

  @override
  String get managerId;
  @override
  String get organizationId;
  @override
  String get departmentId;
  @override
  DateTime get generatedAt;
  @override
  Period get period;
  @override
  DateTime get periodStart;
  @override
  DateTime get periodEnd;
  @override // Team Overview
  int get totalTeams;
  @override
  int get activeTeams;
  @override
  int get totalMembers;
  @override
  int get activeMembers;
  @override // Task Statistics
  int get totalTasks;
  @override
  int get completedTasks;
  @override
  int get inProgressTasks;
  @override
  int get overdueTasks;
  @override
  int get tasksCompletedToday;
  @override
  int get tasksCompletedThisWeek;
  @override
  int get tasksCompletedThisMonth;
  @override // Performance Metrics
  double get completionRate;
  @override
  double get onTimeRate;
  @override
  double get averageQualityRating;
  @override
  int get totalXPEarned;
  @override
  int get averageTaskTime;
  @override // in hours
// Top Performers
  List<TopPerformer> get topPerformers;
  @override
  List<String> get topTeams;
  @override // Problem Areas
  List<PerformanceIssue> get overdueTasksByMember;
  @override
  List<String> get lowPerformers;
  @override
  List<ProjectAtRisk> get projectsAtRisk;
  @override // Trends
  double get productivityTrend;
  @override // percentage change
  double get qualityTrend;
  @override
  double get completionTrend;
  @override // Gamification
  int get achievementsUnlocked;
  @override
  int get activeStreaks;
  @override
  List<String> get teamAchievements;
  @override
  @JsonKey(ignore: true)
  _$$ManagerDashboardModelImplCopyWith<_$ManagerDashboardModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TopPerformer _$TopPerformerFromJson(Map<String, dynamic> json) {
  return _TopPerformer.fromJson(json);
}

/// @nodoc
mixin _$TopPerformer {
  String get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  int get xpEarned => throw _privateConstructorUsedError;
  int get tasksCompleted => throw _privateConstructorUsedError;
  double get qualityRating => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopPerformerCopyWith<TopPerformer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopPerformerCopyWith<$Res> {
  factory $TopPerformerCopyWith(
          TopPerformer value, $Res Function(TopPerformer) then) =
      _$TopPerformerCopyWithImpl<$Res, TopPerformer>;
  @useResult
  $Res call(
      {String userId,
      String username,
      String fullName,
      String teamId,
      int xpEarned,
      int tasksCompleted,
      double qualityRating,
      int rank});
}

/// @nodoc
class _$TopPerformerCopyWithImpl<$Res, $Val extends TopPerformer>
    implements $TopPerformerCopyWith<$Res> {
  _$TopPerformerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? fullName = null,
    Object? teamId = null,
    Object? xpEarned = null,
    Object? tasksCompleted = null,
    Object? qualityRating = null,
    Object? rank = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      xpEarned: null == xpEarned
          ? _value.xpEarned
          : xpEarned // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompleted: null == tasksCompleted
          ? _value.tasksCompleted
          : tasksCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      qualityRating: null == qualityRating
          ? _value.qualityRating
          : qualityRating // ignore: cast_nullable_to_non_nullable
              as double,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopPerformerImplCopyWith<$Res>
    implements $TopPerformerCopyWith<$Res> {
  factory _$$TopPerformerImplCopyWith(
          _$TopPerformerImpl value, $Res Function(_$TopPerformerImpl) then) =
      __$$TopPerformerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String username,
      String fullName,
      String teamId,
      int xpEarned,
      int tasksCompleted,
      double qualityRating,
      int rank});
}

/// @nodoc
class __$$TopPerformerImplCopyWithImpl<$Res>
    extends _$TopPerformerCopyWithImpl<$Res, _$TopPerformerImpl>
    implements _$$TopPerformerImplCopyWith<$Res> {
  __$$TopPerformerImplCopyWithImpl(
      _$TopPerformerImpl _value, $Res Function(_$TopPerformerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? fullName = null,
    Object? teamId = null,
    Object? xpEarned = null,
    Object? tasksCompleted = null,
    Object? qualityRating = null,
    Object? rank = null,
  }) {
    return _then(_$TopPerformerImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      xpEarned: null == xpEarned
          ? _value.xpEarned
          : xpEarned // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompleted: null == tasksCompleted
          ? _value.tasksCompleted
          : tasksCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      qualityRating: null == qualityRating
          ? _value.qualityRating
          : qualityRating // ignore: cast_nullable_to_non_nullable
              as double,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopPerformerImpl implements _TopPerformer {
  const _$TopPerformerImpl(
      {required this.userId,
      required this.username,
      required this.fullName,
      required this.teamId,
      required this.xpEarned,
      required this.tasksCompleted,
      required this.qualityRating,
      required this.rank});

  factory _$TopPerformerImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopPerformerImplFromJson(json);

  @override
  final String userId;
  @override
  final String username;
  @override
  final String fullName;
  @override
  final String teamId;
  @override
  final int xpEarned;
  @override
  final int tasksCompleted;
  @override
  final double qualityRating;
  @override
  final int rank;

  @override
  String toString() {
    return 'TopPerformer(userId: $userId, username: $username, fullName: $fullName, teamId: $teamId, xpEarned: $xpEarned, tasksCompleted: $tasksCompleted, qualityRating: $qualityRating, rank: $rank)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopPerformerImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.xpEarned, xpEarned) ||
                other.xpEarned == xpEarned) &&
            (identical(other.tasksCompleted, tasksCompleted) ||
                other.tasksCompleted == tasksCompleted) &&
            (identical(other.qualityRating, qualityRating) ||
                other.qualityRating == qualityRating) &&
            (identical(other.rank, rank) || other.rank == rank));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, username, fullName,
      teamId, xpEarned, tasksCompleted, qualityRating, rank);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TopPerformerImplCopyWith<_$TopPerformerImpl> get copyWith =>
      __$$TopPerformerImplCopyWithImpl<_$TopPerformerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopPerformerImplToJson(
      this,
    );
  }
}

abstract class _TopPerformer implements TopPerformer {
  const factory _TopPerformer(
      {required final String userId,
      required final String username,
      required final String fullName,
      required final String teamId,
      required final int xpEarned,
      required final int tasksCompleted,
      required final double qualityRating,
      required final int rank}) = _$TopPerformerImpl;

  factory _TopPerformer.fromJson(Map<String, dynamic> json) =
      _$TopPerformerImpl.fromJson;

  @override
  String get userId;
  @override
  String get username;
  @override
  String get fullName;
  @override
  String get teamId;
  @override
  int get xpEarned;
  @override
  int get tasksCompleted;
  @override
  double get qualityRating;
  @override
  int get rank;
  @override
  @JsonKey(ignore: true)
  _$$TopPerformerImplCopyWith<_$TopPerformerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PerformanceIssue _$PerformanceIssueFromJson(Map<String, dynamic> json) {
  return _PerformanceIssue.fromJson(json);
}

/// @nodoc
mixin _$PerformanceIssue {
  String get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  int get overdueTasksCount => throw _privateConstructorUsedError;
  int get daysOverdue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PerformanceIssueCopyWith<PerformanceIssue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PerformanceIssueCopyWith<$Res> {
  factory $PerformanceIssueCopyWith(
          PerformanceIssue value, $Res Function(PerformanceIssue) then) =
      _$PerformanceIssueCopyWithImpl<$Res, PerformanceIssue>;
  @useResult
  $Res call(
      {String userId,
      String username,
      String fullName,
      String teamId,
      int overdueTasksCount,
      int daysOverdue});
}

/// @nodoc
class _$PerformanceIssueCopyWithImpl<$Res, $Val extends PerformanceIssue>
    implements $PerformanceIssueCopyWith<$Res> {
  _$PerformanceIssueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? fullName = null,
    Object? teamId = null,
    Object? overdueTasksCount = null,
    Object? daysOverdue = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      overdueTasksCount: null == overdueTasksCount
          ? _value.overdueTasksCount
          : overdueTasksCount // ignore: cast_nullable_to_non_nullable
              as int,
      daysOverdue: null == daysOverdue
          ? _value.daysOverdue
          : daysOverdue // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PerformanceIssueImplCopyWith<$Res>
    implements $PerformanceIssueCopyWith<$Res> {
  factory _$$PerformanceIssueImplCopyWith(_$PerformanceIssueImpl value,
          $Res Function(_$PerformanceIssueImpl) then) =
      __$$PerformanceIssueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String username,
      String fullName,
      String teamId,
      int overdueTasksCount,
      int daysOverdue});
}

/// @nodoc
class __$$PerformanceIssueImplCopyWithImpl<$Res>
    extends _$PerformanceIssueCopyWithImpl<$Res, _$PerformanceIssueImpl>
    implements _$$PerformanceIssueImplCopyWith<$Res> {
  __$$PerformanceIssueImplCopyWithImpl(_$PerformanceIssueImpl _value,
      $Res Function(_$PerformanceIssueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? fullName = null,
    Object? teamId = null,
    Object? overdueTasksCount = null,
    Object? daysOverdue = null,
  }) {
    return _then(_$PerformanceIssueImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      overdueTasksCount: null == overdueTasksCount
          ? _value.overdueTasksCount
          : overdueTasksCount // ignore: cast_nullable_to_non_nullable
              as int,
      daysOverdue: null == daysOverdue
          ? _value.daysOverdue
          : daysOverdue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PerformanceIssueImpl implements _PerformanceIssue {
  const _$PerformanceIssueImpl(
      {required this.userId,
      required this.username,
      required this.fullName,
      required this.teamId,
      required this.overdueTasksCount,
      required this.daysOverdue});

  factory _$PerformanceIssueImpl.fromJson(Map<String, dynamic> json) =>
      _$$PerformanceIssueImplFromJson(json);

  @override
  final String userId;
  @override
  final String username;
  @override
  final String fullName;
  @override
  final String teamId;
  @override
  final int overdueTasksCount;
  @override
  final int daysOverdue;

  @override
  String toString() {
    return 'PerformanceIssue(userId: $userId, username: $username, fullName: $fullName, teamId: $teamId, overdueTasksCount: $overdueTasksCount, daysOverdue: $daysOverdue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PerformanceIssueImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.overdueTasksCount, overdueTasksCount) ||
                other.overdueTasksCount == overdueTasksCount) &&
            (identical(other.daysOverdue, daysOverdue) ||
                other.daysOverdue == daysOverdue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, username, fullName,
      teamId, overdueTasksCount, daysOverdue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PerformanceIssueImplCopyWith<_$PerformanceIssueImpl> get copyWith =>
      __$$PerformanceIssueImplCopyWithImpl<_$PerformanceIssueImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PerformanceIssueImplToJson(
      this,
    );
  }
}

abstract class _PerformanceIssue implements PerformanceIssue {
  const factory _PerformanceIssue(
      {required final String userId,
      required final String username,
      required final String fullName,
      required final String teamId,
      required final int overdueTasksCount,
      required final int daysOverdue}) = _$PerformanceIssueImpl;

  factory _PerformanceIssue.fromJson(Map<String, dynamic> json) =
      _$PerformanceIssueImpl.fromJson;

  @override
  String get userId;
  @override
  String get username;
  @override
  String get fullName;
  @override
  String get teamId;
  @override
  int get overdueTasksCount;
  @override
  int get daysOverdue;
  @override
  @JsonKey(ignore: true)
  _$$PerformanceIssueImplCopyWith<_$PerformanceIssueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProjectAtRisk _$ProjectAtRiskFromJson(Map<String, dynamic> json) {
  return _ProjectAtRisk.fromJson(json);
}

/// @nodoc
mixin _$ProjectAtRisk {
  String get projectId => throw _privateConstructorUsedError;
  String get projectName => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  double get completionPercentage => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  int get daysUntilDue => throw _privateConstructorUsedError;
  RiskLevel get riskLevel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectAtRiskCopyWith<ProjectAtRisk> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectAtRiskCopyWith<$Res> {
  factory $ProjectAtRiskCopyWith(
          ProjectAtRisk value, $Res Function(ProjectAtRisk) then) =
      _$ProjectAtRiskCopyWithImpl<$Res, ProjectAtRisk>;
  @useResult
  $Res call(
      {String projectId,
      String projectName,
      String teamId,
      String teamName,
      double completionPercentage,
      DateTime dueDate,
      int daysUntilDue,
      RiskLevel riskLevel});
}

/// @nodoc
class _$ProjectAtRiskCopyWithImpl<$Res, $Val extends ProjectAtRisk>
    implements $ProjectAtRiskCopyWith<$Res> {
  _$ProjectAtRiskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? projectName = null,
    Object? teamId = null,
    Object? teamName = null,
    Object? completionPercentage = null,
    Object? dueDate = null,
    Object? daysUntilDue = null,
    Object? riskLevel = null,
  }) {
    return _then(_value.copyWith(
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      completionPercentage: null == completionPercentage
          ? _value.completionPercentage
          : completionPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      daysUntilDue: null == daysUntilDue
          ? _value.daysUntilDue
          : daysUntilDue // ignore: cast_nullable_to_non_nullable
              as int,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as RiskLevel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectAtRiskImplCopyWith<$Res>
    implements $ProjectAtRiskCopyWith<$Res> {
  factory _$$ProjectAtRiskImplCopyWith(
          _$ProjectAtRiskImpl value, $Res Function(_$ProjectAtRiskImpl) then) =
      __$$ProjectAtRiskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String projectId,
      String projectName,
      String teamId,
      String teamName,
      double completionPercentage,
      DateTime dueDate,
      int daysUntilDue,
      RiskLevel riskLevel});
}

/// @nodoc
class __$$ProjectAtRiskImplCopyWithImpl<$Res>
    extends _$ProjectAtRiskCopyWithImpl<$Res, _$ProjectAtRiskImpl>
    implements _$$ProjectAtRiskImplCopyWith<$Res> {
  __$$ProjectAtRiskImplCopyWithImpl(
      _$ProjectAtRiskImpl _value, $Res Function(_$ProjectAtRiskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? projectName = null,
    Object? teamId = null,
    Object? teamName = null,
    Object? completionPercentage = null,
    Object? dueDate = null,
    Object? daysUntilDue = null,
    Object? riskLevel = null,
  }) {
    return _then(_$ProjectAtRiskImpl(
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      completionPercentage: null == completionPercentage
          ? _value.completionPercentage
          : completionPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      daysUntilDue: null == daysUntilDue
          ? _value.daysUntilDue
          : daysUntilDue // ignore: cast_nullable_to_non_nullable
              as int,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as RiskLevel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectAtRiskImpl implements _ProjectAtRisk {
  const _$ProjectAtRiskImpl(
      {required this.projectId,
      required this.projectName,
      required this.teamId,
      required this.teamName,
      required this.completionPercentage,
      required this.dueDate,
      required this.daysUntilDue,
      required this.riskLevel});

  factory _$ProjectAtRiskImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectAtRiskImplFromJson(json);

  @override
  final String projectId;
  @override
  final String projectName;
  @override
  final String teamId;
  @override
  final String teamName;
  @override
  final double completionPercentage;
  @override
  final DateTime dueDate;
  @override
  final int daysUntilDue;
  @override
  final RiskLevel riskLevel;

  @override
  String toString() {
    return 'ProjectAtRisk(projectId: $projectId, projectName: $projectName, teamId: $teamId, teamName: $teamName, completionPercentage: $completionPercentage, dueDate: $dueDate, daysUntilDue: $daysUntilDue, riskLevel: $riskLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectAtRiskImpl &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.completionPercentage, completionPercentage) ||
                other.completionPercentage == completionPercentage) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.daysUntilDue, daysUntilDue) ||
                other.daysUntilDue == daysUntilDue) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, projectId, projectName, teamId,
      teamName, completionPercentage, dueDate, daysUntilDue, riskLevel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectAtRiskImplCopyWith<_$ProjectAtRiskImpl> get copyWith =>
      __$$ProjectAtRiskImplCopyWithImpl<_$ProjectAtRiskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectAtRiskImplToJson(
      this,
    );
  }
}

abstract class _ProjectAtRisk implements ProjectAtRisk {
  const factory _ProjectAtRisk(
      {required final String projectId,
      required final String projectName,
      required final String teamId,
      required final String teamName,
      required final double completionPercentage,
      required final DateTime dueDate,
      required final int daysUntilDue,
      required final RiskLevel riskLevel}) = _$ProjectAtRiskImpl;

  factory _ProjectAtRisk.fromJson(Map<String, dynamic> json) =
      _$ProjectAtRiskImpl.fromJson;

  @override
  String get projectId;
  @override
  String get projectName;
  @override
  String get teamId;
  @override
  String get teamName;
  @override
  double get completionPercentage;
  @override
  DateTime get dueDate;
  @override
  int get daysUntilDue;
  @override
  RiskLevel get riskLevel;
  @override
  @JsonKey(ignore: true)
  _$$ProjectAtRiskImplCopyWith<_$ProjectAtRiskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
