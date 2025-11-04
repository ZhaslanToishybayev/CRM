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

    final response = await _client
        .from('tasks')
        .select()
        .eq('user_id', user.id)
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

    final response = await _client
        .from('tasks')
        .select()
        .eq('id', taskId)
        .eq('user_id', user.id)
        .singleOrNull();

    if (response == null) return null;

    return _mapFromJson(response);
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final taskData = _mapToJson(task);
    taskData['user_id'] = user.id;

    final response = await _client
        .from('tasks')
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

    final taskData = _mapToJson(task);
    taskData['updated_at'] = DateTime.now().toIso8601String();

    final response = await _client
        .from('tasks')
        .update(taskData)
        .eq('id', task.id)
        .eq('user_id', user.id)
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

    await _client
        .from('tasks')
        .delete()
        .eq('id', taskId)
        .eq('user_id', user.id);
  }

  @override
  Future<TaskModel> completeTask(String taskId) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final response = await _client
        .from('tasks')
        .update({
          'status': 'completed',
          'completed_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', taskId)
        .eq('user_id', user.id)
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

    final channel = _client.channel('tasks:${user.id}');

    final controller = StreamController<List<TaskModel>>.broadcast();

    // Send initial data
    getTasks().then((tasks) {
      controller.add(tasks);
    }).catchError((error) {
      controller.addError(error);
    });

    // Listen to INSERT events
    channel.on(
      'postgres_changes',
      event: 'INSERT',
      schema: 'public',
      table: 'tasks',
      filter: 'user_id=eq.${user.id}',
      (payload) {
        final newTask = _mapFromJson(payload.new as Map<String, dynamic>);
        getTasks().then(controller.add).catchError(controller.addError);
      },
    );

    // Listen to UPDATE events
    channel.on(
      'postgres_changes',
      event: 'UPDATE',
      schema: 'public',
      table: 'tasks',
      filter: 'user_id=eq.${user.id}',
      (payload) {
        getTasks().then(controller.add).catchError(controller.addError);
      },
    );

    // Listen to DELETE events
    channel.on(
      'postgres_changes',
      event: 'DELETE',
      schema: 'public',
      table: 'tasks',
      filter: 'user_id=eq.${user.id}',
      (payload) {
        getTasks().then(controller.add).catchError(controller.addError);
      },
    );

    channel.subscribe();

    return controller.stream;
  }

  // Helper methods to map between JSON and TaskModel
  TaskModel _mapFromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      xp: json['xp'] as int? ?? 10,
      priority: TaskPriority.values.firstWhere(
        (p) => p.toString().split('.').last == json['priority'],
        orElse: () => TaskPriority.medium,
      ),
      status: TaskStatus.values.firstWhere(
        (s) => s.toString().split('.').last == json['status'],
        orElse: () => TaskStatus.pending,
      ),
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date'] as String)
          : null,
      category: json['category'] as String?,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> _mapToJson(TaskModel task) {
    return {
      'title': task.title,
      'description': task.description,
      'xp': task.xp,
      'priority': task.priority.toString().split('.').last,
      'status': task.status.toString().split('.').last,
      'due_date': task.dueDate?.toIso8601String(),
      'category': task.category,
      'completed_at': task.completedAt?.toIso8601String(),
    };
  }
}
