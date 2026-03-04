import 'dart:convert';
import '../../../core/supabase/supabase_config.dart';

class AIRepository {
  static final AIRepository _instance = AIRepository._internal();
  factory AIRepository() => _instance;
  AIRepository._internal();

  final _supabase = SupabaseConfig.client;

  /// Получает все задачи пользователя из Supabase
  Future<List<Map<String, dynamic>>> getUserTasks(String userId) async {
    try {
      final response = await _supabase
          .from('tasks')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final tasks = response as List;
      return tasks.map((task) => Map<String, dynamic>.from(task)).toList();
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }

  /// Получает статистику пользователя
  Future<Map<String, dynamic>> getUserStats(String userId) async {
    try {
      final response = await _supabase
          .from('user_stats')
          .select()
          .eq('id', userId)
          .single();

      return Map<String, dynamic>.from(response);
    } catch (e) {
      print('Error fetching user stats: $e');
      return {
        'level': 1,
        'xp': 0,
        'streak': 0,
        'completed_tasks': 0,
        'total_tasks': 0,
      };
    }
  }

  /// Создает новую задачу на основе рекомендации AI
  Future<bool> createTaskFromRecommendation(
    String userId,
    Map<String, dynamic> recommendation,
  ) async {
    try {
      final task = {
        'user_id': userId,
        'title': recommendation['title'],
        'description': recommendation['description'] ?? '',
        'category': recommendation['suggestedCategory'],
        'priority': recommendation['suggestedPriority'],
        'status': 'pending',
        'created_at': DateTime.now().toIso8601String(),
      };

      await _supabase.from('tasks').insert(task);
      return true;
    } catch (e) {
      print('Error creating task: $e');
      return false;
    }
  }

  /// Применяет предложение AI (например, перегруппировка)
  Future<bool> applySuggestion(
    String userId,
    Map<String, dynamic> suggestion,
  ) async {
    try {
      // В зависимости от типа предложения
      final type = suggestion['type'];

      switch (type) {
        case 'workloadBalancing':
          return await _redistributeTasks(userId);
        case 'taskGrouping':
          return await _groupTasksByCategory(userId);
        case 'deadlineOptimization':
          return await _optimizeDeadlines(userId);
        default:
          return false;
      }
    } catch (e) {
      print('Error applying suggestion: $e');
      return false;
    }
  }

  Future<bool> _redistributeTasks(String userId) async {
    // Логика перераспределения задач
    print('Applying workload balancing for user: $userId');
    return true;
  }

  Future<bool> _groupTasksByCategory(String userId) async {
    // Логика группировки задач
    print('Grouping tasks by category for user: $userId');
    return true;
  }

  Future<bool> _optimizeDeadlines(String userId) async {
    // Логика оптимизации дедлайнов
    print('Optimizing deadlines for user: $userId');
    return true;
  }

  /// Получает анализ продуктивности пользователя
  Future<Map<String, dynamic>> getProductivityAnalysis(String userId) async {
    try {
      final tasks = await getUserTasks(userId);

      final completedTasks = tasks.where((t) => t['status'] == 'completed').length;
      final totalTasks = tasks.length;
      final completionRate = totalTasks > 0 ? completedTasks / totalTasks : 0.0;

      // Анализ по категориям
      final categoryStats = <String, int>{};
      for (final task in tasks) {
        final category = task['category'] ?? 'General';
        categoryStats[category] = (categoryStats[category] ?? 0) + 1;
      }

      // Анализ по приоритетам
      final priorityStats = <int, int>{};
      for (final task in tasks) {
        final priority = task['priority'] ?? 2;
        priorityStats[priority] = (priorityStats[priority] ?? 0) + 1;
      }

      return {
        'totalTasks': totalTasks,
        'completedTasks': completedTasks,
        'completionRate': completionRate,
        'categoryStats': categoryStats,
        'priorityStats': priorityStats,
        'lastUpdated': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      print('Error getting productivity analysis: $e');
      return {};
    }
  }

  /// Получает текущего пользователя
  String? getCurrentUserId() {
    final user = _supabase.auth.currentUser;
    return user?.id;
  }

  /// Проверяет, авторизован ли пользователь
  bool isUserAuthenticated() {
    return _supabase.auth.currentUser != null;
  }
}
