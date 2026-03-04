// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmployeeReportModel _$EmployeeReportModelFromJson(Map<String, dynamic> json) {
  return _EmployeeReportModel.fromJson(json);
}

/// @nodoc
mixin _$EmployeeReportModel {
  String get userId => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get departmentId => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  Period get period => throw _privateConstructorUsedError;
  DateTime get periodStart => throw _privateConstructorUsedError;
  DateTime get periodEnd =>
      throw _privateConstructorUsedError; // Personal Information
  String get username => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String get jobTitle => throw _privateConstructorUsedError;
  DateTime get hireDate =>
      throw _privateConstructorUsedError; // Performance Summary
  int get currentLevel => throw _privateConstructorUsedError;
  int get totalXP => throw _privateConstructorUsedError;
  int get xpEarnedThisPeriod => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  int get tasksCompleted => throw _privateConstructorUsedError;
  int get tasksCompletedOnTime => throw _privateConstructorUsedError;
  int get tasksCompletedOverdue =>
      throw _privateConstructorUsedError; // Quality Metrics
  double get averageQualityRating => throw _privateConstructorUsedError;
  int get fiveStarRatings => throw _privateConstructorUsedError;
  int get tasksWithoutRevisions => throw _privateConstructorUsedError;
  String? get managerFeedback =>
      throw _privateConstructorUsedError; // Task Details
  List<TaskSummary> get completedTasks => throw _privateConstructorUsedError;
  List<TaskSummary> get overdueTasks => throw _privateConstructorUsedError;
  List<TaskSummary> get upcomingTasks => throw _privateConstructorUsedError;
  Map<WorkTaskPriority, int> get tasksByPriority =>
      throw _privateConstructorUsedError;
  Map<WorkTaskType, int> get tasksByType => throw _privateConstructorUsedError;
  Map<String, int> get tasksByCategory =>
      throw _privateConstructorUsedError; // Time Tracking
  double get averageTaskTime => throw _privateConstructorUsedError; // in hours
  int get totalTimeSpent => throw _privateConstructorUsedError; // in minutes
  int get estimatedTime => throw _privateConstructorUsedError; // in minutes
  double get timeAccuracy => throw _privateConstructorUsedError; // percentage
// Achievements
  List<AchievementModel> get unlockedAchievements =>
      throw _privateConstructorUsedError;
  List<AchievementModel> get nearAchievements =>
      throw _privateConstructorUsedError;
  int get totalAchievements => throw _privateConstructorUsedError; // Trends
  double get productivityTrend => throw _privateConstructorUsedError;
  double get qualityTrend => throw _privateConstructorUsedError;
  double get xpTrend => throw _privateConstructorUsedError; // Goals
  List<Goal> get goals => throw _privateConstructorUsedError;
  List<GoalProgress> get goalProgress =>
      throw _privateConstructorUsedError; // Recommendations
  List<String> get recommendations => throw _privateConstructorUsedError;
  List<String> get strengths => throw _privateConstructorUsedError;
  List<String> get improvements => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeReportModelCopyWith<EmployeeReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeReportModelCopyWith<$Res> {
  factory $EmployeeReportModelCopyWith(
          EmployeeReportModel value, $Res Function(EmployeeReportModel) then) =
      _$EmployeeReportModelCopyWithImpl<$Res, EmployeeReportModel>;
  @useResult
  $Res call(
      {String userId,
      String organizationId,
      String departmentId,
      String teamId,
      DateTime generatedAt,
      Period period,
      DateTime periodStart,
      DateTime periodEnd,
      String username,
      String fullName,
      String email,
      String? avatarUrl,
      String jobTitle,
      DateTime hireDate,
      int currentLevel,
      int totalXP,
      int xpEarnedThisPeriod,
      int currentStreak,
      int longestStreak,
      int tasksCompleted,
      int tasksCompletedOnTime,
      int tasksCompletedOverdue,
      double averageQualityRating,
      int fiveStarRatings,
      int tasksWithoutRevisions,
      String? managerFeedback,
      List<TaskSummary> completedTasks,
      List<TaskSummary> overdueTasks,
      List<TaskSummary> upcomingTasks,
      Map<WorkTaskPriority, int> tasksByPriority,
      Map<WorkTaskType, int> tasksByType,
      Map<String, int> tasksByCategory,
      double averageTaskTime,
      int totalTimeSpent,
      int estimatedTime,
      double timeAccuracy,
      List<AchievementModel> unlockedAchievements,
      List<AchievementModel> nearAchievements,
      int totalAchievements,
      double productivityTrend,
      double qualityTrend,
      double xpTrend,
      List<Goal> goals,
      List<GoalProgress> goalProgress,
      List<String> recommendations,
      List<String> strengths,
      List<String> improvements});
}

/// @nodoc
class _$EmployeeReportModelCopyWithImpl<$Res, $Val extends EmployeeReportModel>
    implements $EmployeeReportModelCopyWith<$Res> {
  _$EmployeeReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? organizationId = null,
    Object? departmentId = null,
    Object? teamId = null,
    Object? generatedAt = null,
    Object? period = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? username = null,
    Object? fullName = null,
    Object? email = null,
    Object? avatarUrl = freezed,
    Object? jobTitle = null,
    Object? hireDate = null,
    Object? currentLevel = null,
    Object? totalXP = null,
    Object? xpEarnedThisPeriod = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? tasksCompleted = null,
    Object? tasksCompletedOnTime = null,
    Object? tasksCompletedOverdue = null,
    Object? averageQualityRating = null,
    Object? fiveStarRatings = null,
    Object? tasksWithoutRevisions = null,
    Object? managerFeedback = freezed,
    Object? completedTasks = null,
    Object? overdueTasks = null,
    Object? upcomingTasks = null,
    Object? tasksByPriority = null,
    Object? tasksByType = null,
    Object? tasksByCategory = null,
    Object? averageTaskTime = null,
    Object? totalTimeSpent = null,
    Object? estimatedTime = null,
    Object? timeAccuracy = null,
    Object? unlockedAchievements = null,
    Object? nearAchievements = null,
    Object? totalAchievements = null,
    Object? productivityTrend = null,
    Object? qualityTrend = null,
    Object? xpTrend = null,
    Object? goals = null,
    Object? goalProgress = null,
    Object? recommendations = null,
    Object? strengths = null,
    Object? improvements = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      departmentId: null == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
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
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      jobTitle: null == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String,
      hireDate: null == hireDate
          ? _value.hireDate
          : hireDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentLevel: null == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      totalXP: null == totalXP
          ? _value.totalXP
          : totalXP // ignore: cast_nullable_to_non_nullable
              as int,
      xpEarnedThisPeriod: null == xpEarnedThisPeriod
          ? _value.xpEarnedThisPeriod
          : xpEarnedThisPeriod // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompleted: null == tasksCompleted
          ? _value.tasksCompleted
          : tasksCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompletedOnTime: null == tasksCompletedOnTime
          ? _value.tasksCompletedOnTime
          : tasksCompletedOnTime // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompletedOverdue: null == tasksCompletedOverdue
          ? _value.tasksCompletedOverdue
          : tasksCompletedOverdue // ignore: cast_nullable_to_non_nullable
              as int,
      averageQualityRating: null == averageQualityRating
          ? _value.averageQualityRating
          : averageQualityRating // ignore: cast_nullable_to_non_nullable
              as double,
      fiveStarRatings: null == fiveStarRatings
          ? _value.fiveStarRatings
          : fiveStarRatings // ignore: cast_nullable_to_non_nullable
              as int,
      tasksWithoutRevisions: null == tasksWithoutRevisions
          ? _value.tasksWithoutRevisions
          : tasksWithoutRevisions // ignore: cast_nullable_to_non_nullable
              as int,
      managerFeedback: freezed == managerFeedback
          ? _value.managerFeedback
          : managerFeedback // ignore: cast_nullable_to_non_nullable
              as String?,
      completedTasks: null == completedTasks
          ? _value.completedTasks
          : completedTasks // ignore: cast_nullable_to_non_nullable
              as List<TaskSummary>,
      overdueTasks: null == overdueTasks
          ? _value.overdueTasks
          : overdueTasks // ignore: cast_nullable_to_non_nullable
              as List<TaskSummary>,
      upcomingTasks: null == upcomingTasks
          ? _value.upcomingTasks
          : upcomingTasks // ignore: cast_nullable_to_non_nullable
              as List<TaskSummary>,
      tasksByPriority: null == tasksByPriority
          ? _value.tasksByPriority
          : tasksByPriority // ignore: cast_nullable_to_non_nullable
              as Map<WorkTaskPriority, int>,
      tasksByType: null == tasksByType
          ? _value.tasksByType
          : tasksByType // ignore: cast_nullable_to_non_nullable
              as Map<WorkTaskType, int>,
      tasksByCategory: null == tasksByCategory
          ? _value.tasksByCategory
          : tasksByCategory // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      averageTaskTime: null == averageTaskTime
          ? _value.averageTaskTime
          : averageTaskTime // ignore: cast_nullable_to_non_nullable
              as double,
      totalTimeSpent: null == totalTimeSpent
          ? _value.totalTimeSpent
          : totalTimeSpent // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedTime: null == estimatedTime
          ? _value.estimatedTime
          : estimatedTime // ignore: cast_nullable_to_non_nullable
              as int,
      timeAccuracy: null == timeAccuracy
          ? _value.timeAccuracy
          : timeAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
      unlockedAchievements: null == unlockedAchievements
          ? _value.unlockedAchievements
          : unlockedAchievements // ignore: cast_nullable_to_non_nullable
              as List<AchievementModel>,
      nearAchievements: null == nearAchievements
          ? _value.nearAchievements
          : nearAchievements // ignore: cast_nullable_to_non_nullable
              as List<AchievementModel>,
      totalAchievements: null == totalAchievements
          ? _value.totalAchievements
          : totalAchievements // ignore: cast_nullable_to_non_nullable
              as int,
      productivityTrend: null == productivityTrend
          ? _value.productivityTrend
          : productivityTrend // ignore: cast_nullable_to_non_nullable
              as double,
      qualityTrend: null == qualityTrend
          ? _value.qualityTrend
          : qualityTrend // ignore: cast_nullable_to_non_nullable
              as double,
      xpTrend: null == xpTrend
          ? _value.xpTrend
          : xpTrend // ignore: cast_nullable_to_non_nullable
              as double,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<Goal>,
      goalProgress: null == goalProgress
          ? _value.goalProgress
          : goalProgress // ignore: cast_nullable_to_non_nullable
              as List<GoalProgress>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      strengths: null == strengths
          ? _value.strengths
          : strengths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      improvements: null == improvements
          ? _value.improvements
          : improvements // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeeReportModelImplCopyWith<$Res>
    implements $EmployeeReportModelCopyWith<$Res> {
  factory _$$EmployeeReportModelImplCopyWith(_$EmployeeReportModelImpl value,
          $Res Function(_$EmployeeReportModelImpl) then) =
      __$$EmployeeReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String organizationId,
      String departmentId,
      String teamId,
      DateTime generatedAt,
      Period period,
      DateTime periodStart,
      DateTime periodEnd,
      String username,
      String fullName,
      String email,
      String? avatarUrl,
      String jobTitle,
      DateTime hireDate,
      int currentLevel,
      int totalXP,
      int xpEarnedThisPeriod,
      int currentStreak,
      int longestStreak,
      int tasksCompleted,
      int tasksCompletedOnTime,
      int tasksCompletedOverdue,
      double averageQualityRating,
      int fiveStarRatings,
      int tasksWithoutRevisions,
      String? managerFeedback,
      List<TaskSummary> completedTasks,
      List<TaskSummary> overdueTasks,
      List<TaskSummary> upcomingTasks,
      Map<WorkTaskPriority, int> tasksByPriority,
      Map<WorkTaskType, int> tasksByType,
      Map<String, int> tasksByCategory,
      double averageTaskTime,
      int totalTimeSpent,
      int estimatedTime,
      double timeAccuracy,
      List<AchievementModel> unlockedAchievements,
      List<AchievementModel> nearAchievements,
      int totalAchievements,
      double productivityTrend,
      double qualityTrend,
      double xpTrend,
      List<Goal> goals,
      List<GoalProgress> goalProgress,
      List<String> recommendations,
      List<String> strengths,
      List<String> improvements});
}

