import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/auth/auth_service.dart';
import 'package:hive/hive.dart';
import 'package:gamified_task_app/providers_crm.dart';

Client _client(String id) {
  return Client(
    id: id,
    firstName: 'Client',
    lastName: id,
    email: 'client$id@example.com',
    createdAt: DateTime.now(),
  );
}

void main() {
  late Directory hiveTempDir;

  setUpAll(() async {
    hiveTempDir = await Directory.systemTemp.createTemp(
      'clients_notifier_test_',
    );
    Hive.init(hiveTempDir.path);
    AuthService.debugForceDemoMode = true;
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ClientAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ClientStatusAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(ClientSourceAdapter());
    }
  });

  tearDownAll(() async {
    AuthService.resetForTest();
    await Hive.close();
    if (hiveTempDir.existsSync()) {
      await hiveTempDir.delete(recursive: true);
    }
  });

  group('ClientsNotifier real behavior', () {
    test('replaceClients should restore exact snapshot', () async {
      final notifier = ClientsNotifier();
      final snapshot = [_client('1'), _client('2')];

      await notifier.replaceClients(snapshot);

      expect(notifier.state.length, 2);
      expect(notifier.state[0].id, '1');
      expect(notifier.state[1].id, '2');
    });

    test('out-of-range operations should not throw', () async {
      final notifier = ClientsNotifier();
      await notifier.addClient(_client('1'));

      await expectLater(notifier.updateClient(99, _client('2')), completes);
      await expectLater(notifier.deleteClient(99), completes);
      expect(notifier.state.length, 1);
      expect(notifier.state.first.id, '1');
    });
  });
}
