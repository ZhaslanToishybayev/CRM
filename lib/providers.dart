// Riverpod providers for app state management.

import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'auth/auth_service.dart';
import 'core/config/runtime_flags.dart';
import 'core/database/supabase_config.dart';

// ========== MODELS ==========

enum TaskPriority { low, medium, high }

const _noClientIdUpdate = Object();

class Task {
  final String id;
  String title;
  String description;
  TaskPriority priority;
  String category;
  String? clientId;
  DateTime? dueDate;
  DateTime createdAt;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.priority = TaskPriority.medium,
    this.category = 'General',
    this.clientId,
    this.dueDate,
    required this.createdAt,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority.index,
      'category': category,
      'clientId': clientId,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      priority: TaskPriority.values[json['priority']],
      category: json['category'] ?? 'General',
      clientId: json['clientId'] as String?,
      dueDate: json['dueDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['dueDate'])
          : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskPriority? priority,
    String? category,
    Object? clientId = _noClientIdUpdate,
    DateTime? dueDate,
    DateTime? createdAt,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      clientId: identical(clientId, _noClientIdUpdate)
          ? this.clientId
          : clientId as String?,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class UserStats {
  int xp;
  int level;
  int streak;
  DateTime? lastTaskDate;

  UserStats({this.xp = 0, this.level = 1, this.streak = 0, this.lastTaskDate});

  Map<String, dynamic> toJson() {
    return {
      'xp': xp,
      'level': level,
      'streak': streak,
      'lastTaskDate': lastTaskDate?.millisecondsSinceEpoch,
    };
  }

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      xp: json['xp'] ?? 0,
      level: json['level'] ?? 1,
      streak: json['streak'] ?? 0,
      lastTaskDate: json['lastTaskDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['lastTaskDate'])
          : null,
    );
  }

  UserStats copyWith({
    int? xp,
    int? level,
    int? streak,
    DateTime? lastTaskDate,
  }) {
    return UserStats(
      xp: xp ?? this.xp,
      level: level ?? this.level,
      streak: streak ?? this.streak,
      lastTaskDate: lastTaskDate ?? this.lastTaskDate,
    );
  }
}

// ========== AUTH PROVIDER ==========

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false);

  bool _isLoggedIn = false;
  String _username = '';
  String _email = '';

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;
  String get email => _email;

  /// Get user ID (for task association)
  String getUserId() {
    if (_email.isNotEmpty) {
      return _email;
    }
    return 'demo_user';
  }

  void login({
    required String email,
    required String password,
    required String username,
  }) {
    _email = email;
    _username = username;
    _isLoggedIn = true;
    state = true;
  }

  void loginDemo() {
    _email = 'demo@example.com';
    _username = 'Demo User';
    _isLoggedIn = true;
    state = true;
  }

  void logout() {
    _isLoggedIn = false;
    _username = '';
    _email = '';
    state = false;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});

