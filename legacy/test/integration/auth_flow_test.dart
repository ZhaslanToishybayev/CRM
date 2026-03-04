/// Integration Tests for Authentication Flow

import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/auth/auth_service.dart';

void main() {
  group('Authentication Flow Integration Tests', () {
    late AuthNotifier authNotifier;

    setUp(() async {
      AuthService.debugForceDemoMode = true;
      await AuthService.logout();
      authNotifier = AuthNotifier();
    });

    tearDown(() {
      AuthService.resetForTest();
    });

    test('should complete sign in flow', () async {
      await authNotifier.login('demo@crm.com', 'demo');

      expect(authNotifier.state, isNotNull);
      expect(authNotifier.state!.email, 'demo@crm.com');
    });

    test('should maintain authentication state until sign out', () async {
      await authNotifier.login('demo@crm.com', 'demo');
      expect(authNotifier.state, isNotNull);

      expect(AuthService.isAuthenticated, isTrue);
    });

    test('should handle sign out properly', () async {
      await authNotifier.login('demo@crm.com', 'demo');

      authNotifier.logout();

      expect(authNotifier.state, isNull);
      expect(AuthService.isAuthenticated, isFalse);
    });

    test('should reject invalid credentials', () async {
      await expectLater(
        authNotifier.login('invalid@example.com', 'wrong'),
        throwsException,
      );

      expect(authNotifier.state, isNull);
    });

    test('should allow repeated valid logins after logout', () async {
      await authNotifier.login('demo@crm.com', 'demo');
      authNotifier.logout();
      await authNotifier.login('demo@crm.com', 'demo');

      expect(authNotifier.state, isNotNull);
    });
  });
}
