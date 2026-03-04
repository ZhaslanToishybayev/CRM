import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _EmployeeReportStub extends StatelessWidget {
  const _EmployeeReportStub();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Report')),
      body: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Tasks'),
              Tab(text: 'Goals'),
            ],
          ),
          Icon(Icons.download),
        ],
      ),
    );
  }
}

void main() {
  group('EmployeeReport Widget Tests', () {
    testWidgets('should display employee report title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DefaultTabController(length: 3, child: _EmployeeReportStub()),
        ),
      );

      expect(find.text('My Report'), findsOneWidget);
    });

    testWidgets('should display tab bar with 3 tabs', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DefaultTabController(length: 3, child: _EmployeeReportStub()),
        ),
      );

      expect(find.text('Overview'), findsOneWidget);
      expect(find.text('Tasks'), findsOneWidget);
      expect(find.text('Goals'), findsOneWidget);
    });

    testWidgets('should display export button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DefaultTabController(length: 3, child: _EmployeeReportStub()),
        ),
      );

      expect(find.byIcon(Icons.download), findsOneWidget);
    });
  });
}
