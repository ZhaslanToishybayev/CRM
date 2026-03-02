/// Supabase Task Data Source
/// Educational Project - Gamified Task Management App
///
/// Concrete implementation of TaskDataSource using Supabase

import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/database/supabase_config.dart';
import '../models/task_model.dart';
import 'task_data_source.dart';

class SupabaseTaskDataSource implements TaskDataSource {
  final _client = SupabaseConfig.client;

  @override
  Future<List<TaskModel>> getTasks() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final schema = await _resolveTaskSchema();

    final response = await _client
        .from(schema.table)
        .select()
        .eq(schema.userIdColumn, user.id)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response)
        .map((json) => _mapFromJson(json))
        .toList();
  }

  @override
  Future<TaskModel?> getTaskById(String taskId) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final schema = await _resolveTaskSchema();

    final response = await _client
        .from(schema.table)
        .select()
        .eq('id', taskId)
        .eq(schema.userIdColumn, user.id)
        .maybeSingle();

    if (response == null) return null;

    return _mapFromJson(response);
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final schema = await _resolveTaskSchema();
    final taskData = _mapToJson(
      task,
      table: schema.table,
      forCreate: true,
      userId: user.id,
    );

    final response = await _client
        .from(schema.table)
        .insert(taskData)
        .select()
        .single();

    return _mapFromJson(response);
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final schema = await _resolveTaskSchema();
    final taskData = _mapToJson(
      task,
      table: schema.table,
      forCreate: false,
      userId: user.id,
    );
    taskData['updated_at'] = DateTime.now().toIso8601String();

    final response = await _client
        .from(schema.table)
        .update(taskData)
        .eq('id', task.id)
        .eq(schema.userIdColumn, user.id)
        .select()
        .single();

    return _mapFromJson(response);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final schema = await _resolveTaskSchema();

    await _client
        .from(schema.table)
        .delete()
        .eq('id', taskId)
        .eq(schema.userIdColumn, user.id);
  }

  @override
  Future<TaskModel> completeTask(String taskId) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final schema = await _resolveTaskSchema();
    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
      'is_completed': true,
    };
    if (schema.table == 'work_tasks') {
      updates['status'] = 'completed';
      updates['completed_at'] = DateTime.now().toIso8601String();
    }

    final response = await _client
        .from(schema.table)
        .update(updates)
        .eq('id', taskId)
        .eq(schema.userIdColumn, user.id)
        .select()
        .single();

    return _mapFromJson(response);
  }

  @override
  Stream<List<TaskModel>> watchTasks() {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    final controller = StreamController<List<TaskModel>>.broadcast();
    RealtimeChannel? channel;

    _resolveTaskSchema().then((schema) {
      channel = _client.channel('${schema.table}:${user.id}');

      // Send initial data
      getTasks().then(controller.add).catchError(controller.addError);

      void refresh() {
        getTasks().then(controller.add).catchError(controller.addError);
      }

      channel!.onPostgresChanges(
        event: PostgresChangeEvent.insert,
        schema: 'public',
        table: schema.table,
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: schema.userIdColumn,
          value: user.id,
        ),
        callback: (_) => refresh(),
      );

      channel!.onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: schema.table,
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: schema.userIdColumn,
          value: user.id,
        ),
        callback: (_) => refresh(),
      );

      channel!.onPostgresChanges(
        event: PostgresChangeEvent.delete,
        schema: 'public',
        table: schema.table,
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: schema.userIdColumn,
          value: user.id,
        ),
        callback: (_) => refresh(),
      );

      channel!.subscribe();
    }).catchError((Object error, StackTrace stackTrace) {
      controller.addError(error, stackTrace);
    });

    controller.onCancel = () async {
      if (channel != null) {
        await _client.removeChannel(channel!);
      }
    };

    return controller.stream;
  }

  // Helper methods to map between JSON and TaskModel
  TaskModel _mapFromJson(Map<String, dynamic> json) {
    final userId = (json['user_id'] ?? json['assignee_id'] ?? '') as String;
    final rawPriority = json['priority']?.toString().toLowerCase();
    final rawStatus = json['status']?.toString().toLowerCase();
    final isCompleted = json['is_completed'] as bool? ??
        rawStatus == 'completed' ||
        rawStatus == 'done' ||
        rawStatus == 'closed';

    final priority = switch (rawPriority) {
      'low' => TaskPriority.low,
      'high' => TaskPriority.high,
      'urgent' => TaskPriority.urgent,
      'critical' => TaskPriority.urgent,
      'medium' => TaskPriority.medium,
      _ => TaskPriority.medium,
    };

    final status = isCompleted ? TaskStatus.completed : TaskStatus.pending;

    return TaskModel(
      id: json['id'] as String,
      userId: userId,
      title: json['title'] as String,
      description: json['description'] as String?,
      xp: json['xp'] as int? ?? 10,
      priority: priority,
      status: status,
      dueDate: json['due_date'] != null
          ? _parseDate(json['due_date'])
          : null,
      category: json['category'] as String?,
      completedAt: json['completed_at'] != null
          ? _parseDate(json['completed_at'])
          : null,
      createdAt: _parseDate(json['created_at']) ?? DateTime.now(),
      updatedAt: _parseDate(json['updated_at']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> _mapToJson(
    TaskModel task, {
    required String table,
    required bool forCreate,
    required String userId,
  }) {
    final priority = switch (task.priority) {
      TaskPriority.low => 'low',
      TaskPriority.medium => 'medium',
      TaskPriority.high => 'high',
      TaskPriority.urgent => table == 'work_tasks' ? 'urgent' : 'high',
    };
    final status = task.status == TaskStatus.completed ? 'completed' : 'pending';

    final row = <String, dynamic>{
      'title': task.title,
      'description': task.description,
      'xp': task.xp,
      'priority': priority,
      'status': status,
      'due_date': task.dueDate?.toIso8601String(),
      'category': task.category,
      'completed_at': task.completedAt?.toIso8601String(),
      'is_completed': task.status == TaskStatus.completed,
    };

    if (forCreate) {
      if (table == 'work_tasks') {
        row['assignee_id'] = userId;
        row['reporter_id'] = userId;
        row['task_type'] = 'personal';
      } else {
        row['user_id'] = userId;
      }
    }

    return row;
  }

  Future<_TaskSchemaContext> _resolveTaskSchema() async {
    final table = await SupabaseConfig.detectTaskTable();
    final userIdColumn = table == 'work_tasks' ? 'assignee_id' : 'user_id';
    return _TaskSchemaContext(
      table: table,
      userIdColumn: userIdColumn,
    );
  }

  DateTime? _parseDate(dynamic raw) {
    if (raw == null) return null;
    if (raw is DateTime) return raw;
    return DateTime.tryParse(raw.toString());
  }
}

class _TaskSchemaContext {
  const _TaskSchemaContext({
    required this.table,
    required this.userIdColumn,
  });

  final String table;
  final String userIdColumn;
}
