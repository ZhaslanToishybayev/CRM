// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$teamServiceHash() => r'451f345629a1378c0c75f93dc3108523ed7c1712';

/// See also [teamService].
@ProviderFor(teamService)
final teamServiceProvider = AutoDisposeProvider<TeamService>.internal(
  teamService,
  name: r'teamServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$teamServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TeamServiceRef = AutoDisposeProviderRef<TeamService>;
String _$organizationTeamsHash() => r'73b991145e0e1450ba8599b9cba8c2495114136e';

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

/// Provider for teams in an organization
///
/// Copied from [organizationTeams].
@ProviderFor(organizationTeams)
const organizationTeamsProvider = OrganizationTeamsFamily();

/// Provider for teams in an organization
///
/// Copied from [organizationTeams].
class OrganizationTeamsFamily extends Family<AsyncValue<List<TeamModel>>> {
  /// Provider for teams in an organization
  ///
  /// Copied from [organizationTeams].
  const OrganizationTeamsFamily();

  /// Provider for teams in an organization
  ///
  /// Copied from [organizationTeams].
  OrganizationTeamsProvider call(
    String organizationId,
  ) {
    return OrganizationTeamsProvider(
      organizationId,
    );
  }

  @override
  OrganizationTeamsProvider getProviderOverride(
    covariant OrganizationTeamsProvider provider,
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
  String? get name => r'organizationTeamsProvider';
}

/// Provider for teams in an organization
///
/// Copied from [organizationTeams].
class OrganizationTeamsProvider
    extends AutoDisposeFutureProvider<List<TeamModel>> {
  /// Provider for teams in an organization
  ///
  /// Copied from [organizationTeams].
  OrganizationTeamsProvider(
    String organizationId,
  ) : this._internal(
          (ref) => organizationTeams(
            ref as OrganizationTeamsRef,
            organizationId,
          ),
          from: organizationTeamsProvider,
          name: r'organizationTeamsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$organizationTeamsHash,
          dependencies: OrganizationTeamsFamily._dependencies,
          allTransitiveDependencies:
              OrganizationTeamsFamily._allTransitiveDependencies,
          organizationId: organizationId,
        );

  OrganizationTeamsProvider._internal(
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
    FutureOr<List<TeamModel>> Function(OrganizationTeamsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrganizationTeamsProvider._internal(
        (ref) => create(ref as OrganizationTeamsRef),
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
  AutoDisposeFutureProviderElement<List<TeamModel>> createElement() {
    return _OrganizationTeamsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrganizationTeamsProvider &&
        other.organizationId == organizationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, organizationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OrganizationTeamsRef on AutoDisposeFutureProviderRef<List<TeamModel>> {
  /// The parameter `organizationId` of this provider.
  String get organizationId;
}

class _OrganizationTeamsProviderElement
    extends AutoDisposeFutureProviderElement<List<TeamModel>>
    with OrganizationTeamsRef {
  _OrganizationTeamsProviderElement(super.provider);

  @override
  String get organizationId =>
      (origin as OrganizationTeamsProvider).organizationId;
}

String _$departmentTeamsHash() => r'277bfb2c17f2a5bf71760a62f574c6a11ab1267a';

/// Provider for teams in a department
///
/// Copied from [departmentTeams].
@ProviderFor(departmentTeams)
const departmentTeamsProvider = DepartmentTeamsFamily();

/// Provider for teams in a department
///
/// Copied from [departmentTeams].
class DepartmentTeamsFamily extends Family<AsyncValue<List<TeamModel>>> {
  /// Provider for teams in a department
  ///
  /// Copied from [departmentTeams].
  const DepartmentTeamsFamily();

  /// Provider for teams in a department
  ///
  /// Copied from [departmentTeams].
  DepartmentTeamsProvider call(
    String departmentId,
  ) {
    return DepartmentTeamsProvider(
      departmentId,
    );
  }

  @override
  DepartmentTeamsProvider getProviderOverride(
    covariant DepartmentTeamsProvider provider,
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
  String? get name => r'departmentTeamsProvider';
}

/// Provider for teams in a department
///
/// Copied from [departmentTeams].
class DepartmentTeamsProvider
    extends AutoDisposeFutureProvider<List<TeamModel>> {
  /// Provider for teams in a department
  ///
  /// Copied from [departmentTeams].
  DepartmentTeamsProvider(
    String departmentId,
  ) : this._internal(
          (ref) => departmentTeams(
            ref as DepartmentTeamsRef,
            departmentId,
          ),
          from: departmentTeamsProvider,
          name: r'departmentTeamsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$departmentTeamsHash,
          dependencies: DepartmentTeamsFamily._dependencies,
          allTransitiveDependencies:
              DepartmentTeamsFamily._allTransitiveDependencies,
          departmentId: departmentId,
        );

  DepartmentTeamsProvider._internal(
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
    FutureOr<List<TeamModel>> Function(DepartmentTeamsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DepartmentTeamsProvider._internal(
        (ref) => create(ref as DepartmentTeamsRef),
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
  AutoDisposeFutureProviderElement<List<TeamModel>> createElement() {
    return _DepartmentTeamsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DepartmentTeamsProvider &&
        other.departmentId == departmentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, departmentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DepartmentTeamsRef on AutoDisposeFutureProviderRef<List<TeamModel>> {
  /// The parameter `departmentId` of this provider.
  String get departmentId;
}

class _DepartmentTeamsProviderElement
    extends AutoDisposeFutureProviderElement<List<TeamModel>>
    with DepartmentTeamsRef {
  _DepartmentTeamsProviderElement(super.provider);

  @override
  String get departmentId => (origin as DepartmentTeamsProvider).departmentId;
}

String _$userTeamsHash() => r'08ebebacbd46ba4b79deedb17d2500cb7f186a1a';

/// Provider for teams of a specific user
///
/// Copied from [userTeams].
@ProviderFor(userTeams)
const userTeamsProvider = UserTeamsFamily();

/// Provider for teams of a specific user
///
/// Copied from [userTeams].
class UserTeamsFamily extends Family<AsyncValue<List<TeamModel>>> {
  /// Provider for teams of a specific user
  ///
  /// Copied from [userTeams].
  const UserTeamsFamily();

  /// Provider for teams of a specific user
  ///
  /// Copied from [userTeams].
  UserTeamsProvider call(
    String userId,
  ) {
    return UserTeamsProvider(
      userId,
    );
  }

  @override
  UserTeamsProvider getProviderOverride(
    covariant UserTeamsProvider provider,
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
  String? get name => r'userTeamsProvider';
}

/// Provider for teams of a specific user
///
/// Copied from [userTeams].
class UserTeamsProvider extends AutoDisposeFutureProvider<List<TeamModel>> {
  /// Provider for teams of a specific user
  ///
  /// Copied from [userTeams].
  UserTeamsProvider(
    String userId,
  ) : this._internal(
          (ref) => userTeams(
            ref as UserTeamsRef,
            userId,
          ),
          from: userTeamsProvider,
          name: r'userTeamsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userTeamsHash,
          dependencies: UserTeamsFamily._dependencies,
          allTransitiveDependencies: UserTeamsFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserTeamsProvider._internal(
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
    FutureOr<List<TeamModel>> Function(UserTeamsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserTeamsProvider._internal(
        (ref) => create(ref as UserTeamsRef),
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
  AutoDisposeFutureProviderElement<List<TeamModel>> createElement() {
    return _UserTeamsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserTeamsProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserTeamsRef on AutoDisposeFutureProviderRef<List<TeamModel>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserTeamsProviderElement
    extends AutoDisposeFutureProviderElement<List<TeamModel>>
    with UserTeamsRef {
  _UserTeamsProviderElement(super.provider);

  @override
  String get userId => (origin as UserTeamsProvider).userId;
}

String _$teamHash() => r'7e1a5a25f4f8806002f11c2636a531d5b5dbc29c';

/// Provider for a specific team by ID
///
/// Copied from [team].
@ProviderFor(team)
const teamProvider = TeamFamily();

/// Provider for a specific team by ID
///
/// Copied from [team].
class TeamFamily extends Family<AsyncValue<TeamModel>> {
  /// Provider for a specific team by ID
  ///
  /// Copied from [team].
  const TeamFamily();

  /// Provider for a specific team by ID
  ///
  /// Copied from [team].
  TeamProvider call(
    String teamId,
  ) {
    return TeamProvider(
      teamId,
    );
  }

  @override
  TeamProvider getProviderOverride(
    covariant TeamProvider provider,
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
  String? get name => r'teamProvider';
}

/// Provider for a specific team by ID
///
/// Copied from [team].
class TeamProvider extends AutoDisposeFutureProvider<TeamModel> {
  /// Provider for a specific team by ID
  ///
  /// Copied from [team].
  TeamProvider(
    String teamId,
  ) : this._internal(
          (ref) => team(
            ref as TeamRef,
            teamId,
          ),
          from: teamProvider,
          name: r'teamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$teamHash,
          dependencies: TeamFamily._dependencies,
          allTransitiveDependencies: TeamFamily._allTransitiveDependencies,
          teamId: teamId,
        );

  TeamProvider._internal(
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
    FutureOr<TeamModel> Function(TeamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TeamProvider._internal(
        (ref) => create(ref as TeamRef),
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
  AutoDisposeFutureProviderElement<TeamModel> createElement() {
    return _TeamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamProvider && other.teamId == teamId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, teamId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TeamRef on AutoDisposeFutureProviderRef<TeamModel> {
  /// The parameter `teamId` of this provider.
  String get teamId;
}

class _TeamProviderElement extends AutoDisposeFutureProviderElement<TeamModel>
    with TeamRef {
  _TeamProviderElement(super.provider);

  @override
  String get teamId => (origin as TeamProvider).teamId;
}

String _$teamMembersHash() => r'88d2ae84f72f0d4d2def497507e59f47f4f4650c';

/// Provider for team members
///
/// Copied from [teamMembers].
@ProviderFor(teamMembers)
const teamMembersProvider = TeamMembersFamily();

/// Provider for team members
///
/// Copied from [teamMembers].
class TeamMembersFamily extends Family<AsyncValue<List<TeamMemberModel>>> {
  /// Provider for team members
  ///
  /// Copied from [teamMembers].
  const TeamMembersFamily();

  /// Provider for team members
  ///
  /// Copied from [teamMembers].
  TeamMembersProvider call(
    String teamId,
  ) {
    return TeamMembersProvider(
      teamId,
    );
  }

  @override
  TeamMembersProvider getProviderOverride(
    covariant TeamMembersProvider provider,
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
  String? get name => r'teamMembersProvider';
}

/// Provider for team members
///
/// Copied from [teamMembers].
class TeamMembersProvider
    extends AutoDisposeFutureProvider<List<TeamMemberModel>> {
  /// Provider for team members
  ///
  /// Copied from [teamMembers].
  TeamMembersProvider(
    String teamId,
  ) : this._internal(
          (ref) => teamMembers(
            ref as TeamMembersRef,
            teamId,
          ),
          from: teamMembersProvider,
          name: r'teamMembersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$teamMembersHash,
          dependencies: TeamMembersFamily._dependencies,
          allTransitiveDependencies:
              TeamMembersFamily._allTransitiveDependencies,
          teamId: teamId,
        );

  TeamMembersProvider._internal(
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
    FutureOr<List<TeamMemberModel>> Function(TeamMembersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TeamMembersProvider._internal(
        (ref) => create(ref as TeamMembersRef),
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
  AutoDisposeFutureProviderElement<List<TeamMemberModel>> createElement() {
    return _TeamMembersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamMembersProvider && other.teamId == teamId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, teamId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TeamMembersRef on AutoDisposeFutureProviderRef<List<TeamMemberModel>> {
  /// The parameter `teamId` of this provider.
  String get teamId;
}

class _TeamMembersProviderElement
    extends AutoDisposeFutureProviderElement<List<TeamMemberModel>>
    with TeamMembersRef {
  _TeamMembersProviderElement(super.provider);

  @override
  String get teamId => (origin as TeamMembersProvider).teamId;
}

String _$teamMemberHash() => r'27583034302de9ac117508af3ce97bfbceb03e17';

/// Provider for a specific team member
///
/// Copied from [teamMember].
@ProviderFor(teamMember)
const teamMemberProvider = TeamMemberFamily();

/// Provider for a specific team member
///
/// Copied from [teamMember].
class TeamMemberFamily extends Family<AsyncValue<TeamMemberModel?>> {
  /// Provider for a specific team member
  ///
  /// Copied from [teamMember].
  const TeamMemberFamily();

  /// Provider for a specific team member
  ///
  /// Copied from [teamMember].
  TeamMemberProvider call(
    String teamId,
    String userId,
  ) {
    return TeamMemberProvider(
      teamId,
      userId,
    );
  }

  @override
  TeamMemberProvider getProviderOverride(
    covariant TeamMemberProvider provider,
  ) {
    return call(
      provider.teamId,
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
  String? get name => r'teamMemberProvider';
}

/// Provider for a specific team member
///
/// Copied from [teamMember].
class TeamMemberProvider extends AutoDisposeFutureProvider<TeamMemberModel?> {
  /// Provider for a specific team member
  ///
  /// Copied from [teamMember].
  TeamMemberProvider(
    String teamId,
    String userId,
  ) : this._internal(
          (ref) => teamMember(
            ref as TeamMemberRef,
            teamId,
            userId,
          ),
          from: teamMemberProvider,
          name: r'teamMemberProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$teamMemberHash,
          dependencies: TeamMemberFamily._dependencies,
          allTransitiveDependencies:
              TeamMemberFamily._allTransitiveDependencies,
          teamId: teamId,
          userId: userId,
        );

  TeamMemberProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.teamId,
    required this.userId,
  }) : super.internal();

  final String teamId;
  final String userId;

  @override
  Override overrideWith(
    FutureOr<TeamMemberModel?> Function(TeamMemberRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TeamMemberProvider._internal(
        (ref) => create(ref as TeamMemberRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        teamId: teamId,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TeamMemberModel?> createElement() {
    return _TeamMemberProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamMemberProvider &&
        other.teamId == teamId &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, teamId.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TeamMemberRef on AutoDisposeFutureProviderRef<TeamMemberModel?> {
  /// The parameter `teamId` of this provider.
  String get teamId;

  /// The parameter `userId` of this provider.
  String get userId;
}

class _TeamMemberProviderElement
    extends AutoDisposeFutureProviderElement<TeamMemberModel?>
    with TeamMemberRef {
  _TeamMemberProviderElement(super.provider);

  @override
  String get teamId => (origin as TeamMemberProvider).teamId;
  @override
  String get userId => (origin as TeamMemberProvider).userId;
}

String _$teamStatsHash() => r'fa674aa29c8e5acc5a0bfb527e3c880926380938';

/// Provider for team statistics
///
/// Copied from [teamStats].
@ProviderFor(teamStats)
const teamStatsProvider = TeamStatsFamily();

/// Provider for team statistics
///
/// Copied from [teamStats].
class TeamStatsFamily extends Family<AsyncValue<TeamStats>> {
  /// Provider for team statistics
  ///
  /// Copied from [teamStats].
  const TeamStatsFamily();

  /// Provider for team statistics
  ///
  /// Copied from [teamStats].
  TeamStatsProvider call(
    String teamId,
  ) {
    return TeamStatsProvider(
      teamId,
    );
  }

  @override
  TeamStatsProvider getProviderOverride(
    covariant TeamStatsProvider provider,
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
  String? get name => r'teamStatsProvider';
}

/// Provider for team statistics
///
/// Copied from [teamStats].
class TeamStatsProvider extends AutoDisposeFutureProvider<TeamStats> {
  /// Provider for team statistics
  ///
  /// Copied from [teamStats].
  TeamStatsProvider(
    String teamId,
  ) : this._internal(
          (ref) => teamStats(
            ref as TeamStatsRef,
            teamId,
          ),
          from: teamStatsProvider,
          name: r'teamStatsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$teamStatsHash,
          dependencies: TeamStatsFamily._dependencies,
          allTransitiveDependencies: TeamStatsFamily._allTransitiveDependencies,
          teamId: teamId,
        );

  TeamStatsProvider._internal(
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
    FutureOr<TeamStats> Function(TeamStatsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TeamStatsProvider._internal(
        (ref) => create(ref as TeamStatsRef),
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
  AutoDisposeFutureProviderElement<TeamStats> createElement() {
    return _TeamStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamStatsProvider && other.teamId == teamId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, teamId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TeamStatsRef on AutoDisposeFutureProviderRef<TeamStats> {
  /// The parameter `teamId` of this provider.
  String get teamId;
}

class _TeamStatsProviderElement
    extends AutoDisposeFutureProviderElement<TeamStats> with TeamStatsRef {
  _TeamStatsProviderElement(super.provider);

  @override
  String get teamId => (origin as TeamStatsProvider).teamId;
}

String _$teamNotifierHash() => r'c96ef6d52ca5a713d48ece53431e23f398b1cf60';

/// Notifier for creating a new team
///
/// Copied from [TeamNotifier].
@ProviderFor(TeamNotifier)
final teamNotifierProvider =
    AutoDisposeAsyncNotifierProvider<TeamNotifier, void>.internal(
  TeamNotifier.new,
  name: r'teamNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$teamNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TeamNotifier = AutoDisposeAsyncNotifier<void>;
String _$teamMemberNotifierHash() =>
    r'a3d8de19d4d28ab70eee0d7f3ff191491b39aa4c';

/// Notifier for managing team members
///
/// Copied from [TeamMemberNotifier].
@ProviderFor(TeamMemberNotifier)
final teamMemberNotifierProvider =
    AutoDisposeAsyncNotifierProvider<TeamMemberNotifier, void>.internal(
  TeamMemberNotifier.new,
  name: r'teamMemberNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$teamMemberNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TeamMemberNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
