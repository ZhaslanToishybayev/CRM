import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/auth/auth_service.dart';
import 'package:hive/hive.dart';
import 'package:gamified_task_app/providers.dart';

Task _task(String id, {bool completed = false}) {
  return Task(
    id: id,
    title: 'Task $id',
    createdAt: DateTime.now(),
    isCompleted: completed,
  );
}

void main() {
  late Directory hiveTempDir;

  setUpAll(() async {
    hiveTempDir = await Directory.systemTemp.createTemp('tasks_notifier_test_');
    Hive.init(hiveTempDir.path);
    AuthService.debugForceDemoMode = true;
  });

  tearDownAll(() async {
    AuthService.resetForTest();
    await Hive.close();
    if (hiveTempDir.existsSync()) {
      await hiveTempDir.delete(recursive: true);
    }
  });

  group('TasksNotifier real behavior', () {
    test('toggleComplete should toggle both directions', () async {
      final notifier = TasksNotifier();
      await notifier.addTask(_task('1', completed: false));

      expect(notifier.state.first.isCompleted, isFalse);
      await notifier.toggleComplete(0);
      expect(notifier.state.first.isCompleted, isTrue);
      await notifier.toggleComplete(0);
      expect(notifier.state.first.isCompleted, isFalse);
    });

    test('clearCompleted should remove completed tasks only', () async {
      final notifier = TasksNotifier();
      await notifier.addTask(_task('1', completed: false));
      await notifier.addTask(_task('2', completed: true));
      await notifier.addTask(_task('3', completed: false));

      await notifier.clearCompleted();

      expect(notifier.state.length, 2);
      expect(notifier.state.any((task) => task.isCompleted), isFalse);
    });

    test('replaceTasks should restore exact snapshot', () async {
      final notifier = TasksNotifier();
      final snapshot = [
        _task('1', completed: true),
        _task('2', completed: false),
      ];

      await notifier.replaceTasks(snapshot);

      expect(notifier.state.length, 2);
      expect(notifier.state[0].id, '1');
      expect(notifier.state[0].isCompleted, isTrue);
      expect(notifier.state[1].id, '2');
      expect(notifier.state[1].isCompleted, isFalse);
    });

    test('out-of-range operations should not throw', () async {
      final notifier = TasksNotifier();
      await notifier.addTask(_task('1', completed: false));

      await expectLater(notifier.updateTask(99, _task('2')), completes);
      await expectLater(notifier.deleteTask(99), completes);
      await expectLater(notifier.toggleComplete(99), completes);
      expect(notifier.state.length, 1);
      expect(notifier.state.first.id, '1');
    });
  });
}
