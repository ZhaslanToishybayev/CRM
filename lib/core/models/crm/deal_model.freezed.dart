// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deal_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DealModel _$DealModelFromJson(Map<String, dynamic> json) {
  return _DealModel.fromJson(json);
}

/// @nodoc
mixin _$DealModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description =>
      throw _privateConstructorUsedError; // Financial details
  double get amount => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  double? get probability => throw _privateConstructorUsedError; // 0-100
// Dates
  DateTime? get closeDate => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError; // Relations
  String get clientId => throw _privateConstructorUsedError;
  String? get clientName => throw _privateConstructorUsedError;
  String? get companyId => throw _privateConstructorUsedError;
  String? get companyName => throw _privateConstructorUsedError; // Pipeline
  String get stageId => throw _privateConstructorUsedError;
  String? get stageName => throw _privateConstructorUsedError;
  int get stageOrder => throw _privateConstructorUsedError; // Status
  DealStatus get status => throw _privateConstructorUsedError;
  DealSource? get source => throw _privateConstructorUsedError; // Assigned user
  String? get assignedTo => throw _privateConstructorUsedError;
  String? get assignedToName =>
      throw _privateConstructorUsedError; // Products/Services
  List<DealProduct> get products =>
      throw _privateConstructorUsedError; // Tracking
  String? get notes => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  Map<String, dynamic>? get customFields => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DealModelCopyWith<DealModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealModelCopyWith<$Res> {
  factory $DealModelCopyWith(DealModel value, $Res Function(DealModel) then) =
      _$DealModelCopyWithImpl<$Res, DealModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      double amount,
      String? currency,
      double? probability,
      DateTime? closeDate,
      DateTime? createdAt,
      DateTime? updatedAt,
      String clientId,
      String? clientName,
      String? companyId,
      String? companyName,
      String stageId,
      String? stageName,
      int stageOrder,
      DealStatus status,
      DealSource? source,
      String? assignedTo,
      String? assignedToName,
      List<DealProduct> products,
      String? notes,
      List<String> tags,
      Map<String, dynamic>? customFields});
}

/// @nodoc
class _$DealModelCopyWithImpl<$Res, $Val extends DealModel>
    implements $DealModelCopyWith<$Res> {
  _$DealModelCopyWithImpl(this._value, this._then);

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
    Object? amount = null,
    Object? currency = freezed,
    Object? probability = freezed,
    Object? closeDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? clientId = null,
    Object? clientName = freezed,
    Object? companyId = freezed,
    Object? companyName = freezed,
    Object? stageId = null,
    Object? stageName = freezed,
    Object? stageOrder = null,
    Object? status = null,
    Object? source = freezed,
    Object? assignedTo = freezed,
    Object? assignedToName = freezed,
    Object? products = null,
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
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      probability: freezed == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double?,
      closeDate: freezed == closeDate
          ? _value.closeDate
          : closeDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      stageId: null == stageId
          ? _value.stageId
          : stageId // ignore: cast_nullable_to_non_nullable
              as String,
      stageName: freezed == stageName
          ? _value.stageName
          : stageName // ignore: cast_nullable_to_non_nullable
              as String?,
      stageOrder: null == stageOrder
          ? _value.stageOrder
          : stageOrder // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DealStatus,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as DealSource?,
      assignedTo: freezed == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedToName: freezed == assignedToName
          ? _value.assignedToName
          : assignedToName // ignore: cast_nullable_to_non_nullable
              as String?,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<DealProduct>,
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
abstract class _$$DealModelImplCopyWith<$Res>
    implements $DealModelCopyWith<$Res> {
  factory _$$DealModelImplCopyWith(
          _$DealModelImpl value, $Res Function(_$DealModelImpl) then) =
      __$$DealModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      double amount,
      String? currency,
      double? probability,
      DateTime? closeDate,
      DateTime? createdAt,
      DateTime? updatedAt,
      String clientId,
      String? clientName,
      String? companyId,
      String? companyName,
      String stageId,
      String? stageName,
      int stageOrder,
      DealStatus status,
      DealSource? source,
      String? assignedTo,
      String? assignedToName,
      List<DealProduct> products,
      String? notes,
      List<String> tags,
      Map<String, dynamic>? customFields});
}

