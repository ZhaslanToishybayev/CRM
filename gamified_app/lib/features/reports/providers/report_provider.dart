/// Report Provider
/// Riverpod provider for managing reports state

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/manager_dashboard_model.dart';
import '../models/employee_report_model.dart';
import '../services/analytics_service.dart';
import '../services/pdf_export_service.dart';

part 'report_provider.g.dart';

// Analytics service provider
@riverpod
AnalyticsService analyticsService(AnalyticsServiceRef ref) {
  return AnalyticsService.instance;
}

// PDF export service provider
@riverpod
PDFExportService pdfExportService(PDFExportServiceRef ref) {
  return PDFExportService.instance;
}

/// Provider for manager dashboard
@riverpod
Future<ManagerDashboardModel> managerDashboard(
  ManagerDashboardRef ref,
  String managerId,
  String organizationId,
  String departmentId,
  Period period,
) async {
  final analyticsService = ref.watch(analyticsServiceProvider);

  // Mock data for demonstration
  // In real app, this would call the actual service
  return ManagerDashboardModel(
    managerId: managerId,
    organizationId: organizationId,
    departmentId: departmentId,
    generatedAt: DateTime.now(),
    period: period,
    periodStart: DateTime.now().subtract(Duration(days: 30)),
    periodEnd: DateTime.now(),
    totalTeams: 5,
    activeTeams: 4,
    totalMembers: 28,
    activeMembers: 25,
    totalTasks: 150,
    completedTasks: 120,
    inProgressTasks: 20,
    overdueTasks: 10,
    tasksCompletedToday: 8,
    tasksCompletedThisWeek: 45,
    tasksCompletedThisMonth: 120,
    completionRate: 0.8,
    onTimeRate: 0.92,
    averageQualityRating: 4.2,
    totalXPEarned: 25000,
    averageTaskTime: 2.5,
    topPerformers: [],
    topTeams: [],
    overdueTasksByMember: [],
    lowPerformers: [],
    projectsAtRisk: [],
    productivityTrend: 15.5,
    qualityTrend: 8.2,
    completionTrend: 12.3,
    achievementsUnlocked: 45,
    activeStreaks: 12,
    teamAchievements: [],
  );
}

/// Provider for employee report
@riverpod
Future<EmployeeReportModel> employeeReport(
  EmployeeReportRef ref,
  String userId,
  Period period,
) async {
  final analyticsService = ref.watch(analyticsServiceProvider);

  // Mock data for demonstration
  return EmployeeReportModel(
    userId: userId,
    organizationId: 'org_1',
    departmentId: 'dept_1',
    teamId: 'team_1',
    generatedAt: DateTime.now(),
    period: period,
    periodStart: DateTime.now().subtract(Duration(days: 30)),
    periodEnd: DateTime.now(),
    username: 'john_doe',
    fullName: 'John Doe',
    email: 'john.doe@company.com',
    avatarUrl: null,
    jobTitle: 'Senior Developer',
    hireDate: DateTime(2020, 1, 15),
    currentLevel: 15,
    totalXP: 15000,
    xpEarnedThisPeriod: 2500,
    currentStreak: 7,
    longestStreak: 30,
    tasksCompleted: 45,
    tasksCompletedOnTime: 42,
    tasksCompletedOverdue: 3,
    averageQualityRating: 4.2,
    fiveStarRatings: 15,
    tasksWithoutRevisions: 30,
    managerFeedback: 'Great work this period!',
    completedTasks: [],
    overdueTasks: [],
    upcomingTasks: [],
    tasksByPriority: {},
    tasksByType: {},
    tasksByCategory: {},
    averageTaskTime: 2.5,
    totalTimeSpent: 6750,
    estimatedTime: 7200,
    timeAccuracy: 93.5,
    unlockedAchievements: [],
    nearAchievements: [],
    totalAchievements: 25,
    productivityTrend: 12.5,
    qualityTrend: 7.3,
    xpTrend: 15.8,
    goals: [],
    goalProgress: [],
    recommendations: [],
    strengths: [],
    improvements: [],
  );
}

/// Notifier for PDF exports
@riverpod
class PDFExportNotifier extends _$PDFExportNotifier {
  @override
  FutureOr<void> build() {
    // Initial state
  }

  /// Export manager dashboard to PDF
  Future<String> exportManagerDashboard({
    required ManagerDashboardModel dashboardData,
    required String managerName,
  }) async {
    final exportService = ref.read(pdfExportServiceProvider);
    final exportId = 'export_${DateTime.now().millisecondsSinceEpoch}';

    // Set loading state
    state = const AsyncValue.loading();

    try {
      // Start export
      final filePath = await exportService.exportManagerDashboard(
        dashboardData: dashboardData,
        managerName: managerName,
      );

      // Update state
      state = AsyncValue.data(ExportResult.success(filePath));

      return filePath;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  /// Export employee report to PDF
  Future<String> exportEmployeeReport({
    required EmployeeReportModel reportData,
  }) async {
    final exportService = ref.read(pdfExportServiceProvider);
    final exportId = 'export_${DateTime.now().millisecondsSinceEpoch}';

    // Set loading state
    state = const AsyncValue.loading();

    try {
      final filePath = await exportService.exportEmployeeReport(
        reportData: reportData,
      );

      state = AsyncValue.data(ExportResult.success(filePath));

      return filePath;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  /// Get export history
  Future<List<ExportHistory>> getExportHistory(String userId) async {
    final exportService = ref.read(pdfExportServiceProvider);
    return await exportService.getExportHistory(userId: userId);
  }

  /// Delete export
  Future<void> deleteExport(String exportId) async {
    final exportService = ref.read(pdfExportServiceProvider);
    await exportService.deleteExport(exportId);

    // Refresh history if needed
    ref.invalidate(getExportHistoryProvider);
  }
}

/// Provider for export history
@riverpod
Future<List<ExportHistory>> getExportHistory(
  GetExportHistoryRef ref,
  String userId,
) async {
  final notifier = ref.read(pdfExportNotifierProvider.notifier);
  return await notifier.getExportHistory(userId);
}

/// Export result model
class ExportResult {
  final bool success;
  final String filePath;
  final String? error;

  const ExportResult.success(this.filePath)
      : success = true,
        error = null;

  const ExportResult.failure(this.error)
      : success = false,
        filePath = '';

  bool get isSuccess => success;
  bool get isFailure => !success;
}