/// @nodoc
class __$$EmployeeReportModelImplCopyWithImpl<$Res>
    extends _$EmployeeReportModelCopyWithImpl<$Res, _$EmployeeReportModelImpl>
    implements _$$EmployeeReportModelImplCopyWith<$Res> {
  __$$EmployeeReportModelImplCopyWithImpl(_$EmployeeReportModelImpl _value,
      $Res Function(_$EmployeeReportModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? organizationId = null,
    Object? departmentId = null,
    Object? teamId = null,
    Object? generatedAt = null,
    Object? period = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? username = null,
    Object? fullName = null,
    Object? email = null,
    Object? avatarUrl = freezed,
    Object? jobTitle = null,
    Object? hireDate = null,
    Object? currentLevel = null,
    Object? totalXP = null,
    Object? xpEarnedThisPeriod = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? tasksCompleted = null,
    Object? tasksCompletedOnTime = null,
    Object? tasksCompletedOverdue = null,
    Object? averageQualityRating = null,
    Object? fiveStarRatings = null,
    Object? tasksWithoutRevisions = null,
    Object? managerFeedback = freezed,
    Object? completedTasks = null,
    Object? overdueTasks = null,
    Object? upcomingTasks = null,
    Object? tasksByPriority = null,
    Object? tasksByType = null,
    Object? tasksByCategory = null,
    Object? averageTaskTime = null,
    Object? totalTimeSpent = null,
    Object? estimatedTime = null,
    Object? timeAccuracy = null,
    Object? unlockedAchievements = null,
    Object? nearAchievements = null,
    Object? totalAchievements = null,
    Object? productivityTrend = null,
    Object? qualityTrend = null,
    Object? xpTrend = null,
    Object? goals = null,
    Object? goalProgress = null,
    Object? recommendations = null,
    Object? strengths = null,
    Object? improvements = null,
  }) {
    return _then(_$EmployeeReportModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      departmentId: null == departmentId
          ? _value.departmentId
          : departmentId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
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
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      jobTitle: null == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String,
      hireDate: null == hireDate
          ? _value.hireDate
          : hireDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentLevel: null == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      totalXP: null == totalXP
          ? _value.totalXP
          : totalXP // ignore: cast_nullable_to_non_nullable
              as int,
      xpEarnedThisPeriod: null == xpEarnedThisPeriod
          ? _value.xpEarnedThisPeriod
          : xpEarnedThisPeriod // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompleted: null == tasksCompleted
          ? _value.tasksCompleted
          : tasksCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompletedOnTime: null == tasksCompletedOnTime
          ? _value.tasksCompletedOnTime
          : tasksCompletedOnTime // ignore: cast_nullable_to_non_nullable
              as int,
      tasksCompletedOverdue: null == tasksCompletedOverdue
          ? _value.tasksCompletedOverdue
          : tasksCompletedOverdue // ignore: cast_nullable_to_non_nullable
              as int,
      averageQualityRating: null == averageQualityRating
          ? _value.averageQualityRating
          : averageQualityRating // ignore: cast_nullable_to_non_nullable
              as double,
      fiveStarRatings: null == fiveStarRatings
          ? _value.fiveStarRatings
          : fiveStarRatings // ignore: cast_nullable_to_non_nullable
              as int,
      tasksWithoutRevisions: null == tasksWithoutRevisions
          ? _value.tasksWithoutRevisions
          : tasksWithoutRevisions // ignore: cast_nullable_to_non_nullable
              as int,
      managerFeedback: freezed == managerFeedback
          ? _value.managerFeedback
          : managerFeedback // ignore: cast_nullable_to_non_nullable
              as String?,
      completedTasks: null == completedTasks
          ? _value._completedTasks
          : completedTasks // ignore: cast_nullable_to_non_nullable
              as List<TaskSummary>,
      overdueTasks: null == overdueTasks
          ? _value._overdueTasks
          : overdueTasks // ignore: cast_nullable_to_non_nullable
              as List<TaskSummary>,
      upcomingTasks: null == upcomingTasks
          ? _value._upcomingTasks
          : upcomingTasks // ignore: cast_nullable_to_non_nullable
              as List<TaskSummary>,
      tasksByPriority: null == tasksByPriority
          ? _value._tasksByPriority
          : tasksByPriority // ignore: cast_nullable_to_non_nullable
              as Map<WorkTaskPriority, int>,
      tasksByType: null == tasksByType
          ? _value._tasksByType
          : tasksByType // ignore: cast_nullable_to_non_nullable
              as Map<WorkTaskType, int>,
      tasksByCategory: null == tasksByCategory
          ? _value._tasksByCategory
          : tasksByCategory // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      averageTaskTime: null == averageTaskTime
          ? _value.averageTaskTime
          : averageTaskTime // ignore: cast_nullable_to_non_nullable
              as double,
      totalTimeSpent: null == totalTimeSpent
          ? _value.totalTimeSpent
          : totalTimeSpent // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedTime: null == estimatedTime
          ? _value.estimatedTime
          : estimatedTime // ignore: cast_nullable_to_non_nullable
              as int,
      timeAccuracy: null == timeAccuracy
          ? _value.timeAccuracy
          : timeAccuracy // ignore: cast_nullable_to_non_nullable
              as double,
      unlockedAchievements: null == unlockedAchievements
          ? _value._unlockedAchievements
          : unlockedAchievements // ignore: cast_nullable_to_non_nullable
              as List<AchievementModel>,
      nearAchievements: null == nearAchievements
          ? _value._nearAchievements
          : nearAchievements // ignore: cast_nullable_to_non_nullable
              as List<AchievementModel>,
      totalAchievements: null == totalAchievements
          ? _value.totalAchievements
          : totalAchievements // ignore: cast_nullable_to_non_nullable
              as int,
      productivityTrend: null == productivityTrend
          ? _value.productivityTrend
          : productivityTrend // ignore: cast_nullable_to_non_nullable
              as double,
      qualityTrend: null == qualityTrend
          ? _value.qualityTrend
          : qualityTrend // ignore: cast_nullable_to_non_nullable
              as double,
      xpTrend: null == xpTrend
          ? _value.xpTrend
          : xpTrend // ignore: cast_nullable_to_non_nullable
              as double,
      goals: null == goals
          ? _value._goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<Goal>,
      goalProgress: null == goalProgress
          ? _value._goalProgress
          : goalProgress // ignore: cast_nullable_to_non_nullable
              as List<GoalProgress>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      strengths: null == strengths
          ? _value._strengths
          : strengths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      improvements: null == improvements
          ? _value._improvements
          : improvements // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeReportModelImpl extends _EmployeeReportModel {
  const _$EmployeeReportModelImpl(
      {required this.userId,
      required this.organizationId,
      required this.departmentId,
      required this.teamId,
      required this.generatedAt,
      required this.period,
      required this.periodStart,
      required this.periodEnd,
      required this.username,
      required this.fullName,
      required this.email,
      required this.avatarUrl,
      required this.jobTitle,
      required this.hireDate,
      required this.currentLevel,
      required this.totalXP,
      required this.xpEarnedThisPeriod,
      required this.currentStreak,
      required this.longestStreak,
      required this.tasksCompleted,
      required this.tasksCompletedOnTime,
      required this.tasksCompletedOverdue,
      required this.averageQualityRating,
      required this.fiveStarRatings,
      required this.tasksWithoutRevisions,
      required this.managerFeedback,
      required final List<TaskSummary> completedTasks,
      required final List<TaskSummary> overdueTasks,
      required final List<TaskSummary> upcomingTasks,
      required final Map<WorkTaskPriority, int> tasksByPriority,
      required final Map<WorkTaskType, int> tasksByType,
      required final Map<String, int> tasksByCategory,
      required this.averageTaskTime,
      required this.totalTimeSpent,
      required this.estimatedTime,
      required this.timeAccuracy,
      required final List<AchievementModel> unlockedAchievements,
      required final List<AchievementModel> nearAchievements,
      required this.totalAchievements,
      required this.productivityTrend,
      required this.qualityTrend,
      required this.xpTrend,
      required final List<Goal> goals,
      required final List<GoalProgress> goalProgress,
      required final List<String> recommendations,
      required final List<String> strengths,
      required final List<String> improvements})
      : _completedTasks = completedTasks,
        _overdueTasks = overdueTasks,
        _upcomingTasks = upcomingTasks,
        _tasksByPriority = tasksByPriority,
        _tasksByType = tasksByType,
        _tasksByCategory = tasksByCategory,
        _unlockedAchievements = unlockedAchievements,
        _nearAchievements = nearAchievements,
        _goals = goals,
        _goalProgress = goalProgress,
        _recommendations = recommendations,
        _strengths = strengths,
        _improvements = improvements,
        super._();

  factory _$EmployeeReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeReportModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String organizationId;
  @override
  final String departmentId;
  @override
  final String teamId;
  @override
  final DateTime generatedAt;
  @override
  final Period period;
  @override
  final DateTime periodStart;
  @override
  final DateTime periodEnd;
// Personal Information
  @override
  final String username;
  @override
  final String fullName;
  @override
  final String email;
  @override
  final String? avatarUrl;
  @override
  final String jobTitle;
  @override
  final DateTime hireDate;
// Performance Summary
  @override
  final int currentLevel;
  @override
  final int totalXP;
  @override
  final int xpEarnedThisPeriod;
  @override
  final int currentStreak;
  @override
  final int longestStreak;
  @override
  final int tasksCompleted;
  @override
  final int tasksCompletedOnTime;
  @override
  final int tasksCompletedOverdue;
// Quality Metrics
  @override
  final double averageQualityRating;
  @override
  final int fiveStarRatings;
  @override
  final int tasksWithoutRevisions;
  @override
  final String? managerFeedback;
// Task Details
  final List<TaskSummary> _completedTasks;
// Task Details
  @override
  List<TaskSummary> get completedTasks {
    if (_completedTasks is EqualUnmodifiableListView) return _completedTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedTasks);
  }

  final List<TaskSummary> _overdueTasks;
  @override
  List<TaskSummary> get overdueTasks {
    if (_overdueTasks is EqualUnmodifiableListView) return _overdueTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_overdueTasks);
  }

  final List<TaskSummary> _upcomingTasks;
  @override
  List<TaskSummary> get upcomingTasks {
    if (_upcomingTasks is EqualUnmodifiableListView) return _upcomingTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcomingTasks);
  }

  final Map<WorkTaskPriority, int> _tasksByPriority;
  @override
  Map<WorkTaskPriority, int> get tasksByPriority {
    if (_tasksByPriority is EqualUnmodifiableMapView) return _tasksByPriority;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tasksByPriority);
  }

  final Map<WorkTaskType, int> _tasksByType;
  @override
  Map<WorkTaskType, int> get tasksByType {
    if (_tasksByType is EqualUnmodifiableMapView) return _tasksByType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tasksByType);
  }

  final Map<String, int> _tasksByCategory;
  @override
  Map<String, int> get tasksByCategory {
    if (_tasksByCategory is EqualUnmodifiableMapView) return _tasksByCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tasksByCategory);
  }

