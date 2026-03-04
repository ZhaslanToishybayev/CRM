// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$analyticsServiceHash() => r'f232fa9e275bf825fe6b35a4e94bf366dba6d8c5';

/// See also [analyticsService].
@ProviderFor(analyticsService)
final analyticsServiceProvider = AutoDisposeProvider<AnalyticsService>.internal(
  analyticsService,
  name: r'analyticsServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$analyticsServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AnalyticsServiceRef = AutoDisposeProviderRef<AnalyticsService>;
String _$pdfExportServiceHash() => r'2657ec26e34efc405cf8e999a1922a13052ed6fc';

/// See also [pdfExportService].
@ProviderFor(pdfExportService)
final pdfExportServiceProvider = AutoDisposeProvider<PDFExportService>.internal(
  pdfExportService,
  name: r'pdfExportServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pdfExportServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PdfExportServiceRef = AutoDisposeProviderRef<PDFExportService>;
String _$managerDashboardHash() => r'f701e0461710b763aed8e6a6f77d3cb589eea056';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for manager dashboard
///
/// Copied from [managerDashboard].
@ProviderFor(managerDashboard)
const managerDashboardProvider = ManagerDashboardFamily();

/// Provider for manager dashboard
///
/// Copied from [managerDashboard].
class ManagerDashboardFamily extends Family<AsyncValue<ManagerDashboardModel>> {
  /// Provider for manager dashboard
  ///
  /// Copied from [managerDashboard].
  const ManagerDashboardFamily();

  /// Provider for manager dashboard
  ///
  /// Copied from [managerDashboard].
  ManagerDashboardProvider call(
    String managerId,
    String organizationId,
    String departmentId,
    Period period,
  ) {
    return ManagerDashboardProvider(
      managerId,
      organizationId,
      departmentId,
      period,
    );
  }

  @override
  ManagerDashboardProvider getProviderOverride(
    covariant ManagerDashboardProvider provider,
  ) {
    return call(
      provider.managerId,
      provider.organizationId,
      provider.departmentId,
      provider.period,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'managerDashboardProvider';
}

/// Provider for manager dashboard
///
/// Copied from [managerDashboard].
class ManagerDashboardProvider
    extends AutoDisposeFutureProvider<ManagerDashboardModel> {
  /// Provider for manager dashboard
  ///
  /// Copied from [managerDashboard].
  ManagerDashboardProvider(
    String managerId,
    String organizationId,
    String departmentId,
    Period period,
  ) : this._internal(
          (ref) => managerDashboard(
            ref as ManagerDashboardRef,
            managerId,
            organizationId,
            departmentId,
            period,
          ),
          from: managerDashboardProvider,
          name: r'managerDashboardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$managerDashboardHash,
          dependencies: ManagerDashboardFamily._dependencies,
          allTransitiveDependencies:
              ManagerDashboardFamily._allTransitiveDependencies,
          managerId: managerId,
          organizationId: organizationId,
          departmentId: departmentId,
          period: period,
        );

  ManagerDashboardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.managerId,
    required this.organizationId,
    required this.departmentId,
    required this.period,
  }) : super.internal();

  final String managerId;
  final String organizationId;
  final String departmentId;
  final Period period;

  @override
  Override overrideWith(
    FutureOr<ManagerDashboardModel> Function(ManagerDashboardRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ManagerDashboardProvider._internal(
        (ref) => create(ref as ManagerDashboardRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        managerId: managerId,
        organizationId: organizationId,
        departmentId: departmentId,
        period: period,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ManagerDashboardModel> createElement() {
    return _ManagerDashboardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ManagerDashboardProvider &&
        other.managerId == managerId &&
        other.organizationId == organizationId &&
        other.departmentId == departmentId &&
        other.period == period;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, managerId.hashCode);
    hash = _SystemHash.combine(hash, organizationId.hashCode);
    hash = _SystemHash.combine(hash, departmentId.hashCode);
    hash = _SystemHash.combine(hash, period.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ManagerDashboardRef
    on AutoDisposeFutureProviderRef<ManagerDashboardModel> {
  /// The parameter `managerId` of this provider.
  String get managerId;

  /// The parameter `organizationId` of this provider.
  String get organizationId;

  /// The parameter `departmentId` of this provider.
  String get departmentId;

  /// The parameter `period` of this provider.
  Period get period;
}

class _ManagerDashboardProviderElement
    extends AutoDisposeFutureProviderElement<ManagerDashboardModel>
    with ManagerDashboardRef {
  _ManagerDashboardProviderElement(super.provider);

  @override
  String get managerId => (origin as ManagerDashboardProvider).managerId;
  @override
  String get organizationId =>
      (origin as ManagerDashboardProvider).organizationId;
  @override
  String get departmentId => (origin as ManagerDashboardProvider).departmentId;
  @override
  Period get period => (origin as ManagerDashboardProvider).period;
}

String _$employeeReportHash() => r'05f2831bbcbb2dc7065a6dd3f04460dcb4289dfe';

/// Provider for employee report
///
/// Copied from [employeeReport].
@ProviderFor(employeeReport)
const employeeReportProvider = EmployeeReportFamily();

/// Provider for employee report
///
/// Copied from [employeeReport].
class EmployeeReportFamily extends Family<AsyncValue<EmployeeReportModel>> {
  /// Provider for employee report
  ///
  /// Copied from [employeeReport].
  const EmployeeReportFamily();

  /// Provider for employee report
  ///
  /// Copied from [employeeReport].
  EmployeeReportProvider call(
    String userId,
    Period period,
  ) {
    return EmployeeReportProvider(
      userId,
      period,
    );
  }

  @override
  EmployeeReportProvider getProviderOverride(
    covariant EmployeeReportProvider provider,
  ) {
    return call(
      provider.userId,
      provider.period,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'employeeReportProvider';
}

/// Provider for employee report
///
/// Copied from [employeeReport].
class EmployeeReportProvider
    extends AutoDisposeFutureProvider<EmployeeReportModel> {
  /// Provider for employee report
  ///
  /// Copied from [employeeReport].
  EmployeeReportProvider(
    String userId,
    Period period,
  ) : this._internal(
          (ref) => employeeReport(
            ref as EmployeeReportRef,
            userId,
            period,
          ),
          from: employeeReportProvider,
          name: r'employeeReportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$employeeReportHash,
          dependencies: EmployeeReportFamily._dependencies,
          allTransitiveDependencies:
              EmployeeReportFamily._allTransitiveDependencies,
          userId: userId,
          period: period,
        );

  EmployeeReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.period,
  }) : super.internal();

  final String userId;
  final Period period;

  @override
  Override overrideWith(
    FutureOr<EmployeeReportModel> Function(EmployeeReportRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EmployeeReportProvider._internal(
        (ref) => create(ref as EmployeeReportRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        period: period,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<EmployeeReportModel> createElement() {
    return _EmployeeReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EmployeeReportProvider &&
        other.userId == userId &&
        other.period == period;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, period.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EmployeeReportRef on AutoDisposeFutureProviderRef<EmployeeReportModel> {
  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `period` of this provider.
  Period get period;
}

class _EmployeeReportProviderElement
    extends AutoDisposeFutureProviderElement<EmployeeReportModel>
    with EmployeeReportRef {
  _EmployeeReportProviderElement(super.provider);

  @override
  String get userId => (origin as EmployeeReportProvider).userId;
  @override
  Period get period => (origin as EmployeeReportProvider).period;
}

String _$getExportHistoryHash() => r'53721968a8f787a938271ff85e46fab29a28c795';

/// Provider for export history
///
/// Copied from [getExportHistory].
@ProviderFor(getExportHistory)
const getExportHistoryProvider = GetExportHistoryFamily();

/// Provider for export history
///
/// Copied from [getExportHistory].
class GetExportHistoryFamily extends Family<AsyncValue<List<ExportHistory>>> {
  /// Provider for export history
  ///
  /// Copied from [getExportHistory].
  const GetExportHistoryFamily();

  /// Provider for export history
  ///
  /// Copied from [getExportHistory].
  GetExportHistoryProvider call(
    String userId,
  ) {
    return GetExportHistoryProvider(
      userId,
    );
  }

  @override
  GetExportHistoryProvider getProviderOverride(
    covariant GetExportHistoryProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getExportHistoryProvider';
}

/// Provider for export history
///
/// Copied from [getExportHistory].
class GetExportHistoryProvider
    extends AutoDisposeFutureProvider<List<ExportHistory>> {
  /// Provider for export history
  ///
  /// Copied from [getExportHistory].
  GetExportHistoryProvider(
    String userId,
  ) : this._internal(
          (ref) => getExportHistory(
            ref as GetExportHistoryRef,
            userId,
          ),
          from: getExportHistoryProvider,
          name: r'getExportHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getExportHistoryHash,
          dependencies: GetExportHistoryFamily._dependencies,
          allTransitiveDependencies:
              GetExportHistoryFamily._allTransitiveDependencies,
          userId: userId,
        );

  GetExportHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<List<ExportHistory>> Function(GetExportHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetExportHistoryProvider._internal(
        (ref) => create(ref as GetExportHistoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ExportHistory>> createElement() {
    return _GetExportHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetExportHistoryProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetExportHistoryRef on AutoDisposeFutureProviderRef<List<ExportHistory>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _GetExportHistoryProviderElement
    extends AutoDisposeFutureProviderElement<List<ExportHistory>>
    with GetExportHistoryRef {
  _GetExportHistoryProviderElement(super.provider);

  @override
  String get userId => (origin as GetExportHistoryProvider).userId;
}

String _$pDFExportNotifierHash() => r'42f4a4ff9a02ec77d5fab6fd18a8fb2a0d857595';

/// Notifier for PDF exports
///
/// Copied from [PDFExportNotifier].
@ProviderFor(PDFExportNotifier)
final pDFExportNotifierProvider =
    AutoDisposeAsyncNotifierProvider<PDFExportNotifier, void>.internal(
  PDFExportNotifier.new,
  name: r'pDFExportNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pDFExportNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PDFExportNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
