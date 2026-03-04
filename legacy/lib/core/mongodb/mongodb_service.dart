/// MongoDB Service - Real Database Operations
/// Educational Project - Gamified Task Management App
/// No Demo Mode - Real MongoDB Backend Only

import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/task_model.dart';
import '../models/user_stats_model.dart';

class MongoDBService {
  static final MongoDBService _instance = MongoDBService._internal();
  factory MongoDBService() => _instance;
  MongoDBService._internal() {
    _initializeDio();
  }

  static const String baseUrl = 'http://localhost:3002/api';
  late final Dio _dio;

  void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
    // Add logging interceptor
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  // ====================
  // AUTH METHODS (MOCK)
  // ====================

  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return response.data;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/signup',
        data: {
          'email': email,
          'password': password,
          'username': username,
        },
      );

      return response.data;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<void> signOut() async {
    // Mock sign out - just clear local state
    return;
  }

  // ====================
  // TASKS METHODS
  // ====================

  Future<List<TaskModel>> getTasks(String userId) async {
    try {
      final response = await _dio.get('/tasks');
      final List<dynamic> data = response.data;

      return data.map((json) => TaskModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  Future<TaskModel> createTask(TaskModel task) async {
    try {
      final response = await _dio.post(
        '/tasks',
        data: task.toJson(),
      );

      return TaskModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create task: $e');
    }
  }

  Future<TaskModel> updateTask(TaskModel task) async {
    try {
      final response = await _dio.put(
        '/tasks/${task.id}',
        data: task.toJson(),
      );

      return TaskModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _dio.delete('/tasks/$taskId');
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  Future<TaskModel> completeTask(String taskId) async {
    try {
      // Get current task
      final tasks = await getTasks('demo-user');
      final task = tasks.firstWhere((t) => t.id == taskId);

      // Update to completed
      final updatedTask = task.copyWith(
        isCompleted: true,
      );

      final response = await _dio.put(
        '/tasks/${task.id}',
        data: updatedTask.toJson(),
      );

      return TaskModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to complete task: $e');
    }
  }

  // ====================
  // USER STATS METHODS
  // ====================

  Future<UserStatsModel?> getUserStats(String userId) async {
    try {
      final response = await _dio.get('/user-stats/$userId');
      return UserStatsModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch user stats: $e');
    }
  }

  Future<void> updateUserStats(UserStatsModel stats) async {
    try {
      await _dio.put(
        '/user-stats/${stats.id}',
        data: stats.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update user stats: $e');
    }
  }

  Future<void> addUserXP(String userId, int xpAmount) async {
    try {
      final stats = await getUserStats(userId);
      if (stats != null) {
        final newXP = stats.xp + xpAmount;
        final newLevel = (newXP / 100).floor() + 1;
        final updatedStats = stats.copyWith(
          xp: newXP,
          level: newLevel,
        );
        await updateUserStats(updatedStats);
      }
    } catch (e) {
      throw Exception('Failed to add user XP: $e');
    }
  }

  Future<void> updateUserStreak(String userId) async {
    try {
      final stats = await getUserStats(userId);
      if (stats != null) {
        final now = DateTime.now();
        int newStreak = stats.streak;

        if (stats.lastTaskDate == null ||
            now.difference(stats.lastTaskDate!).inDays == 1) {
          newStreak = stats.streak + 1;
        } else if (now.day != stats.lastTaskDate!.day) {
          newStreak = 1;
        }

        final updatedStats = stats.copyWith(
          streak: newStreak,
          lastTaskDate: now,
        );
        await updateUserStats(updatedStats);
      }
    } catch (e) {
      throw Exception('Failed to update user streak: $e');
    }
  }

  // ====================
  // UTILITY METHODS
  // ====================

  Future<void> seedSampleData() async {
    try {
      await _dio.post('/seed');
    } catch (e) {
      throw Exception('Failed to seed data: $e');
    }
  }

  Future<Map<String, dynamic>> healthCheck() async {
    try {
      final response = await _dio.get('/health');
      return response.data;
    } catch (e) {
      throw Exception('Health check failed: $e');
    }
  }
}
