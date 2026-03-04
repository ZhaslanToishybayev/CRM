// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) {
  return _CompanyModel.fromJson(json);
}

/// @nodoc
mixin _$CompanyModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description =>
      throw _privateConstructorUsedError; // Contact information
  String? get website => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get fax => throw _privateConstructorUsedError; // Address
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get zipCode => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError; // Company details
  String? get industry => throw _privateConstructorUsedError;
  int? get employeeCount => throw _privateConstructorUsedError;
  double? get annualRevenue => throw _privateConstructorUsedError;
  String? get taxId => throw _privateConstructorUsedError; // Logo
  String? get logoUrl => throw _privateConstructorUsedError; // CRM fields
  CompanyStatus? get status => throw _privateConstructorUsedError;
  CompanySize? get size => throw _privateConstructorUsedError; // Relations
  List<String> get clientIds => throw _privateConstructorUsedError;
  List<String> get dealIds =>
      throw _privateConstructorUsedError; // Social media
  String? get linkedinUrl => throw _privateConstructorUsedError;
  String? get twitterUrl => throw _privateConstructorUsedError;
  String? get facebookUrl => throw _privateConstructorUsedError; // Dates
  DateTime? get foundedDate => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Additional info
  String? get notes => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  Map<String, dynamic>? get customFields => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyModelCopyWith<CompanyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyModelCopyWith<$Res> {
  factory $CompanyModelCopyWith(
          CompanyModel value, $Res Function(CompanyModel) then) =
      _$CompanyModelCopyWithImpl<$Res, CompanyModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String? website,
      String? email,
      String? phone,
      String? fax,
      String? address,
      String? city,
      String? state,
      String? zipCode,
      String? country,
      String? industry,
      int? employeeCount,
      double? annualRevenue,
      String? taxId,
      String? logoUrl,
      CompanyStatus? status,
      CompanySize? size,
      List<String> clientIds,
      List<String> dealIds,
      String? linkedinUrl,
      String? twitterUrl,
      String? facebookUrl,
      DateTime? foundedDate,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? notes,
      List<String> tags,
      Map<String, dynamic>? customFields});
}

/// @nodoc
class _$CompanyModelCopyWithImpl<$Res, $Val extends CompanyModel>
    implements $CompanyModelCopyWith<$Res> {
  _$CompanyModelCopyWithImpl(this._value, this._then);

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
    Object? website = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? fax = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? zipCode = freezed,
    Object? country = freezed,
    Object? industry = freezed,
    Object? employeeCount = freezed,
    Object? annualRevenue = freezed,
    Object? taxId = freezed,
    Object? logoUrl = freezed,
    Object? status = freezed,
    Object? size = freezed,
    Object? clientIds = null,
    Object? dealIds = null,
    Object? linkedinUrl = freezed,
    Object? twitterUrl = freezed,
    Object? facebookUrl = freezed,
    Object? foundedDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? notes = freezed,
    Object? tags = null,
    Object? customFields = freezed,
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
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      fax: freezed == fax
          ? _value.fax
          : fax // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      industry: freezed == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeCount: freezed == employeeCount
          ? _value.employeeCount
          : employeeCount // ignore: cast_nullable_to_non_nullable
              as int?,
      annualRevenue: freezed == annualRevenue
          ? _value.annualRevenue
          : annualRevenue // ignore: cast_nullable_to_non_nullable
              as double?,
      taxId: freezed == taxId
          ? _value.taxId
          : taxId // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CompanyStatus?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as CompanySize?,
      clientIds: null == clientIds
          ? _value.clientIds
          : clientIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dealIds: null == dealIds
          ? _value.dealIds
          : dealIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      linkedinUrl: freezed == linkedinUrl
          ? _value.linkedinUrl
          : linkedinUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      twitterUrl: freezed == twitterUrl
          ? _value.twitterUrl
          : twitterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      facebookUrl: freezed == facebookUrl
          ? _value.facebookUrl
          : facebookUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      foundedDate: freezed == foundedDate
          ? _value.foundedDate
          : foundedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
abstract class _$$CompanyModelImplCopyWith<$Res>
    implements $CompanyModelCopyWith<$Res> {
  factory _$$CompanyModelImplCopyWith(
          _$CompanyModelImpl value, $Res Function(_$CompanyModelImpl) then) =
      __$$CompanyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String? website,
      String? email,
      String? phone,
      String? fax,
      String? address,
      String? city,
      String? state,
      String? zipCode,
      String? country,
      String? industry,
      int? employeeCount,
      double? annualRevenue,
      String? taxId,
      String? logoUrl,
      CompanyStatus? status,
      CompanySize? size,
      List<String> clientIds,
      List<String> dealIds,
      String? linkedinUrl,
      String? twitterUrl,
      String? facebookUrl,
      DateTime? foundedDate,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? notes,
      List<String> tags,
      Map<String, dynamic>? customFields});
}

