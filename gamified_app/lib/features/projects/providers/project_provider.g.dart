// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectServiceHash() => r'2c42c32ad559f9827cfb0b6c9b34f7208f96c79b';

/// See also [projectService].
@ProviderFor(projectService)
final projectServiceProvider = AutoDisposeProvider<ProjectService>.internal(
  projectService,
  name: r'projectServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$projectServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProjectServiceRef = AutoDisposeProviderRef<ProjectService>;
String _$organizationProjectsHash() =>
    r'976349e464b7b1aaa55ad73c75f89d429c329a20';

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

/// Provider for projects in an organization
///
/// Copied from [organizationProjects].
@ProviderFor(organizationProjects)
const organizationProjectsProvider = OrganizationProjectsFamily();

/// Provider for projects in an organization
///
/// Copied from [organizationProjects].
class OrganizationProjectsFamily
    extends Family<AsyncValue<List<ProjectModel>>> {
  /// Provider for projects in an organization
  ///
  /// Copied from [organizationProjects].
  const OrganizationProjectsFamily();

  /// Provider for projects in an organization
  ///
  /// Copied from [organizationProjects].
  OrganizationProjectsProvider call(
    String organizationId,
  ) {
    return OrganizationProjectsProvider(
      organizationId,
    );
  }

  @override
  OrganizationProjectsProvider getProviderOverride(
    covariant OrganizationProjectsProvider provider,
  ) {
    return call(
      provider.organizationId,
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
  String? get name => r'organizationProjectsProvider';
}

/// Provider for projects in an organization
///
/// Copied from [organizationProjects].
class OrganizationProjectsProvider
    extends AutoDisposeFutureProvider<List<ProjectModel>> {
  /// Provider for projects in an organization
  ///
  /// Copied from [organizationProjects].
  OrganizationProjectsProvider(
    String organizationId,
  ) : this._internal(
          (ref) => organizationProjects(
            ref as OrganizationProjectsRef,
            organizationId,
          ),
          from: organizationProjectsProvider,
          name: r'organizationProjectsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$organizationProjectsHash,
          dependencies: OrganizationProjectsFamily._dependencies,
          allTransitiveDependencies:
              OrganizationProjectsFamily._allTransitiveDependencies,
          organizationId: organizationId,
        );

  OrganizationProjectsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.organizationId,
  }) : super.internal();

  final String organizationId;

  @override
  Override overrideWith(
    FutureOr<List<ProjectModel>> Function(OrganizationProjectsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrganizationProjectsProvider._internal(
        (ref) => create(ref as OrganizationProjectsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        organizationId: organizationId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ProjectModel>> createElement() {
    return _OrganizationProjectsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrganizationProjectsProvider &&
        other.organizationId == organizationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, organizationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OrganizationProjectsRef
    on AutoDisposeFutureProviderRef<List<ProjectModel>> {
  /// The parameter `organizationId` of this provider.
  String get organizationId;
}

class _OrganizationProjectsProviderElement
    extends AutoDisposeFutureProviderElement<List<ProjectModel>>
    with OrganizationProjectsRef {
  _OrganizationProjectsProviderElement(super.provider);

  @override
  String get organizationId =>
      (origin as OrganizationProjectsProvider).organizationId;
}

String _$teamProjectsHash() => r'd6ed1d227a617c513d2c128e28561b7b39add9dc';

/// Provider for projects in a team
///
/// Copied from [teamProjects].
@ProviderFor(teamProjects)
const teamProjectsProvider = TeamProjectsFamily();

/// Provider for projects in a team
///
/// Copied from [teamProjects].
class TeamProjectsFamily extends Family<AsyncValue<List<ProjectModel>>> {
  /// Provider for projects in a team
  ///
  /// Copied from [teamProjects].
  const TeamProjectsFamily();

  /// Provider for projects in a team
  ///
  /// Copied from [teamProjects].
  TeamProjectsProvider call(
    String teamId,
  ) {
    return TeamProjectsProvider(
      teamId,
    );
  }

  @override
  TeamProjectsProvider getProviderOverride(
    covariant TeamProjectsProvider provider,
  ) {
    return call(
      provider.teamId,
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
  String? get name => r'teamProjectsProvider';
}

/// Provider for projects in a team
///
/// Copied from [teamProjects].
class TeamProjectsProvider
    extends AutoDisposeFutureProvider<List<ProjectModel>> {
  /// Provider for projects in a team
  ///
  /// Copied from [teamProjects].
  TeamProjectsProvider(
    String teamId,
  ) : this._internal(
          (ref) => teamProjects(
            ref as TeamProjectsRef,
            teamId,
          ),
          from: teamProjectsProvider,
          name: r'teamProjectsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$teamProjectsHash,
          dependencies: TeamProjectsFamily._dependencies,
          allTransitiveDependencies:
              TeamProjectsFamily._allTransitiveDependencies,
          teamId: teamId,
        );

  TeamProjectsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.teamId,
  }) : super.internal();

  final String teamId;

  @override
  Override overrideWith(
    FutureOr<List<ProjectModel>> Function(TeamProjectsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TeamProjectsProvider._internal(
        (ref) => create(ref as TeamProjectsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        teamId: teamId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ProjectModel>> createElement() {
    return _TeamProjectsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamProjectsProvider && other.teamId == teamId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, teamId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TeamProjectsRef on AutoDisposeFutureProviderRef<List<ProjectModel>> {
  /// The parameter `teamId` of this provider.
  String get teamId;
}

class _TeamProjectsProviderElement
    extends AutoDisposeFutureProviderElement<List<ProjectModel>>
    with TeamProjectsRef {
  _TeamProjectsProviderElement(super.provider);

  @override
  String get teamId => (origin as TeamProjectsProvider).teamId;
}

String _$departmentProjectsHash() =>
    r'24e0d3fe07d52d482000a327d7d17ac56f6abd50';

/// Provider for projects in a department
///
/// Copied from [departmentProjects].
@ProviderFor(departmentProjects)
const departmentProjectsProvider = DepartmentProjectsFamily();

/// Provider for projects in a department
///
/// Copied from [departmentProjects].
class DepartmentProjectsFamily extends Family<AsyncValue<List<ProjectModel>>> {
  /// Provider for projects in a department
  ///
  /// Copied from [departmentProjects].
  const DepartmentProjectsFamily();

  /// Provider for projects in a department
  ///
  /// Copied from [departmentProjects].
  DepartmentProjectsProvider call(
    String departmentId,
  ) {
    return DepartmentProjectsProvider(
      departmentId,
    );
  }

  @override
  DepartmentProjectsProvider getProviderOverride(
    covariant DepartmentProjectsProvider provider,
  ) {
    return call(
      provider.departmentId,
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
  String? get name => r'departmentProjectsProvider';
}

/// Provider for projects in a department
///
/// Copied from [departmentProjects].
class DepartmentProjectsProvider
    extends AutoDisposeFutureProvider<List<ProjectModel>> {
  /// Provider for projects in a department
  ///
  /// Copied from [departmentProjects].
  DepartmentProjectsProvider(
    String departmentId,
  ) : this._internal(
          (ref) => departmentProjects(
            ref as DepartmentProjectsRef,
            departmentId,
          ),
          from: departmentProjectsProvider,
          name: r'departmentProjectsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$departmentProjectsHash,
          dependencies: DepartmentProjectsFamily._dependencies,
          allTransitiveDependencies:
              DepartmentProjectsFamily._allTransitiveDependencies,
          departmentId: departmentId,
        );

  DepartmentProjectsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.departmentId,
  }) : super.internal();

  final String departmentId;

  @override
  Override overrideWith(
    FutureOr<List<ProjectModel>> Function(DepartmentProjectsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DepartmentProjectsProvider._internal(
        (ref) => create(ref as DepartmentProjectsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        departmentId: departmentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ProjectModel>> createElement() {
    return _DepartmentProjectsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DepartmentProjectsProvider &&
        other.departmentId == departmentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, departmentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DepartmentProjectsRef
    on AutoDisposeFutureProviderRef<List<ProjectModel>> {
  /// The parameter `departmentId` of this provider.
  String get departmentId;
}

class _DepartmentProjectsProviderElement
    extends AutoDisposeFutureProviderElement<List<ProjectModel>>
    with DepartmentProjectsRef {
  _DepartmentProjectsProviderElement(super.provider);

  @override
  String get departmentId =>
      (origin as DepartmentProjectsProvider).departmentId;
}

String _$userProjectsHash() => r'f52516450c43617b2869fa60aac26bc79a871a9f';

/// Provider for projects of a specific user
///
/// Copied from [userProjects].
@ProviderFor(userProjects)
const userProjectsProvider = UserProjectsFamily();

/// Provider for projects of a specific user
///
/// Copied from [userProjects].
class UserProjectsFamily extends Family<AsyncValue<List<ProjectModel>>> {
  /// Provider for projects of a specific user
  ///
  /// Copied from [userProjects].
  const UserProjectsFamily();

  /// Provider for projects of a specific user
  ///
  /// Copied from [userProjects].
  UserProjectsProvider call(
    String userId,
  ) {
    return UserProjectsProvider(
      userId,
    );
  }

  @override
  UserProjectsProvider getProviderOverride(
    covariant UserProjectsProvider provider,
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
  String? get name => r'userProjectsProvider';
}

/// Provider for projects of a specific user
///
/// Copied from [userProjects].
class UserProjectsProvider
    extends AutoDisposeFutureProvider<List<ProjectModel>> {
  /// Provider for projects of a specific user
  ///
  /// Copied from [userProjects].
  UserProjectsProvider(
    String userId,
  ) : this._internal(
          (ref) => userProjects(
            ref as UserProjectsRef,
            userId,
          ),
          from: userProjectsProvider,
          name: r'userProjectsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userProjectsHash,
          dependencies: UserProjectsFamily._dependencies,
          allTransitiveDependencies:
              UserProjectsFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserProjectsProvider._internal(
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
    FutureOr<List<ProjectModel>> Function(UserProjectsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserProjectsProvider._internal(
        (ref) => create(ref as UserProjectsRef),
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
  AutoDisposeFutureProviderElement<List<ProjectModel>> createElement() {
    return _UserProjectsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProjectsProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserProjectsRef on AutoDisposeFutureProviderRef<List<ProjectModel>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserProjectsProviderElement
    extends AutoDisposeFutureProviderElement<List<ProjectModel>>
    with UserProjectsRef {
  _UserProjectsProviderElement(super.provider);

  @override
  String get userId => (origin as UserProjectsProvider).userId;
}

String _$projectHash() => r'8fa223a31b6e542094bb5035157c6627747ef9a9';

/// Provider for a specific project by ID
///
/// Copied from [project].
@ProviderFor(project)
const projectProvider = ProjectFamily();

/// Provider for a specific project by ID
///
/// Copied from [project].
class ProjectFamily extends Family<AsyncValue<ProjectModel>> {
  /// Provider for a specific project by ID
  ///
  /// Copied from [project].
  const ProjectFamily();

  /// Provider for a specific project by ID
  ///
  /// Copied from [project].
  ProjectProvider call(
    String projectId,
  ) {
    return ProjectProvider(
      projectId,
    );
  }

  @override
  ProjectProvider getProviderOverride(
    covariant ProjectProvider provider,
  ) {
    return call(
      provider.projectId,
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
  String? get name => r'projectProvider';
}

/// Provider for a specific project by ID
///
/// Copied from [project].
class ProjectProvider extends AutoDisposeFutureProvider<ProjectModel> {
  /// Provider for a specific project by ID
  ///
  /// Copied from [project].
  ProjectProvider(
    String projectId,
  ) : this._internal(
          (ref) => project(
            ref as ProjectRef,
            projectId,
          ),
          from: projectProvider,
          name: r'projectProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$projectHash,
          dependencies: ProjectFamily._dependencies,
          allTransitiveDependencies: ProjectFamily._allTransitiveDependencies,
          projectId: projectId,
        );

  ProjectProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.projectId,
  }) : super.internal();

  final String projectId;

  @override
  Override overrideWith(
    FutureOr<ProjectModel> Function(ProjectRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProjectProvider._internal(
        (ref) => create(ref as ProjectRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        projectId: projectId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ProjectModel> createElement() {
    return _ProjectProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectProvider && other.projectId == projectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProjectRef on AutoDisposeFutureProviderRef<ProjectModel> {
  /// The parameter `projectId` of this provider.
  String get projectId;
}

class _ProjectProviderElement
    extends AutoDisposeFutureProviderElement<ProjectModel> with ProjectRef {
  _ProjectProviderElement(super.provider);

  @override
  String get projectId => (origin as ProjectProvider).projectId;
}

String _$projectStatsHash() => r'2277030870f0848e0c007227ed3accabbfc66982';

/// Provider for project statistics
///
/// Copied from [projectStats].
@ProviderFor(projectStats)
const projectStatsProvider = ProjectStatsFamily();

/// Provider for project statistics
///
/// Copied from [projectStats].
class ProjectStatsFamily extends Family<AsyncValue<ProjectStats>> {
  /// Provider for project statistics
  ///
  /// Copied from [projectStats].
  const ProjectStatsFamily();

  /// Provider for project statistics
  ///
  /// Copied from [projectStats].
  ProjectStatsProvider call(
    String projectId,
  ) {
    return ProjectStatsProvider(
      projectId,
    );
  }

  @override
  ProjectStatsProvider getProviderOverride(
    covariant ProjectStatsProvider provider,
  ) {
    return call(
      provider.projectId,
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
  String? get name => r'projectStatsProvider';
}

/// Provider for project statistics
///
/// Copied from [projectStats].
class ProjectStatsProvider extends AutoDisposeFutureProvider<ProjectStats> {
  /// Provider for project statistics
  ///
  /// Copied from [projectStats].
  ProjectStatsProvider(
    String projectId,
  ) : this._internal(
          (ref) => projectStats(
            ref as ProjectStatsRef,
            projectId,
          ),
          from: projectStatsProvider,
          name: r'projectStatsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$projectStatsHash,
          dependencies: ProjectStatsFamily._dependencies,
          allTransitiveDependencies:
              ProjectStatsFamily._allTransitiveDependencies,
          projectId: projectId,
        );

  ProjectStatsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.projectId,
  }) : super.internal();

  final String projectId;

  @override
  Override overrideWith(
    FutureOr<ProjectStats> Function(ProjectStatsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProjectStatsProvider._internal(
        (ref) => create(ref as ProjectStatsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        projectId: projectId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ProjectStats> createElement() {
    return _ProjectStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectStatsProvider && other.projectId == projectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProjectStatsRef on AutoDisposeFutureProviderRef<ProjectStats> {
  /// The parameter `projectId` of this provider.
  String get projectId;
}

class _ProjectStatsProviderElement
    extends AutoDisposeFutureProviderElement<ProjectStats>
    with ProjectStatsRef {
  _ProjectStatsProviderElement(super.provider);

  @override
  String get projectId => (origin as ProjectStatsProvider).projectId;
}

String _$projectNotifierHash() => r'c887d644b2c00d77687364d12ccd663f1bffeefc';

/// Notifier for managing projects
///
/// Copied from [ProjectNotifier].
@ProviderFor(ProjectNotifier)
final projectNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ProjectNotifier, void>.internal(
  ProjectNotifier.new,
  name: r'projectNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$projectNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProjectNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