// Time Tracking
  @override
  final double averageTaskTime;
// in hours
  @override
  final int totalTimeSpent;
// in minutes
  @override
  final int estimatedTime;
// in minutes
  @override
  final double timeAccuracy;
// percentage
// Achievements
  final List<AchievementModel> _unlockedAchievements;
// percentage
// Achievements
  @override
  List<AchievementModel> get unlockedAchievements {
    if (_unlockedAchievements is EqualUnmodifiableListView)
      return _unlockedAchievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unlockedAchievements);
  }

  final List<AchievementModel> _nearAchievements;
  @override
  List<AchievementModel> get nearAchievements {
    if (_nearAchievements is EqualUnmodifiableListView)
      return _nearAchievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nearAchievements);
  }

  @override
  final int totalAchievements;
// Trends
  @override
  final double productivityTrend;
  @override
  final double qualityTrend;
  @override
  final double xpTrend;
// Goals
  final List<Goal> _goals;
// Goals
  @override
  List<Goal> get goals {
    if (_goals is EqualUnmodifiableListView) return _goals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goals);
  }

  final List<GoalProgress> _goalProgress;
  @override
  List<GoalProgress> get goalProgress {
    if (_goalProgress is EqualUnmodifiableListView) return _goalProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goalProgress);
  }

