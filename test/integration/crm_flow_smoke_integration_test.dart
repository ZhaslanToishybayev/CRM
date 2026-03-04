import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamified_task_app/auth/auth_service.dart';
import 'package:gamified_task_app/main.dart';
import 'package:gamified_task_app/providers.dart';
import 'package:gamified_task_app/providers_crm.dart';

class _InMemoryTasksNotifier extends TasksNotifier {
  @override
  Future<void> loadTasks() async {}

  @override
  Future<void> saveTasks() async {}
}

class _InMemoryClientsNotifier extends ClientsNotifier {
  @override
  Future<void> loadClients() async {}

  @override
  Future<void> saveClients() async {}
}

class _InMemoryUserStatsNotifier extends UserStatsNotifier {
  @override
  Future<void> loadUserStats() async {}

  @override
  Future<void> saveUserStats() async {}
}

void main() {
  setUpAll(() {
    AuthService.debugForceDemoMode = true;
  });

  tearDownAll(() {
    AuthService.resetForTest();
  });

  testWidgets(
    'integration smoke: create client -> create linked task -> verify in task/client views',
    (tester) async {
      final container = ProviderContainer(
        overrides: [
          tasksProvider.overrideWith((ref) => _InMemoryTasksNotifier()),
          clientsProvider.overrideWith((ref) => _InMemoryClientsNotifier()),
          userStatsProvider.overrideWith((ref) => _InMemoryUserStatsNotifier()),
        ],
      );
      addTearDown(container.dispose);

      final client = Client(
        id: 'client-int-1',
        firstName: 'Grace',
        lastName: 'Hopper',
        email: 'grace.hopper@example.com',
        status: ClientStatus.active,
        source: ClientSource.referral,
        createdAt: DateTime(2026, 3, 4),
      );

      await container.read(clientsProvider.notifier).addClient(client);
      await container.read(tasksProvider.notifier).addTask(
        Task(
          id: 'task-int-1',
          title: 'Prepare contract draft',
          description: 'Attach commercial terms and timeline',
          priority: TaskPriority.high,
          category: 'Work',
          clientId: client.id,
          createdAt: DateTime(2026, 3, 4),
        ),
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: TasksPage()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Prepare contract draft'), findsOneWidget);
      expect(find.text('Клиент: Grace Hopper'), findsOneWidget);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: Scaffold(body: ClientDetailsBottomSheet(client: client)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Связанные задачи'), findsOneWidget);
      expect(find.text('Prepare contract draft'), findsOneWidget);
    },
  );
}
