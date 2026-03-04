import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Mock task provider for testing
final taskProviderMock = StateNotifierProvider<TaskNotifierMock, AsyncValue<List<TaskMock>>>(
  (ref) => TaskNotifierMock(),
);

class TaskMock {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;

  const TaskMock({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.createdAt,
  });
}

class TaskNotifierMock extends StateNotifier<AsyncValue<List<TaskMock>>> {
  TaskNotifierMock() : super(const AsyncValue.loading());

  static int _idCounter = 0;

  String _nextId() {
    _idCounter += 1;
    return 'task-$_idCounter';
  }

  Future<void> loadTasks() async {
    state = const AsyncValue.data([]);
  }

  Future<void> addTask(String title) async {
    final currentTasks = state.value ?? [];
    final newTask = TaskMock(
      id: _nextId(),
      title: title,
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    state = AsyncValue.data([...currentTasks, newTask]);
  }

  Future<void> toggleTask(String id) async {
    final currentTasks = state.value ?? [];
    final updatedTasks = currentTasks.map((task) {
      if (task.id == id) {
        return TaskMock(
          id: task.id,
          title: task.title,
          isCompleted: !task.isCompleted,
          createdAt: task.createdAt,
        );
      }
      return task;
    }).toList();
    state = AsyncValue.data(updatedTasks);
  }

  Future<void> deleteTask(String id) async {
    final currentTasks = state.value ?? [];
    final updatedTasks = currentTasks.where((task) => task.id != id).toList();
    state = AsyncValue.data(updatedTasks);
  }

  Future<void> clearCompleted() async {
    final currentTasks = state.value ?? [];
    final activeTasks = currentTasks.where((task) => !task.isCompleted).toList();
    state = AsyncValue.data(activeTasks);
  }
}

void main() {
  group('TaskProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should initialize with loading state', () {
      final notifier = container.read(taskProviderMock.notifier);
      expect(notifier.state, isA<AsyncLoading<List<TaskMock>>>());
    });

    test('should load empty list of tasks', () async {
      final notifier = container.read(taskProviderMock.notifier);
      await notifier.loadTasks();

      expect(notifier.state.value, isEmpty);
      expect(notifier.state.value, equals([]));
    });

    test('should add a task', () async {
      final notifier = container.read(taskProviderMock.notifier);
      await notifier.loadTasks();

      expect(notifier.state.value, isEmpty);

      await notifier.addTask('Test Task');

      expect(notifier.state.value, hasLength(1));
      expect(notifier.state.value?.first.title, 'Test Task');
      expect(notifier.state.value?.first.isCompleted, false);
    });

    test('should toggle task completion', () async {
      final notifier = container.read(taskProviderMock.notifier);
      await notifier.addTask('Test Task');

      final task = notifier.state.value?.first;
      expect(task?.isCompleted, false);

      await notifier.toggleTask(task!.id);

      final updatedTask = notifier.state.value?.first;
      expect(updatedTask?.isCompleted, true);

      await notifier.toggleTask(task.id);

      final toggledBackTask = notifier.state.value?.first;
      expect(toggledBackTask?.isCompleted, false);
    });

    test('should delete a task', () async {
      final notifier = container.read(taskProviderMock.notifier);
      await notifier.addTask('Task 1');
      await notifier.addTask('Task 2');
      await notifier.addTask('Task 3');

      expect(notifier.state.value, hasLength(3));

      final taskToDelete = notifier.state.value![1];
      await notifier.deleteTask(taskToDelete.id);

      expect(notifier.state.value, hasLength(2));
      expect(notifier.state.value?.any((task) => task.id == taskToDelete.id), false);
    });

    test('should clear completed tasks', () async {
      final notifier = container.read(taskProviderMock.notifier);
      await notifier.addTask('Task 1');
      await notifier.addTask('Task 2');
      await notifier.addTask('Task 3');

      // Toggle middle task as completed
      final taskToComplete = notifier.state.value![1];
      await notifier.toggleTask(taskToComplete.id);

      // Toggle another task as completed
      final anotherTask = notifier.state.value![2];
      await notifier.toggleTask(anotherTask.id);

      expect(notifier.state.value?.where((task) => task.isCompleted).length, 2);

      await notifier.clearCompleted();

      expect(notifier.state.value, hasLength(1));
      expect(notifier.state.value?.first.isCompleted, false);
      expect(notifier.state.value?.first.title, 'Task 1');
    });

    test('should calculate completed task count', () async {
      final notifier = container.read(taskProviderMock.notifier);
      await notifier.addTask('Task 1');
      await notifier.addTask('Task 2');
      await notifier.addTask('Task 3');

      final task2 = notifier.state.value![1];
      await notifier.toggleTask(task2.id);

      final completedCount = notifier.state.value?.where((task) => task.isCompleted).length ?? 0;
      expect(completedCount, 1);
    });

    test('should calculate active task count', () async {
      final notifier = container.read(taskProviderMock.notifier);
      await notifier.addTask('Task 1');
      await notifier.addTask('Task 2');
      await notifier.addTask('Task 3');

      final task1 = notifier.state.value![0];
      final task2 = notifier.state.value![1];
      await notifier.toggleTask(task1.id);
      await notifier.toggleTask(task2.id);

      final activeCount = notifier.state.value?.where((task) => !task.isCompleted).length ?? 0;
      expect(activeCount, 1);
    });

    test('should maintain task order', () async {
      final notifier = container.read(taskProviderMock.notifier);
      await notifier.addTask('First Task');
      await notifier.addTask('Second Task');
      await notifier.addTask('Third Task');

      final tasks = notifier.state.value!;
      expect(tasks[0].title, 'First Task');
      expect(tasks[1].title, 'Second Task');
      expect(tasks[2].title, 'Third Task');

      // Delete middle task
      await notifier.deleteTask(tasks[1].id);

      final remainingTasks = notifier.state.value!;
      expect(remainingTasks[0].title, 'First Task');
      expect(remainingTasks[1].title, 'Third Task');
    });

    test('should generate unique IDs', () async {
      final notifier = container.read(taskProviderMock.notifier);
      await notifier.addTask('Task 1');
      await notifier.addTask('Task 2');

      final tasks = notifier.state.value!;
      expect(tasks[0].id, isNot(equals(tasks[1].id)));
    });

    test('should handle multiple add operations', () async {
      final notifier = container.read(taskProviderMock.notifier);

      for (int i = 1; i <= 10; i++) {
        await notifier.addTask('Task $i');
      }

      expect(notifier.state.value, hasLength(10));

      for (int i = 0; i < 10; i++) {
        expect(notifier.state.value?[i].title, 'Task ${i + 1}');
      }
    });

    test('should handle delete non-existent task gracefully', () async {
      final notifier = container.read(taskProviderMock.notifier);
      await notifier.addTask('Task 1');

      expect(notifier.state.value, hasLength(1));

      // Try to delete non-existent task
      await notifier.deleteTask('non-existent-id');

      expect(notifier.state.value, hasLength(1));
    });

    test('should handle toggle non-existent task gracefully', () async {
      final notifier = container.read(taskProviderMock.notifier);
      await notifier.addTask('Task 1');

      expect(notifier.state.value?[0].isCompleted, false);

      // Try to toggle non-existent task
      await notifier.toggleTask('non-existent-id');

      expect(notifier.state.value?[0].isCompleted, false);
    });
  });
}
