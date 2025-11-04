/// Corporate Supabase Service - Full Corporate Features
/// Phase 4: Complete Integration with all Corporate Features

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/organizations/models/organization_model.dart';
import '../../features/organizations/models/department_model.dart';
import '../../features/teams/models/team_model.dart';
import '../../features/teams/models/team_member_model.dart';
import '../../features/projects/models/project_model.dart';
import '../../features/auth/models/corporate_user_model.dart';
import '../../features/tasks/models/work_task_model.dart';
import '../../features/achievements/models/achievement_model.dart';
import '../../features/achievements/models/work_achievement_definitions.dart';
import '../../features/reports/models/manager_dashboard_model.dart';
import '../../features/reports/models/employee_report_model.dart';

class CorporateSupabaseService {
  static final CorporateSupabaseService _instance = CorporateSupabaseService._internal();
  factory CorporateSupabaseService() => _instance;
  CorporateSupabaseService._internal();

  SupabaseClient get _client => Supabase.instance.client;

  // ====================
  // AUTHENTICATION
  // ====================

  User? get currentUser => _client.auth.currentUser;

  bool get isAuthenticated => _client.auth.currentSession != null;

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String username,
    required String fullName,
    String? organizationId,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'username': username,
        'full_name': fullName,
      },
    );

    if (response.user != null) {
      await _createCorporateUserProfile(
        userId: response.user!.id,
        email: email,
        username: username,
        fullName: fullName,
        organizationId: organizationId,
      );
    }

    return response;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  // ====================
  // ORGANIZATIONS
  // ====================

  Future<List<OrganizationModel>> getOrganizations() async {
    final response = await _client
        .from('organizations')
        .select()
        .eq('is_active', true);

    return (response as List<dynamic>)
        .map((json) => OrganizationModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<OrganizationModel?> getOrganization(String id) async {
    final response = await _client
        .from('organizations')
        .select()
        .eq('id', id)
        .single();

    if (response != null) {
      return OrganizationModel.fromJson(response as Map<String, dynamic>);
    }
    return null;
  }

  Future<OrganizationModel> createOrganization(OrganizationModel org) async {
    final response = await _client
        .from('organizations')
        .insert(org.toJson())
        .select()
        .single();

    return OrganizationModel.fromJson(response as Map<String, dynamic>);
  }

  // ====================
  // DEPARTMENTS
  // ====================

  Future<List<DepartmentModel>> getDepartments(String organizationId) async {
    final response = await _client
        .from('departments')
        .select()
        .eq('organization_id', organizationId)
        .eq('is_active', true);

    return (response as List<dynamic>)
        .map((json) => DepartmentModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<DepartmentModel> createDepartment(DepartmentModel dept) async {
    final response = await _client
        .from('departments')
        .insert(dept.toJson())
        .select()
        .single();

    return DepartmentModel.fromJson(response as Map<String, dynamic>);
  }

  // ====================
  // TEAMS
  // ====================

  Future<List<TeamModel>> getTeams(String departmentId) async {
    final response = await _client
        .from('teams')
        .select()
        .eq('department_id', departmentId)
        .eq('is_active', true);

    return (response as List<dynamic>)
        .map((json) => TeamModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<TeamModel> createTeam(TeamModel team) async {
    final response = await _client
        .from('teams')
        .insert(team.toJson())
        .select()
        .single();

    return TeamModel.fromJson(response as Map<String, dynamic>);
  }

  Future<TeamModel?> getTeam(String id) async {
    final response = await _client
        .from('teams')
        .select()
        .eq('id', id)
        .single();

    if (response != null) {
      return TeamModel.fromJson(response as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateTeam(TeamModel team) async {
    await _client.from('teams').update(team.toJson()).eq('id', team.id);
  }

  Future<void> deleteTeam(String teamId) async {
    await _client.from('teams').delete().eq('id', teamId);
  }

  // ====================
  // TEAM MEMBERS
  // ====================

  Future<List<TeamMemberModel>> getTeamMembers(String teamId) async {
    final response = await _client
        .from('team_members')
        .select()
        .eq('team_id', teamId)
        .eq('is_active', true);

    return (response as List<dynamic>)
        .map((json) => TeamMemberModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> addTeamMember({
    required String teamId,
    required String userId,
    String role = 'employee',
  }) async {
    await _client.from('team_members').insert({
      'team_id': teamId,
      'user_id': userId,
      'role': role,
    });
  }

  Future<void> removeTeamMember(String teamId, String userId) async {
    await _client
        .from('team_members')
        .delete()
        .eq('team_id', teamId)
        .eq('user_id', userId);
  }

  // ====================
  // PROJECTS
  // ====================

  Future<List<ProjectModel>> getProjects(String organizationId) async {
    final response = await _client
        .from('projects')
        .select()
        .eq('organization_id', organizationId)
        .eq('is_active', true);

    return (response as List<dynamic>)
        .map((json) => ProjectModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<ProjectModel>> getTeamProjects(String teamId) async {
    final response = await _client
        .from('projects')
        .select()
        .eq('team_id', teamId)
        .eq('is_active', true);

    return (response as List<dynamic>)
        .map((json) => ProjectModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<ProjectModel> createProject(ProjectModel project) async {
    final response = await _client
        .from('projects')
        .insert(project.toJson())
        .select()
        .single();

    return ProjectModel.fromJson(response as Map<String, dynamic>);
  }

  Future<ProjectModel?> getProject(String id) async {
    final response = await _client
        .from('projects')
        .select()
        .eq('id', id)
        .single();

    if (response != null) {
      return ProjectModel.fromJson(response as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateProject(ProjectModel project) async {
    await _client.from('projects').update(project.toJson()).eq('id', project.id);
  }

  // ====================
  // CORPORATE USERS
  // ====================

  Future<CorporateUserModel?> getCorporateUser(String userId) async {
    final response = await _client
        .from('corporate_users')
        .select()
        .eq('user_id', userId)
        .single();

    if (response != null) {
      return CorporateUserModel.fromJson(response as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<CorporateUserModel>> getTeamMembersByTeamId(String teamId) async {
    final response = await _client
        .from('corporate_users')
        .select()
        .eq('team_id', teamId)
        .eq('is_active', true);

    return (response as List<dynamic>)
        .map((json) => CorporateUserModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<CorporateUserModel>> getDepartmentUsers(String departmentId) async {
    final response = await _client
        .from('corporate_users')
        .select()
        .eq('department_id', departmentId)
        .eq('is_active', true);

    return (response as List<dynamic>)
        .map((json) => CorporateUserModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<CorporateUserModel> createCorporateUser(CorporateUserModel user) async {
    final response = await _client
        .from('corporate_users')
        .insert(user.toJson())
        .select()
        .single();

    return CorporateUserModel.fromJson(response as Map<String, dynamic>);
  }

  Future<void> updateCorporateUser(CorporateUserModel user) async {
    await _client
        .from('corporate_users')
        .update(user.toJson())
        .eq('user_id', user.userId);
  }

  // ====================
  // WORK TASKS
  // ====================

  Future<List<WorkTaskModel>> getWorkTasks({
    String? teamId,
    String? assigneeId,
    String? projectId,
    String? status,
  }) async {
    var query = _client.from('work_tasks').select().eq('is_archived', false);

    if (teamId != null) {
      query = query.eq('team_id', teamId);
    }
    if (assigneeId != null) {
      query = query.eq('assignee_id', assigneeId);
    }
    if (projectId != null) {
      query = query.eq('project_id', projectId);
    }
    if (status != null) {
      query = query.eq('status', status);
    }

    final response = await query;

    return (response as List<dynamic>)
        .map((json) => WorkTaskModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<WorkTaskModel>> getMyTasks(String userId) async {
    final response = await _client
        .from('work_tasks')
        .select()
        .eq('assignee_id', userId)
        .eq('is_archived', false)
        .order('due_date', nullsFirst: true);

    return (response as List<dynamic>)
        .map((json) => WorkTaskModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<WorkTaskModel> createWorkTask(WorkTaskModel task) async {
    final response = await _client
        .from('work_tasks')
        .insert(task.toJson())
        .select()
        .single();

    return WorkTaskModel.fromJson(response as Map<String, dynamic>);
  }

  Future<WorkTaskModel?> getWorkTask(String id) async {
    final response = await _client
        .from('work_tasks')
        .select()
        .eq('id', id)
        .single();

    if (response != null) {
      return WorkTaskModel.fromJson(response as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateWorkTask(WorkTaskModel task) async {
    await _client.from('work_tasks').update(task.toJson()).eq('id', task.id);
  }

  Future<void> completeWorkTask(String taskId) async {
    final task = await getWorkTask(taskId);
    if (task != null) {
      final updatedTask = task.copyWith(
        isCompleted: true,
        status: 'completed',
        completedAt: DateTime.now(),
      );
      await updateWorkTask(updatedTask);
    }
  }

  Future<void> deleteWorkTask(String taskId) async {
    await _client.from('work_tasks').delete().eq('id', taskId);
  }

  // ====================
  // ACHIEVEMENTS & GAMIFICATION
  // ====================

  Future<List<AchievementDefinition>> getAchievements({
    AchievementCategory? category,
  }) async {
    var query = _client.from('achievements').select();

    if (category != null) {
      query = query.eq('category', category.name);
    }

    final response = await query;

    return (response as List<dynamic>)
        .map((json) => AchievementDefinition.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<WorkAchievementDefinition>> getUserAchievements(String userId) async {
    final response = await _client
        .from('user_achievements')
        .select('*, achievements(*)')
        .eq('user_id', userId);

    return (response as List<dynamic>)
        .map((json) => WorkAchievementDefinition.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> unlockAchievement({
    required String userId,
    required String achievementId,
  }) async {
    await _client.from('user_achievements').insert({
      'user_id': userId,
      'achievement_id': achievementId,
    });
  }

  // ====================
  // XP & LEVELS
  // ====================

  Future<Map<String, dynamic>?> getUserXP(String userId) async {
    final response = await _client
        .from('user_xp')
        .select()
        .eq('user_id', userId)
        .single();

    return response as Map<String, dynamic>?;
  }

  Future<void> addUserXP(String userId, int xpAmount) async {
    final response = await _client.rpc('get_user_task_stats', params: {'user_id_param': userId});

    if (response != null) {
      final stats = response as Map<String, dynamic>;
      final currentXP = stats['total_xp'] as int? ?? 0;
      final newXP = currentXP + xpAmount;
      final newLevel = (newXP / 100).floor() + 1;

      await _client.from('user_xp').upsert({
        'user_id': userId,
        'total_xp': newXP,
        'current_level': newLevel,
        'updated_at': DateTime.now().toIso8601String(),
      });
    }
  }

  // ====================
  // LEADERBOARDS
  // ====================

  Future<List<ManagerDashboardModel>> getTeamLeaderboard(String teamId) async {
    final response = await _client
        .from('leaderboard_entries')
        .select()
        .eq('team_id', teamId)
        .order('rank', ascending: true);

    return (response as List<dynamic>)
        .map((json) => ManagerDashboardModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateLeaderboard(String organizationId, report_period period) async {
    await _client.rpc('update_leaderboard', params: {
      'org_id': organizationId,
      'period_type': period.name,
    });
  }

  // ====================
  // REPORTS & ANALYTICS
  // ====================

  Future<ManagerDashboardModel> generateManagerDashboard({
    required String managerId,
    required String organizationId,
    required String departmentId,
    required report_period period,
  }) async {
    final response = await _client.rpc('generate_manager_dashboard', params: {
      'manager_id_param': managerId,
      'org_id_param': organizationId,
      'dept_id_param': departmentId,
      'period_param': period.name,
    });

    return ManagerDashboardModel.fromJson(response as Map<String, dynamic>);
  }

  Future<EmployeeReportModel> generateEmployeeReport({
    required String userId,
    required report_period period,
  }) async {
    final response = await _client.rpc('generate_employee_report', params: {
      'user_id_param': userId,
      'period_param': period.name,
    });

    return EmployeeReportModel.fromJson(response as Map<String, dynamic>);
  }

  // ====================
  // NOTIFICATIONS
  // ====================

  Future<List<Map<String, dynamic>>> getNotifications(String userId) async {
    final response = await _client
        .from('notifications')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .limit(50);

    return response as List<Map<String, dynamic>>;
  }

  Future<void> sendNotification({
    required String userId,
    required String title,
    required String message,
    required String type,
    Map<String, dynamic>? metadata,
  }) async {
    await _client.from('notifications').insert({
      'user_id': userId,
      'title': title,
      'message': message,
      'type': type,
      'metadata': metadata ?? {},
    });
  }

  Future<void> markNotificationRead(String notificationId) async {
    await _client
        .from('notifications')
        .update({'is_read': true})
        .eq('id', notificationId);
  }

  // ====================
  // REAL-TIME SUBSCRIPTIONS
  // ====================

  Stream<List<WorkTaskModel>> subscribeToTeamTasks(String teamId) {
    return _client
        .from('work_tasks')
        .stream(primaryKey: ['id'])
        .eq('team_id', teamId)
        .eq('is_archived', false)
        .map((data) => data
            .map((json) => WorkTaskModel.fromJson(json as Map<String, dynamic>))
            .toList());
  }

  Stream<Map<String, dynamic>> subscribeToUserStats(String userId) {
    return _client
        .from('user_xp')
        .stream(primaryKey: ['user_id'])
        .eq('user_id', userId)
        .map((data) => data.isNotEmpty
            ? data.first as Map<String, dynamic>
            : {});
  }

  Stream<List<Map<String, dynamic>>> subscribeToNotifications(String userId) {
    return _client
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .eq('is_read', false)
        .map((data) => data as List<Map<String, dynamic>>);
  }

  // ====================
  // PRIVATE HELPER METHODS
  // ====================

  Future<void> _createCorporateUserProfile({
    required String userId,
    required String email,
    required String username,
    required String fullName,
    String? organizationId,
  }) async {
    // Create user in auth profile
    await _client.from('corporate_users').insert({
      'user_id': userId,
      'email': email,
      'username': username,
      'full_name': fullName,
      'organization_id': organizationId,
      'role': 'employee',
    });

    // Initialize XP record
    await _client.from('user_xp').insert({
      'user_id': userId,
      'total_xp': 0,
      'current_level': 1,
      'current_streak': 0,
      'longest_streak': 0,
    });
  }
}
