import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/features/auth/providers/auth_provider.dart';

import '../helpers/fake_auth_repository.dart';

void main() {
  group('Authentication Flow Integration Tests', () {
    late ProviderContainer container;
    late FakeAuthRepository fakeAuthRepository;

    setUp(() {
      fakeAuthRepository = FakeAuthRepository();
      container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWith((ref) => fakeAuthRepository),
        ],
      );
    });

    tearDown(() {
      fakeAuthRepository.dispose();
      container.dispose();
    });

    test('completes sign up -> authenticated', () async {
      final notifier = container.read(authStateNotifierProvider.notifier);

      await notifier.signUp(
        email: 'new.user@example.com',
        password: 'Password123!',
        username: 'new.user',
      );

      expect(container.read(isAuthenticatedProvider), isTrue);
      expect(container.read(authStateProvider)?.username, 'new.user');
    });

    test('supports sign in and sign out flow', () async {
      final notifier = container.read(authStateNotifierProvider.notifier);

      await notifier.signIn(
        email: 'user@example.com',
        password: 'Password123!',
      );
      expect(container.read(isAuthenticatedProvider), isTrue);

      await notifier.signOut();
      expect(container.read(isAuthenticatedProvider), isFalse);
    });

    test('delegates reset password to repository', () async {
      final notifier = container.read(authStateNotifierProvider.notifier);
      await notifier.resetPassword('user@example.com');
      expect(fakeAuthRepository.lastResetPasswordEmail, 'user@example.com');
    });
  });
}
