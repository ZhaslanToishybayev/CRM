// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pipeline_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PipelineModel _$PipelineModelFromJson(Map<String, dynamic> json) {
  return _PipelineModel.fromJson(json);
}

/// @nodoc
mixin _$PipelineModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError; // Stages
  List<PipelineStage> get stages =>
      throw _privateConstructorUsedError; // Metrics
  double? get totalValue => throw _privateConstructorUsedError;
  int? get totalDeals => throw _privateConstructorUsedError;
  int? get wonDeals => throw _privateConstructorUsedError;
  int? get lostDeals => throw _privateConstructorUsedError; // Dates
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PipelineModelCopyWith<PipelineModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PipelineModelCopyWith<$Res> {
  factory $PipelineModelCopyWith(
          PipelineModel value, $Res Function(PipelineModel) then) =
      _$PipelineModelCopyWithImpl<$Res, PipelineModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      bool isDefault,
      List<PipelineStage> stages,
      double? totalValue,
      int? totalDeals,
      int? wonDeals,
      int? lostDeals,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$PipelineModelCopyWithImpl<$Res, $Val extends PipelineModel>
    implements $PipelineModelCopyWith<$Res> {
  _$PipelineModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? isDefault = null,
    Object? stages = null,
    Object? totalValue = freezed,
    Object? totalDeals = freezed,
    Object? wonDeals = freezed,
    Object? lostDeals = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      stages: null == stages
          ? _value.stages
          : stages // ignore: cast_nullable_to_non_nullable
              as List<PipelineStage>,
      totalValue: freezed == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double?,
      totalDeals: freezed == totalDeals
          ? _value.totalDeals
          : totalDeals // ignore: cast_nullable_to_non_nullable
              as int?,
      wonDeals: freezed == wonDeals
          ? _value.wonDeals
          : wonDeals // ignore: cast_nullable_to_non_nullable
              as int?,
      lostDeals: freezed == lostDeals
          ? _value.lostDeals
          : lostDeals // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PipelineModelImplCopyWith<$Res>
    implements $PipelineModelCopyWith<$Res> {
  factory _$$PipelineModelImplCopyWith(
          _$PipelineModelImpl value, $Res Function(_$PipelineModelImpl) then) =
      __$$PipelineModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      bool isDefault,
      List<PipelineStage> stages,
      double? totalValue,
      int? totalDeals,
      int? wonDeals,
      int? lostDeals,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$PipelineModelImplCopyWithImpl<$Res>
    extends _$PipelineModelCopyWithImpl<$Res, _$PipelineModelImpl>
    implements _$$PipelineModelImplCopyWith<$Res> {
  __$$PipelineModelImplCopyWithImpl(
      _$PipelineModelImpl _value, $Res Function(_$PipelineModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? isDefault = null,
    Object? stages = null,
    Object? totalValue = freezed,
    Object? totalDeals = freezed,
    Object? wonDeals = freezed,
    Object? lostDeals = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$PipelineModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      stages: null == stages
          ? _value._stages
          : stages // ignore: cast_nullable_to_non_nullable
              as List<PipelineStage>,
      totalValue: freezed == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double?,
      totalDeals: freezed == totalDeals
          ? _value.totalDeals
          : totalDeals // ignore: cast_nullable_to_non_nullable
              as int?,
      wonDeals: freezed == wonDeals
          ? _value.wonDeals
          : wonDeals // ignore: cast_nullable_to_non_nullable
              as int?,
      lostDeals: freezed == lostDeals
          ? _value.lostDeals
          : lostDeals // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PipelineModelImpl implements _PipelineModel {
  const _$PipelineModelImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.isDefault,
      final List<PipelineStage> stages = const [],
      this.totalValue,
      this.totalDeals,
      this.wonDeals,
      this.lostDeals,
      this.createdAt,
      this.updatedAt})
      : _stages = stages;

  factory _$PipelineModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PipelineModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final bool isDefault;
// Stages
  final List<PipelineStage> _stages;
// Stages
  @override
  @JsonKey()
  List<PipelineStage> get stages {
    if (_stages is EqualUnmodifiableListView) return _stages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stages);
  }

// Metrics
  @override
  final double? totalValue;
  @override
  final int? totalDeals;
  @override
  final int? wonDeals;
  @override
  final int? lostDeals;
// Dates
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PipelineModel(id: $id, name: $name, description: $description, isDefault: $isDefault, stages: $stages, totalValue: $totalValue, totalDeals: $totalDeals, wonDeals: $wonDeals, lostDeals: $lostDeals, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PipelineModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            const DeepCollectionEquality().equals(other._stages, _stages) &&
            (identical(other.totalValue, totalValue) ||
                other.totalValue == totalValue) &&
            (identical(other.totalDeals, totalDeals) ||
                other.totalDeals == totalDeals) &&
            (identical(other.wonDeals, wonDeals) ||
                other.wonDeals == wonDeals) &&
            (identical(other.lostDeals, lostDeals) ||
                other.lostDeals == lostDeals) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      isDefault,
      const DeepCollectionEquality().hash(_stages),
      totalValue,
      totalDeals,
      wonDeals,
      lostDeals,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PipelineModelImplCopyWith<_$PipelineModelImpl> get copyWith =>
      __$$PipelineModelImplCopyWithImpl<_$PipelineModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PipelineModelImplToJson(
      this,
    );
  }
}

abstract class _PipelineModel implements PipelineModel {
  const factory _PipelineModel(
      {required final String id,
      required final String name,
      final String? description,
      required final bool isDefault,
      final List<PipelineStage> stages,
      final double? totalValue,
      final int? totalDeals,
      final int? wonDeals,
      final int? lostDeals,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$PipelineModelImpl;

  factory _PipelineModel.fromJson(Map<String, dynamic> json) =
      _$PipelineModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  bool get isDefault;
  @override // Stages
  List<PipelineStage> get stages;
  @override // Metrics
  double? get totalValue;
  @override
  int? get totalDeals;
  @override
  int? get wonDeals;
  @override
  int? get lostDeals;
  @override // Dates
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$PipelineModelImplCopyWith<_$PipelineModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PipelineStage _$PipelineStageFromJson(Map<String, dynamic> json) {
  return _PipelineStage.fromJson(json);
}

/// @nodoc
mixin _$PipelineStage {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  double get probability => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PipelineStageCopyWith<PipelineStage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PipelineStageCopyWith<$Res> {
  factory $PipelineStageCopyWith(
          PipelineStage value, $Res Function(PipelineStage) then) =
      _$PipelineStageCopyWithImpl<$Res, PipelineStage>;
  @useResult
  $Res call(
      {String id,
      String name,
      int order,
      double probability,
      String? description,
      int? color});
}

/// @nodoc
class _$PipelineStageCopyWithImpl<$Res, $Val extends PipelineStage>
    implements $PipelineStageCopyWith<$Res> {
  _$PipelineStageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? order = null,
    Object? probability = null,
    Object? description = freezed,
    Object? color = freezed,
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
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PipelineStageImplCopyWith<$Res>
    implements $PipelineStageCopyWith<$Res> {
  factory _$$PipelineStageImplCopyWith(
          _$PipelineStageImpl value, $Res Function(_$PipelineStageImpl) then) =
      __$$PipelineStageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int order,
      double probability,
      String? description,
      int? color});
}

/// @nodoc
class __$$PipelineStageImplCopyWithImpl<$Res>
    extends _$PipelineStageCopyWithImpl<$Res, _$PipelineStageImpl>
    implements _$$PipelineStageImplCopyWith<$Res> {
  __$$PipelineStageImplCopyWithImpl(
      _$PipelineStageImpl _value, $Res Function(_$PipelineStageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? order = null,
    Object? probability = null,
    Object? description = freezed,
    Object? color = freezed,
  }) {
    return _then(_$PipelineStageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PipelineStageImpl implements _PipelineStage {
  const _$PipelineStageImpl(
      {required this.id,
      required this.name,
      required this.order,
      required this.probability,
      this.description,
      this.color});

  factory _$PipelineStageImpl.fromJson(Map<String, dynamic> json) =>
      _$$PipelineStageImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int order;
  @override
  final double probability;
  @override
  final String? description;
  @override
  final int? color;

  @override
  String toString() {
    return 'PipelineStage(id: $id, name: $name, order: $order, probability: $probability, description: $description, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PipelineStageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, order, probability, description, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PipelineStageImplCopyWith<_$PipelineStageImpl> get copyWith =>
      __$$PipelineStageImplCopyWithImpl<_$PipelineStageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PipelineStageImplToJson(
      this,
    );
  }
}

abstract class _PipelineStage implements PipelineStage {
  const factory _PipelineStage(
      {required final String id,
      required final String name,
      required final int order,
      required final double probability,
      final String? description,
      final int? color}) = _$PipelineStageImpl;

  factory _PipelineStage.fromJson(Map<String, dynamic> json) =
      _$PipelineStageImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get order;
  @override
  double get probability;
  @override
  String? get description;
  @override
  int? get color;
  @override
  @JsonKey(ignore: true)
  _$$PipelineStageImplCopyWith<_$PipelineStageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