// ========== TASKS PROVIDER ==========

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  final String tasksBoxKey = 'tasks';
  bool _isSyncing = false;

  bool get _useDemoStorage => kDemoMode || AuthService.debugForceDemoMode;
  bool get _canUseBackend =>
      !_useDemoStorage &&
      SupabaseConfig.isConfigured &&
      AuthService.currentUser != null;

  String? get _currentUserId => AuthService.currentUser?.id;

  void _ensureBackendReady({required String operation}) {
    if (_useDemoStorage) return;
    if (!SupabaseConfig.isConfigured) {
      throw StateError(
        'Backend mode is enabled, but SUPABASE_URL/SUPABASE_ANON_KEY are missing. '
        'Unable to $operation.',
      );
    }
    if (_currentUserId == null) {
      throw StateError('Authentication is required to $operation.');
    }
  }

  TaskPriority _priorityFromDb(dynamic value) {
    if (value is int) {
      if (value <= 1) return TaskPriority.low;
      if (value == 2) return TaskPriority.medium;
      return TaskPriority.high;
    }
    if (value is String) {
      switch (value.toLowerCase()) {
        case 'low':
          return TaskPriority.low;
        case 'high':
          return TaskPriority.high;
        case 'medium':
        default:
          return TaskPriority.medium;
      }
    }
    return TaskPriority.medium;
  }

  int _priorityToDb(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return 1;
      case TaskPriority.medium:
        return 2;
      case TaskPriority.high:
        return 3;
    }
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  Task _taskFromDb(Map<String, dynamic> row) {
    final statusValue = row['status'];
    final isCompletedValue = row['is_completed'];
    final isCompleted = statusValue != null
        ? statusValue == 'completed'
        : (isCompletedValue == true);

    return Task(
      id: row['id']?.toString() ?? '',
      title: row['title']?.toString() ?? '',
      description: row['description']?.toString() ?? '',
      priority: _priorityFromDb(row['priority']),
      category: row['category']?.toString() ?? 'General',
      clientId: row['client_id']?.toString(),
      dueDate: _parseDate(row['due_date']),
      createdAt:
          _parseDate(row['created_at']) ??
          _parseDate(row['updated_at']) ??
          DateTime.now(),
      isCompleted: isCompleted,
    );
  }

  Map<String, dynamic> _taskToDb(Task task, {bool includeId = true}) {
    return {
      if (includeId) 'id': task.id,
      if (_currentUserId != null) 'user_id': _currentUserId,
      'title': task.title,
      'description': task.description,
      'priority': _priorityToDb(task.priority),
      'status': task.isCompleted ? 'completed' : 'pending',
      'category': task.category,
      'client_id': task.clientId,
      'due_date': task.dueDate?.toIso8601String(),
      'completed_at': task.isCompleted
          ? DateTime.now().toIso8601String()
          : null,
      'updated_at': DateTime.now().toIso8601String(),
    };
  }

  Future<void> _syncTask(Task task, {required bool isNew}) async {
    final userId = _currentUserId;
    if (!_canUseBackend || userId == null) {
      _ensureBackendReady(operation: isNew ? 'create task' : 'update task');
      return;
    }

    if (isNew) {
      final response = await SupabaseConfig.client
          .from('tasks')
          .insert(_taskToDb(task, includeId: false))
          .select()
          .single();

      final savedTask = _taskFromDb(Map<String, dynamic>.from(response));
      final idx = state.indexWhere((item) => item.id == task.id);
      if (idx >= 0) {
        state = [
          ...state.sublist(0, idx),
          savedTask,
          ...state.sublist(idx + 1),
        ];
      }
      return;
    }

    final response = await SupabaseConfig.client
        .from('tasks')
        .update(_taskToDb(task))
        .eq('id', task.id)
        .eq('user_id', userId)
        .select()
        .single();

    final savedTask = _taskFromDb(Map<String, dynamic>.from(response));
    final idx = state.indexWhere((item) => item.id == task.id);
    if (idx >= 0) {
      state = [...state.sublist(0, idx), savedTask, ...state.sublist(idx + 1)];
    }
  }

  Future<void> _syncDeleteTask(Task task) async {
    final userId = _currentUserId;
    if (!_canUseBackend || userId == null) {
      _ensureBackendReady(operation: 'delete task');
      return;
    }
    await SupabaseConfig.client
        .from('tasks')
        .delete()
        .eq('id', task.id)
        .eq('user_id', userId);
  }

  Future<void> _syncAllTasks(List<Task> tasks) async {
    final userId = _currentUserId;
    if (!_canUseBackend || userId == null) {
      _ensureBackendReady(operation: 'sync tasks');
      return;
    }
    if (_isSyncing) return;
    _isSyncing = true;
    try {
      final desiredById = <String, Task>{
        for (final task in tasks) task.id: task,
      };
      final rawRemote = await SupabaseConfig.client
          .from('tasks')
          .select()
          .eq('user_id', userId);
      final remoteRows = (rawRemote as List)
          .map((row) => Map<String, dynamic>.from(row as Map))
          .toList();

      final remoteIds = remoteRows
          .map((row) => row['id']?.toString())
          .whereType<String>()
          .toSet();
      final desiredIds = desiredById.keys.toSet();

      for (final task in tasks) {
        if (remoteIds.contains(task.id)) {
          await SupabaseConfig.client
              .from('tasks')
              .update(_taskToDb(task))
              .eq('id', task.id)
              .eq('user_id', userId);
        } else {
          await SupabaseConfig.client
              .from('tasks')
              .insert(_taskToDb(task, includeId: false));
        }
      }

      final staleIds = remoteIds.difference(desiredIds);
      for (final staleId in staleIds) {
        await SupabaseConfig.client
            .from('tasks')
            .delete()
            .eq('id', staleId)
            .eq('user_id', userId);
      }
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> loadTasks() async {
    if (!_useDemoStorage) {
      _ensureBackendReady(operation: 'load tasks');
      final userId = _currentUserId!;
      final response = await SupabaseConfig.client
          .from('tasks')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      state = (response as List)
          .map((row) => _taskFromDb(Map<String, dynamic>.from(row as Map)))
          .toList();
      return;
    }

    try {
      final tasksBox = await Hive.openBox(tasksBoxKey);
      final tasksData = tasksBox.get(tasksBoxKey);
      if (tasksData != null) {
        final List<dynamic> tasksList = tasksData;
        state = tasksList
            .map(
              (taskJson) => Task.fromJson(Map<String, dynamic>.from(taskJson)),
            )
            .toList();
      }
    } catch (e) {
      developer.log('event=task_load_local_failed error=$e');
    }
  }

  Future<void> saveTasks() async {
    if (!_useDemoStorage) return;
    try {
      final tasksBox = await Hive.openBox(tasksBoxKey);
      await tasksBox.put(
        tasksBoxKey,
        state.map((task) => task.toJson()).toList(),
      );
    } catch (e) {
      developer.log('event=task_save_local_failed error=$e');
    }
  }

  Future<void> addTask(Task task) async {
    if (!_useDemoStorage) {
      _ensureBackendReady(operation: 'create task');
    }
    final previousState = List<Task>.from(state);
    state = [task, ...state];
    if (_useDemoStorage) {
      await saveTasks();
      return;
    }

    try {
      await _syncTask(task, isNew: true);
    } catch (error) {
      state = previousState;
      developer.log('event=task_create_failed error=$error');
      rethrow;
    }
  }

  Future<void> updateTask(int index, Task task) async {
    if (index < 0 || index >= state.length) return;
    if (!_useDemoStorage) {
      _ensureBackendReady(operation: 'update task');
    }
    final previousState = List<Task>.from(state);
    state = [...state.sublist(0, index), task, ...state.sublist(index + 1)];
    if (_useDemoStorage) {
      await saveTasks();
      return;
    }

    try {
      await _syncTask(task, isNew: false);
    } catch (error) {
      state = previousState;
      developer.log('event=task_update_failed error=$error');
      rethrow;
    }
  }

  Future<void> deleteTask(int index) async {
    if (index < 0 || index >= state.length) return;
    if (!_useDemoStorage) {
      _ensureBackendReady(operation: 'delete task');
    }
    final previousState = List<Task>.from(state);
    final taskToDelete = state[index];
    state = [...state.sublist(0, index), ...state.sublist(index + 1)];
    if (_useDemoStorage) {
      await saveTasks();
      return;
    }

    try {
      await _syncDeleteTask(taskToDelete);
    } catch (error) {
      state = previousState;
      developer.log('event=task_delete_failed error=$error');
      rethrow;
    }
  }

  Future<void> toggleComplete(int index) async {
    if (index < 0 || index >= state.length) return;
    if (!_useDemoStorage) {
      _ensureBackendReady(operation: 'toggle task completion');
    }
    final previousState = List<Task>.from(state);
    final updatedTask = state[index].copyWith(
      isCompleted: !state[index].isCompleted,
    );
    state = [
      ...state.sublist(0, index),
      updatedTask,
      ...state.sublist(index + 1),
    ];
    if (_useDemoStorage) {
      await saveTasks();
      return;
    }

    try {
      await _syncTask(updatedTask, isNew: false);
    } catch (error) {
      state = previousState;
      developer.log('event=task_toggle_failed error=$error');
      rethrow;
    }
  }

  Future<void> clearCompleted() async {
    if (!_useDemoStorage) {
      _ensureBackendReady(operation: 'clear completed tasks');
    }
    final previousState = List<Task>.from(state);
    final completedTasks = state.where((task) => task.isCompleted).toList();
    state = state.where((task) => !task.isCompleted).toList();
    if (_useDemoStorage) {
      await saveTasks();
      return;
    }

    try {
      for (final task in completedTasks) {
        await _syncDeleteTask(task);
      }
    } catch (error) {
      state = previousState;
      developer.log('event=task_clear_completed_failed error=$error');
      rethrow;
    }
  }

  Future<void> replaceTasks(List<Task> tasks) async {
    if (!_useDemoStorage) {
      _ensureBackendReady(operation: 'replace tasks');
    }
    state = List<Task>.from(tasks);
    if (_useDemoStorage) {
      await saveTasks();
      return;
    }

    try {
      await _syncAllTasks(tasks);
    } catch (error) {
      developer.log('event=task_replace_failed error=$error');
    }
  }

  Future<void> loadAll() async {
    await loadTasks();
  }
}

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});

