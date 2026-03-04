/// Project Provider
/// Riverpod provider for managing projects state

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/project_model.dart';
import '../services/project_service.dart';

part 'project_provider.g.dart';

// Project service provider
@riverpod
ProjectService projectService(ProjectServiceRef ref) {
  return ProjectService();
}

/// Provider for projects in an organization
@riverpod
Future<List<ProjectModel>> organizationProjects(
  OrganizationProjectsRef ref,
  String organizationId,
) async {
  final projectService = ref.watch(projectServiceProvider);
  return await projectService.getProjectsByOrganization(organizationId);
}

/// Provider for projects in a team
@riverpod
Future<List<ProjectModel>> teamProjects(
  TeamProjectsRef ref,
  String teamId,
) async {
  final projectService = ref.watch(projectServiceProvider);
  return await projectService.getProjectsByTeam(teamId);
}

/// Provider for projects in a department
@riverpod
Future<List<ProjectModel>> departmentProjects(
  DepartmentProjectsRef ref,
  String departmentId,
) async {
  final projectService = ref.watch(projectServiceProvider);
  return await projectService.getProjectsByDepartment(departmentId);
}

/// Provider for projects of a specific user
@riverpod
Future<List<ProjectModel>> userProjects(
  UserProjectsRef ref,
  String userId,
) async {
  final projectService = ref.watch(projectServiceProvider);
  return await projectService.getUserProjects(userId);
}

/// Provider for a specific project by ID
@riverpod
Future<ProjectModel> project(
  ProjectRef ref,
  String projectId,
) async {
  final projectService = ref.watch(projectServiceProvider);
  return await projectService.getProject(projectId);
}

/// Provider for project statistics
@riverpod
Future<ProjectStats> projectStats(
  ProjectStatsRef ref,
  String projectId,
) async {
  final projectService = ref.watch(projectServiceProvider);
  return await projectService.getProjectStats(projectId);
}

/// Notifier for managing projects
@riverpod
class ProjectNotifier extends _$ProjectNotifier {
  @override
  FutureOr<void> build() {
    // Initial state
  }

  /// Create a new project
  Future<void> createProject({
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
    final projectService = ref.read(projectServiceProvider);
    final project = await projectService.createProject(
      name: name,
      organizationId: organizationId,
      createdBy: createdBy,
      description: description,
      icon: icon,
      color: color,
      teamId: teamId,
      departmentId: departmentId,
      startDate: startDate,
      endDate: endDate,
      dueDate: dueDate,
      priority: priority,
      totalBudget: totalBudget,
      memberIds: memberIds,
    );

    // Invalidate relevant providers to refresh data
    ref.invalidate(organizationProjectsProvider(organizationId));
    if (teamId != null) {
      ref.invalidate(teamProjectsProvider(teamId));
    }
    if (departmentId != null) {
      ref.invalidate(departmentProjectsProvider(departmentId));
    }
    ref.invalidate(userProjectsProvider(createdBy));

    return project;
  }

  /// Update project status
  Future<void> updateProjectStatus({
    required String projectId,
    required ProjectStatus status,
  }) async {
    final projectService = ref.read(projectServiceProvider);
    final project = await projectService.updateProjectStatus(
      projectId: projectId,
      status: status,
    );

    // Invalidate relevant providers
    ref.invalidate(projectProvider(projectId));
    ref.invalidate(projectStatsProvider(projectId));

    return project;
  }

  /// Update project details
  Future<void> updateProject({
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
    final projectService = ref.read(projectServiceProvider);
    final project = await projectService.updateProject(
      projectId: projectId,
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
    );

    // Invalidate relevant providers
    ref.invalidate(projectProvider(projectId));
    ref.invalidate(projectStatsProvider(projectId));

    return project;
  }

  /// Delete a project
  Future<void> deleteProject(String projectId) async {
    final projectService = ref.read(projectServiceProvider);
    await projectService.deleteProject(projectId);

    // Invalidate all project-related providers
    ref.invalidate(projectProvider(projectId));
    ref.invalidate(projectStatsProvider(projectId));
  }

  /// Add member to project
  Future<void> addProjectMember({
    required String projectId,
    required String userId,
  }) async {
    final projectService = ref.read(projectServiceProvider);
    await projectService.addProjectMember(
      projectId: projectId,
      userId: userId,
    );

    // Invalidate relevant providers
    ref.invalidate(projectProvider(projectId));
    ref.invalidate(projectStatsProvider(projectId));
  }

  /// Remove member from project
  Future<void> removeProjectMember({
    required String projectId,
    required String userId,
  }) async {
    final projectService = ref.read(projectServiceProvider);
    await projectService.removeProjectMember(
      projectId: projectId,
      userId: userId,
    );

    // Invalidate relevant providers
    ref.invalidate(projectProvider(projectId));
    ref.invalidate(projectStatsProvider(projectId));
  }
}
