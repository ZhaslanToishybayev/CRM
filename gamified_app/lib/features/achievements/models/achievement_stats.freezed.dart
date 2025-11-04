// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AchievementStats _$AchievementStatsFromJson(Map<String, dynamic> json) {
  return _AchievementStats.fromJson(json);
}

/// @nodoc
mixin _$AchievementStats {
  int get totalAchievements => throw _privateConstructorUsedError;
  int get unlockedAchievements => throw _privateConstructorUsedError;
  int get lockedAchievements => throw _privateConstructorUsedError;
  double get completionPercentage => throw _privateConstructorUsedError;
  Map<AchievementCategory, int> get categoryStats =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AchievementStatsCopyWith<AchievementStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementStatsCopyWith<$Res> {
  factory $AchievementStatsCopyWith(
          AchievementStats value, $Res Function(AchievementStats) then) =
      _$AchievementStatsCopyWithImpl<$Res, AchievementStats>;
  @useResult
  $Res call(
      {int totalAchievements,
      int unlockedAchievements,
      int lockedAchievements,
      double completionPercentage,
      Map<AchievementCategory, int> categoryStats});
}

/// @nodoc
class _$AchievementStatsCopyWithImpl<$Res, $Val extends AchievementStats>
    implements $AchievementStatsCopyWith<$Res> {
  _$AchievementStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAchievements = null,
    Object? unlockedAchievements = null,
    Object? lockedAchievements = null,
    Object? completionPercentage = null,
    Object? categoryStats = null,
  }) {
    return _then(_value.copyWith(
      totalAchievements: null == totalAchievements
          ? _value.totalAchievements
          : totalAchievements // ignore: cast_nullable_to_non_nullable
              as int,
      unlockedAchievements: null == unlockedAchievements
          ? _value.unlockedAchievements
          : unlockedAchievements // ignore: cast_nullable_to_non_nullable
              as int,
      lockedAchievements: null == lockedAchievements
          ? _value.lockedAchievements
          : lockedAchievements // ignore: cast_nullable_to_non_nullable
              as int,
      completionPercentage: null == completionPercentage
          ? _value.completionPercentage
          : completionPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      categoryStats: null == categoryStats
          ? _value.categoryStats
          : categoryStats // ignore: cast_nullable_to_non_nullable
              as Map<AchievementCategory, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AchievementStatsImplCopyWith<$Res>
    implements $AchievementStatsCopyWith<$Res> {
  factory _$$AchievementStatsImplCopyWith(_$AchievementStatsImpl value,
          $Res Function(_$AchievementStatsImpl) then) =
      __$$AchievementStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalAchievements,
      int unlockedAchievements,
      int lockedAchievements,
      double completionPercentage,
      Map<AchievementCategory, int> categoryStats});
}

/// @nodoc
class __$$AchievementStatsImplCopyWithImpl<$Res>
    extends _$AchievementStatsCopyWithImpl<$Res, _$AchievementStatsImpl>
    implements _$$AchievementStatsImplCopyWith<$Res> {
  __$$AchievementStatsImplCopyWithImpl(_$AchievementStatsImpl _value,
      $Res Function(_$AchievementStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAchievements = null,
    Object? unlockedAchievements = null,
    Object? lockedAchievements = null,
    Object? completionPercentage = null,
    Object? categoryStats = null,
  }) {
    return _then(_$AchievementStatsImpl(
      totalAchievements: null == totalAchievements
          ? _value.totalAchievements
          : totalAchievements // ignore: cast_nullable_to_non_nullable
              as int,
      unlockedAchievements: null == unlockedAchievements
          ? _value.unlockedAchievements
          : unlockedAchievements // ignore: cast_nullable_to_non_nullable
              as int,
      lockedAchievements: null == lockedAchievements
          ? _value.lockedAchievements
          : lockedAchievements // ignore: cast_nullable_to_non_nullable
              as int,
      completionPercentage: null == completionPercentage
          ? _value.completionPercentage
          : completionPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      categoryStats: null == categoryStats
          ? _value._categoryStats
          : categoryStats // ignore: cast_nullable_to_non_nullable
              as Map<AchievementCategory, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AchievementStatsImpl implements _AchievementStats {
  const _$AchievementStatsImpl(
      {required this.totalAchievements,
      required this.unlockedAchievements,
      required this.lockedAchievements,
      required this.completionPercentage,
      final Map<AchievementCategory, int> categoryStats = const {}})
      : _categoryStats = categoryStats;

  factory _$AchievementStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AchievementStatsImplFromJson(json);

  @override
  final int totalAchievements;
  @override
  final int unlockedAchievements;
  @override
  final int lockedAchievements;
  @override
  final double completionPercentage;
  final Map<AchievementCategory, int> _categoryStats;
  @override
  @JsonKey()
  Map<AchievementCategory, int> get categoryStats {
    if (_categoryStats is EqualUnmodifiableMapView) return _categoryStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryStats);
  }

  @override
  String toString() {
    return 'AchievementStats(totalAchievements: $totalAchievements, unlockedAchievements: $unlockedAchievements, lockedAchievements: $lockedAchievements, completionPercentage: $completionPercentage, categoryStats: $categoryStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementStatsImpl &&
            (identical(other.totalAchievements, totalAchievements) ||
                other.totalAchievements == totalAchievements) &&
            (identical(other.unlockedAchievements, unlockedAchievements) ||
                other.unlockedAchievements == unlockedAchievements) &&
            (identical(other.lockedAchievements, lockedAchievements) ||
                other.lockedAchievements == lockedAchievements) &&
            (identical(other.completionPercentage, completionPercentage) ||
                other.completionPercentage == completionPercentage) &&
            const DeepCollectionEquality()
                .equals(other._categoryStats, _categoryStats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalAchievements,
      unlockedAchievements,
      lockedAchievements,
      completionPercentage,
      const DeepCollectionEquality().hash(_categoryStats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementStatsImplCopyWith<_$AchievementStatsImpl> get copyWith =>
      __$$AchievementStatsImplCopyWithImpl<_$AchievementStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AchievementStatsImplToJson(
      this,
    );
  }
}

abstract class _AchievementStats implements AchievementStats {
  const factory _AchievementStats(
          {required final int totalAchievements,
          required final int unlockedAchievements,
          required final int lockedAchievements,
          required final double completionPercentage,
          final Map<AchievementCategory, int> categoryStats}) =
      _$AchievementStatsImpl;

  factory _AchievementStats.fromJson(Map<String, dynamic> json) =
      _$AchievementStatsImpl.fromJson;

  @override
  int get totalAchievements;
  @override
  int get unlockedAchievements;
  @override
  int get lockedAchievements;
  @override
  double get completionPercentage;
  @override
  Map<AchievementCategory, int> get categoryStats;
  @override
  @JsonKey(ignore: true)
  _$$AchievementStatsImplCopyWith<_$AchievementStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