/// @nodoc
class __$$DealModelImplCopyWithImpl<$Res>
    extends _$DealModelCopyWithImpl<$Res, _$DealModelImpl>
    implements _$$DealModelImplCopyWith<$Res> {
  __$$DealModelImplCopyWithImpl(
      _$DealModelImpl _value, $Res Function(_$DealModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? amount = null,
    Object? currency = freezed,
    Object? probability = freezed,
    Object? closeDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? clientId = null,
    Object? clientName = freezed,
    Object? companyId = freezed,
    Object? companyName = freezed,
    Object? stageId = null,
    Object? stageName = freezed,
    Object? stageOrder = null,
    Object? status = null,
    Object? source = freezed,
    Object? assignedTo = freezed,
    Object? assignedToName = freezed,
    Object? products = null,
    Object? notes = freezed,
    Object? tags = null,
    Object? customFields = freezed,
  }) {
    return _then(_$DealModelImpl(
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
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      probability: freezed == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double?,
      closeDate: freezed == closeDate
          ? _value.closeDate
          : closeDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      stageId: null == stageId
          ? _value.stageId
          : stageId // ignore: cast_nullable_to_non_nullable
              as String,
      stageName: freezed == stageName
          ? _value.stageName
          : stageName // ignore: cast_nullable_to_non_nullable
              as String?,
      stageOrder: null == stageOrder
          ? _value.stageOrder
          : stageOrder // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DealStatus,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as DealSource?,
      assignedTo: freezed == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedToName: freezed == assignedToName
          ? _value.assignedToName
          : assignedToName // ignore: cast_nullable_to_non_nullable
              as String?,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<DealProduct>,
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
class _$DealModelImpl implements _DealModel {
  const _$DealModelImpl(
      {required this.id,
      required this.title,
      this.description,
      required this.amount,
      this.currency,
      this.probability,
      this.closeDate,
      this.createdAt,
      this.updatedAt,
      required this.clientId,
      this.clientName,
      this.companyId,
      this.companyName,
      required this.stageId,
      this.stageName,
      required this.stageOrder,
      required this.status,
      this.source,
      this.assignedTo,
      this.assignedToName,
      final List<DealProduct> products = const [],
      this.notes,
      final List<String> tags = const [],
      final Map<String, dynamic>? customFields})
      : _products = products,
        _tags = tags,
        _customFields = customFields;

  factory _$DealModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DealModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
// Financial details
  @override
  final double amount;
  @override
  final String? currency;
  @override
  final double? probability;
// 0-100
// Dates
  @override
  final DateTime? closeDate;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
// Relations
  @override
  final String clientId;
  @override
  final String? clientName;
  @override
  final String? companyId;
  @override
  final String? companyName;
// Pipeline
  @override
  final String stageId;
  @override
  final String? stageName;
  @override
  final int stageOrder;
// Status
  @override
  final DealStatus status;
  @override
  final DealSource? source;
// Assigned user
  @override
  final String? assignedTo;
  @override
  final String? assignedToName;
// Products/Services
  final List<DealProduct> _products;
// Products/Services
  @override
  @JsonKey()
  List<DealProduct> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

// Tracking
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
    return 'DealModel(id: $id, title: $title, description: $description, amount: $amount, currency: $currency, probability: $probability, closeDate: $closeDate, createdAt: $createdAt, updatedAt: $updatedAt, clientId: $clientId, clientName: $clientName, companyId: $companyId, companyName: $companyName, stageId: $stageId, stageName: $stageName, stageOrder: $stageOrder, status: $status, source: $source, assignedTo: $assignedTo, assignedToName: $assignedToName, products: $products, notes: $notes, tags: $tags, customFields: $customFields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DealModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            (identical(other.closeDate, closeDate) ||
                other.closeDate == closeDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.stageId, stageId) || other.stageId == stageId) &&
            (identical(other.stageName, stageName) ||
                other.stageName == stageName) &&
            (identical(other.stageOrder, stageOrder) ||
                other.stageOrder == stageOrder) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.assignedTo, assignedTo) ||
                other.assignedTo == assignedTo) &&
            (identical(other.assignedToName, assignedToName) ||
                other.assignedToName == assignedToName) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
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
        amount,
        currency,
        probability,
        closeDate,
        createdAt,
        updatedAt,
        clientId,
        clientName,
        companyId,
        companyName,
        stageId,
        stageName,
        stageOrder,
        status,
        source,
        assignedTo,
        assignedToName,
        const DeepCollectionEquality().hash(_products),
        notes,
        const DeepCollectionEquality().hash(_tags),
        const DeepCollectionEquality().hash(_customFields)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DealModelImplCopyWith<_$DealModelImpl> get copyWith =>
      __$$DealModelImplCopyWithImpl<_$DealModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DealModelImplToJson(
      this,
    );
  }
}

