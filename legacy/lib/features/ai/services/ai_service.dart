import 'dart:math';
import '../models/ai_suggestion_model.dart';
import '../models/task_recommendation_model.dart';

class AIService {
  static final AIService _instance = AIService._internal();
  factory AIService() => _instance;
  AIService._internal();

  final Random _random = Random();

  /// Генерирует умные предложения на основе анализа задач пользователя
  Future<List<AISuggestion>> generateSuggestions(
    List<dynamic> userTasks,
    Map<String, dynamic> userStats,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final suggestions = <AISuggestion>[];

    // Анализ перегрузки задач
    final activeTasks = userTasks
        .where((task) => task.status != 'completed')
        .length;

    if (activeTasks > 10) {
      suggestions.add(AISuggestion(
        id: 'sugg_${DateTime.now().millisecondsSinceEpoch}_1',
        title: 'У вас много активных задач',
        description:
            'Рекомендуем приоритизировать задачи и делегировать часть команды',
        type: AISuggestionType.workloadBalancing,
        priority: 3,
        confidence: 0.85,
        createdAt: DateTime.now(),
        reasons: ['Активных задач: $activeTasks', 'Рекомендуемый максимум: 7-10'],
        metadata: {'currentWorkload': activeTasks},
      ));
    }

    // Анализ дедлайнов
    final upcomingDeadlines = userTasks
        .where((task) =>
            task.dueDate != null &&
            task.dueDate.isBefore(DateTime.now().add(const Duration(days: 2))) &&
            task.status != 'completed')
        .length;

    if (upcomingDeadlines > 0) {
      suggestions.add(AISuggestion(
        id: 'sugg_${DateTime.now().millisecondsSinceEpoch}_2',
        title: 'Приближающиеся дедлайны',
        description:
            'У вас есть $upcomingDeadlines задач с дедлайном в ближайшие 2 дня',
        type: AISuggestionType.deadlineOptimization,
        priority: 2,
        confidence: 0.92,
        createdAt: DateTime.now(),
        reasons: ['Срочные задачи: $upcomingDeadlines', 'Риск просрочки'],
        metadata: {'urgentTasks': upcomingDeadlines},
      ));
    }

    // Предложение группировки задач
    final categories = <String>{};
    for (final task in userTasks) {
      if (task.category != null) {
        categories.add(task.category);
      }
    }

    if (categories.length > 3) {
      suggestions.add(AISuggestion(
        id: 'sugg_${DateTime.now().millisecondsSinceEpoch}_3',
        title: 'Оптимизация по категориям',
        description:
            'Попробуйте группировать задачи по проектам для лучшей концентрации',
        type: AISuggestionType.taskGrouping,
        priority: 1,
        confidence: 0.78,
        createdAt: DateTime.now(),
        reasons: ['Категорий: ${categories.length}', 'Рекомендуем: 3-5'],
        metadata: {'categories': categories.toList()},
      ));
    }

    return suggestions;
  }

  /// Генерирует рекомендации для создания новых задач
  Future<List<TaskRecommendation>> generateTaskRecommendations(
    List<dynamic> userTasks,
    Map<String, dynamic> userStats,
  ) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final recommendations = <TaskRecommendation>[];

    // Анализ паттернов пользователя
    final workTasks = userTasks
        .where((task) => task.category == 'Work')
        .length;
    final personalTasks = userTasks
        .where((task) => task.category == 'Personal')
        .length;

    if (workTasks > personalTasks * 2) {
      recommendations.add(TaskRecommendation(
        id: 'rec_${DateTime.now().millisecondsSinceEpoch}_1',
        title: 'Запланировать время для личных дел',
        description:
            'Рекомендуем добавить личные задачи для баланса работы и жизни',
        estimatedDuration: 60,
        recommendedDueDate: DateTime.now().add(const Duration(days: 3)),
        suggestedPriority: 2,
        suggestedCategory: 'Personal',
        tags: ['work-life-balance', 'self-care'],
        matchScore: 0.88,
        context: {
          'workTasks': workTasks,
          'personalTasks': personalTasks,
          'ratio': workTasks / max(1, personalTasks),
        },
      ));
    }

    // Предложение задач на основе текущей загрузки
    final lowPriorityTasks = userTasks
        .where((task) => task.priority == 1 && task.status != 'completed')
        .length;

    if (lowPriorityTasks < 2) {
      recommendations.add(TaskRecommendation(
        id: 'rec_${DateTime.now().millisecondsSinceEpoch}_2',
        title: 'Добавить стратегические задачи',
        description:
            'Рассмотрите добавление долгосрочных целей и планирования',
        estimatedDuration: 120,
        recommendedDueDate: DateTime.now().add(const Duration(days: 7)),
        suggestedPriority: 2,
        suggestedCategory: 'Work',
        tags: ['strategy', 'planning', 'goals'],
        matchScore: 0.75,
        context: {'strategy': 'long-term-planning'},
      ));
    }

