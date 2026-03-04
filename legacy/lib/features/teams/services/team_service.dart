/// Team Service
/// Service for managing teams, members, and team operations

import '../models/team_model.dart';
import '../models/team_member_model.dart';
import '../../organizations/models/department_model.dart';
import '../../organizations/models/organization_model.dart';
import '../../tasks/models/work_task_model.dart';

class TeamService {
  /// Create a new team
  Future<TeamModel> createTeam({
    required String name,
    required String departmentId,
    required String organizationId,
    required String createdBy,
    String? description,
    String? icon,
    String? color,
    int? memberLimit,
  }) async {
    final team = TeamModel(
      id: _generateId(),
      name: name,
      departmentId: departmentId,
      organizationId: organizationId,
      createdBy: createdBy,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      description: description,
      icon: icon,
      color: color,
      memberLimit: memberLimit,
      activeMembers: 0,
      totalTasks: 0,
      completedTasks: 0,
    );

    // Save to database (Supabase or Hive)
    await _saveTeam(team);

    // Add creator as admin member
    await addMemberToTeam(
      teamId: team.id,
      userId: createdBy,
      role: TeamMemberRole.admin,
      addedBy: createdBy,
    );

    return team;
  }

  /// Add a member to a team
  Future<TeamMemberModel> addMemberToTeam({
    required String teamId,
    required String userId,
    required TeamMemberRole role,
    required String addedBy,
  }) async {
    // Check if member already exists
    final existingMember = await getTeamMember(teamId, userId);
    if (existingMember != null) {
      throw Exception('User is already a member of this team');
    }

    // Check team capacity
    final team = await getTeam(teamId);
    if (team.isAtCapacity) {
      throw Exception('Team is at maximum capacity');
    }

    final member = TeamMemberModel(
      id: _generateId(),
      teamId: teamId,
      userId: userId,
      role: role,
      status: TeamMemberStatus.active,
      joinedAt: DateTime.now(),
      lastActiveAt: DateTime.now(),
      addedBy: addedBy,
    );

    await _saveTeamMember(member);

    // Update team member count
    await updateTeamMemberCount(teamId);

    return member;
  }

  /// Remove a member from a team
  Future<void> removeMemberFromTeam({
    required String teamId,
    required String userId,
  }) async {
    final member = await getTeamMember(teamId, userId);
    if (member == null) {
      throw Exception('User is not a member of this team');
    }

    await _removeTeamMember(member.id);
    await updateTeamMemberCount(teamId);

    // Reassign or unassign any tasks assigned to this user
    await _reassignUserTasks(teamId, userId);
  }

  /// Update member role
  Future<void> updateMemberRole({
    required String teamId,
    required String userId,
    required TeamMemberRole newRole,
  }) async {
    final member = await getTeamMember(teamId, userId);
    if (member == null) {
      throw Exception('User is not a member of this team');
    }

    final updatedMember = member.copyWith(
      role: newRole,
    );

    await _saveTeamMember(updatedMember);
  }

  /// Get all teams in an organization
  Future<List<TeamModel>> getTeamsByOrganization(String organizationId) async {
    // Query from database
    final teams = await _queryTeamsByOrganization(organizationId);
    return teams;
  }

  /// Get all teams in a department
  Future<List<TeamModel>> getTeamsByDepartment(String departmentId) async {
    // Query from database
    final teams = await _queryTeamsByDepartment(departmentId);
    return teams;
  }

  /// Get team by ID
  Future<TeamModel> getTeam(String teamId) async {
    final team = await _queryTeam(teamId);
    if (team == null) {
      throw Exception('Team not found');
    }
    return team;
  }

  /// Get team member details
  Future<TeamMemberModel?> getTeamMember(String teamId, String userId) async {
    // Query from database
    return await _queryTeamMember(teamId, userId);
  }

  /// Get all members of a team
  Future<List<TeamMemberModel>> getTeamMembers(String teamId) async {
    final members = await _queryTeamMembers(teamId);
    return members;
  }

  /// Get teams for a specific user
  Future<List<TeamModel>> getUserTeams(String userId) async {
    // Get all team memberships for user
    final memberships = await _queryUserTeamMemberships(userId);
    final teamIds = memberships.map((m) => m.teamId).toList();

    // Get team details
    final teams = await _queryTeamsByIds(teamIds);
    return teams;
  }

  /// Update team details
  Future<TeamModel> updateTeam({
    required String teamId,
    String? name,
    String? description,
    String? icon,
    String? color,
    int? memberLimit,
  }) async {
    final team = await getTeam(teamId);

    final updatedTeam = team.copyWith(
      name: name,
      description: description,
      icon: icon,
      color: color,
      memberLimit: memberLimit,
      updatedAt: DateTime.now(),
    );

    await _saveTeam(updatedTeam);
    return updatedTeam;
  }

  /// Delete a team
  Future<void> deleteTeam(String teamId) async {
    final team = await getTeam(teamId);

    // Remove all team members
    final members = await getTeamMembers(teamId);
    for (final member in members) {
      await _removeTeamMember(member.id);
    }

    // Delete team
    await _deleteTeam(teamId);

    // Reassign or delete team tasks
    await _reassignOrDeleteTeamTasks(teamId);
  }

