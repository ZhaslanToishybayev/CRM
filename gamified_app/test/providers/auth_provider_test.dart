import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/features/auth/providers/auth_provider.dart';

import '../helpers/fake_auth_repository.dart';

void main() {
  group('AuthProvider Tests', () {
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

    test('starts unauthenticated', () {
      expect(container.read(authStateProvider), isNull);
      expect(container.read(isAuthenticatedProvider), isFalse);
    });

    test('updates state after sign in', () async {
      final notifier = container.read(authStateNotifierProvider.notifier);

      await notifier.signIn(
        email: 'user@example.com',
        password: 'Password123!',
      );

      expect(container.read(isAuthenticatedProvider), isTrue);
      expect(container.read(authStateProvider)?.email, 'user@example.com');
    });

    test('clears state on sign out', () async {
      final notifier = container.read(authStateNotifierProvider.notifier);

      await notifier.signIn(
        email: 'user@example.com',
        password: 'Password123!',
      );
      await notifier.signOut();

      expect(container.read(authStateProvider), isNull);
      expect(container.read(isAuthenticatedProvider), isFalse);
    });
  });
}
