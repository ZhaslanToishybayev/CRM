// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crm_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Client _$ClientFromJson(Map<String, dynamic> json) {
  return _Client.fromJson(json);
}

/// @nodoc
mixin _$Client {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get company => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  ClientStatus get status => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get assignedTo => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientCopyWith<Client> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientCopyWith<$Res> {
  factory $ClientCopyWith(Client value, $Res Function(Client) then) =
      _$ClientCopyWithImpl<$Res, Client>;
  @useResult
  $Res call(
      {String id,
      String name,
      String company,
      String email,
      String phone,
      ClientStatus status,
      String source,
      String assignedTo,
      double value,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$ClientCopyWithImpl<$Res, $Val extends Client>
    implements $ClientCopyWith<$Res> {
  _$ClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? company = null,
    Object? email = null,
    Object? phone = null,
    Object? status = null,
    Object? source = null,
    Object? assignedTo = null,
    Object? value = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ClientStatus,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      assignedTo: null == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientImplCopyWith<$Res> implements $ClientCopyWith<$Res> {
  factory _$$ClientImplCopyWith(
          _$ClientImpl value, $Res Function(_$ClientImpl) then) =
      __$$ClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String company,
      String email,
      String phone,
      ClientStatus status,
      String source,
      String assignedTo,
      double value,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$ClientImplCopyWithImpl<$Res>
    extends _$ClientCopyWithImpl<$Res, _$ClientImpl>
    implements _$$ClientImplCopyWith<$Res> {
  __$$ClientImplCopyWithImpl(
      _$ClientImpl _value, $Res Function(_$ClientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? company = null,
    Object? email = null,
    Object? phone = null,
    Object? status = null,
    Object? source = null,
    Object? assignedTo = null,
    Object? value = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ClientImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ClientStatus,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      assignedTo: null == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientImpl implements _Client {
  const _$ClientImpl(
      {required this.id,
      required this.name,
      required this.company,
      required this.email,
      required this.phone,
      required this.status,
      required this.source,
      required this.assignedTo,
      required this.value,
      required this.createdAt,
      required this.updatedAt});

  factory _$ClientImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String company;
  @override
  final String email;
  @override
  final String phone;
  @override
  final ClientStatus status;
  @override
  final String source;
  @override
  final String assignedTo;
  @override
  final double value;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Client(id: $id, name: $name, company: $company, email: $email, phone: $phone, status: $status, source: $source, assignedTo: $assignedTo, value: $value, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.assignedTo, assignedTo) ||
                other.assignedTo == assignedTo) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, company, email, phone,
      status, source, assignedTo, value, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientImplCopyWith<_$ClientImpl> get copyWith =>
      __$$ClientImplCopyWithImpl<_$ClientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientImplToJson(
      this,
    );
  }
}

abstract class _Client implements Client {
  const factory _Client(
      {required final String id,
      required final String name,
      required final String company,
      required final String email,
      required final String phone,
      required final ClientStatus status,
      required final String source,
      required final String assignedTo,
      required final double value,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$ClientImpl;

  factory _Client.fromJson(Map<String, dynamic> json) = _$ClientImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get company;
  @override
  String get email;
  @override
  String get phone;
  @override
  ClientStatus get status;
  @override
  String get source;
  @override
  String get assignedTo;
  @override
  double get value;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ClientImplCopyWith<_$ClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Deal _$DealFromJson(Map<String, dynamic> json) {
  return _Deal.fromJson(json);
}

/// @nodoc
mixin _$Deal {
  String get id => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  DealStage get stage => throw _privateConstructorUsedError;
  int get probability => throw _privateConstructorUsedError;
  DateTime get expectedCloseDate => throw _privateConstructorUsedError;
  String get assignedTo => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DealCopyWith<Deal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealCopyWith<$Res> {
  factory $DealCopyWith(Deal value, $Res Function(Deal) then) =
      _$DealCopyWithImpl<$Res, Deal>;
  @useResult
  $Res call(
      {String id,
      String clientId,
      String title,
      String description,
      double value,
      DealStage stage,
      int probability,
      DateTime expectedCloseDate,
      String assignedTo,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$DealCopyWithImpl<$Res, $Val extends Deal>
    implements $DealCopyWith<$Res> {
  _$DealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? title = null,
    Object? description = null,
    Object? value = null,
    Object? stage = null,
    Object? probability = null,
    Object? expectedCloseDate = null,
    Object? assignedTo = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as DealStage,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as int,
      expectedCloseDate: null == expectedCloseDate
          ? _value.expectedCloseDate
          : expectedCloseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      assignedTo: null == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DealImplCopyWith<$Res> implements $DealCopyWith<$Res> {
  factory _$$DealImplCopyWith(
          _$DealImpl value, $Res Function(_$DealImpl) then) =
      __$$DealImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String clientId,
      String title,
      String description,
      double value,
      DealStage stage,
      int probability,
      DateTime expectedCloseDate,
      String assignedTo,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$DealImplCopyWithImpl<$Res>
    extends _$DealCopyWithImpl<$Res, _$DealImpl>
    implements _$$DealImplCopyWith<$Res> {
  __$$DealImplCopyWithImpl(_$DealImpl _value, $Res Function(_$DealImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? title = null,
    Object? description = null,
    Object? value = null,
    Object? stage = null,
    Object? probability = null,
    Object? expectedCloseDate = null,
    Object? assignedTo = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$DealImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as DealStage,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as int,
      expectedCloseDate: null == expectedCloseDate
          ? _value.expectedCloseDate
          : expectedCloseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      assignedTo: null == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DealImpl implements _Deal {
  const _$DealImpl(
      {required this.id,
      required this.clientId,
      required this.title,
      required this.description,
      required this.value,
      required this.stage,
      required this.probability,
      required this.expectedCloseDate,
      required this.assignedTo,
      required this.createdAt,
      required this.updatedAt});

  factory _$DealImpl.fromJson(Map<String, dynamic> json) =>
      _$$DealImplFromJson(json);

  @override
  final String id;
  @override
  final String clientId;
  @override
  final String title;
  @override
  final String description;
  @override
  final double value;
  @override
  final DealStage stage;
  @override
  final int probability;
  @override
  final DateTime expectedCloseDate;
  @override
  final String assignedTo;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Deal(id: $id, clientId: $clientId, title: $title, description: $description, value: $value, stage: $stage, probability: $probability, expectedCloseDate: $expectedCloseDate, assignedTo: $assignedTo, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DealImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.expectedCloseDate, expectedCloseDate) ||
                other.expectedCloseDate == expectedCloseDate) &&
            (identical(other.assignedTo, assignedTo) ||
                other.assignedTo == assignedTo) &&
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
      clientId,
      title,
      description,
      value,
      stage,
      probability,
      expectedCloseDate,
      assignedTo,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DealImplCopyWith<_$DealImpl> get copyWith =>
      __$$DealImplCopyWithImpl<_$DealImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DealImplToJson(
      this,
    );
  }
}

abstract class _Deal implements Deal {
  const factory _Deal(
      {required final String id,
      required final String clientId,
      required final String title,
      required final String description,
      required final double value,
      required final DealStage stage,
      required final int probability,
      required final DateTime expectedCloseDate,
      required final String assignedTo,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$DealImpl;

  factory _Deal.fromJson(Map<String, dynamic> json) = _$DealImpl.fromJson;

  @override
  String get id;
  @override
  String get clientId;
  @override
  String get title;
  @override
  String get description;
  @override
  double get value;
  @override
  DealStage get stage;
  @override
  int get probability;
  @override
  DateTime get expectedCloseDate;
  @override
  String get assignedTo;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$DealImplCopyWith<_$DealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return _Activity.fromJson(json);
}

/// @nodoc
mixin _$Activity {
  String get id => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String? get dealId => throw _privateConstructorUsedError;
  ActivityType get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get scheduledAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  ActivityStatus get status => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivityCopyWith<Activity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityCopyWith<$Res> {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) then) =
      _$ActivityCopyWithImpl<$Res, Activity>;
  @useResult
  $Res call(
      {String id,
      String clientId,
      String? dealId,
      ActivityType type,
      String description,
      DateTime scheduledAt,
      DateTime? completedAt,
      ActivityStatus status,
      String createdBy});
}

/// @nodoc
class _$ActivityCopyWithImpl<$Res, $Val extends Activity>
    implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? dealId = freezed,
    Object? type = null,
    Object? description = null,
    Object? scheduledAt = null,
    Object? completedAt = freezed,
    Object? status = null,
    Object? createdBy = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      dealId: freezed == dealId
          ? _value.dealId
          : dealId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ActivityStatus,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityImplCopyWith<$Res>
    implements $ActivityCopyWith<$Res> {
  factory _$$ActivityImplCopyWith(
          _$ActivityImpl value, $Res Function(_$ActivityImpl) then) =
      __$$ActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String clientId,
      String? dealId,
      ActivityType type,
      String description,
      DateTime scheduledAt,
      DateTime? completedAt,
      ActivityStatus status,
      String createdBy});
}

/// @nodoc
class __$$ActivityImplCopyWithImpl<$Res>
    extends _$ActivityCopyWithImpl<$Res, _$ActivityImpl>
    implements _$$ActivityImplCopyWith<$Res> {
  __$$ActivityImplCopyWithImpl(
      _$ActivityImpl _value, $Res Function(_$ActivityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? dealId = freezed,
    Object? type = null,
    Object? description = null,
    Object? scheduledAt = null,
    Object? completedAt = freezed,
    Object? status = null,
    Object? createdBy = null,
  }) {
    return _then(_$ActivityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      dealId: freezed == dealId
          ? _value.dealId
          : dealId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ActivityStatus,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityImpl implements _Activity {
  const _$ActivityImpl(
      {required this.id,
      required this.clientId,
      required this.dealId,
      required this.type,
      required this.description,
      required this.scheduledAt,
      this.completedAt,
      required this.status,
      required this.createdBy});

  factory _$ActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityImplFromJson(json);

  @override
  final String id;
  @override
  final String clientId;
  @override
  final String? dealId;
  @override
  final ActivityType type;
  @override
  final String description;
  @override
  final DateTime scheduledAt;
  @override
  final DateTime? completedAt;
  @override
  final ActivityStatus status;
  @override
  final String createdBy;

  @override
  String toString() {
    return 'Activity(id: $id, clientId: $clientId, dealId: $dealId, type: $type, description: $description, scheduledAt: $scheduledAt, completedAt: $completedAt, status: $status, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.dealId, dealId) || other.dealId == dealId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, clientId, dealId, type,
      description, scheduledAt, completedAt, status, createdBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      __$$ActivityImplCopyWithImpl<_$ActivityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityImplToJson(
      this,
    );
  }
}

abstract class _Activity implements Activity {
  const factory _Activity(
      {required final String id,
      required final String clientId,
      required final String? dealId,
      required final ActivityType type,
      required final String description,
      required final DateTime scheduledAt,
      final DateTime? completedAt,
      required final ActivityStatus status,
      required final String createdBy}) = _$ActivityImpl;

  factory _Activity.fromJson(Map<String, dynamic> json) =
      _$ActivityImpl.fromJson;

  @override
  String get id;
  @override
  String get clientId;
  @override
  String? get dealId;
  @override
  ActivityType get type;
  @override
  String get description;
  @override
  DateTime get scheduledAt;
  @override
  DateTime? get completedAt;
  @override
  ActivityStatus get status;
  @override
  String get createdBy;
  @override
  @JsonKey(ignore: true)
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SalesStats _$SalesStatsFromJson(Map<String, dynamic> json) {
  return _SalesStats.fromJson(json);
}

/// @nodoc
mixin _$SalesStats {
  double get totalRevenue => throw _privateConstructorUsedError;
  int get totalDeals => throw _privateConstructorUsedError;
  double get conversionRate => throw _privateConstructorUsedError;
  double get averageDealSize => throw _privateConstructorUsedError;
  List<DealStageStats> get stageStats => throw _privateConstructorUsedError;
  List<MonthlyRevenue> get monthlyRevenue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SalesStatsCopyWith<SalesStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesStatsCopyWith<$Res> {
  factory $SalesStatsCopyWith(
          SalesStats value, $Res Function(SalesStats) then) =
      _$SalesStatsCopyWithImpl<$Res, SalesStats>;
  @useResult
  $Res call(
      {double totalRevenue,
      int totalDeals,
      double conversionRate,
      double averageDealSize,
      List<DealStageStats> stageStats,
      List<MonthlyRevenue> monthlyRevenue});
}

/// @nodoc
class _$SalesStatsCopyWithImpl<$Res, $Val extends SalesStats>
    implements $SalesStatsCopyWith<$Res> {
  _$SalesStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? totalDeals = null,
    Object? conversionRate = null,
    Object? averageDealSize = null,
    Object? stageStats = null,
    Object? monthlyRevenue = null,
  }) {
    return _then(_value.copyWith(
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      totalDeals: null == totalDeals
          ? _value.totalDeals
          : totalDeals // ignore: cast_nullable_to_non_nullable
              as int,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as double,
      averageDealSize: null == averageDealSize
          ? _value.averageDealSize
          : averageDealSize // ignore: cast_nullable_to_non_nullable
              as double,
      stageStats: null == stageStats
          ? _value.stageStats
          : stageStats // ignore: cast_nullable_to_non_nullable
              as List<DealStageStats>,
      monthlyRevenue: null == monthlyRevenue
          ? _value.monthlyRevenue
          : monthlyRevenue // ignore: cast_nullable_to_non_nullable
              as List<MonthlyRevenue>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalesStatsImplCopyWith<$Res>
    implements $SalesStatsCopyWith<$Res> {
  factory _$$SalesStatsImplCopyWith(
          _$SalesStatsImpl value, $Res Function(_$SalesStatsImpl) then) =
      __$$SalesStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalRevenue,
      int totalDeals,
      double conversionRate,
      double averageDealSize,
      List<DealStageStats> stageStats,
      List<MonthlyRevenue> monthlyRevenue});
}

/// @nodoc
class __$$SalesStatsImplCopyWithImpl<$Res>
    extends _$SalesStatsCopyWithImpl<$Res, _$SalesStatsImpl>
    implements _$$SalesStatsImplCopyWith<$Res> {
  __$$SalesStatsImplCopyWithImpl(
      _$SalesStatsImpl _value, $Res Function(_$SalesStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? totalDeals = null,
    Object? conversionRate = null,
    Object? averageDealSize = null,
    Object? stageStats = null,
    Object? monthlyRevenue = null,
  }) {
    return _then(_$SalesStatsImpl(
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      totalDeals: null == totalDeals
          ? _value.totalDeals
          : totalDeals // ignore: cast_nullable_to_non_nullable
              as int,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as double,
      averageDealSize: null == averageDealSize
          ? _value.averageDealSize
          : averageDealSize // ignore: cast_nullable_to_non_nullable
              as double,
      stageStats: null == stageStats
          ? _value._stageStats
          : stageStats // ignore: cast_nullable_to_non_nullable
              as List<DealStageStats>,
      monthlyRevenue: null == monthlyRevenue
          ? _value._monthlyRevenue
          : monthlyRevenue // ignore: cast_nullable_to_non_nullable
              as List<MonthlyRevenue>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesStatsImpl implements _SalesStats {
  const _$SalesStatsImpl(
      {required this.totalRevenue,
      required this.totalDeals,
      required this.conversionRate,
      required this.averageDealSize,
      required final List<DealStageStats> stageStats,
      required final List<MonthlyRevenue> monthlyRevenue})
      : _stageStats = stageStats,
        _monthlyRevenue = monthlyRevenue;

  factory _$SalesStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesStatsImplFromJson(json);

  @override
  final double totalRevenue;
  @override
  final int totalDeals;
  @override
  final double conversionRate;
  @override
  final double averageDealSize;
  final List<DealStageStats> _stageStats;
  @override
  List<DealStageStats> get stageStats {
    if (_stageStats is EqualUnmodifiableListView) return _stageStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stageStats);
  }

  final List<MonthlyRevenue> _monthlyRevenue;
  @override
  List<MonthlyRevenue> get monthlyRevenue {
    if (_monthlyRevenue is EqualUnmodifiableListView) return _monthlyRevenue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monthlyRevenue);
  }

  @override
  String toString() {
    return 'SalesStats(totalRevenue: $totalRevenue, totalDeals: $totalDeals, conversionRate: $conversionRate, averageDealSize: $averageDealSize, stageStats: $stageStats, monthlyRevenue: $monthlyRevenue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesStatsImpl &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.totalDeals, totalDeals) ||
                other.totalDeals == totalDeals) &&
            (identical(other.conversionRate, conversionRate) ||
                other.conversionRate == conversionRate) &&
            (identical(other.averageDealSize, averageDealSize) ||
                other.averageDealSize == averageDealSize) &&
            const DeepCollectionEquality()
                .equals(other._stageStats, _stageStats) &&
            const DeepCollectionEquality()
                .equals(other._monthlyRevenue, _monthlyRevenue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalRevenue,
      totalDeals,
      conversionRate,
      averageDealSize,
      const DeepCollectionEquality().hash(_stageStats),
      const DeepCollectionEquality().hash(_monthlyRevenue));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesStatsImplCopyWith<_$SalesStatsImpl> get copyWith =>
      __$$SalesStatsImplCopyWithImpl<_$SalesStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesStatsImplToJson(
      this,
    );
  }
}

abstract class _SalesStats implements SalesStats {
  const factory _SalesStats(
      {required final double totalRevenue,
      required final int totalDeals,
      required final double conversionRate,
      required final double averageDealSize,
      required final List<DealStageStats> stageStats,
      required final List<MonthlyRevenue> monthlyRevenue}) = _$SalesStatsImpl;

  factory _SalesStats.fromJson(Map<String, dynamic> json) =
      _$SalesStatsImpl.fromJson;

  @override
  double get totalRevenue;
  @override
  int get totalDeals;
  @override
  double get conversionRate;
  @override
  double get averageDealSize;
  @override
  List<DealStageStats> get stageStats;
  @override
  List<MonthlyRevenue> get monthlyRevenue;
  @override
  @JsonKey(ignore: true)
  _$$SalesStatsImplCopyWith<_$SalesStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DealStageStats _$DealStageStatsFromJson(Map<String, dynamic> json) {
  return _DealStageStats.fromJson(json);
}

/// @nodoc
mixin _$DealStageStats {
  DealStage get stage => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  double get totalValue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DealStageStatsCopyWith<DealStageStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealStageStatsCopyWith<$Res> {
  factory $DealStageStatsCopyWith(
          DealStageStats value, $Res Function(DealStageStats) then) =
      _$DealStageStatsCopyWithImpl<$Res, DealStageStats>;
  @useResult
  $Res call({DealStage stage, int count, double totalValue});
}

/// @nodoc
class _$DealStageStatsCopyWithImpl<$Res, $Val extends DealStageStats>
    implements $DealStageStatsCopyWith<$Res> {
  _$DealStageStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stage = null,
    Object? count = null,
    Object? totalValue = null,
  }) {
    return _then(_value.copyWith(
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as DealStage,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      totalValue: null == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DealStageStatsImplCopyWith<$Res>
    implements $DealStageStatsCopyWith<$Res> {
  factory _$$DealStageStatsImplCopyWith(_$DealStageStatsImpl value,
          $Res Function(_$DealStageStatsImpl) then) =
      __$$DealStageStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DealStage stage, int count, double totalValue});
}

/// @nodoc
class __$$DealStageStatsImplCopyWithImpl<$Res>
    extends _$DealStageStatsCopyWithImpl<$Res, _$DealStageStatsImpl>
    implements _$$DealStageStatsImplCopyWith<$Res> {
  __$$DealStageStatsImplCopyWithImpl(
      _$DealStageStatsImpl _value, $Res Function(_$DealStageStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stage = null,
    Object? count = null,
    Object? totalValue = null,
  }) {
    return _then(_$DealStageStatsImpl(
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as DealStage,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      totalValue: null == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DealStageStatsImpl implements _DealStageStats {
  const _$DealStageStatsImpl(
      {required this.stage, required this.count, required this.totalValue});

  factory _$DealStageStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DealStageStatsImplFromJson(json);

  @override
  final DealStage stage;
  @override
  final int count;
  @override
  final double totalValue;

  @override
  String toString() {
    return 'DealStageStats(stage: $stage, count: $count, totalValue: $totalValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DealStageStatsImpl &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.totalValue, totalValue) ||
                other.totalValue == totalValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, stage, count, totalValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DealStageStatsImplCopyWith<_$DealStageStatsImpl> get copyWith =>
      __$$DealStageStatsImplCopyWithImpl<_$DealStageStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DealStageStatsImplToJson(
      this,
    );
  }
}

abstract class _DealStageStats implements DealStageStats {
  const factory _DealStageStats(
      {required final DealStage stage,
      required final int count,
      required final double totalValue}) = _$DealStageStatsImpl;

  factory _DealStageStats.fromJson(Map<String, dynamic> json) =
      _$DealStageStatsImpl.fromJson;

  @override
  DealStage get stage;
  @override
  int get count;
  @override
  double get totalValue;
  @override
  @JsonKey(ignore: true)
  _$$DealStageStatsImplCopyWith<_$DealStageStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyRevenue _$MonthlyRevenueFromJson(Map<String, dynamic> json) {
  return _MonthlyRevenue.fromJson(json);
}

/// @nodoc
mixin _$MonthlyRevenue {
  String get month => throw _privateConstructorUsedError;
  double get revenue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MonthlyRevenueCopyWith<MonthlyRevenue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyRevenueCopyWith<$Res> {
  factory $MonthlyRevenueCopyWith(
          MonthlyRevenue value, $Res Function(MonthlyRevenue) then) =
      _$MonthlyRevenueCopyWithImpl<$Res, MonthlyRevenue>;
  @useResult
  $Res call({String month, double revenue});
}

/// @nodoc
class _$MonthlyRevenueCopyWithImpl<$Res, $Val extends MonthlyRevenue>
    implements $MonthlyRevenueCopyWith<$Res> {
  _$MonthlyRevenueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? revenue = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlyRevenueImplCopyWith<$Res>
    implements $MonthlyRevenueCopyWith<$Res> {
  factory _$$MonthlyRevenueImplCopyWith(_$MonthlyRevenueImpl value,
          $Res Function(_$MonthlyRevenueImpl) then) =
      __$$MonthlyRevenueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String month, double revenue});
}

/// @nodoc
class __$$MonthlyRevenueImplCopyWithImpl<$Res>
    extends _$MonthlyRevenueCopyWithImpl<$Res, _$MonthlyRevenueImpl>
    implements _$$MonthlyRevenueImplCopyWith<$Res> {
  __$$MonthlyRevenueImplCopyWithImpl(
      _$MonthlyRevenueImpl _value, $Res Function(_$MonthlyRevenueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? revenue = null,
  }) {
    return _then(_$MonthlyRevenueImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyRevenueImpl implements _MonthlyRevenue {
  const _$MonthlyRevenueImpl({required this.month, required this.revenue});

  factory _$MonthlyRevenueImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyRevenueImplFromJson(json);

  @override
  final String month;
  @override
  final double revenue;

  @override
  String toString() {
    return 'MonthlyRevenue(month: $month, revenue: $revenue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyRevenueImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.revenue, revenue) || other.revenue == revenue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, month, revenue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyRevenueImplCopyWith<_$MonthlyRevenueImpl> get copyWith =>
      __$$MonthlyRevenueImplCopyWithImpl<_$MonthlyRevenueImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyRevenueImplToJson(
      this,
    );
  }
}

abstract class _MonthlyRevenue implements MonthlyRevenue {
  const factory _MonthlyRevenue(
      {required final String month,
      required final double revenue}) = _$MonthlyRevenueImpl;

  factory _MonthlyRevenue.fromJson(Map<String, dynamic> json) =
      _$MonthlyRevenueImpl.fromJson;

  @override
  String get month;
  @override
  double get revenue;
  @override
  @JsonKey(ignore: true)
  _$$MonthlyRevenueImplCopyWith<_$MonthlyRevenueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
