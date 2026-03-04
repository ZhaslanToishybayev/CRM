import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:gamified_task_app/auth/auth_service.dart';
import 'package:gamified_task_app/main.dart';

const _email = String.fromEnvironment('E2E_EMAIL', defaultValue: '');
const _password = String.fromEnvironment('E2E_PASSWORD', defaultValue: '');

Future<void> _pumpUntilVisible(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 250));
    if (finder.evaluate().isNotEmpty) return;
  }
  fail('Timed out waiting for $finder');
}

Future<void> _tapWhenVisible(WidgetTester tester, Finder finder) async {
  await _pumpUntilVisible(tester, finder);
  await tester.tap(finder.first);
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'web e2e: supabase login -> create client -> create linked task -> verify',
    (tester) async {
      if (_email.isEmpty || _password.isEmpty) {
        fail(
          'E2E_EMAIL and E2E_PASSWORD are required. '
          'Run with --dart-define=E2E_EMAIL=... --dart-define=E2E_PASSWORD=...',
        );
      }

      AuthService.resetForTest();

      await tester.pumpWidget(const ProviderScope(child: ModernCRMApp()));
      await tester.pumpAndSettle();

      await _pumpUntilVisible(
        tester,
        find.byKey(const Key('login_email_field')),
      );
      await tester.enterText(
        find.byKey(const Key('login_email_field')),
        _email,
      );
      await tester.enterText(
        find.byKey(const Key('login_password_field')),
        _password,
      );
      await tester.tap(find.byKey(const Key('login_submit_button')));
      await tester.pump();

      await _pumpUntilVisible(
        tester,
        find.byKey(const Key('root_layout_scaffold')),
        timeout: const Duration(seconds: 30),
      );

      final suffix = DateTime.now().millisecondsSinceEpoch.toString();
      final firstName = 'E2E$suffix';
      final lastName = 'User';
      final fullName = '$firstName $lastName';
      final clientEmail = 'e2e.$suffix@example.com';
      final taskTitle = 'E2E Task $suffix';

      await _tapWhenVisible(tester, find.byKey(const Key('nav_crm')));
      await _tapWhenVisible(tester, find.byKey(const Key('fab_add_client')));
      await _pumpUntilVisible(
        tester,
        find.byKey(const Key('add_client_sheet')),
      );

      await tester.enterText(
        find.byKey(const Key('client_first_name_field')),
        firstName,
      );
      await tester.enterText(
        find.byKey(const Key('client_last_name_field')),
        lastName,
      );
      await tester.enterText(
        find.byKey(const Key('client_email_field')),
        clientEmail,
      );
      await tester.enterText(
        find.byKey(const Key('client_phone_field')),
        '+77010000000',
      );
      await tester.enterText(
        find.byKey(const Key('client_company_field')),
        'E2E Inc',
      );

      await tester.tap(find.byKey(const Key('client_save_button')));
      await tester.pump();
      await tester.pumpAndSettle();

      await _pumpUntilVisible(
        tester,
        find.text(fullName),
        timeout: const Duration(seconds: 20),
      );

      await _tapWhenVisible(tester, find.byKey(const Key('nav_tasks')));
      await _tapWhenVisible(tester, find.byKey(const Key('fab_add_task')));
      await _pumpUntilVisible(tester, find.byKey(const Key('add_task_sheet')));

      await tester.enterText(
        find.byKey(const Key('task_title_field')),
        taskTitle,
      );
      await tester.enterText(
        find.byKey(const Key('task_description_field')),
        'Created by integration test',
      );

      await tester.tap(find.byKey(const Key('task_client_dropdown')));
      await tester.pumpAndSettle();
      await _tapWhenVisible(tester, find.text(fullName).last);

      await tester.tap(find.byKey(const Key('task_save_button')));
      await tester.pump();
      await tester.pumpAndSettle();

      await _pumpUntilVisible(tester, find.text(taskTitle));
      await _pumpUntilVisible(tester, find.text('Клиент: $fullName'));

      await _tapWhenVisible(tester, find.byKey(const Key('nav_crm')));
      await _tapWhenVisible(tester, find.text(fullName).first);
      await _pumpUntilVisible(
        tester,
        find.byKey(const Key('client_details_sheet')),
      );
      expect(find.text('Связанные задачи'), findsOneWidget);
      expect(find.text(taskTitle), findsOneWidget);
    },
  );
}