// Recommendations
  final List<String> _recommendations;
// Recommendations
  @override
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  final List<String> _strengths;
  @override
  List<String> get strengths {
    if (_strengths is EqualUnmodifiableListView) return _strengths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_strengths);
  }

  final List<String> _improvements;
  @override
  List<String> get improvements {
    if (_improvements is EqualUnmodifiableListView) return _improvements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_improvements);
  }

  @override
  String toString() {
    return 'EmployeeReportModel(userId: $userId, organizationId: $organizationId, departmentId: $departmentId, teamId: $teamId, generatedAt: $generatedAt, period: $period, periodStart: $periodStart, periodEnd: $periodEnd, username: $username, fullName: $fullName, email: $email, avatarUrl: $avatarUrl, jobTitle: $jobTitle, hireDate: $hireDate, currentLevel: $currentLevel, totalXP: $totalXP, xpEarnedThisPeriod: $xpEarnedThisPeriod, currentStreak: $currentStreak, longestStreak: $longestStreak, tasksCompleted: $tasksCompleted, tasksCompletedOnTime: $tasksCompletedOnTime, tasksCompletedOverdue: $tasksCompletedOverdue, averageQualityRating: $averageQualityRating, fiveStarRatings: $fiveStarRatings, tasksWithoutRevisions: $tasksWithoutRevisions, managerFeedback: $managerFeedback, completedTasks: $completedTasks, overdueTasks: $overdueTasks, upcomingTasks: $upcomingTasks, tasksByPriority: $tasksByPriority, tasksByType: $tasksByType, tasksByCategory: $tasksByCategory, averageTaskTime: $averageTaskTime, totalTimeSpent: $totalTimeSpent, estimatedTime: $estimatedTime, timeAccuracy: $timeAccuracy, unlockedAchievements: $unlockedAchievements, nearAchievements: $nearAchievements, totalAchievements: $totalAchievements, productivityTrend: $productivityTrend, qualityTrend: $qualityTrend, xpTrend: $xpTrend, goals: $goals, goalProgress: $goalProgress, recommendations: $recommendations, strengths: $strengths, improvements: $improvements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeReportModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.departmentId, departmentId) ||
                other.departmentId == departmentId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.hireDate, hireDate) ||
                other.hireDate == hireDate) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel) &&
            (identical(other.totalXP, totalXP) || other.totalXP == totalXP) &&
            (identical(other.xpEarnedThisPeriod, xpEarnedThisPeriod) ||
                other.xpEarnedThisPeriod == xpEarnedThisPeriod) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.tasksCompleted, tasksCompleted) ||
                other.tasksCompleted == tasksCompleted) &&
            (identical(other.tasksCompletedOnTime, tasksCompletedOnTime) ||
                other.tasksCompletedOnTime == tasksCompletedOnTime) &&
            (identical(other.tasksCompletedOverdue, tasksCompletedOverdue) ||
                other.tasksCompletedOverdue == tasksCompletedOverdue) &&
            (identical(other.averageQualityRating, averageQualityRating) ||
                other.averageQualityRating == averageQualityRating) &&
            (identical(other.fiveStarRatings, fiveStarRatings) ||
                other.fiveStarRatings == fiveStarRatings) &&
            (identical(other.tasksWithoutRevisions, tasksWithoutRevisions) ||
                other.tasksWithoutRevisions == tasksWithoutRevisions) &&
            (identical(other.managerFeedback, managerFeedback) ||
                other.managerFeedback == managerFeedback) &&
            const DeepCollectionEquality()
                .equals(other._completedTasks, _completedTasks) &&
            const DeepCollectionEquality()
                .equals(other._overdueTasks, _overdueTasks) &&
            const DeepCollectionEquality()
                .equals(other._upcomingTasks, _upcomingTasks) &&
            const DeepCollectionEquality()
                .equals(other._tasksByPriority, _tasksByPriority) &&
            const DeepCollectionEquality()
                .equals(other._tasksByType, _tasksByType) &&
            const DeepCollectionEquality()
                .equals(other._tasksByCategory, _tasksByCategory) &&
            (identical(other.averageTaskTime, averageTaskTime) ||
                other.averageTaskTime == averageTaskTime) &&
            (identical(other.totalTimeSpent, totalTimeSpent) ||
                other.totalTimeSpent == totalTimeSpent) &&
            (identical(other.estimatedTime, estimatedTime) ||
                other.estimatedTime == estimatedTime) &&
            (identical(other.timeAccuracy, timeAccuracy) ||
                other.timeAccuracy == timeAccuracy) &&
            const DeepCollectionEquality()
                .equals(other._unlockedAchievements, _unlockedAchievements) &&
            const DeepCollectionEquality()
                .equals(other._nearAchievements, _nearAchievements) &&
            (identical(other.totalAchievements, totalAchievements) ||
                other.totalAchievements == totalAchievements) &&
            (identical(other.productivityTrend, productivityTrend) ||
                other.productivityTrend == productivityTrend) &&
            (identical(other.qualityTrend, qualityTrend) ||
                other.qualityTrend == qualityTrend) &&
            (identical(other.xpTrend, xpTrend) || other.xpTrend == xpTrend) &&
            const DeepCollectionEquality().equals(other._goals, _goals) &&
            const DeepCollectionEquality()
                .equals(other._goalProgress, _goalProgress) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            const DeepCollectionEquality()
                .equals(other._strengths, _strengths) &&
            const DeepCollectionEquality()
                .equals(other._improvements, _improvements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        userId,
        organizationId,
        departmentId,
        teamId,
        generatedAt,
        period,
        periodStart,
        periodEnd,
        username,
        fullName,
        email,
        avatarUrl,
        jobTitle,
        hireDate,
        currentLevel,
        totalXP,
        xpEarnedThisPeriod,
        currentStreak,
        longestStreak,
        tasksCompleted,
        tasksCompletedOnTime,
        tasksCompletedOverdue,
        averageQualityRating,
        fiveStarRatings,
        tasksWithoutRevisions,
        managerFeedback,
        const DeepCollectionEquality().hash(_completedTasks),
        const DeepCollectionEquality().hash(_overdueTasks),
        const DeepCollectionEquality().hash(_upcomingTasks),
        const DeepCollectionEquality().hash(_tasksByPriority),
        const DeepCollectionEquality().hash(_tasksByType),
        const DeepCollectionEquality().hash(_tasksByCategory),
        averageTaskTime,
        totalTimeSpent,
        estimatedTime,
        timeAccuracy,
        const DeepCollectionEquality().hash(_unlockedAchievements),
        const DeepCollectionEquality().hash(_nearAchievements),
        totalAchievements,
        productivityTrend,
        qualityTrend,
        xpTrend,
        const DeepCollectionEquality().hash(_goals),
        const DeepCollectionEquality().hash(_goalProgress),
        const DeepCollectionEquality().hash(_recommendations),
        const DeepCollectionEquality().hash(_strengths),
        const DeepCollectionEquality().hash(_improvements)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeReportModelImplCopyWith<_$EmployeeReportModelImpl> get copyWith =>
      __$$EmployeeReportModelImplCopyWithImpl<_$EmployeeReportModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeReportModelImplToJson(
      this,
    );
  }
}

