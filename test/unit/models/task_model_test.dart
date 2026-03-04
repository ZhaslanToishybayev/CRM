import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model_test.freezed.dart';
part 'task_model_test.g.dart';

enum TaskPriority { low, medium, high, urgent, critical }

enum TaskStatus { pending, inProgress, completed, cancelled }

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String title,
    String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
    required TaskPriority priority,
    required TaskStatus status,
    DateTime? dueDate,
    @Default([]) List<String> subtasks,
    @Default(0) int xpEarned,
    @Default(false) bool isCompleted,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}

void main() {
  group('TaskModel', () {
    test('should create task with required fields', () {
      final task = TaskModel(
        id: '1',
        title: 'Test Task',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        priority: TaskPriority.high,
        status: TaskStatus.pending,
      );

      expect(task.id, '1');
      expect(task.title, 'Test Task');
      expect(task.priority, TaskPriority.high);
      expect(task.status, TaskStatus.pending);
      expect(task.xpEarned, 0);
      expect(task.isCompleted, false);
    });

    test('should handle description', () {
      final task = TaskModel(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        priority: TaskPriority.medium,
        status: TaskStatus.pending,
      );

      expect(task.description, 'Test Description');
    });

    test('should handle due date', () {
      final dueDate = DateTime.now().add(const Duration(days: 1));
      final task = TaskModel(
        id: '1',
        title: 'Test Task',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        priority: TaskPriority.urgent,
        status: TaskStatus.pending,
        dueDate: dueDate,
      );

      expect(task.dueDate, dueDate);
    });

    test('should handle subtasks', () {
      final task = TaskModel(
        id: '1',
        title: 'Test Task',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        priority: TaskPriority.low,
        status: TaskStatus.pending,
        subtasks: ['Subtask 1', 'Subtask 2', 'Subtask 3'],
      );

      expect(task.subtasks, hasLength(3));
      expect(task.subtasks.first, 'Subtask 1');
    });

    test('should handle XP earned', () {
      final task = TaskModel(
        id: '1',
        title: 'Test Task',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        priority: TaskPriority.critical,
        status: TaskStatus.completed,
        xpEarned: 100,
        isCompleted: true,
      );

      expect(task.xpEarned, 100);
      expect(task.isCompleted, true);
      expect(task.status, TaskStatus.completed);
    });

    test('should convert to JSON and from JSON', () {
      final task = TaskModel(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        createdAt: DateTime(2025, 1, 1),
        updatedAt: DateTime(2025, 1, 2),
        priority: TaskPriority.high,
        status: TaskStatus.inProgress,
        subtasks: ['Subtask 1'],
        xpEarned: 50,
        isCompleted: false,
      );

      final json = task.toJson();
      final restoredTask = TaskModel.fromJson(json);

      expect(restoredTask.id, task.id);
      expect(restoredTask.title, task.title);
      expect(restoredTask.description, task.description);
      expect(restoredTask.priority, task.priority);
      expect(restoredTask.status, task.status);
      expect(restoredTask.subtasks, task.subtasks);
      expect(restoredTask.xpEarned, task.xpEarned);
      expect(restoredTask.isCompleted, task.isCompleted);
    });

    test('should compare tasks by priority', () {
      final lowTask = TaskModel(
        id: '1',
        title: 'Low Priority',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        priority: TaskPriority.low,
        status: TaskStatus.pending,
      );

      final highTask = TaskModel(
        id: '2',
        title: 'High Priority',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        priority: TaskPriority.high,
        status: TaskStatus.pending,
      );

      expect(lowTask.priority.index, lessThan(highTask.priority.index));
    });

    test('should handle empty subtasks list', () {
      final task = TaskModel(
        id: '1',
        title: 'Test Task',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        priority: TaskPriority.medium,
        status: TaskStatus.pending,
      );

      expect(task.subtasks, isEmpty);
      expect(task.subtasks, equals([]));
    });
  });
}
