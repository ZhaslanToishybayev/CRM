import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ai_suggestion_model.dart';
import '../models/task_recommendation_model.dart';
import '../services/ai_service.dart';
import '../services/glm_ai_service.dart';
import '../services/ai_settings_service.dart';
import '../repositories/ai_repository.dart';

final aiServiceProvider = Provider<AIService>((ref) {
  return AIService();
});

final glmAIServiceProvider = Provider<GLMAIService>((ref) {
  return GLMAIService();
});

final aiRepositoryProvider = Provider<AIRepository>((ref) {
  return AIRepository();
});

final aiSettingsServiceProvider = Provider<AISettingsService>((ref) {
  return AISettingsService();
});

final useGLMProvider = StateProvider<bool>((ref) {
  return false; // По умолчанию используем локальные алгоритмы
});

final aiSettingsInfoProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final settings = ref.read(aiSettingsServiceProvider);
  return await settings.getSettingsInfo();
});

// Providers для AI suggestions
final aiSuggestionsProvider =
    StateNotifierProvider<AISuggestionsNotifier, AsyncValue<List<AISuggestion>>>((ref) {
  return AISuggestionsNotifier(ref);
});

// Providers для task recommendations
final taskRecommendationsProvider = StateNotifierProvider<TaskRecommendationsNotifier,
    AsyncValue<List<TaskRecommendation>>>((ref) {
  return TaskRecommendationsNotifier(ref);
});

// Providers для AI insights
final aiInsightsProvider =
    StateNotifierProvider<AIInsightsNotifier, AsyncValue<List<AIInsight>>>((ref) {
  return AIInsightsNotifier(ref);
});