// ========== USER STATS PROVIDER ==========

class UserStatsNotifier extends StateNotifier<UserStats> {
  UserStatsNotifier() : super(UserStats());

  final String userBoxKey = 'user';

  Future<void> loadUserStats() async {
    try {
      final userBox = await Hive.openBox(userBoxKey);
      final userData = userBox.get(userBoxKey);
      if (userData != null) {
        state = UserStats.fromJson(Map<String, dynamic>.from(userData));
      }
    } catch (e) {
      developer.log('event=user_stats_load_failed error=$e');
    }
  }

  Future<void> saveUserStats() async {
    try {
      final userBox = await Hive.openBox(userBoxKey);
      await userBox.put(userBoxKey, state.toJson());
    } catch (e) {
      developer.log('event=user_stats_save_failed error=$e');
    }
  }

  void addXP(int amount) {
    final newXP = state.xp + amount;
    final newLevel = (newXP / 100).floor() + 1;
    final levelChanged = newLevel > state.level;

    state = state.copyWith(xp: newXP);

    if (levelChanged) {
      state = state.copyWith(level: newLevel);
    }

    saveUserStats();
  }

  void updateStreak() {
    final now = DateTime.now();
    int newStreak = state.streak;

    if (state.lastTaskDate == null ||
        now.difference(state.lastTaskDate!).inDays == 1) {
      newStreak = state.streak + 1;
    } else if (now.day != state.lastTaskDate!.day) {
      newStreak = 1;
    }

    state = state.copyWith(streak: newStreak, lastTaskDate: now);

    saveUserStats();
  }

