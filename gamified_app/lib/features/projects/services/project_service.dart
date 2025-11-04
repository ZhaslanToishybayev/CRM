/// Project Service
/// Service for managing projects, tasks, and project operations

import '../models/project_model.dart';
import '../../organizations/models/organization_model.dart';
import '../../organizations/models/department_model.dart';
import '../../teams/models/team_model.dart';
import '../../tasks/models/work_task_model.dart';

class ProjectService {
  /// Create a new project
  Future<ProjectModel> createProject({
    required String name,
    required String organizationId,
    required String createdBy,
    String? description,
    String? icon,
    String? color,
    String? teamId,
    String? departmentId,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? dueDate,
    ProjectPriority priority = ProjectPriority.medium,
    int? totalBudget,
    List<String>? memberIds,
  }) async {
    final project = ProjectModel(
      id: _generateId(),
      name: name,
      organizationId: organizationId,
      createdBy: createdBy,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      description: description,
      icon: icon,
      color: color,
      teamId: teamId,
      departmentId: departmentId,
      startDate: startDate,
      endDate: endDate,
      dueDate: dueDate,
      status: ProjectStatus.planning,
      priority: priority,
      totalTasks: 0,
      completedTasks: 0,
      totalBudget: totalBudget ?? 0,
      spentBudget: 0,
      memberIds: memberIds ?? [],
      completionPercentage: 0,
    );

    // Save to database
    await _saveProject(project);

    return project;
  }

  /// Update project status
  Future<ProjectModel> updateProjectStatus({
    required String projectId,
    required ProjectStatus status,
  }) async {
    final project = await getProject(projectId);

    final updatedProject = project.copyWith(
      status: status,
      updatedAt: DateTime.now(),
    );

    // If project is completed, mark all tasks as completed
    if (status == ProjectStatus.completed) {
      await _completeAllProjectTasks(projectId);
    }

    await _saveProject(updatedProject);
    return updatedProject;
  }

  /// Update project details
  Future<ProjectModel> updateProject({
    required String projectId,
    String? name,
    String? description,
    String? icon,
    String? color,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? dueDate,
    ProjectPriority? priority,
    int? totalBudget,
    int? spentBudget,
  }) async {
    final project = await getProject(projectId);

    final updatedProject = project.copyWith(
      name: name,
      description: description,
      icon: icon,
      color: color,
      startDate: startDate,
      endDate: endDate,
      dueDate: dueDate,
      priority: priority,
      totalBudget: totalBudget,
      spentBudget: spentBudget,
      updatedAt: DateTime.now(),
    );

    await _saveProject(updatedProject);
    return updatedProject;
  }

  /// Add a member to the project
  Future<void> addProjectMember({
    required String projectId,
    required String userId,
  }) async {
    final project = await getProject(projectId);

    if (project.memberIds.contains(userId)) {
      throw Exception('User is already a member of this project');
    }

    final updatedProject = project.copyWith(
      memberIds: [...project.memberIds, userId],
    );

    await _saveProject(updatedProject);
  }

  /// Remove a member from the project
  Future<void> removeProjectMember({
    required String projectId,
    required String userId,
  }) async {
    final project = await getProject(projectId);

    final updatedMembers = project.memberIds.where((id) => id != userId).toList();

    final updatedProject = project.copyWith(
      memberIds: updatedMembers,
    );

    await _saveProject(updatedProject);

    // Reassign or unassign any tasks assigned to this user
    await _reassignUserTasks(projectId, userId);
  }

  /// Get all projects in an organization
  Future<List<ProjectModel>> getProjectsByOrganization(String organizationId) async {
    final projects = await _queryProjectsByOrganization(organizationId);
    return projects;
  }

  /// Get all projects for a team
  Future<List<ProjectModel>> getProjectsByTeam(String teamId) async {
    final projects = await _queryProjectsByTeam(teamId);
    return projects;
  }

  /// Get all projects for a department
  Future<List<ProjectModel>> getProjectsByDepartment(String departmentId) async {
    final projects = await _queryProjectsByDepartment(departmentId);
    return projects;
  }

  /// Get project by ID
  Future<ProjectModel> getProject(String projectId) async {
    final project = await _queryProject(projectId);
    if (project == null) {
      throw Exception('Project not found');
    }
    return project;
  }

  /// Get projects for a specific user
  Future<List<ProjectModel>> getUserProjects(String userId) async {
    // Get all project memberships
    final memberships = await _queryUserProjectMemberships(userId);
    final projectIds = memberships;

    // Get project details
    final projects = await _queryProjectsByIds(projectIds);
    return projects;
  }

