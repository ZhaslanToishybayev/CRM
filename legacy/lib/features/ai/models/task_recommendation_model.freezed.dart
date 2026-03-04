// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_recommendation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskRecommendation _$TaskRecommendationFromJson(Map<String, dynamic> json) {
  return _TaskRecommendation.fromJson(json);
}

/// @nodoc
mixin _$TaskRecommendation {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get estimatedDuration => throw _privateConstructorUsedError;
  DateTime get recommendedDueDate => throw _privateConstructorUsedError;
  int get suggestedPriority => throw _privateConstructorUsedError;
  String get suggestedCategory => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  double get matchScore => throw _privateConstructorUsedError;
  Map<String, dynamic>? get context => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskRecommendationCopyWith<TaskRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskRecommendationCopyWith<$Res> {
  factory $TaskRecommendationCopyWith(
          TaskRecommendation value, $Res Function(TaskRecommendation) then) =
      _$TaskRecommendationCopyWithImpl<$Res, TaskRecommendation>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      int estimatedDuration,
      DateTime recommendedDueDate,
      int suggestedPriority,
      String suggestedCategory,
      List<String> tags,
      double matchScore,
      Map<String, dynamic>? context});
}

/// @nodoc
class _$TaskRecommendationCopyWithImpl<$Res, $Val extends TaskRecommendation>
    implements $TaskRecommendationCopyWith<$Res> {
  _$TaskRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? estimatedDuration = null,
    Object? recommendedDueDate = null,
    Object? suggestedPriority = null,
    Object? suggestedCategory = null,
    Object? tags = null,
    Object? matchScore = null,
    Object? context = freezed,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedDuration: null == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as int,
      recommendedDueDate: null == recommendedDueDate
          ? _value.recommendedDueDate
          : recommendedDueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      suggestedPriority: null == suggestedPriority
          ? _value.suggestedPriority
          : suggestedPriority // ignore: cast_nullable_to_non_nullable
              as int,
      suggestedCategory: null == suggestedCategory
          ? _value.suggestedCategory
          : suggestedCategory // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      matchScore: null == matchScore
          ? _value.matchScore
          : matchScore // ignore: cast_nullable_to_non_nullable
              as double,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskRecommendationImplCopyWith<$Res>
    implements $TaskRecommendationCopyWith<$Res> {
  factory _$$TaskRecommendationImplCopyWith(_$TaskRecommendationImpl value,
          $Res Function(_$TaskRecommendationImpl) then) =
      __$$TaskRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      int estimatedDuration,
      DateTime recommendedDueDate,
      int suggestedPriority,
      String suggestedCategory,
      List<String> tags,
      double matchScore,
      Map<String, dynamic>? context});
}

/// @nodoc
class __$$TaskRecommendationImplCopyWithImpl<$Res>
    extends _$TaskRecommendationCopyWithImpl<$Res, _$TaskRecommendationImpl>
    implements _$$TaskRecommendationImplCopyWith<$Res> {
  __$$TaskRecommendationImplCopyWithImpl(_$TaskRecommendationImpl _value,
      $Res Function(_$TaskRecommendationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? estimatedDuration = null,
    Object? recommendedDueDate = null,
    Object? suggestedPriority = null,
    Object? suggestedCategory = null,
    Object? tags = null,
    Object? matchScore = null,
    Object? context = freezed,
  }) {
    return _then(_$TaskRecommendationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedDuration: null == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as int,
      recommendedDueDate: null == recommendedDueDate
          ? _value.recommendedDueDate
          : recommendedDueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      suggestedPriority: null == suggestedPriority
          ? _value.suggestedPriority
          : suggestedPriority // ignore: cast_nullable_to_non_nullable
              as int,
      suggestedCategory: null == suggestedCategory
          ? _value.suggestedCategory
          : suggestedCategory // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      matchScore: null == matchScore
          ? _value.matchScore
          : matchScore // ignore: cast_nullable_to_non_nullable
              as double,
      context: freezed == context
          ? _value._context
          : context // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskRecommendationImpl implements _TaskRecommendation {
  const _$TaskRecommendationImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.estimatedDuration,
      required this.recommendedDueDate,
      required this.suggestedPriority,
      required this.suggestedCategory,
      final List<String> tags = const [],
      required this.matchScore,
      final Map<String, dynamic>? context})
      : _tags = tags,
        _context = context;

  factory _$TaskRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskRecommendationImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final int estimatedDuration;
  @override
  final DateTime recommendedDueDate;
  @override
  final int suggestedPriority;
  @override
  final String suggestedCategory;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final double matchScore;
  final Map<String, dynamic>? _context;
  @override
  Map<String, dynamic>? get context {
    final value = _context;
    if (value == null) return null;
    if (_context is EqualUnmodifiableMapView) return _context;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'TaskRecommendation(id: $id, title: $title, description: $description, estimatedDuration: $estimatedDuration, recommendedDueDate: $recommendedDueDate, suggestedPriority: $suggestedPriority, suggestedCategory: $suggestedCategory, tags: $tags, matchScore: $matchScore, context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskRecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration) &&
            (identical(other.recommendedDueDate, recommendedDueDate) ||
                other.recommendedDueDate == recommendedDueDate) &&
            (identical(other.suggestedPriority, suggestedPriority) ||
                other.suggestedPriority == suggestedPriority) &&
            (identical(other.suggestedCategory, suggestedCategory) ||
                other.suggestedCategory == suggestedCategory) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.matchScore, matchScore) ||
                other.matchScore == matchScore) &&
            const DeepCollectionEquality().equals(other._context, _context));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      estimatedDuration,
      recommendedDueDate,
      suggestedPriority,
      suggestedCategory,
      const DeepCollectionEquality().hash(_tags),
      matchScore,
      const DeepCollectionEquality().hash(_context));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskRecommendationImplCopyWith<_$TaskRecommendationImpl> get copyWith =>
      __$$TaskRecommendationImplCopyWithImpl<_$TaskRecommendationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskRecommendationImplToJson(
      this,
    );
  }
}