abstract class _DealModel implements DealModel {
  const factory _DealModel(
      {required final String id,
      required final String title,
      final String? description,
      required final double amount,
      final String? currency,
      final double? probability,
      final DateTime? closeDate,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      required final String clientId,
      final String? clientName,
      final String? companyId,
      final String? companyName,
      required final String stageId,
      final String? stageName,
      required final int stageOrder,
      required final DealStatus status,
      final DealSource? source,
      final String? assignedTo,
      final String? assignedToName,
      final List<DealProduct> products,
      final String? notes,
      final List<String> tags,
      final Map<String, dynamic>? customFields}) = _$DealModelImpl;

  factory _DealModel.fromJson(Map<String, dynamic> json) =
      _$DealModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override // Financial details
  double get amount;
  @override
  String? get currency;
  @override
  double? get probability;
  @override // 0-100
// Dates
  DateTime? get closeDate;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override // Relations
  String get clientId;
  @override
  String? get clientName;
  @override
  String? get companyId;
  @override
  String? get companyName;
  @override // Pipeline
  String get stageId;
  @override
  String? get stageName;
  @override
  int get stageOrder;
  @override // Status
  DealStatus get status;
  @override
  DealSource? get source;
  @override // Assigned user
  String? get assignedTo;
  @override
  String? get assignedToName;
  @override // Products/Services
  List<DealProduct> get products;
  @override // Tracking
  String? get notes;
  @override
  List<String> get tags;
  @override
  Map<String, dynamic>? get customFields;
  @override
  @JsonKey(ignore: true)
  _$$DealModelImplCopyWith<_$DealModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DealProduct _$DealProductFromJson(Map<String, dynamic> json) {
  return _DealProduct.fromJson(json);
}

/// @nodoc
mixin _$DealProduct {
  String get productId => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;
  double get totalPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DealProductCopyWith<DealProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealProductCopyWith<$Res> {
  factory $DealProductCopyWith(
          DealProduct value, $Res Function(DealProduct) then) =
      _$DealProductCopyWithImpl<$Res, DealProduct>;
  @useResult
  $Res call(
      {String productId,
      String productName,
      double quantity,
      double unitPrice,
      double totalPrice});
}

/// @nodoc
class _$DealProductCopyWithImpl<$Res, $Val extends DealProduct>
    implements $DealProductCopyWith<$Res> {
  _$DealProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? totalPrice = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DealProductImplCopyWith<$Res>
    implements $DealProductCopyWith<$Res> {
  factory _$$DealProductImplCopyWith(
          _$DealProductImpl value, $Res Function(_$DealProductImpl) then) =
      __$$DealProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String productId,
      String productName,
      double quantity,
      double unitPrice,
      double totalPrice});
}

/// @nodoc
class __$$DealProductImplCopyWithImpl<$Res>
    extends _$DealProductCopyWithImpl<$Res, _$DealProductImpl>
    implements _$$DealProductImplCopyWith<$Res> {
  __$$DealProductImplCopyWithImpl(
      _$DealProductImpl _value, $Res Function(_$DealProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? totalPrice = null,
  }) {
    return _then(_$DealProductImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DealProductImpl implements _DealProduct {
  const _$DealProductImpl(
      {required this.productId,
      required this.productName,
      required this.quantity,
      required this.unitPrice,
      required this.totalPrice});

  factory _$DealProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$DealProductImplFromJson(json);

  @override
  final String productId;
  @override
  final String productName;
  @override
  final double quantity;
  @override
  final double unitPrice;
  @override
  final double totalPrice;

  @override
  String toString() {
    return 'DealProduct(productId: $productId, productName: $productName, quantity: $quantity, unitPrice: $unitPrice, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DealProductImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, productId, productName, quantity, unitPrice, totalPrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DealProductImplCopyWith<_$DealProductImpl> get copyWith =>
      __$$DealProductImplCopyWithImpl<_$DealProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DealProductImplToJson(
      this,
    );
  }
}

abstract class _DealProduct implements DealProduct {
  const factory _DealProduct(
      {required final String productId,
      required final String productName,
      required final double quantity,
      required final double unitPrice,
      required final double totalPrice}) = _$DealProductImpl;

  factory _DealProduct.fromJson(Map<String, dynamic> json) =
      _$DealProductImpl.fromJson;

  @override
  String get productId;
  @override
  String get productName;
  @override
  double get quantity;
  @override
  double get unitPrice;
  @override
  double get totalPrice;
  @override
  @JsonKey(ignore: true)
  _$$DealProductImplCopyWith<_$DealProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
