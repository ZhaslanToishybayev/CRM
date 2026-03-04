import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/providers.dart';

void main() {
  test('Task keeps clientId through copyWith and json mapping', () {
    final original = Task(
      id: 'task-1',
      title: 'Call customer',
      clientId: 'client-42',
      createdAt: DateTime(2026, 3, 4),
    );

    final copied = original.copyWith(title: 'Call VIP customer');
    expect(copied.clientId, 'client-42');

    final restored = Task.fromJson(original.toJson());
    expect(restored.clientId, 'client-42');
  });

  test('Task supports explicit no-client tasks', () {
    final task = Task(
      id: 'task-2',
      title: 'General planning',
      clientId: null,
      createdAt: DateTime(2026, 3, 4),
    );

    expect(task.clientId, isNull);

    final restored = Task.fromJson(task.toJson());
    expect(restored.clientId, isNull);
  });
}