/// @nodoc
class __$$CompanyModelImplCopyWithImpl<$Res>
    extends _$CompanyModelCopyWithImpl<$Res, _$CompanyModelImpl>
    implements _$$CompanyModelImplCopyWith<$Res> {
  __$$CompanyModelImplCopyWithImpl(
      _$CompanyModelImpl _value, $Res Function(_$CompanyModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? website = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? fax = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? zipCode = freezed,
    Object? country = freezed,
    Object? industry = freezed,
    Object? employeeCount = freezed,
    Object? annualRevenue = freezed,
    Object? taxId = freezed,
    Object? logoUrl = freezed,
    Object? status = freezed,
    Object? size = freezed,
    Object? clientIds = null,
    Object? dealIds = null,
    Object? linkedinUrl = freezed,
    Object? twitterUrl = freezed,
    Object? facebookUrl = freezed,
    Object? foundedDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? notes = freezed,
    Object? tags = null,
    Object? customFields = freezed,
  }) {
    return _then(_$CompanyModelImpl(
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
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      fax: freezed == fax
          ? _value.fax
          : fax // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      industry: freezed == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeCount: freezed == employeeCount
          ? _value.employeeCount
          : employeeCount // ignore: cast_nullable_to_non_nullable
              as int?,
      annualRevenue: freezed == annualRevenue
          ? _value.annualRevenue
          : annualRevenue // ignore: cast_nullable_to_non_nullable
              as double?,
      taxId: freezed == taxId
          ? _value.taxId
          : taxId // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CompanyStatus?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as CompanySize?,
      clientIds: null == clientIds
          ? _value._clientIds
          : clientIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dealIds: null == dealIds
          ? _value._dealIds
          : dealIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      linkedinUrl: freezed == linkedinUrl
          ? _value.linkedinUrl
          : linkedinUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      twitterUrl: freezed == twitterUrl
          ? _value.twitterUrl
          : twitterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      facebookUrl: freezed == facebookUrl
          ? _value.facebookUrl
          : facebookUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      foundedDate: freezed == foundedDate
          ? _value.foundedDate
          : foundedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
class _$CompanyModelImpl implements _CompanyModel {
  const _$CompanyModelImpl(
      {required this.id,
      required this.name,
      this.description,
      this.website,
      this.email,
      this.phone,
      this.fax,
      this.address,
      this.city,
      this.state,
      this.zipCode,
      this.country,
      this.industry,
      this.employeeCount,
      this.annualRevenue,
      this.taxId,
      this.logoUrl,
      this.status,
      this.size,
      final List<String> clientIds = const [],
      final List<String> dealIds = const [],
      this.linkedinUrl,
      this.twitterUrl,
      this.facebookUrl,
      this.foundedDate,
      this.createdAt,
      this.updatedAt,
      this.notes,
      final List<String> tags = const [],
      final Map<String, dynamic>? customFields})
      : _clientIds = clientIds,
        _dealIds = dealIds,
        _tags = tags,
        _customFields = customFields;

  factory _$CompanyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
// Contact information
  @override
  final String? website;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? fax;
// Address
  @override
  final String? address;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? zipCode;
  @override
  final String? country;
// Company details
  @override
  final String? industry;
  @override
  final int? employeeCount;
  @override
  final double? annualRevenue;
  @override
  final String? taxId;
// Logo
  @override
  final String? logoUrl;
// CRM fields
  @override
  final CompanyStatus? status;
  @override
  final CompanySize? size;
// Relations
  final List<String> _clientIds;
// Relations
  @override
  @JsonKey()
  List<String> get clientIds {
    if (_clientIds is EqualUnmodifiableListView) return _clientIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clientIds);
  }

  final List<String> _dealIds;
  @override
  @JsonKey()
  List<String> get dealIds {
    if (_dealIds is EqualUnmodifiableListView) return _dealIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dealIds);
  }

// Social media
  @override
  final String? linkedinUrl;
  @override
  final String? twitterUrl;
  @override
  final String? facebookUrl;
// Dates
  @override
  final DateTime? foundedDate;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
// Additional info
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
    return 'CompanyModel(id: $id, name: $name, description: $description, website: $website, email: $email, phone: $phone, fax: $fax, address: $address, city: $city, state: $state, zipCode: $zipCode, country: $country, industry: $industry, employeeCount: $employeeCount, annualRevenue: $annualRevenue, taxId: $taxId, logoUrl: $logoUrl, status: $status, size: $size, clientIds: $clientIds, dealIds: $dealIds, linkedinUrl: $linkedinUrl, twitterUrl: $twitterUrl, facebookUrl: $facebookUrl, foundedDate: $foundedDate, createdAt: $createdAt, updatedAt: $updatedAt, notes: $notes, tags: $tags, customFields: $customFields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.fax, fax) || other.fax == fax) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.industry, industry) ||
                other.industry == industry) &&
            (identical(other.employeeCount, employeeCount) ||
                other.employeeCount == employeeCount) &&
            (identical(other.annualRevenue, annualRevenue) ||
                other.annualRevenue == annualRevenue) &&
            (identical(other.taxId, taxId) || other.taxId == taxId) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.size, size) || other.size == size) &&
            const DeepCollectionEquality()
                .equals(other._clientIds, _clientIds) &&
            const DeepCollectionEquality().equals(other._dealIds, _dealIds) &&
            (identical(other.linkedinUrl, linkedinUrl) ||
                other.linkedinUrl == linkedinUrl) &&
            (identical(other.twitterUrl, twitterUrl) ||
                other.twitterUrl == twitterUrl) &&
            (identical(other.facebookUrl, facebookUrl) ||
                other.facebookUrl == facebookUrl) &&
            (identical(other.foundedDate, foundedDate) ||
                other.foundedDate == foundedDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
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
        name,
        description,
        website,
        email,
        phone,
        fax,
        address,
        city,
        state,
        zipCode,
        country,
        industry,
        employeeCount,
        annualRevenue,
        taxId,
        logoUrl,
        status,
        size,
        const DeepCollectionEquality().hash(_clientIds),
        const DeepCollectionEquality().hash(_dealIds),
        linkedinUrl,
        twitterUrl,
        facebookUrl,
        foundedDate,
        createdAt,
        updatedAt,
        notes,
        const DeepCollectionEquality().hash(_tags),
        const DeepCollectionEquality().hash(_customFields)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyModelImplCopyWith<_$CompanyModelImpl> get copyWith =>
      __$$CompanyModelImplCopyWithImpl<_$CompanyModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyModelImplToJson(
      this,
    );
  }
}

