/// Supabase Service - Database Operations
/// Educational Project - Gamified Task Management App

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task_model.dart';
import '../models/user_stats_model.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  SupabaseClient? _client;

  SupabaseClient get _clientInstance {
    _client ??= Supabase.instance.client;
    return _client!;
  }

  // ====================
  // AUTH METHODS
  // ====================

  /// Sign up with email and password
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    final response = await _clientInstance.auth.signUp(
      email: email,
      password: password,
      data: {'username': username},
    );

    // Create user profile if sign up successful
    if (response.user != null) {
      await _createUserProfile(
        userId: response.user!.id,
        username: username,
        email: email,
      );
    }

    return response;
  }

  /// Sign in with email and password
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _clientInstance.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Sign in anonymously (demo mode)
  Future<AuthResponse> signInAnonymously() async {
    return await _clientInstance.auth.signInAnonymously();
  }

  /// Sign out
  Future<void> signOut() async {
    await _clientInstance.auth.signOut();
  }

  /// Get current user
  User? get currentUser => _clientInstance.auth.currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => _clientInstance.auth.currentSession != null;

  // ====================
  // USER PROFILE METHODS
  // ====================

  Future<void> _createUserProfile({
    required String userId,
    required String username,
    required String email,
  }) async {
    await _clientInstance.from('user_stats').insert({
      'id': userId,
      'username': username,
      'email': email,
    });
  }

  /// Get user statistics
  Future<UserStatsModel?> getUserStats(String userId) async {
    final response = await _clientInstance
        .from('user_stats')
        .select()
        .eq('id', userId)
        .single();

    if (response != null) {
      return UserStatsModel.fromJson(response as Map<String, dynamic>);
    }

    return null;
  }

  /// Update user statistics
  Future<void> updateUserStats(UserStatsModel stats) async {
    await _clientInstance
        .from('user_stats')
        .update(stats.toJson())
        .eq('id', stats.id);
  }

  /// Add XP to user
  Future<void> addUserXP(String userId, int xpAmount) async {
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
  }

  /// Update user streak
  Future<void> updateUserStreak(String userId) async {
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
  }

  // ====================
  // TASKS METHODS
  // ====================

  /// Get all tasks for user
  Future<List<TaskModel>> getTasks(String userId) async {
    final response = await _clientInstance
        .from('tasks')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    final List<dynamic> data = response as List<dynamic>;
    return data
        .map((json) => TaskModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Get task by ID
  Future<TaskModel?> getTaskById(String taskId) async {
    final response = await _clientInstance
        .from('tasks')
        .select()
        .eq('id', taskId)
        .single();

    if (response != null) {
      return TaskModel.fromJson(response as Map<String, dynamic>);
    }

    return null;
  }

  /// Create new task
  Future<TaskModel> createTask(TaskModel task) async {
    final response = await _clientInstance
        .from('tasks')
        .insert(task.toJson())
        .select()
        .single();

    if (response != null) {
      return TaskModel.fromJson(response as Map<String, dynamic>);
    }

    throw Exception('Failed to create task');
  }

  /// Update task
  Future<TaskModel> updateTask(TaskModel task) async {
    final response = await _clientInstance
        .from('tasks')
        .update(task.toJson())
        .eq('id', task.id)
        .select()
        .single();

    if (response != null) {
      return TaskModel.fromJson(response as Map<String, dynamic>);
    }

    throw Exception('Failed to update task');
  }

  /// Delete task
  Future<void> deleteTask(String taskId) async {
    await _clientInstance.from('tasks').delete().eq('id', taskId);
  }

  /// Mark task as completed
  Future<TaskModel> completeTask(String taskId) async {
    final task = await getTaskById(taskId);
    if (task != null) {
      final completedTask = task.copyWith(isCompleted: true);
      return await updateTask(completedTask);
    }

    throw Exception('Task not found');
  }

  // ====================
  // REAL-TIME SUBSCRIPTIONS
  // ====================

  /// Subscribe to tasks changes
  Stream<List<TaskModel>> subscribeToTasks(String userId) {
    return _clientInstance
        .from('tasks')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map((data) => data
            .map((json) => TaskModel.fromJson(json as Map<String, dynamic>))
            .toList());
  }

  /// Subscribe to user stats changes
  Stream<UserStatsModel?> subscribeToUserStats(String userId) {
    return _clientInstance
        .from('user_stats')
        .stream(primaryKey: ['id'])
        .eq('id', userId)
        .map((data) => data.isNotEmpty
            ? UserStatsModel.fromJson(data.first as Map<String, dynamic>)
            : null);
  }

  // ====================
  // UTILITY METHODS
  // ====================

  /// Check if user profile exists
  Future<bool> userProfileExists(String userId) async {
    final response = await _clientInstance
        .from('user_stats')
        .select('id')
        .eq('id', userId)
        .limit(1);

    return response.isNotEmpty;
  }

  /// Get user statistics view
  Future<Map<String, dynamic>?> getUserTaskStats(String userId) async {
    final response = await _clientInstance
        .rpc('get_user_task_stats', params: {'user_id_param': userId});

    if (response != null) {
      return response as Map<String, dynamic>;
    }

    return null;
  }
}
