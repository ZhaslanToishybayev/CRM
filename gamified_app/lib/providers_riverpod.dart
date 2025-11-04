/// Riverpod Providers for Gamified Task Management App
/// Task 2.4: State Management Implementation
/// Educational Project

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'main_simple.dart';

// ========== STORAGE KEYS ==========
const String tasksBoxKey = 'tasks';
const String userBoxKey = 'user';

// ========== HIVE SERVICE ==========
class HiveService {
  static const String tasksBoxKey = 'tasks';
  static const String userBoxKey = 'user';

  static Future<Box> get tasksBox async => Hive.openBox(tasksBoxKey);
  static Future<Box> get userBox async => Hive.openBox(userBoxKey);
}

// ========== TASK PROVIDER ==========
class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      final box = await HiveService.tasksBox;
      final tasksData = box.get(tasksBoxKey);
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

  Future<void> _saveTasks() async {
    try {
      final box = await HiveService.tasksBox;
      await box.put(tasksBoxKey, state.map((task) => task.toJson()).toList());
    } catch (e) {
      print('Error saving tasks: $e');
    }
  }

  void addTask(Task task) {
    state = [task, ...state];
    _saveTasks();
  }

  void updateTask(int index, Task task) {
    state = [...state];
    state[index] = task;
    _saveTasks();
  }

  void deleteTask(int index) {
    state = [...state]..removeAt(index);
    _saveTasks();
  }

  void completeTask(int index) {
    state = [...state];
    state[index] = state[index].copyWith(isCompleted: true);
    _saveTasks();
  }

  List<Task> getActiveTasks() {
    return state.where((task) => !task.isCompleted).toList();
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

// ========== AUTH PROVIDER ==========
class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false) {
    _loadAuth();
  }

  String _username = '';
  String _email = '';

  String get username => _username;
  String get email => _email;

  Future<void> _loadAuth() async {
    try {
      final box = await HiveService.userBox;
      final authData = box.get('auth');
      if (authData != null) {
        final Map<String, dynamic> data = authData;
        _username = data['username'] ?? '';
        _email = data['email'] ?? '';
        state = data['isLoggedIn'] ?? false;
      }
    } catch (e) {
      print('Error loading auth: $e');
    }
  }

  Future<void> _saveAuth() async {
    try {
      final box = await HiveService.userBox;
      await box.put('auth', {
        'username': _username,
        'email': _email,
        'isLoggedIn': state,
      });
    } catch (e) {
      print('Error saving auth: $e');
    }
  }

  void login(String username, String email) {
    _username = username;
    _email = email;
    state = true;
    _saveAuth();
  }

  void loginDemo() {
    _username = 'Demo User';
    _email = 'demo@example.com';
    state = true;
    _saveAuth();
  }

  void logout() {
    state = false;
    _username = '';
    _email = '';
    _saveAuth();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});

// ========== GAMIFICATION PROVIDER ==========
class GamificationNotifier extends StateNotifier<UserStats> {
  GamificationNotifier() : super(const UserStats()) {
    _loadStats();
  }

  Future<void> _loadStats() async {
    try {
      final box = await HiveService.userBox;
      final statsData = box.get('gamification');
      if (statsData != null) {
        final Map<String, dynamic> data = statsData;
        state = UserStats(
          xp: data['xp'] ?? 0,
          level: data['level'] ?? 1,
          streak: data['streak'] ?? 0,
          lastTaskDate: data['lastTaskDate'] != null
              ? DateTime.fromMillisecondsSinceEpoch(data['lastTaskDate'])
              : null,
        );
      }
    } catch (e) {
      print('Error loading gamification stats: $e');
    }
  }

  Future<void> _saveStats() async {
    try {
      final box = await HiveService.userBox;
      await box.put('gamification', {
        'xp': state.xp,
        'level': state.level,
        'streak': state.streak,
        'lastTaskDate': state.lastTaskDate?.millisecondsSinceEpoch,
      });
    } catch (e) {
      print('Error saving gamification stats: $e');
    }
  }

  void addXP(int amount) {
    state = state.copyWith(xp: state.xp + amount);
    _updateLevel();
    _saveStats();
  }

  void _updateLevel() {
    final newLevel = (state.xp / 100).floor() + 1;
    if (newLevel > state.level) {
      state = state.copyWith(level: newLevel);
    }
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
    _saveStats();
  }

  void completeTask() {
    addXP(25);
    updateStreak();
  }
}

final gamificationProvider = StateNotifierProvider<GamificationNotifier, UserStats>((ref) {
  return GamificationNotifier();
});

// ========== USER STATS MODEL ==========
class UserStats {
  final int xp;
  final int level;
  final int streak;
  final DateTime? lastTaskDate;

  const UserStats({
    this.xp = 0,
    this.level = 1,
    this.streak = 0,
    this.lastTaskDate,
  });

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

// ========== FILTER PROVIDERS ==========
final categoryFilterProvider = StateProvider<String>((ref) {
  return 'All';
});

final priorityFilterProvider = StateProvider<String>((ref) {
  return 'All';
});