abstract class _EmployeeReportModel extends EmployeeReportModel {
  const factory _EmployeeReportModel(
      {required final String userId,
      required final String organizationId,
      required final String departmentId,
      required final String teamId,
      required final DateTime generatedAt,
      required final Period period,
      required final DateTime periodStart,
      required final DateTime periodEnd,
      required final String username,
      required final String fullName,
      required final String email,
      required final String? avatarUrl,
      required final String jobTitle,
      required final DateTime hireDate,
      required final int currentLevel,
      required final int totalXP,
      required final int xpEarnedThisPeriod,
      required final int currentStreak,
      required final int longestStreak,
      required final int tasksCompleted,
      required final int tasksCompletedOnTime,
      required final int tasksCompletedOverdue,
      required final double averageQualityRating,
      required final int fiveStarRatings,
      required final int tasksWithoutRevisions,
      required final String? managerFeedback,
      required final List<TaskSummary> completedTasks,
      required final List<TaskSummary> overdueTasks,
      required final List<TaskSummary> upcomingTasks,
      required final Map<WorkTaskPriority, int> tasksByPriority,
      required final Map<WorkTaskType, int> tasksByType,
      required final Map<String, int> tasksByCategory,
      required final double averageTaskTime,
      required final int totalTimeSpent,
      required final int estimatedTime,
      required final double timeAccuracy,
      required final List<AchievementModel> unlockedAchievements,
      required final List<AchievementModel> nearAchievements,
      required final int totalAchievements,
      required final double productivityTrend,
      required final double qualityTrend,
      required final double xpTrend,
      required final List<Goal> goals,
      required final List<GoalProgress> goalProgress,
      required final List<String> recommendations,
      required final List<String> strengths,
      required final List<String> improvements}) = _$EmployeeReportModelImpl;
  const _EmployeeReportModel._() : super._();