    return recommendations;
  }

  /// Генерирует инсайты на основе анализа данных
  Future<List<AIInsight>> generateInsights(
    List<dynamic> userTasks,
    Map<String, dynamic> userStats,
  ) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final insights = <AIInsight>[];

    // Анализ продуктивности
    final completedTasks = userTasks
        .where((task) => task.status == 'completed')
        .length;
    final totalTasks = userTasks.length;

    if (totalTasks > 0) {
      final completionRate = completedTasks / totalTasks;
      if (completionRate > 0.8) {
        insights.add(AIInsight(
          id: 'insight_${DateTime.now().millisecondsSinceEpoch}_1',
          type: InsightType.productivity.name,
          title: 'Отличная продуктивность! 🎉',
          message:
              'Вы завершаете ${(completionRate * 100).toStringAsFixed(0)}% своих задач. Так держать!',
          importance: 0.9,
          createdAt: DateTime.now(),
          actions: ['continue-current-strategy', 'set-higher-goals'],
          data: {'completionRate': completionRate},
        ));
      } else if (completionRate < 0.5) {
        insights.add(AIInsight(
          id: 'insight_${DateTime.now().millisecondsSinceEpoch}_2',
          type: InsightType.productivity.name,
          title: 'Можно улучшить выполнение задач 💪',
          message:
              'Рекомендуем разбивать большие задачи на более мелкие',
          importance: 0.8,
          createdAt: DateTime.now(),
          actions: ['break-tasks-into-smaller', 'review-priorities'],
          data: {'completionRate': completionRate},
        ));
      }
    }

    // Анализ паттернов
    final weekdaysWithMostTasks = _analyzeWeekdayPatterns(userTasks);
    if (weekdaysWithMostTasks.isNotEmpty) {
      insights.add(AIInsight(
        id: 'insight_${DateTime.now().millisecondsSinceEpoch}_3',
        type: InsightType.patterns.name,
        title: 'Обнаружен паттерн работы',
        message:
            'Больше всего задач вы выполняете в: ${weekdaysWithMostTasks.join(', ')}',
        importance: 0.7,
        createdAt: DateTime.now(),
        actions: ['plan-intensive-tasks', 'optimize-schedule'],
        data: {'patternDays': weekdaysWithMostTasks},
      ));
    }

    return insights;
  }

  List<String> _analyzeWeekdayPatterns(List<dynamic> tasks) {
    final weekdayCount = <int, int>{};
    for (final task in tasks) {
      if (task.createdAt != null) {
        final weekday = task.createdAt.weekday;
        weekdayCount[weekday] = (weekdayCount[weekday] ?? 0) + 1;
      }
    }

    if (weekdayCount.isEmpty) return [];

    final maxCount = weekdayCount.values.reduce(max);
    return weekdayCount.entries
        .where((entry) => entry.value == maxCount)
        .map((entry) => _weekdayName(entry.key))
        .toList();
  }

  String _weekdayName(int weekday) {
    const names = [
      'Понедельник',
      'Вторник',
      'Среда',
      'Четверг',
      'Пятница',
      'Суббота',
      'Воскресенье'
    ];
    return names[weekday - 1];
  }

  /// Оценивает время выполнения задачи
  int estimateTaskDuration(Map<String, dynamic> task, List<dynamic> userTasks) {
    // Простая эвристика на основе категории и приоритета
    final category = task['category'] as String? ?? 'General';
    final priority = task['priority'] as int? ?? 2;

    int baseDuration = 60; // базовое время в минутах

    switch (category) {
      case 'Work':
        baseDuration = 90;
        break;
      case 'Personal':
        baseDuration = 45;
        break;
      case 'Health':
        baseDuration = 30;
        break;
      case 'Shopping':
        baseDuration = 30;
        break;
    }

    if (priority == 3) {
      baseDuration = (baseDuration * 1.5).round();
    } else if (priority == 1) {
      baseDuration = (baseDuration * 0.7).round();
    }

    return baseDuration;
  }

  /// Предлагает оптимальное время для задачи
  DateTime? suggestOptimalTiming(
    Map<String, dynamic> task,
    List<dynamic> userTasks,
  ) {
    final now = DateTime.now();
    final category = task['category'] as String? ?? 'General';

    // Простые рекомендации по времени
    switch (category) {
      case 'Work':
        return DateTime(now.year, now.month, now.day, 10, 0);
      case 'Health':
        return DateTime(now.year, now.month, now.day, 7, 0);
      case 'Personal':
        return DateTime(now.year, now.month, now.day, 18, 0);
    }

    return null;
  }
}
