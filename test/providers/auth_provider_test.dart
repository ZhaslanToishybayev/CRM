import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/auth/auth_service.dart';

void main() {
  group('AuthNotifier state transitions', () {
    late AuthNotifier notifier;

    setUp(() async {
      AuthService.debugForceDemoMode = true;
      await AuthService.logout();
      notifier = AuthNotifier();
    });

    tearDown(() {
      AuthService.resetForTest();
    });

    test('initial state is unauthenticated', () {
      expect(notifier.state, isNull);
    });

    test('successful login updates authenticated user', () async {
      await notifier.login('demo@crm.com', 'demo');

      expect(notifier.state, isNotNull);
      expect(notifier.state!.email, 'demo@crm.com');
      expect(notifier.state!.name, 'Demo User');
    });

    test('failed login keeps state unauthenticated', () async {
      await expectLater(
        notifier.login('wrong@example.com', 'bad-password'),
        throwsException,
      );
      expect(notifier.state, isNull);
    });

    test('logout clears state after successful login', () async {
      await notifier.login('demo@crm.com', 'demo');
      expect(notifier.state, isNotNull);

      notifier.logout();
      expect(notifier.state, isNull);
    });
  });
}