  /// Get all tasks for a project
  Future<List<WorkTaskModel>> getProjectTasks(String projectId) async {
    final tasks = await _queryProjectTasks(projectId);
    return tasks;
  }

  /// Create a task within a project
  Future<WorkTaskModel> createProjectTask({
    required String projectId,
    required String title,
    required String userId,
    String? description,
    WorkTaskPriority priority = WorkTaskPriority.medium,
    int xp = 10,
    DateTime? dueDate,
    DateTime? startDate,
    String? category,
    List<String>? assignedTo,
    String? assignedBy,
    int? estimatedHours,
    bool billable = false,
  }) async {
    final project = await getProject(projectId);

    final task = WorkTaskModel(
      id: _generateTaskId(),
      userId: userId,
      title: title,
      description: description,
      xp: xp,
      priority: priority,
      progress: WorkTaskProgress.notStarted,
      dueDate: dueDate,
      startDate: startDate,
      category: category,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      organizationId: project.organizationId,
      projectId: projectId,
      departmentId: project.departmentId,
      teamId: project.teamId,
      assignedBy: assignedBy ?? userId,
      assignedTo: assignedTo,
      type: WorkTaskType.project,
      source: WorkTaskSource.manual,
      estimatedHours: estimatedHours,
      billable: billable,
      timeSpent: 0,
    );

    await _saveTask(task);

    // Update project task count
    await _updateProjectTaskCount(projectId, increment: 1);

    return task;
  }

  /// Update project statistics
  Future<void> updateProjectStats(String projectId) async {
    final project = await getProject(projectId);
    final tasks = await getProjectTasks(projectId);

    final completedTasks = tasks
        .where((t) => t.progress == WorkTaskProgress.completed)
        .length;

    final totalTimeSpent = tasks
        .fold<int>(0, (sum, task) => sum + task.timeSpent);

    final completionPercentage = tasks.isEmpty
        ? 0
        : ((completedTasks / tasks.length) * 100).round();

    final updatedProject = project.copyWith(
      totalTasks: tasks.length,
      completedTasks: completedTasks,
      completionPercentage: completionPercentage,
      updatedAt: DateTime.now(),
    );

    await _saveProject(updatedProject);
  }

  /// Delete a project
  Future<void> deleteProject(String projectId) async {
    final project = await getProject(projectId);

    // Get all project tasks
    final tasks = await getProjectTasks(projectId);

    // Delete or reassign tasks
    for (final task in tasks) {
      if (task.assignedTo != null && task.assignedTo!.isNotEmpty) {
        // Reassign to original user
        await _reassignTask(task.id, task.assignedTo!, task.userId);
      } else {
        // Delete task
        await _deleteTask(task.id);
      }
    }

    // Delete project
    await _deleteProject(projectId);
  }

  /// Get project statistics
  Future<ProjectStats> getProjectStats(String projectId) async {
    final project = await getProject(projectId);
    final tasks = await getProjectTasks(projectId);

    final completedTasks = tasks
        .where((t) => t.progress == WorkTaskProgress.completed)
        .length;

    final overdueTasks = tasks
        .where((t) => t.isOverdue)
        .length;

    final inProgressTasks = tasks
        .where((t) => t.progress == WorkTaskProgress.inProgress)
        .length;

    final totalTimeSpent = tasks
        .fold<int>(0, (sum, task) => sum + task.timeSpent);

    final completedTimeSpent = tasks
        .where((t) => t.progress == WorkTaskProgress.completed)
        .fold<int>(0, (sum, task) => sum + task.timeSpent);

    final totalEstimatedHours = tasks
        .where((t) => t.estimatedHours != null)
        .fold<int>(0, (sum, task) => sum + (task.estimatedHours ?? 0));

    return ProjectStats(
      totalTasks: tasks.length,
      completedTasks: completedTasks,
      overdueTasks: overdueTasks,
      inProgressTasks: inProgressTasks,
      completionPercentage: tasks.isEmpty
          ? 0.0
          : (completedTasks / tasks.length) * 100,
      totalTimeSpent: totalTimeSpent,
      completedTimeSpent: completedTimeSpent,
      estimatedHours: totalEstimatedHours,
      memberCount: project.memberIds.length,
      totalBudget: project.totalBudget,
      spentBudget: project.spentBudget,
    );
  }