  void reset() {
    state = UserStats();
    saveUserStats();
  }

  void replaceStats(UserStats stats) {
    state = stats;
    saveUserStats();
  }
}

final userStatsProvider = StateNotifierProvider<UserStatsNotifier, UserStats>((
  ref,
) {
  return UserStatsNotifier();
});

// ========== FILTERS PROVIDER ==========

class FiltersNotifier extends StateNotifier<Map<String, String>> {
  FiltersNotifier() : super({'category': 'All', 'priority': 'All'});

  void setCategoryFilter(String category) {
    state = {...state, 'category': category};
  }

  void setPriorityFilter(String priority) {
    state = {...state, 'priority': priority};
  }

  String get categoryFilter => state['category'] ?? 'All';
  String get priorityFilter => state['priority'] ?? 'All';
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<String, String>>((ref) {
      return FiltersNotifier();
    });

// ========== COMBINED PROVIDER ==========

class AppState {
  final bool isLoggedIn;
  final List<Task> tasks;
  final UserStats userStats;
  final Map<String, String> filters;

  AppState({
    required this.isLoggedIn,
    required this.tasks,
    required this.userStats,
    required this.filters,
  });

  List<Task> get filteredTasks {
    return tasks.where((task) {
      final categoryMatch =
          filters['category'] == 'All' || task.category == filters['category'];
      final priorityMatch =
          filters['priority'] == 'All' ||
          task.priority.name == filters['priority']!.toLowerCase();
      return categoryMatch && priorityMatch && !task.isCompleted;
    }).toList();
  }
}

final appStateProvider = Provider<AppState>((ref) {
  final isLoggedIn = ref.watch(authProvider);
  final tasks = ref.watch(tasksProvider);
  final userStats = ref.watch(userStatsProvider);
  final filters = ref.watch(filtersProvider);

  return AppState(
    isLoggedIn: isLoggedIn,
    tasks: tasks,
    userStats: userStats,
    filters: filters,
  );
});
