/// Widget Tests for Manager Dashboard
/// Tests the manager dashboard UI

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/features/reports/screens/manager_dashboard_screen.dart';

void main() {
  group('ManagerDashboard Widget Tests', () {
    testWidgets('should display manager dashboard title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ManagerDashboardScreen(
            organizationId: 'org-1',
            departmentId: 'dept-1',
            managerId: 'manager-1',
          ),
        ),
      );

      expect(find.text('Manager Dashboard'), findsOneWidget);
    });

    testWidgets('should display tab bar with 4 tabs', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ManagerDashboardScreen(
            organizationId: 'org-1',
            departmentId: 'dept-1',
            managerId: 'manager-1',
          ),
        ),
      );

      expect(find.text('Overview'), findsOneWidget);
      expect(find.text('Performance'), findsOneWidget);
      expect(find.text('Teams'), findsOneWidget);
      expect(find.text('Analytics'), findsOneWidget);
    });

    testWidgets('should display period selector', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ManagerDashboardScreen(
            organizationId: 'org-1',
            departmentId: 'dept-1',
            managerId: 'manager-1',
          ),
        ),
      );

      expect(find.text('Period:'), findsOneWidget);
    });
  });
}
