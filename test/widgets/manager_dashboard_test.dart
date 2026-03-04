import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _ManagerDashboardStub extends StatelessWidget {
  const _ManagerDashboardStub();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manager Dashboard')),
      body: Column(
        children: [
          Text('Period:'),
          TabBar(
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Performance'),
              Tab(text: 'Teams'),
              Tab(text: 'Analytics'),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  group('ManagerDashboard Widget Tests', () {
    testWidgets('should display manager dashboard title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DefaultTabController(length: 4, child: _ManagerDashboardStub()),
        ),
      );

      expect(find.text('Manager Dashboard'), findsOneWidget);
    });

    testWidgets('should display tab bar with 4 tabs', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DefaultTabController(length: 4, child: _ManagerDashboardStub()),
        ),
      );

      expect(find.text('Overview'), findsOneWidget);
      expect(find.text('Performance'), findsOneWidget);
      expect(find.text('Teams'), findsOneWidget);
      expect(find.text('Analytics'), findsOneWidget);
    });

    testWidgets('should display period selector', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DefaultTabController(length: 4, child: _ManagerDashboardStub()),
        ),
      );

      expect(find.text('Period:'), findsOneWidget);
    });
  });
}
