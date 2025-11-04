/// Team Provider
/// Riverpod provider for managing teams state

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/team_model.dart';
import '../models/team_member_model.dart';
import '../services/team_service.dart';

part 'team_provider.g.dart';

// Team service provider
@riverpod
TeamService teamService(TeamServiceRef ref) {
  return TeamService();
}

/// Provider for teams in an organization
@riverpod
Future<List<TeamModel>> organizationTeams(
  OrganizationTeamsRef ref,
  String organizationId,
) async {
  final teamService = ref.watch(teamServiceProvider);
  return await teamService.getTeamsByOrganization(organizationId);
}

/// Provider for teams in a department
@riverpod
Future<List<TeamModel>> departmentTeams(
  DepartmentTeamsRef ref,
  String departmentId,
) async {
  final teamService = ref.watch(teamServiceProvider);
  return await teamService.getTeamsByDepartment(departmentId);
}

/// Provider for teams of a specific user
@riverpod
Future<List<TeamModel>> userTeams(
  UserTeamsRef ref,
  String userId,
) async {
  final teamService = ref.watch(teamServiceProvider);
  return await teamService.getUserTeams(userId);
}

/// Provider for a specific team by ID
@riverpod
Future<TeamModel> team(
  TeamRef ref,
  String teamId,
) async {
  final teamService = ref.watch(teamServiceProvider);
  return await teamService.getTeam(teamId);
}

/// Provider for team members
@riverpod
Future<List<TeamMemberModel>> teamMembers(
  TeamMembersRef ref,
  String teamId,
) async {
  final teamService = ref.watch(teamServiceProvider);
  return await teamService.getTeamMembers(teamId);
}

/// Provider for a specific team member
@riverpod
Future<TeamMemberModel?> teamMember(
  TeamMemberRef ref,
  String teamId,
  String userId,
) async {
  final teamService = ref.watch(teamServiceProvider);
  return await teamService.getTeamMember(teamId, userId);
}

/// Provider for team statistics
@riverpod
Future<TeamStats> teamStats(
  TeamStatsRef ref,
  String teamId,
) async {
  final teamService = ref.watch(teamServiceProvider);
  return await teamService.getTeamStats(teamId);
}

/// Notifier for creating a new team
@riverpod
class TeamNotifier extends _$TeamNotifier {
  @override
  FutureOr<void> build() {
    // Initial state
  }

  /// Create a new team
  Future<void> createTeam({
    required String name,
    required String departmentId,
    required String organizationId,
    required String createdBy,
    String? description,
    String? icon,
    String? color,
    int? memberLimit,
  }) async {
    final teamService = ref.read(teamServiceProvider);
    final team = await teamService.createTeam(
      name: name,
      departmentId: departmentId,
      organizationId: organizationId,
      createdBy: createdBy,
      description: description,
      icon: icon,
      color: color,
      memberLimit: memberLimit,
    );

    // Invalidate relevant providers to refresh data
    ref.invalidate(organizationTeamsProvider(organizationId));
    ref.invalidate(departmentTeamsProvider(departmentId));
    ref.invalidate(userTeamsProvider(createdBy));

    return team;
  }

  /// Update team details
  Future<void> updateTeam({
    required String teamId,
    String? name,
    String? description,
    String? icon,
    String? color,
    int? memberLimit,
  }) async {
    final teamService = ref.read(teamServiceProvider);
    final team = await teamService.updateTeam(
      teamId: teamId,
      name: name,
      description: description,
      icon: icon,
      color: color,
      memberLimit: memberLimit,
    );

    // Invalidate relevant providers
    ref.invalidate(teamProvider(teamId));
    ref.invalidate(teamStatsProvider(teamId));

    return team;
  }

  /// Delete a team
  Future<void> deleteTeam(String teamId) async {
    final teamService = ref.read(teamServiceProvider);
    await teamService.deleteTeam(teamId);

    // Invalidate all team-related providers
    ref.invalidate(teamProvider(teamId));
    ref.invalidate(teamMembersProvider(teamId));
    ref.invalidate(teamStatsProvider(teamId));
  }
}

/// Notifier for managing team members
@riverpod
class TeamMemberNotifier extends _$TeamMemberNotifier {
  @override
  FutureOr<void> build() {
    // Initial state
  }

  /// Add member to team
  Future<void> addMember({
    required String teamId,
    required String userId,
    required TeamMemberRole role,
    required String addedBy,
  }) async {
    final teamService = ref.read(teamServiceProvider);
    await teamService.addMemberToTeam(
      teamId: teamId,
      userId: userId,
      role: role,
      addedBy: addedBy,
    );

    // Invalidate relevant providers
    ref.invalidate(teamMembersProvider(teamId));
    ref.invalidate(teamMemberProvider(teamId, userId));
    ref.invalidate(teamStatsProvider(teamId));
  }

  /// Remove member from team
  Future<void> removeMember({
    required String teamId,
    required String userId,
  }) async {
    final teamService = ref.read(teamServiceProvider);
    await teamService.removeMemberFromTeam(
      teamId: teamId,
      userId: userId,
    );

    // Invalidate relevant providers
    ref.invalidate(teamMembersProvider(teamId));
    ref.invalidate(teamMemberProvider(teamId, userId));
    ref.invalidate(teamStatsProvider(teamId));
  }

  /// Update member role
  Future<void> updateMemberRole({
    required String teamId,
    required String userId,
    required TeamMemberRole newRole,
  }) async {
    final teamService = ref.read(teamServiceProvider);
    await teamService.updateMemberRole(
      teamId: teamId,
      userId: userId,
      newRole: newRole,
    );

    // Invalidate relevant providers
    ref.invalidate(teamMembersProvider(teamId));
    ref.invalidate(teamMemberProvider(teamId, userId));
  }

  /// Assign task to team
  Future<void> assignTaskToTeam({
    required String taskId,
    required String teamId,
    required String assignedBy,
  }) async {
    final teamService = ref.read(teamServiceProvider);
    await teamService.assignTaskToTeam(
      taskId: taskId,
      teamId: teamId,
      assignedBy: assignedBy,
    );

    // Invalidate team stats
    ref.invalidate(teamStatsProvider(teamId));
  }

  /// Reassign task
  Future<void> reassignTask({
    required String taskId,
    required String fromUserId,
    required String toUserId,
    required String reason,
  }) async {
    final teamService = ref.read(teamServiceProvider);
    await teamService.reassignTask(
      taskId: taskId,
      fromUserId: fromUserId,
      toUserId: toUserId,
      reason: reason,
    );
  }
}