class AISuggestionsNotifier extends StateNotifier<AsyncValue<List<AISuggestion>>> {
  AISuggestionsNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadSuggestions();
  }

  final Ref ref;

  Future<void> loadSuggestions() async {
    try {
      final useGLM = ref.read(useGLMProvider);
      final tasks = await _getUserTasks();
      final stats = await _getUserStats();

      List<AISuggestion> suggestions;

      if (useGLM) {
        final glmService = ref.read(glmAIServiceProvider);
        suggestions = await glmService.generateSuggestionsWithGLM(tasks, stats);
      } else {
        final aiService = ref.read(aiServiceProvider);
        suggestions = await aiService.generateSuggestions(tasks, stats);
      }

      state = AsyncValue.data(suggestions);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshSuggestions() async {
    state = const AsyncValue.loading();
    await loadSuggestions();
  }

  Future<List<dynamic>> _getUserTasks() async {
    // Демо-данные для демонстрации
    return [
      {'id': '1', 'title': 'Task 1', 'category': 'Work', 'priority': 3, 'status': 'in_progress'},
      {'id': '2', 'title': 'Task 2', 'category': 'Work', 'priority': 2, 'status': 'pending'},
      {'id': '3', 'title': 'Task 3', 'category': 'Personal', 'priority': 1, 'status': 'completed'},
      {'id': '4', 'title': 'Task 4', 'category': 'Work', 'priority': 2, 'status': 'pending'},
      {'id': '5', 'title': 'Task 5', 'category': 'Work', 'priority': 3, 'status': 'pending'},
      {'id': '6', 'title': 'Task 6', 'category': 'Work', 'priority': 1, 'status': 'pending'},
      {'id': '7', 'title': 'Task 7', 'category': 'Personal', 'priority': 2, 'status': 'pending'},
      {'id': '8', 'title': 'Task 8', 'category': 'Health', 'priority': 2, 'status': 'pending'},
    ];
  }

  Future<Map<String, dynamic>> _getUserStats() async {
    return {
      'level': 5,
      'xp': 250,
      'streak': 3,
      'completedTasks': 15,
      'totalTasks': 20,
    };
  }
}

class TaskRecommendationsNotifier
    extends StateNotifier<AsyncValue<List<TaskRecommendation>>> {
  TaskRecommendationsNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadRecommendations();
  }

  final Ref ref;

  Future<void> loadRecommendations() async {
    try {
      final aiService = ref.read(aiServiceProvider);
      final tasks = await _getUserTasks();
      final stats = await _getUserStats();

      final recommendations = await aiService.generateTaskRecommendations(tasks, stats);
      state = AsyncValue.data(recommendations);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshRecommendations() async {
    state = const AsyncValue.loading();
    await loadRecommendations();
  }

  Future<List<dynamic>> _getUserTasks() async {
    final repository = ref.read(aiRepositoryProvider);
    final userId = repository.getCurrentUserId();

    if (userId == null) {
      // Fallback к демо-данным если не авторизован
      return [
        {'id': '1', 'title': 'Task 1', 'category': 'Work', 'priority': 3, 'status': 'in_progress'},
        {'id': '2', 'title': 'Task 2', 'category': 'Work', 'priority': 2, 'status': 'pending'},
        {'id': '3', 'title': 'Task 3', 'category': 'Personal', 'priority': 1, 'status': 'completed'},
        {'id': '4', 'title': 'Task 4', 'category': 'Work', 'priority': 2, 'status': 'pending'},
        {'id': '5', 'title': 'Task 5', 'category': 'Work', 'priority': 3, 'status': 'pending'},
        {'id': '6', 'title': 'Task 6', 'category': 'Work', 'priority': 1, 'status': 'pending'},
        {'id': '7', 'title': 'Task 7', 'category': 'Personal', 'priority': 2, 'status': 'pending'},
        {'id': '8', 'title': 'Task 8', 'category': 'Health', 'priority': 2, 'status': 'pending'},
      ];
    }

    return await repository.getUserTasks(userId);
  }

  Future<Map<String, dynamic>> _getUserStats() async {
    final repository = ref.read(aiRepositoryProvider);
    final userId = repository.getCurrentUserId();

    if (userId == null) {
      return {
        'level': 1,
        'xp': 0,
        'streak': 0,
        'completedTasks': 0,
        'totalTasks': 0,
      };
    }

    return await repository.getUserStats(userId);
  }
}

class AIInsightsNotifier extends StateNotifier<AsyncValue<List<AIInsight>>> {
  AIInsightsNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadInsights();
  }

  final Ref ref;

  Future<void> loadInsights() async {
    try {
      final aiService = ref.read(aiServiceProvider);
      final tasks = await _getUserTasks();
      final stats = await _getUserStats();

      final insights = await aiService.generateInsights(tasks, stats);
      state = AsyncValue.data(insights);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshInsights() async {
    state = const AsyncValue.loading();
    await loadInsights();
  }

  Future<List<dynamic>> _getUserTasks() async {
    final repository = ref.read(aiRepositoryProvider);
    final userId = repository.getCurrentUserId();

    if (userId == null) {
      // Fallback к демо-данным если не авторизован
      return [
        {'id': '1', 'title': 'Task 1', 'category': 'Work', 'priority': 3, 'status': 'in_progress'},
        {'id': '2', 'title': 'Task 2', 'category': 'Work', 'priority': 2, 'status': 'pending'},
        {'id': '3', 'title': 'Task 3', 'category': 'Personal', 'priority': 1, 'status': 'completed'},
        {'id': '4', 'title': 'Task 4', 'category': 'Work', 'priority': 2, 'status': 'pending'},
        {'id': '5', 'title': 'Task 5', 'category': 'Work', 'priority': 3, 'status': 'pending'},
        {'id': '6', 'title': 'Task 6', 'category': 'Work', 'priority': 1, 'status': 'pending'},
        {'id': '7', 'title': 'Task 7', 'category': 'Personal', 'priority': 2, 'status': 'pending'},
        {'id': '8', 'title': 'Task 8', 'category': 'Health', 'priority': 2, 'status': 'pending'},
      ];
    }

    return await repository.getUserTasks(userId);
  }

  Future<Map<String, dynamic>> _getUserStats() async {
    final repository = ref.read(aiRepositoryProvider);
    final userId = repository.getCurrentUserId();

    if (userId == null) {
      return {
        'level': 1,
        'xp': 0,
        'streak': 0,
        'completedTasks': 0,
        'totalTasks': 0,
      };
    }

    return await repository.getUserStats(userId);
  }
}
