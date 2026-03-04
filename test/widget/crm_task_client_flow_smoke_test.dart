import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamified_task_app/auth/auth_service.dart';
import 'package:gamified_task_app/main.dart';
import 'package:gamified_task_app/providers.dart';
import 'package:gamified_task_app/providers_crm.dart';

class InMemoryTasksNotifier extends TasksNotifier {
  @override
  Future<void> loadTasks() async {}

  @override
  Future<void> saveTasks() async {}
}

class InMemoryClientsNotifier extends ClientsNotifier {
  @override
  Future<void> loadClients() async {}

  @override
  Future<void> saveClients() async {}
}

class InMemoryUserStatsNotifier extends UserStatsNotifier {
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
    'smoke flow: create client -> create linked task -> visible in task list and client details',
    (tester) async {
      final container = ProviderContainer(
        overrides: [
          tasksProvider.overrideWith((ref) => InMemoryTasksNotifier()),
          clientsProvider.overrideWith((ref) => InMemoryClientsNotifier()),
          userStatsProvider.overrideWith((ref) => InMemoryUserStatsNotifier()),
        ],
      );
      addTearDown(container.dispose);

      final client = Client(
        id: 'client-1',
        firstName: 'Ada',
        lastName: 'Lovelace',
        email: 'ada@example.com',
        status: ClientStatus.active,
        source: ClientSource.referral,
        createdAt: DateTime(2026, 3, 4),
      );

      await container.read(clientsProvider.notifier).addClient(client);
      await container
          .read(tasksProvider.notifier)
          .addTask(
            Task(
              id: 'task-1',
              title: 'Prepare proposal',
              description: 'Follow-up with pricing details',
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

      expect(find.text('Prepare proposal'), findsOneWidget);
      expect(find.text('Клиент: Ada Lovelace'), findsOneWidget);

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
      expect(find.text('Prepare proposal'), findsOneWidget);
    },
  );

  testWidgets(
    'negative flow: no-client task is not shown in client linked tasks section',
    (tester) async {
      final container = ProviderContainer(
        overrides: [
          tasksProvider.overrideWith((ref) => InMemoryTasksNotifier()),
          clientsProvider.overrideWith((ref) => InMemoryClientsNotifier()),
          userStatsProvider.overrideWith((ref) => InMemoryUserStatsNotifier()),
        ],
      );
      addTearDown(container.dispose);

      final client = Client(
        id: 'client-2',
        firstName: 'Grace',
        lastName: 'Hopper',
        email: 'grace@example.com',
        status: ClientStatus.active,
        source: ClientSource.website,
        createdAt: DateTime(2026, 3, 4),
      );

      await container.read(clientsProvider.notifier).addClient(client);
      await container
          .read(tasksProvider.notifier)
          .addTask(
            Task(
              id: 'task-linked',
              title: 'Linked follow-up',
              description: 'Visible in linked tasks',
              priority: TaskPriority.medium,
              category: 'Work',
              clientId: client.id,
              createdAt: DateTime(2026, 3, 4),
            ),
          );
      await container
          .read(tasksProvider.notifier)
          .addTask(
            Task(
              id: 'task-no-client',
              title: 'General backlog task',
              description: 'No client assigned',
              priority: TaskPriority.low,
              category: 'General',
              clientId: null,
              createdAt: DateTime(2026, 3, 4),
            ),
          );

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
      expect(find.text('Linked follow-up'), findsOneWidget);
      expect(find.text('General backlog task'), findsNothing);
    },
  );
}
