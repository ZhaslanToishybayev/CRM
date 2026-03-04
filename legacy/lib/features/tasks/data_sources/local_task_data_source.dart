/// Local Task Data Source (Hive)
/// Educational Project - Gamified Task Management App
///
/// Concrete implementation of local task storage using Hive for offline storage

import 'package:hive/hive.dart';

import 'task_data_source.dart';
import '../models/task_model.dart';

class LocalTaskDataSourceImpl implements LocalTaskDataSource {
  static const String _boxName = 'tasks';
  late Box<TaskModel> _box;

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<TaskModel>(_boxName);
    } else {
      _box = Hive.box<TaskModel>(_boxName);
    }
  }

  Box<TaskModel> get box {
    if (!_box.isOpen) {
      throw Exception('LocalTaskDataSource not initialized. Call init() first.');
    }
    return _box;
  }

  @override
  List<TaskModel> getTasks() {
    final tasks = box.values.toList();
    tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return tasks;
  }

  @override
  Future<void> saveTasks(List<TaskModel> tasks) async {
    await box.clear();
    for (final task in tasks) {
      await box.put(task.id, task);
    }
  }

  @override
  Future<void> addTask(TaskModel task) async {
    await box.put(task.id, task);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    await box.put(task.id, task);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await box.delete(taskId);
  }

  @override
  List<TaskModel> getTasksByUserId(String userId) {
    return box.values
        .where((task) => task.userId == userId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<void> clearTasks() async {
    await box.clear();
  }
}

/// Adapter for Hive to store TaskModel
class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    return TaskModel(
      id: reader.readString(),
      userId: reader.readString(),
      title: reader.readString(),
      description: reader.readString(),
      xp: reader.readInt(),
      priority: TaskPriority.values[reader.readInt()],
      status: TaskStatus.values[reader.readInt()],
      dueDate: reader.readBool() ? DateTime.fromMillisecondsSinceEpoch(reader.readInt()) : null,
      category: reader.readString(),
      completedAt: reader.readBool() ? DateTime.fromMillisecondsSinceEpoch(reader.readInt()) : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.userId);
    writer.writeString(obj.title);
    writer.writeString(obj.description ?? '');
    writer.writeInt(obj.xp);
    writer.writeInt(obj.priority.index);
    writer.writeInt(obj.status.index);
    writer.writeBool(obj.dueDate != null);
    if (obj.dueDate != null) {
      writer.writeInt(obj.dueDate!.millisecondsSinceEpoch);
    }
    writer.writeString(obj.category ?? '');
    writer.writeBool(obj.completedAt != null);
    if (obj.completedAt != null) {
      writer.writeInt(obj.completedAt!.millisecondsSinceEpoch);
    }
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
    writer.writeInt(obj.updatedAt.millisecondsSinceEpoch);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter && runtimeType == other.runtimeType;
}
