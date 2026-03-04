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
  bool _isDemoMode = false;

  SupabaseClient get _clientInstance {
    _client ??= Supabase.instance.client;
    return _client!;
  }

  SupabaseClient? get _safeClient {
    if (_client != null) {
      return _client;
    }

    try {
      _client = Supabase.instance.client;
      return _client;
    } catch (_) {
      return null;
    }
  }

  /// Enable Demo Mode (works without authentication)
  void enableDemoMode() {
    _isDemoMode = true;
  }

  /// Check if in Demo Mode
  bool get isDemoMode => _isDemoMode;

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
    // Enable demo mode first
    enableDemoMode();

    // Create demo user
    final demoUser = User(
      id: 'demo-user-uuid',
      appMetadata: {},
      userMetadata: {},
      aud: 'authenticated',
      createdAt: DateTime.now().toIso8601String(),
      role: 'authenticated',
      email: 'demo@example.com',
      emailConfirmedAt: DateTime.now().toIso8601String(),
      lastSignInAt: DateTime.now().toIso8601String(),
      confirmationSentAt: DateTime.now().toIso8601String(),
    );

    // Create demo session
    final demoSession = Session(
      accessToken: 'demo_token',
      refreshToken: 'demo_refresh',
      expiresIn: 3600,
      tokenType: 'bearer',
      user: demoUser,
    );

    // Return mock response for demo mode
    return AuthResponse(
      session: demoSession,
      user: demoUser,
    );
  }

  /// Sign out
  Future<void> signOut() async {
    await _clientInstance.auth.signOut();
  }

  /// Get current user
  User? get currentUser => _safeClient?.auth.currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => _safeClient?.auth.currentSession != null;

  // ====================
  // USER PROFILE METHODS
  // ====================

  Future<void> _createUserProfile({
    required String userId,
    required String username,
    required String email,
  }) async {
    // In Demo Mode, don't create profile
    if (_isDemoMode) {
      return;
    }

    try {
      await _clientInstance.from('user_stats').insert({
        'id': userId,
        'username': username,
        'email': email,
        'xp': 0,
        'level': 1,
        'streak': 0,
      });
    } catch (e) {
      print('Warning: Could not create user profile: $e');
      // Don't throw - user can still use the app without profile
    }
  }

  /// Get user statistics
  Future<UserStatsModel?> getUserStats(String userId) async {
    // In Demo Mode, return mock stats
    if (_isDemoMode) {
      return UserStatsModel.create(
        id: userId,
        username: 'Demo User',
        email: 'demo@example.com',
      );
    }

    // Validate userId is not empty
    if (userId.isEmpty) {
      return null;
    }

    try {
      final response = await _clientInstance
          .from('user_stats')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response != null && response is Map<String, dynamic>) {
        return UserStatsModel.fromJson(response);
      }
    } catch (e) {
      print('Warning: Could not get user stats: $e');
    }

    return null;
  }

  /// Update user statistics
  Future<void> updateUserStats(UserStatsModel stats) async {
    await _clientInstance
        .from('user_stats')
        .update(stats.toJson())
        .eq('id', stats.effectiveId);
  }

  /// Add XP to user
  Future<void> addUserXP(String userId, int xpAmount) async {
    // In Demo Mode, don't interact with database
    if (_isDemoMode) {
      print('Demo Mode: XP would be increased by $xpAmount');
      return;
    }

    // Validate userId is not empty
    if (userId.isEmpty) {
      return;
    }

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
      print('Warning: Could not add user XP: $e');
    }
  }

  /// Update user streak
  Future<void> updateUserStreak(String userId) async {
    // In Demo Mode, don't interact with database
    if (_isDemoMode) {
      print('Demo Mode: Streak would be updated');
      return;
    }

    // Validate userId is not empty
    if (userId.isEmpty) {
      return;
    }

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
      print('Warning: Could not update user streak: $e');
    }
  }

  // ====================
  // TASKS METHODS
  // ====================

  /// Get all tasks for user
  Future<List<TaskModel>> getTasks(String userId) async {
    // In Demo Mode, return mock tasks
    if (_isDemoMode) {
      return [
        TaskModel.fromJson({
          'id': 'demo-1',
          'user_id': 'demo-user-uuid',
          'title': 'Добро пожаловать в Demo!',
          'description': 'Это демо-режим. Зарегистрируйтесь для полной функциональности.',
          'category': 'General',
          'priority': 2,
          'status': 'pending',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        }),
      ];
    }

    // Filter by user_id for security
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
    // In Demo Mode, generate a demo user ID
    if (_isDemoMode) {
      final taskData = task.toJson();
      taskData['user_id'] = 'demo-user-uuid';
      // Return mock task with generated ID
      return TaskModel.fromJson({
        ...taskData,
        'id': 'demo-${DateTime.now().millisecondsSinceEpoch}',
      });
    }

    // Get current user ID for the task
    final currentUser = _clientInstance.auth.currentUser;
    if (currentUser == null) {
      throw Exception('User not authenticated');
    }

    final taskData = task.toJsonForDatabase();
    // Set user_id to current authenticated user
    taskData['user_id'] = currentUser.id;

    final response = await _clientInstance
        .from('tasks')
        .insert(taskData)
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
        .update(task.toJsonForDatabase())
        .eq('id', task.effectiveId)
        .eq('user_id', task.userId)
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
    // Don't filter by user_id - RLS policies will handle it automatically
    final response = await _clientInstance
        .from('tasks')
        .update({
          'status': 'completed',
          'completed_at': DateTime.now().toIso8601String(),
        })
        .eq('id', taskId)
        .select()
        .single();

    if (response != null) {
      return TaskModel.fromJson(response as Map<String, dynamic>);
    }

    throw Exception('Task not found');
  }

  // ====================
  // REAL-TIME SUBSCRIPTIONS
  // ====================

  /// Subscribe to tasks changes
  Stream<List<TaskModel>> subscribeToTasks(String userId) {
    // In Demo Mode, return empty stream (no real-time updates needed)
    if (_isDemoMode) {
      return const Stream.empty();
    }

    // Don't filter by user_id - RLS policies will handle row-level security automatically
    return _clientInstance
        .from('tasks')
        .stream(primaryKey: ['id'])
        .map((data) => data
            .map((json) => TaskModel.fromJson(json as Map<String, dynamic>))
            .toList());
  }

  /// Subscribe to user stats changes
  Stream<UserStatsModel?> subscribeToUserStats(String userId) {
    // In Demo Mode, return empty stream (no real-time updates needed)
    if (_isDemoMode) {
      return const Stream.empty();
    }

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
    // In Demo Mode, return mock data
    if (_isDemoMode) {
      return {
        'total_tasks': 0,
        'completed_tasks': 0,
        'pending_tasks': 0,
        'completion_rate': 0.0,
      };
    }

    // Validate userId is not empty
    if (userId.isEmpty) {
      return null;
    }

    try {
      final response = await _clientInstance
          .rpc('get_user_task_stats', params: {'user_id_param': userId});

      if (response != null && response is Map<String, dynamic>) {
        return response;
      }
    } catch (e) {
      print('Warning: Could not get user task stats: $e');
    }

    return null;
  }
}
