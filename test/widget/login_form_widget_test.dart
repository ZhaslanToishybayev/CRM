import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/auth/auth_service.dart';
import 'package:gamified_task_app/auth/login_screen.dart';

void main() {
  setUpAll(() {
    AuthService.debugForceDemoMode = true;
  });

  tearDownAll(() {
    AuthService.resetForTest();
  });

  testWidgets('login form validates empty fields', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: LoginScreen())),
    );

    final emailField = find.byType(TextFormField).at(0);
    final passwordField = find.byType(TextFormField).at(1);

    await tester.enterText(emailField, '');
    await tester.enterText(passwordField, '');
    await tester.tap(find.text('Войти'));
    await tester.pumpAndSettle();

    expect(find.text('Введите email'), findsOneWidget);
  });

  testWidgets('login form shows error on invalid credentials', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: LoginScreen())),
    );

    final emailField = find.byType(TextFormField).at(0);
    final passwordField = find.byType(TextFormField).at(1);

    await tester.enterText(emailField, 'bad@example.com');
    await tester.enterText(passwordField, 'wrong');
    await tester.tap(find.text('Войти'));

    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    expect(find.textContaining('Неверный email или пароль'), findsOneWidget);
  });

  testWidgets('registration mode validates full name', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: LoginScreen())),
    );

    await tester.tap(find.byKey(const Key('auth_mode_toggle_button')));
    await tester.pumpAndSettle();

    expect(find.text('Регистрация'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('signup_full_name_field')), '');
    await tester.enterText(
      find.byKey(const Key('login_email_field')),
      'new.user@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('login_password_field')),
      '123456',
    );

    await tester.tap(find.text('Создать аккаунт'));
    await tester.pumpAndSettle();

    expect(find.text('Введите имя'), findsOneWidget);
  });
}