abstract class _TaskRecommendation implements TaskRecommendation {
  const factory _TaskRecommendation(
      {required final String id,
      required final String title,
      required final String description,
      required final int estimatedDuration,
      required final DateTime recommendedDueDate,
      required final int suggestedPriority,
      required final String suggestedCategory,
      final List<String> tags,
      required final double matchScore,
      final Map<String, dynamic>? context}) = _$TaskRecommendationImpl;

  factory _TaskRecommendation.fromJson(Map<String, dynamic> json) =
      _$TaskRecommendationImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  int get estimatedDuration;
  @override
  DateTime get recommendedDueDate;
  @override
  int get suggestedPriority;
  @override
  String get suggestedCategory;
  @override
  List<String> get tags;
  @override
  double get matchScore;
  @override
  Map<String, dynamic>? get context;
  @override
  @JsonKey(ignore: true)
  _$$TaskRecommendationImplCopyWith<_$TaskRecommendationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AIInsight _$AIInsightFromJson(Map<String, dynamic> json) {
  return _AIInsight.fromJson(json);
}

/// @nodoc
mixin _$AIInsight {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  double get importance => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get actions => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AIInsightCopyWith<AIInsight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIInsightCopyWith<$Res> {
  factory $AIInsightCopyWith(AIInsight value, $Res Function(AIInsight) then) =
      _$AIInsightCopyWithImpl<$Res, AIInsight>;
  @useResult
  $Res call(
      {String id,
      String type,
      String title,
      String message,
      double importance,
      DateTime createdAt,
      List<String> actions,
      Map<String, dynamic>? data});
}

/// @nodoc
class _$AIInsightCopyWithImpl<$Res, $Val extends AIInsight>
    implements $AIInsightCopyWith<$Res> {
  _$AIInsightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? importance = null,
    Object? createdAt = null,
    Object? actions = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actions: null == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIInsightImplCopyWith<$Res>
    implements $AIInsightCopyWith<$Res> {
  factory _$$AIInsightImplCopyWith(
          _$AIInsightImpl value, $Res Function(_$AIInsightImpl) then) =
      __$$AIInsightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      String title,
      String message,
      double importance,
      DateTime createdAt,
      List<String> actions,
      Map<String, dynamic>? data});
}

/// @nodoc
class __$$AIInsightImplCopyWithImpl<$Res>
    extends _$AIInsightCopyWithImpl<$Res, _$AIInsightImpl>
    implements _$$AIInsightImplCopyWith<$Res> {
  __$$AIInsightImplCopyWithImpl(
      _$AIInsightImpl _value, $Res Function(_$AIInsightImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? importance = null,
    Object? createdAt = null,
    Object? actions = null,
    Object? data = freezed,
  }) {
    return _then(_$AIInsightImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actions: null == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIInsightImpl implements _AIInsight {
  const _$AIInsightImpl(
      {required this.id,
      required this.type,
      required this.title,
      required this.message,
      required this.importance,
      required this.createdAt,
      final List<String> actions = const [],
      final Map<String, dynamic>? data})
      : _actions = actions,
        _data = data;

  factory _$AIInsightImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIInsightImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String title;
  @override
  final String message;
  @override
  final double importance;
  @override
  final DateTime createdAt;
  final List<String> _actions;
  @override
  @JsonKey()
  List<String> get actions {
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actions);
  }

  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AIInsight(id: $id, type: $type, title: $title, message: $message, importance: $importance, createdAt: $createdAt, actions: $actions, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIInsightImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.importance, importance) ||
                other.importance == importance) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      title,
      message,
      importance,
      createdAt,
      const DeepCollectionEquality().hash(_actions),
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AIInsightImplCopyWith<_$AIInsightImpl> get copyWith =>
      __$$AIInsightImplCopyWithImpl<_$AIInsightImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIInsightImplToJson(
      this,
    );
  }
}

abstract class _AIInsight implements AIInsight {
  const factory _AIInsight(
      {required final String id,
      required final String type,
      required final String title,
      required final String message,
      required final double importance,
      required final DateTime createdAt,
      final List<String> actions,
      final Map<String, dynamic>? data}) = _$AIInsightImpl;

  factory _AIInsight.fromJson(Map<String, dynamic> json) =
      _$AIInsightImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get title;
  @override
  String get message;
  @override
  double get importance;
  @override
  DateTime get createdAt;
  @override
  List<String> get actions;
  @override
  Map<String, dynamic>? get data;
  @override
  @JsonKey(ignore: true)
  _$$AIInsightImplCopyWith<_$AIInsightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
