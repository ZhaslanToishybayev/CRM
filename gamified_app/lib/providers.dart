/// Riverpod Providers for State Management
/// Educational Project - Gamified Task Management App

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ========== MODELS ==========

enum TaskPriority { low, medium, high }

class Task {
  final String id;
  String title;
  String description;
  TaskPriority priority;
  String category;
  DateTime? dueDate;
  DateTime createdAt;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.priority = TaskPriority.medium,
    this.category = 'General',
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

  UserStats({
    this.xp = 0,
    this.level = 1,
    this.streak = 0,
    this.lastTaskDate,
  });

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
  String _password = '';

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
    _password = password;
    _username = username;
    _isLoggedIn = true;
    state = true;
  }

  void loginDemo() {
    _email = 'demo@example.com';
    _password = 'demo123';
    _username = 'Demo User';
    _isLoggedIn = true;
    state = true;
  }

  void logout() {
    _isLoggedIn = false;
    _username = '';
    _email = '';
    _password = '';
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

  Future<void> loadTasks() async {
    try {
      final tasksBox = await Hive.openBox(tasksBoxKey);
      final tasksData = tasksBox.get(tasksBoxKey);
      if (tasksData != null) {
        final List<dynamic> tasksList = tasksData;
        state = tasksList
            .map((taskJson) => Task.fromJson(Map<String, dynamic>.from(taskJson)))
            .toList();
      }
    } catch (e) {
      print('Error loading tasks: $e');
    }
  }

  Future<void> saveTasks() async {
    try {
      final tasksBox = await Hive.openBox(tasksBoxKey);
      await tasksBox.put(tasksBoxKey, state.map((task) => task.toJson()).toList());
    } catch (e) {
      print('Error saving tasks: $e');
    }
  }

  void addTask(Task task) {
    state = [task, ...state];
    saveTasks();
  }

  void updateTask(int index, Task task) {
    state = [
      ...state.sublist(0, index),
      task,
      ...state.sublist(index + 1),
    ];
    saveTasks();
  }

  void deleteTask(int index) {
    state = [
      ...state.sublist(0, index),
      ...state.sublist(index + 1),
    ];
    saveTasks();
  }

  void toggleComplete(int index) {
    state = [
      ...state.sublist(0, index),
      state[index].copyWith(isCompleted: true),
      ...state.sublist(index + 1),
    ];
    saveTasks();
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
      print('Error loading user stats: $e');
    }
  }

  Future<void> saveUserStats() async {
    try {
      final userBox = await Hive.openBox(userBoxKey);
      await userBox.put(userBoxKey, state.toJson());
    } catch (e) {
      print('Error saving user stats: $e');
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

    state = state.copyWith(
      streak: newStreak,
      lastTaskDate: now,
    );

    saveUserStats();
  }

  void reset() {
    state = UserStats();
    saveUserStats();
  }
}

final userStatsProvider = StateNotifierProvider<UserStatsNotifier, UserStats>((ref) {
  return UserStatsNotifier();
});

// ========== FILTERS PROVIDER ==========

class FiltersNotifier extends StateNotifier<Map<String, String>> {
  FiltersNotifier()
      : super({
          'category': 'All',
          'priority': 'All',
        });

  void setCategoryFilter(String category) {
    state = {...state, 'category': category};
  }

  void setPriorityFilter(String priority) {
    state = {...state, 'priority': priority};
  }

  String get categoryFilter => state['category'] ?? 'All';
  String get priorityFilter => state['priority'] ?? 'All';
}

final filtersProvider = StateNotifierProvider<FiltersNotifier, Map<String, String>>((ref) {
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
      final categoryMatch = filters['category'] == 'All' ||
          task.category == filters['category'];
      final priorityMatch = filters['priority'] == 'All' ||
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
