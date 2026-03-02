import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/features/auth/models/corporate_user_model.dart';
import 'package:gamified_task_app/features/reports/services/analytics_service.dart';

void main() {
  group('AnalyticsService Tests', () {
    late AnalyticsService analyticsService;

    setUp(() {
      analyticsService = AnalyticsService.instance;
    });

    test('creates singleton instance', () {
      expect(AnalyticsService.instance, same(analyticsService));
    });

    test('generates manager dashboard with expected ids', () async {
      final dashboard = await analyticsService.generateManagerDashboard(
        managerId: 'manager-1',
        organizationId: 'org-1',
        departmentId: 'dept-1',
        teams: const [],
        teamMembers: const {},
        teamTasks: const {},
        users: const [],
        period: Period.monthly,
      );

      expect(dashboard.managerId, 'manager-1');
      expect(dashboard.organizationId, 'org-1');
      expect(dashboard.departmentId, 'dept-1');
      expect(dashboard.period, Period.monthly);
    });

    test('generates employee report with empty tasks', () async {
      final user = CorporateUserModel(
        id: 'user-1',
        email: 'user-1@example.com',
        username: 'user-1',
        totalXP: 120,
        currentLevel: 2,
        streakCount: 3,
        organizationId: 'org-1',
        departmentId: 'dept-1',
        teamId: 'team-1',
      );

      final report = await analyticsService.generateEmployeeReport(
        userId: user.id,
        user: user,
        userTasks: const [],
        period: Period.monthly,
      );

      expect(report.userId, user.id);
      expect(report.email, user.email);
      expect(report.tasksCompleted, 0);
    });
  });
}
