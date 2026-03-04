// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_suggestion_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AISuggestion _$AISuggestionFromJson(Map<String, dynamic> json) {
  return _AISuggestion.fromJson(json);
}

/// @nodoc
mixin _$AISuggestion {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  AISuggestionType get type => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get reasons => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AISuggestionCopyWith<AISuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AISuggestionCopyWith<$Res> {
  factory $AISuggestionCopyWith(
          AISuggestion value, $Res Function(AISuggestion) then) =
      _$AISuggestionCopyWithImpl<$Res, AISuggestion>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      AISuggestionType type,
      int priority,
      double confidence,
      DateTime createdAt,
      List<String> reasons,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$AISuggestionCopyWithImpl<$Res, $Val extends AISuggestion>
    implements $AISuggestionCopyWith<$Res> {
  _$AISuggestionCopyWithImpl(this._value, this._then);

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
    Object? type = null,
    Object? priority = null,
    Object? confidence = null,
    Object? createdAt = null,
    Object? reasons = null,
    Object? metadata = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AISuggestionType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reasons: null == reasons
          ? _value.reasons
          : reasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AISuggestionImplCopyWith<$Res>
    implements $AISuggestionCopyWith<$Res> {
  factory _$$AISuggestionImplCopyWith(
          _$AISuggestionImpl value, $Res Function(_$AISuggestionImpl) then) =
      __$$AISuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      AISuggestionType type,
      int priority,
      double confidence,
      DateTime createdAt,
      List<String> reasons,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$AISuggestionImplCopyWithImpl<$Res>
    extends _$AISuggestionCopyWithImpl<$Res, _$AISuggestionImpl>
    implements _$$AISuggestionImplCopyWith<$Res> {
  __$$AISuggestionImplCopyWithImpl(
      _$AISuggestionImpl _value, $Res Function(_$AISuggestionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? priority = null,
    Object? confidence = null,
    Object? createdAt = null,
    Object? reasons = null,
    Object? metadata = freezed,
  }) {
    return _then(_$AISuggestionImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AISuggestionType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reasons: null == reasons
          ? _value._reasons
          : reasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AISuggestionImpl implements _AISuggestion {
  const _$AISuggestionImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.type,
      required this.priority,
      required this.confidence,
      required this.createdAt,
      final List<String> reasons = const [],
      final Map<String, dynamic>? metadata})
      : _reasons = reasons,
        _metadata = metadata;

  factory _$AISuggestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AISuggestionImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final AISuggestionType type;
  @override
  final int priority;
  @override
  final double confidence;
  @override
  final DateTime createdAt;
  final List<String> _reasons;
  @override
  @JsonKey()
  List<String> get reasons {
    if (_reasons is EqualUnmodifiableListView) return _reasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reasons);
  }

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
  String toString() {
    return 'AISuggestion(id: $id, title: $title, description: $description, type: $type, priority: $priority, confidence: $confidence, createdAt: $createdAt, reasons: $reasons, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AISuggestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._reasons, _reasons) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      type,
      priority,
      confidence,
      createdAt,
      const DeepCollectionEquality().hash(_reasons),
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AISuggestionImplCopyWith<_$AISuggestionImpl> get copyWith =>
      __$$AISuggestionImplCopyWithImpl<_$AISuggestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AISuggestionImplToJson(
      this,
    );
  }
}

abstract class _AISuggestion implements AISuggestion {
  const factory _AISuggestion(
      {required final String id,
      required final String title,
      required final String description,
      required final AISuggestionType type,
      required final int priority,
      required final double confidence,
      required final DateTime createdAt,
      final List<String> reasons,
      final Map<String, dynamic>? metadata}) = _$AISuggestionImpl;

  factory _AISuggestion.fromJson(Map<String, dynamic> json) =
      _$AISuggestionImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  AISuggestionType get type;
  @override
  int get priority;
  @override
  double get confidence;
  @override
  DateTime get createdAt;
  @override
  List<String> get reasons;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$AISuggestionImplCopyWith<_$AISuggestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
