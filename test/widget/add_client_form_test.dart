import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamified_task_app/auth/auth_service.dart';
import 'package:gamified_task_app/main.dart';
import 'package:gamified_task_app/providers_crm.dart';

class InMemoryClientsNotifier extends ClientsNotifier {
  @override
  Future<void> loadClients() async {}

  @override
  Future<void> saveClients() async {}
}

void main() {
  setUpAll(() {
    AuthService.debugForceDemoMode = true;
  });

  tearDownAll(() {
    AuthService.resetForTest();
  });

  testWidgets('create client form saves client (happy path)', (tester) async {
    final container = ProviderContainer(
      overrides: [
        clientsProvider.overrideWith((ref) => InMemoryClientsNotifier()),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: Scaffold(body: AddClientBottomSheet())),
      ),
    );

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'Grace');
    await tester.enterText(fields.at(1), 'Hopper');
    await tester.enterText(fields.at(2), 'grace@example.com');

    final createButton = find.byType(ElevatedButton);
    await tester.ensureVisible(createButton);
    await tester.pumpAndSettle();
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    final clients = container.read(clientsProvider);
    expect(clients, hasLength(1));
    expect(clients.first.firstName, 'Grace');
    expect(clients.first.lastName, 'Hopper');
    expect(clients.first.email, 'grace@example.com');
  });
}