  /// Check if project is at risk
  bool isProjectAtRisk(ProjectStats stats, DateTime? dueDate) {
    if (dueDate == null) return false;

    final now = DateTime.now();
    final daysUntilDue = dueDate.difference(now).inDays;

    // At risk if:
    // - Less than 25% complete with less than 25% of time remaining
    // - More than 90% time spent but less than 90% complete
    // - Due within 7 days and less than 50% complete

    if (stats.completionPercentage < 25 && daysUntilDue < (stats.estimatedHours / 8 * 0.25)) {
      return true;
    }

    final timeUsedPercentage = stats.estimatedHours > 0
        ? (stats.completedTimeSpent / stats.estimatedHours) * 100
        : 0;

    if (timeUsedPercentage > 90 && stats.completionPercentage < 90) {
      return true;
    }

    if (daysUntilDue <= 7 && stats.completionPercentage < 50) {
      return true;
    }

    return false;
  }

  // Private methods for database operations

  Future<void> _saveProject(ProjectModel project) async {
    // TODO: Implement Supabase or Hive save
  }

  Future<ProjectModel?> _queryProject(String projectId) async {
    // TODO: Implement Supabase or Hive query
    return null;
  }

  Future<List<ProjectModel>> _queryProjectsByOrganization(String organizationId) async {
    // TODO: Implement Supabase or Hive query
    return [];
  }

  Future<List<ProjectModel>> _queryProjectsByTeam(String teamId) async {
    // TODO: Implement Supabase or Hive query
    return [];
  }

  Future<List<ProjectModel>> _queryProjectsByDepartment(String departmentId) async {
    // TODO: Implement Supabase or Hive query
    return [];
  }

  Future<List<ProjectModel>> _queryProjectsByIds(List<String> projectIds) async {
    // TODO: Implement Supabase or Hive query
    return [];
  }

  Future<List<String>> _queryUserProjectMemberships(String userId) async {
    // TODO: Implement query
    return [];
  }

  Future<List<WorkTaskModel>> _queryProjectTasks(String projectId) async {
    // TODO: Implement Supabase or Hive query
    return [];
  }

  Future<void> _saveTask(WorkTaskModel task) async {
    // TODO: Implement Supabase or Hive save
  }

  Future<void> _deleteTask(String taskId) async {
    // TODO: Implement Supabase or Hive delete
  }

  Future<void> _deleteProject(String projectId) async {
    // TODO: Implement Supabase or Hive delete
  }

  Future<void> _updateProjectTaskCount(String projectId, {required int increment}) async {
    // TODO: Implement task count update
  }

  Future<void> _completeAllProjectTasks(String projectId) async {
    // TODO: Implement task completion
  }

  Future<void> _reassignUserTasks(String projectId, String userId) async {
    // TODO: Implement task reassignment
  }

  Future<void> _reassignTask(String taskId, String fromUserId, String toUserId) async {
    // TODO: Implement task reassignment
  }

  String _generateId() {
    return 'proj_${DateTime.now().millisecondsSinceEpoch}_${_randomString(8)}';
  }

  String _generateTaskId() {
    return 'task_${DateTime.now().millisecondsSinceEpoch}_${_randomString(8)}';
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

/// Project statistics model
class ProjectStats {
  final int totalTasks;
  final int completedTasks;
  final int overdueTasks;
  final int inProgressTasks;
  final double completionPercentage;
  final int totalTimeSpent; // minutes
  final int completedTimeSpent; // minutes
  final int estimatedHours;
  final int memberCount;
  final int totalBudget;
  final int spentBudget;

  const ProjectStats({
    required this.totalTasks,
    required this.completedTasks,
    required this.overdueTasks,
    required this.inProgressTasks,
    required this.completionPercentage,
    required this.totalTimeSpent,
    required this.completedTimeSpent,
    required this.estimatedHours,
    required this.memberCount,
    required this.totalBudget,
    required this.spentBudget,
  });

  /// Get budget usage percentage
  double get budgetUsagePercentage {
    if (totalBudget == 0) return 0.0;
    return (spentBudget / totalBudget) * 100;
  }

  /// Get time usage percentage
  double get timeUsagePercentage {
    if (estimatedHours == 0) return 0.0;
    return (completedTimeSpent / 60 / estimatedHours) * 100;
  }

  /// Check if project is on budget
  bool get isOnBudget => budgetUsagePercentage <= 100;

  /// Check if project is on time
  bool get isOnTime => timeUsagePercentage <= completionPercentage;
}
