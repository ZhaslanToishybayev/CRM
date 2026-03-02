/// Supabase Service - Database Operations
/// Educational Project - Gamified Task Management App

import 'package:supabase_flutter/supabase_flutter.dart';
import '../database/supabase_config.dart';
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
    await SupabaseConfig.upsertProfile(
      userId: userId,
      username: username,
      email: email,
      xp: 0,
      level: 1,
      streak: 0,
    );
  }

  /// Get user statistics
  Future<UserStatsModel?> getUserStats(String userId) async {
    final table = await SupabaseConfig.detectUserStatsTable();
    final idColumn = table == 'corporate_users' ? 'user_id' : 'id';

    final response = await _clientInstance
        .from(table)
        .select()
        .eq(idColumn, userId)
        .single();

    if (response != null) {
      return _mapUserStatsFromRow(response as Map<String, dynamic>, userId);
    }

    return null;
  }

  /// Update user statistics
  Future<void> updateUserStats(UserStatsModel stats) async {
    final table = await SupabaseConfig.detectUserStatsTable();
    final idColumn = table == 'corporate_users' ? 'user_id' : 'id';
    final payload = _userStatsToRow(stats, table);

    await _clientInstance
        .from(table)
        .update(payload)
        .eq(idColumn, stats.id);
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
    final table = await SupabaseConfig.detectTaskTable();
    final userColumn = table == 'work_tasks' ? 'assignee_id' : 'user_id';

    final response = await _clientInstance
        .from(table)
        .select()
        .eq(userColumn, userId)
        .order('created_at', ascending: false);

    final List<dynamic> data = response as List<dynamic>;
    return data
        .map(
          (json) => _mapTaskFromRow(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  /// Get task by ID
  Future<TaskModel?> getTaskById(String taskId) async {
    final table = await SupabaseConfig.detectTaskTable();

    final response = await _clientInstance
        .from(table)
        .select()
        .eq('id', taskId)
        .single();

    if (response != null) {
      return _mapTaskFromRow(response as Map<String, dynamic>);
    }

    return null;
  }

  /// Create new task
  Future<TaskModel> createTask(TaskModel task) async {
    final table = await SupabaseConfig.detectTaskTable();
    final payload = _taskToRow(task, table, forCreate: true);

    final response = await _clientInstance
        .from(table)
        .insert(payload)
        .select()
        .single();

    if (response != null) {
      return _mapTaskFromRow(response as Map<String, dynamic>);
    }

    throw Exception('Failed to create task');
  }

  /// Update task
  Future<TaskModel> updateTask(TaskModel task) async {
    final table = await SupabaseConfig.detectTaskTable();
    final payload = _taskToRow(task, table, forCreate: false);

    final response = await _clientInstance
        .from(table)
        .update(payload)
        .eq('id', task.id)
        .select()
        .single();

    if (response != null) {
      return _mapTaskFromRow(response as Map<String, dynamic>);
    }

    throw Exception('Failed to update task');
  }

  /// Delete task
  Future<void> deleteTask(String taskId) async {
    final table = await SupabaseConfig.detectTaskTable();
    await _clientInstance.from(table).delete().eq('id', taskId);
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
  Stream<List<TaskModel>> subscribeToTasks(String userId) async* {
    final table = await SupabaseConfig.detectTaskTable();
    final userColumn = table == 'work_tasks' ? 'assignee_id' : 'user_id';

    yield* _clientInstance
        .from(table)
        .stream(primaryKey: ['id'])
        .eq(userColumn, userId)
        .map((data) =>
            data.map((json) => _mapTaskFromRow(json as Map<String, dynamic>)).toList());
  }

  /// Subscribe to user stats changes
  Stream<UserStatsModel?> subscribeToUserStats(String userId) async* {
    final table = await SupabaseConfig.detectUserStatsTable();
    final idColumn = table == 'corporate_users' ? 'user_id' : 'id';

    yield* _clientInstance
        .from(table)
        .stream(primaryKey: ['id'])
        .eq(idColumn, userId)
        .map((data) => data.isNotEmpty
            ? _mapUserStatsFromRow(data.first as Map<String, dynamic>, userId)
            : null);
  }

  // ====================
  // UTILITY METHODS
  // ====================

  /// Check if user profile exists
  Future<bool> userProfileExists(String userId) async {
    final table = await SupabaseConfig.detectUserStatsTable();
    final idColumn = table == 'corporate_users' ? 'user_id' : 'id';

    final response = await _clientInstance
        .from(table)
        .select('id')
        .eq(idColumn, userId)
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

  UserStatsModel _mapUserStatsFromRow(Map<String, dynamic> row, String userId) {
    final now = DateTime.now();
    final username = _asString(row['username']) ??
        _asString(row['full_name']) ??
        'user_${userId.substring(0, userId.length >= 8 ? 8 : userId.length)}';
    final email = _asString(row['email']) ?? '';

    return UserStatsModel(
      id: _asString(row['user_id']) ?? _asString(row['id']) ?? userId,
      username: username,
      email: email,
      xp: _asInt(row['xp']) ?? _asInt(row['total_xp']) ?? 0,
      level: _asInt(row['level']) ?? _asInt(row['current_level']) ?? 1,
      streak: _asInt(row['streak']) ?? _asInt(row['streak_count']) ?? 0,
      lastTaskDate: _asDate(row['last_task_date']),
      createdAt: _asDate(row['created_at']) ?? now,
      updatedAt: _asDate(row['updated_at']) ?? now,
    );
  }

  Map<String, dynamic> _userStatsToRow(UserStatsModel stats, String table) {
    if (table == 'corporate_users') {
      return {
        'username': stats.username,
        'email': stats.email,
        'full_name': stats.username,
        'total_xp': stats.xp,
        'current_level': stats.level,
        'streak_count': stats.streak,
        'last_task_date': stats.lastTaskDate?.toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };
    }

    if (table == 'profiles') {
      return {
        'username': stats.username,
        'email': stats.email,
        'total_xp': stats.xp,
        'current_level': stats.level,
        'streak_count': stats.streak,
        'last_task_date': stats.lastTaskDate?.toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };
    }

    return stats.toJson();
  }

  TaskModel _mapTaskFromRow(Map<String, dynamic> row) {
    final now = DateTime.now();
    final id = _asString(row['id']) ?? '';
    final userId = _asString(row['user_id']) ??
        _asString(row['assignee_id']) ??
        _asString(row['reporter_id']) ??
        '';

    final priority = _parseCorePriority(row['priority']);
    final isCompleted = _parseCompleted(row);

    return TaskModel(
      id: id,
      userId: userId,
      title: _asString(row['title']) ?? '',
      description: _asString(row['description']) ?? '',
      priority: priority,
      category: _asString(row['category']) ?? 'General',
      dueDate: _asDate(row['due_date']),
      createdAt: _asDate(row['created_at']) ?? now,
      updatedAt: _asDate(row['updated_at']) ?? now,
      isCompleted: isCompleted,
    );
  }

  Map<String, dynamic> _taskToRow(
    TaskModel task,
    String table, {
    required bool forCreate,
  }) {
    final priority = switch (task.priority) {
      TaskPriority.low => 'low',
      TaskPriority.medium => 'medium',
      TaskPriority.high => 'high',
    };

    final row = <String, dynamic>{
      'title': task.title,
      'description': task.description,
      'priority': priority,
      'category': task.category,
      'due_date': task.dueDate?.toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };

    if (table == 'work_tasks') {
      row['is_completed'] = task.isCompleted;
      row['status'] = task.isCompleted ? 'completed' : 'todo';
      if (task.isCompleted) {
        row['completed_at'] = DateTime.now().toIso8601String();
      }
      if (forCreate) {
        row['assignee_id'] = task.userId;
        row['reporter_id'] = task.userId;
        row['task_type'] = 'personal';
      }
      return row;
    }

    row['is_completed'] = task.isCompleted;
    if (forCreate) {
      row['user_id'] = task.userId;
      row['created_at'] = task.createdAt.toIso8601String();
    }
    return row;
  }

  TaskPriority _parseCorePriority(dynamic value) {
    if (value is int) {
      if (value <= 0) return TaskPriority.low;
      if (value == 1) return TaskPriority.medium;
      return TaskPriority.high;
    }

    final normalized = _asString(value)?.toLowerCase();
    switch (normalized) {
      case 'low':
        return TaskPriority.low;
      case 'high':
      case 'urgent':
      case 'critical':
        return TaskPriority.high;
      default:
        return TaskPriority.medium;
    }
  }

  bool _parseCompleted(Map<String, dynamic> row) {
    final completed = row['is_completed'];
    if (completed is bool) return completed;

    final status = _asString(row['status'])?.toLowerCase();
    return status == 'completed' || status == 'done' || status == 'closed';
  }

  String? _asString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  int? _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  DateTime? _asDate(dynamic value) {
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