  factory _EmployeeReportModel.fromJson(Map<String, dynamic> json) =
      _$EmployeeReportModelImpl.fromJson;

  @override
  String get userId;
  @override
  String get organizationId;
  @override
  String get departmentId;
  @override
  String get teamId;
  @override
  DateTime get generatedAt;
  @override
  Period get period;
  @override
  DateTime get periodStart;
  @override
  DateTime get periodEnd;
  @override // Personal Information
  String get username;
  @override
  String get fullName;
  @override
  String get email;
  @override
  String? get avatarUrl;
  @override
  String get jobTitle;
  @override
  DateTime get hireDate;
  @override // Performance Summary
  int get currentLevel;
  @override
  int get totalXP;
  @override
  int get xpEarnedThisPeriod;
  @override
  int get currentStreak;
  @override
  int get longestStreak;
  @override
  int get tasksCompleted;
  @override
  int get tasksCompletedOnTime;
  @override
  int get tasksCompletedOverdue;
  @override // Quality Metrics
  double get averageQualityRating;
  @override
  int get fiveStarRatings;
  @override
  int get tasksWithoutRevisions;
  @override
  String? get managerFeedback;
  @override // Task Details
  List<TaskSummary> get completedTasks;
  @override
  List<TaskSummary> get overdueTasks;
  @override
  List<TaskSummary> get upcomingTasks;
  @override
  Map<WorkTaskPriority, int> get tasksByPriority;
  @override
  Map<WorkTaskType, int> get tasksByType;
  @override
  Map<String, int> get tasksByCategory;
  @override // Time Tracking
  double get averageTaskTime;
  @override // in hours
  int get totalTimeSpent;
  @override // in minutes
  int get estimatedTime;
  @override // in minutes
  double get timeAccuracy;
  @override // percentage
// Achievements
  List<AchievementModel> get unlockedAchievements;
  @override
  List<AchievementModel> get nearAchievements;
  @override
  int get totalAchievements;
  @override // Trends
  double get productivityTrend;
  @override
  double get qualityTrend;
  @override
  double get xpTrend;
  @override // Goals
  List<Goal> get goals;
  @override
  List<GoalProgress> get goalProgress;
  @override // Recommendations
  List<String> get recommendations;
  @override
  List<String> get strengths;
  @override
  List<String> get improvements;
  @override
  @JsonKey(ignore: true)
  _$$EmployeeReportModelImplCopyWith<_$EmployeeReportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskSummary _$TaskSummaryFromJson(Map<String, dynamic> json) {
  return _TaskSummary.fromJson(json);
}

/// @nodoc
mixin _$TaskSummary {
  String get taskId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  WorkTaskPriority get priority => throw _privateConstructorUsedError;
  WorkTaskType get type => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  DateTime? get dueDate => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int get xpEarned => throw _privateConstructorUsedError;
  int? get qualityRating => throw _privateConstructorUsedError;
  int get timeSpent => throw _privateConstructorUsedError; // in minutes
  int? get estimatedTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskSummaryCopyWith<TaskSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskSummaryCopyWith<$Res> {
  factory $TaskSummaryCopyWith(
          TaskSummary value, $Res Function(TaskSummary) then) =
      _$TaskSummaryCopyWithImpl<$Res, TaskSummary>;
  @useResult
  $Res call(
      {String taskId,
      String title,
      String? description,
      WorkTaskPriority priority,
      WorkTaskType type,
      String? category,
      DateTime? dueDate,
      DateTime? completedAt,
      int xpEarned,
      int? qualityRating,
      int timeSpent,
      int? estimatedTime});
}

/// @nodoc
class _$TaskSummaryCopyWithImpl<$Res, $Val extends TaskSummary>
    implements $TaskSummaryCopyWith<$Res> {
  _$TaskSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? title = null,
    Object? description = freezed,
    Object? priority = null,
    Object? type = null,
    Object? category = freezed,
    Object? dueDate = freezed,
    Object? completedAt = freezed,
    Object? xpEarned = null,
    Object? qualityRating = freezed,
    Object? timeSpent = null,
    Object? estimatedTime = freezed,
  }) {
    return _then(_value.copyWith(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as WorkTaskPriority,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WorkTaskType,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      xpEarned: null == xpEarned
          ? _value.xpEarned
          : xpEarned // ignore: cast_nullable_to_non_nullable
              as int,
      qualityRating: freezed == qualityRating
          ? _value.qualityRating
          : qualityRating // ignore: cast_nullable_to_non_nullable
              as int?,
      timeSpent: null == timeSpent
          ? _value.timeSpent
          : timeSpent // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedTime: freezed == estimatedTime
          ? _value.estimatedTime
          : estimatedTime // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskSummaryImplCopyWith<$Res>
    implements $TaskSummaryCopyWith<$Res> {
  factory _$$TaskSummaryImplCopyWith(
          _$TaskSummaryImpl value, $Res Function(_$TaskSummaryImpl) then) =
      __$$TaskSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String taskId,
      String title,
      String? description,
      WorkTaskPriority priority,
      WorkTaskType type,
      String? category,
      DateTime? dueDate,
      DateTime? completedAt,
      int xpEarned,
      int? qualityRating,
      int timeSpent,
      int? estimatedTime});
}

/// @nodoc
class __$$TaskSummaryImplCopyWithImpl<$Res>
    extends _$TaskSummaryCopyWithImpl<$Res, _$TaskSummaryImpl>
    implements _$$TaskSummaryImplCopyWith<$Res> {
  __$$TaskSummaryImplCopyWithImpl(
      _$TaskSummaryImpl _value, $Res Function(_$TaskSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? title = null,
    Object? description = freezed,
    Object? priority = null,
    Object? type = null,
    Object? category = freezed,
    Object? dueDate = freezed,
    Object? completedAt = freezed,
    Object? xpEarned = null,
    Object? qualityRating = freezed,
    Object? timeSpent = null,
    Object? estimatedTime = freezed,
  }) {
    return _then(_$TaskSummaryImpl(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as WorkTaskPriority,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WorkTaskType,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      xpEarned: null == xpEarned
          ? _value.xpEarned
          : xpEarned // ignore: cast_nullable_to_non_nullable
              as int,
      qualityRating: freezed == qualityRating
          ? _value.qualityRating
          : qualityRating // ignore: cast_nullable_to_non_nullable
              as int?,
      timeSpent: null == timeSpent
          ? _value.timeSpent
          : timeSpent // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedTime: freezed == estimatedTime
          ? _value.estimatedTime
          : estimatedTime // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskSummaryImpl implements _TaskSummary {
  const _$TaskSummaryImpl(
      {required this.taskId,
      required this.title,
      required this.description,
      required this.priority,
      required this.type,
      required this.category,
      required this.dueDate,
      required this.completedAt,
      required this.xpEarned,
      required this.qualityRating,
      required this.timeSpent,
      required this.estimatedTime});

  factory _$TaskSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskSummaryImplFromJson(json);

  @override
  final String taskId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final WorkTaskPriority priority;
  @override
  final WorkTaskType type;
  @override
  final String? category;
  @override
  final DateTime? dueDate;
  @override
  final DateTime? completedAt;
  @override
  final int xpEarned;
  @override
  final int? qualityRating;
  @override
  final int timeSpent;
// in minutes
  @override
  final int? estimatedTime;

  @override
  String toString() {
    return 'TaskSummary(taskId: $taskId, title: $title, description: $description, priority: $priority, type: $type, category: $category, dueDate: $dueDate, completedAt: $completedAt, xpEarned: $xpEarned, qualityRating: $qualityRating, timeSpent: $timeSpent, estimatedTime: $estimatedTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskSummaryImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.xpEarned, xpEarned) ||
                other.xpEarned == xpEarned) &&
            (identical(other.qualityRating, qualityRating) ||
                other.qualityRating == qualityRating) &&
            (identical(other.timeSpent, timeSpent) ||
                other.timeSpent == timeSpent) &&
            (identical(other.estimatedTime, estimatedTime) ||
                other.estimatedTime == estimatedTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      taskId,
      title,
      description,
      priority,
      type,
      category,
      dueDate,
      completedAt,
      xpEarned,
      qualityRating,
      timeSpent,
      estimatedTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskSummaryImplCopyWith<_$TaskSummaryImpl> get copyWith =>
      __$$TaskSummaryImplCopyWithImpl<_$TaskSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskSummaryImplToJson(
      this,
    );
  }
}

abstract class _TaskSummary implements TaskSummary {
  const factory _TaskSummary(
      {required final String taskId,
      required final String title,
      required final String? description,
      required final WorkTaskPriority priority,
      required final WorkTaskType type,
      required final String? category,
      required final DateTime? dueDate,
      required final DateTime? completedAt,
      required final int xpEarned,
      required final int? qualityRating,
      required final int timeSpent,
      required final int? estimatedTime}) = _$TaskSummaryImpl;

  factory _TaskSummary.fromJson(Map<String, dynamic> json) =
      _$TaskSummaryImpl.fromJson;

  @override
  String get taskId;
  @override
  String get title;
  @override
  String? get description;
  @override
  WorkTaskPriority get priority;
  @override
  WorkTaskType get type;
  @override
  String? get category;
  @override
  DateTime? get dueDate;
  @override
  DateTime? get completedAt;
  @override
  int get xpEarned;
  @override
  int? get qualityRating;
  @override
  int get timeSpent;
  @override // in minutes
  int? get estimatedTime;
  @override
  @JsonKey(ignore: true)
  _$$TaskSummaryImplCopyWith<_$TaskSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return _Goal.fromJson(json);
}

/// @nodoc
mixin _$Goal {
  String get goalId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  GoalType get type => throw _privateConstructorUsedError;
  int get targetValue => throw _privateConstructorUsedError;
  int get currentValue => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoalCopyWith<Goal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalCopyWith<$Res> {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) then) =
      _$GoalCopyWithImpl<$Res, Goal>;
  @useResult
  $Res call(
      {String goalId,
      String title,
      String description,
      GoalType type,
      int targetValue,
      int currentValue,
      DateTime startDate,
      DateTime? endDate,
      bool isCompleted});
}

/// @nodoc
class _$GoalCopyWithImpl<$Res, $Val extends Goal>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goalId = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? targetValue = null,
    Object? currentValue = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GoalType,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalImplCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$$GoalImplCopyWith(
          _$GoalImpl value, $Res Function(_$GoalImpl) then) =
      __$$GoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String goalId,
      String title,
      String description,
      GoalType type,
      int targetValue,
      int currentValue,
      DateTime startDate,
      DateTime? endDate,
      bool isCompleted});
}

/// @nodoc
class __$$GoalImplCopyWithImpl<$Res>
    extends _$GoalCopyWithImpl<$Res, _$GoalImpl>
    implements _$$GoalImplCopyWith<$Res> {
  __$$GoalImplCopyWithImpl(_$GoalImpl _value, $Res Function(_$GoalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goalId = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? targetValue = null,
    Object? currentValue = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? isCompleted = null,
  }) {
    return _then(_$GoalImpl(
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GoalType,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalImpl extends _Goal {
  const _$GoalImpl(
      {required this.goalId,
      required this.title,
      required this.description,
      required this.type,
      required this.targetValue,
      required this.currentValue,
      required this.startDate,
      required this.endDate,
      required this.isCompleted})
      : super._();

  factory _$GoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalImplFromJson(json);

  @override
  final String goalId;
  @override
  final String title;
  @override
  final String description;
  @override
  final GoalType type;
  @override
  final int targetValue;
  @override
  final int currentValue;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final bool isCompleted;

  @override
  String toString() {
    return 'Goal(goalId: $goalId, title: $title, description: $description, type: $type, targetValue: $targetValue, currentValue: $currentValue, startDate: $startDate, endDate: $endDate, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalImpl &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, goalId, title, description, type,
      targetValue, currentValue, startDate, endDate, isCompleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalImplCopyWith<_$GoalImpl> get copyWith =>
      __$$GoalImplCopyWithImpl<_$GoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalImplToJson(
      this,
    );
  }
}

abstract class _Goal extends Goal {
  const factory _Goal(
      {required final String goalId,
      required final String title,
      required final String description,
      required final GoalType type,
      required final int targetValue,
      required final int currentValue,
      required final DateTime startDate,
      required final DateTime? endDate,
      required final bool isCompleted}) = _$GoalImpl;
  const _Goal._() : super._();

  factory _Goal.fromJson(Map<String, dynamic> json) = _$GoalImpl.fromJson;

  @override
  String get goalId;
  @override
  String get title;
  @override
  String get description;
  @override
  GoalType get type;
  @override
  int get targetValue;
  @override
  int get currentValue;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  bool get isCompleted;
  @override
  @JsonKey(ignore: true)
  _$$GoalImplCopyWith<_$GoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GoalProgress _$GoalProgressFromJson(Map<String, dynamic> json) {
  return _GoalProgress.fromJson(json);
}

/// @nodoc
mixin _$GoalProgress {
  String get goalId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoalProgressCopyWith<GoalProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalProgressCopyWith<$Res> {
  factory $GoalProgressCopyWith(
          GoalProgress value, $Res Function(GoalProgress) then) =
      _$GoalProgressCopyWithImpl<$Res, GoalProgress>;
  @useResult
  $Res call({String goalId, DateTime date, int value, String? note});
}

/// @nodoc
class _$GoalProgressCopyWithImpl<$Res, $Val extends GoalProgress>
    implements $GoalProgressCopyWith<$Res> {
  _$GoalProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goalId = null,
    Object? date = null,
    Object? value = null,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalProgressImplCopyWith<$Res>
    implements $GoalProgressCopyWith<$Res> {
  factory _$$GoalProgressImplCopyWith(
          _$GoalProgressImpl value, $Res Function(_$GoalProgressImpl) then) =
      __$$GoalProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String goalId, DateTime date, int value, String? note});
}

/// @nodoc
class __$$GoalProgressImplCopyWithImpl<$Res>
    extends _$GoalProgressCopyWithImpl<$Res, _$GoalProgressImpl>
    implements _$$GoalProgressImplCopyWith<$Res> {
  __$$GoalProgressImplCopyWithImpl(
      _$GoalProgressImpl _value, $Res Function(_$GoalProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goalId = null,
    Object? date = null,
    Object? value = null,
    Object? note = freezed,
  }) {
    return _then(_$GoalProgressImpl(
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalProgressImpl implements _GoalProgress {
  const _$GoalProgressImpl(
      {required this.goalId,
      required this.date,
      required this.value,
      required this.note});

  factory _$GoalProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalProgressImplFromJson(json);

  @override
  final String goalId;
  @override
  final DateTime date;
  @override
  final int value;
  @override
  final String? note;

  @override
  String toString() {
    return 'GoalProgress(goalId: $goalId, date: $date, value: $value, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalProgressImpl &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, goalId, date, value, note);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalProgressImplCopyWith<_$GoalProgressImpl> get copyWith =>
      __$$GoalProgressImplCopyWithImpl<_$GoalProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalProgressImplToJson(
      this,
    );
  }
}

abstract class _GoalProgress implements GoalProgress {
  const factory _GoalProgress(
      {required final String goalId,
      required final DateTime date,
      required final int value,
      required final String? note}) = _$GoalProgressImpl;

  factory _GoalProgress.fromJson(Map<String, dynamic> json) =
      _$GoalProgressImpl.fromJson;

  @override
  String get goalId;
  @override
  DateTime get date;
  @override
  int get value;
  @override
  String? get note;
  @override
  @JsonKey(ignore: true)
  _$$GoalProgressImplCopyWith<_$GoalProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
