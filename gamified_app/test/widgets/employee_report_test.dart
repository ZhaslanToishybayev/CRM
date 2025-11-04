/// Widget Tests for Employee Report
/// Tests the employee report UI

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/features/reports/screens/employee_report_screen.dart';

void main() {
  group('EmployeeReport Widget Tests', () {
    testWidgets('should display employee report title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EmployeeReportScreen(userId: 'user-1'),
        ),
      );

      expect(find.text('My Report'), findsOneWidget);
    });

    testWidgets('should display tab bar with 3 tabs', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EmployeeReportScreen(userId: 'user-1'),
        ),
      );

      expect(find.text('Overview'), findsOneWidget);
      expect(find.text('Tasks'), findsOneWidget);
      expect(find.text('Goals'), findsOneWidget);
    });

    testWidgets('should display export button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: EmployeeReportScreen(userId: 'user-1'),
        ),
      );

      expect(find.byIcon(Icons.download), findsOneWidget);
    });
  });
}