abstract class _CompanyModel implements CompanyModel {
  const factory _CompanyModel(
      {required final String id,
      required final String name,
      final String? description,
      final String? website,
      final String? email,
      final String? phone,
      final String? fax,
      final String? address,
      final String? city,
      final String? state,
      final String? zipCode,
      final String? country,
      final String? industry,
      final int? employeeCount,
      final double? annualRevenue,
      final String? taxId,
      final String? logoUrl,
      final CompanyStatus? status,
      final CompanySize? size,
      final List<String> clientIds,
      final List<String> dealIds,
      final String? linkedinUrl,
      final String? twitterUrl,
      final String? facebookUrl,
      final DateTime? foundedDate,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final String? notes,
      final List<String> tags,
      final Map<String, dynamic>? customFields}) = _$CompanyModelImpl;

  factory _CompanyModel.fromJson(Map<String, dynamic> json) =
      _$CompanyModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override // Contact information
  String? get website;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get fax;
  @override // Address
  String? get address;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get zipCode;
  @override
  String? get country;
  @override // Company details
  String? get industry;
  @override
  int? get employeeCount;
  @override
  double? get annualRevenue;
  @override
  String? get taxId;
  @override // Logo
  String? get logoUrl;
  @override // CRM fields
  CompanyStatus? get status;
  @override
  CompanySize? get size;
  @override // Relations
  List<String> get clientIds;
  @override
  List<String> get dealIds;
  @override // Social media
  String? get linkedinUrl;
  @override
  String? get twitterUrl;
  @override
  String? get facebookUrl;
  @override // Dates
  DateTime? get foundedDate;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override // Additional info
  String? get notes;
  @override
  List<String> get tags;
  @override
  Map<String, dynamic>? get customFields;
  @override
  @JsonKey(ignore: true)
  _$$CompanyModelImplCopyWith<_$CompanyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