  /// Get team statistics
  Future<TeamStats> getTeamStats(String teamId) async {
    final team = await getTeam(teamId);
    final tasks = await _queryTeamTasks(teamId);

    final completedTasks = tasks
        .where((t) => t.progress == WorkTaskProgress.completed)
        .length;

    final overdueTasks = tasks
        .where((t) => t.isOverdue)
        .length;

    final inProgressTasks = tasks
        .where((t) => t.progress == WorkTaskProgress.inProgress)
        .length;

    return TeamStats(
      totalTasks: tasks.length,
      completedTasks: completedTasks,
      overdueTasks: overdueTasks,
      inProgressTasks: inProgressTasks,
      completionPercentage: tasks.isEmpty
          ? 0.0
          : (completedTasks / tasks.length) * 100,
      activeMembers: team.activeMembers,
    );
  }

  /// Assign a task to a team
  Future<void> assignTaskToTeam({
    required String taskId,
    required String teamId,
    required String assignedBy,
  }) async {
    final team = await getTeam(teamId);
    final members = await getTeamMembers(teamId);

    if (members.isEmpty) {
      throw Exception('Team has no active members');
    }

    // Assign task to all team members
    final userIds = members.map((m) => m.userId).toList();

    await _assignTaskToUsers(taskId: taskId, userIds: userIds, assignedBy: assignedBy);

    // Update team task count
    await _updateTeamTaskCount(teamId, increment: 1);
  }

  /// Reassign task from one team member to another
  Future<void> reassignTask({
    required String taskId,
    required String fromUserId,
    required String toUserId,
    required String reason,
  }) async {
    await _reassignTask(taskId: taskId, fromUserId: fromUserId, toUserId: toUserId, reason: reason);
  }

  // Private methods for database operations

  Future<void> _saveTeam(TeamModel team) async {
    // TODO: Implement Supabase or Hive save
    // This is a placeholder for database operations
  }

  Future<void> _saveTeamMember(TeamMemberModel member) async {
    // TODO: Implement Supabase or Hive save
  }

  Future<void> _removeTeamMember(String memberId) async {
    // TODO: Implement Supabase or Hive delete
  }

  Future<TeamModel?> _queryTeam(String teamId) async {
    // TODO: Implement Supabase or Hive query
    return null;
  }

  Future<List<TeamModel>> _queryTeamsByOrganization(String organizationId) async {
    // TODO: Implement Supabase or Hive query
    return [];
  }

  Future<List<TeamModel>> _queryTeamsByDepartment(String departmentId) async {
    // TODO: Implement Supabase or Hive query
    return [];
  }

  Future<List<TeamModel>> _queryTeamsByIds(List<String> teamIds) async {
    // TODO: Implement Supabase or Hive query
    return [];
  }

  Future<TeamMemberModel?> _queryTeamMember(String teamId, String userId) async {
    // TODO: Implement Supabase or Hive query
    return null;
  }

  Future<List<TeamMemberModel>> _queryTeamMembers(String teamId) async {
    // TODO: Implement Supabase or Hive query
    return [];
  }

  Future<List<TeamMemberModel>> _queryUserTeamMemberships(String userId) async {
    // TODO: Implement Supabase or Hive query
    return [];
  }

  Future<void> _deleteTeam(String teamId) async {
    // TODO: Implement Supabase or Hive delete
  }

  Future<void> _updateTeamTaskCount(String teamId, {required int increment}) async {
    // TODO: Implement task count update
  }

  Future<void> updateTeamMemberCount(String teamId) async {
    // TODO: Implement member count update
  }

  Future<List<WorkTaskModel>> _queryTeamTasks(String teamId) async {
    // TODO: Implement task query
    return [];
  }

  Future<void> _assignTaskToUsers({
    required String taskId,
    required List<String> userIds,
    required String assignedBy,
  }) async {
    // TODO: Implement task assignment
  }

  Future<void> _reassignTask({
    required String taskId,
    required String fromUserId,
    required String toUserId,
    required String reason,
  }) async {
    // TODO: Implement task reassignment
  }

  Future<void> _reassignUserTasks(String teamId, String userId) async {
    // TODO: Implement task reassignment
  }

  Future<void> _reassignOrDeleteTeamTasks(String teamId) async {
    // TODO: Implement team tasks cleanup
  }

  String _generateId() {
    // Generate unique ID
    return 'team_${DateTime.now().millisecondsSinceEpoch}_${_randomString(8)}';
  }

  String _randomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = DateTime.now().millisecondsSinceEpoch % 1000;
    String result = '';
    for (int i = 0; i < length; i++) {
      result += chars[(random + i) % chars.length];
    }
    return result;
  }
}

/// Team statistics model
class TeamStats {
  final int totalTasks;
  final int completedTasks;
  final int overdueTasks;
  final int inProgressTasks;
  final double completionPercentage;
  final int activeMembers;

  const TeamStats({
    required this.totalTasks,
    required this.completedTasks,
    required this.overdueTasks,
    required this.inProgressTasks,
    required this.completionPercentage,
    required this.activeMembers,
  });
}
