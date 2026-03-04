import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/ai_suggestion_model.dart';
import '../models/task_recommendation_model.dart';

class GLMAIService {
  // Z.AI / GLM 4.6 API Endpoint
  static const String _baseUrl =
      'https://open.bigmodel.cn/api/paas/v4/chat/completions';
  // Pass via:
  // flutter run --dart-define=ZAI_API_KEY=...
  static const String _apiKey = String.fromEnvironment(
    'ZAI_API_KEY',
    defaultValue: '',
  );

  static final GLMAIService _instance = GLMAIService._internal();
  factory GLMAIService() => _instance;
  GLMAIService._internal();

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 25),
      sendTimeout: const Duration(seconds: 10),
    ),
  );

  /// Генерирует умные предложения используя GLM 4.6
  Future<List<AISuggestion>> generateSuggestionsWithGLM(
    List<dynamic> userTasks,
    Map<String, dynamic> userStats,
  ) async {
    try {
      final prompt = _buildSuggestionsPrompt(userTasks, userStats);
      final response = await _callGLM(prompt);

      return _parseSuggestionsResponse(response);
    } catch (_) {
      // Fallback к локальным алгоритмам
      return _generateLocalSuggestions(userTasks, userStats);
    }
  }

  /// Генерирует рекомендации задач используя GLM
  Future<List<TaskRecommendation>> generateTaskRecommendationsWithGLM(
    List<dynamic> userTasks,
    Map<String, dynamic> userStats,
  ) async {
    try {
      final prompt = _buildRecommendationsPrompt(userTasks, userStats);
      final response = await _callGLM(prompt);

      return _parseRecommendationsResponse(response);
    } catch (_) {
      return _generateLocalRecommendations(userTasks, userStats);
    }
  }

  /// Вызывает GLM API
  Future<String> _callGLM(String prompt) async {
    if (_apiKey.isEmpty) {
      throw StateError(
        'Missing ZAI_API_KEY. Provide it via --dart-define=ZAI_API_KEY=...',
      );
    }

    final response = await _dio.post(
      _baseUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'model': 'glm-4-plus',
        'messages': [
          {
            'role': 'system',
            'content':
                'Ты - AI ассистент для управления задачами. Всегда отвечай ТОЛЬКО валидным JSON без дополнительного текста. Не используй markdown форматирование. Начинай ответ с { и заканчивай }.',
          },
          {'role': 'user', 'content': prompt},
        ],
        'temperature': 0.8,
        'top_p': 0.95,
        'max_tokens': 2000,
        'stream': false,
      },
    );

    if (response.statusCode == 200) {
      final content = response.data['choices'][0]['message']['content'];
      return content;
    } else {
      throw Exception(
        'Z.AI API Error (${response.statusCode}): ${response.statusMessage}',
      );
    }
  }

  /// Строит промпт для генерации предложений
  String _buildSuggestionsPrompt(
    List<dynamic> tasks,
    Map<String, dynamic> stats,
  ) {
    final taskCount = tasks.length;
    final completedCount = tasks
        .where((t) => t['status'] == 'completed')
        .length;
    final categories = tasks.map((t) => t['category']).toSet().join(', ');

    return '''
Проанализируй задачи пользователя и предложи улучшения.

Статистика:
- Всего задач: $taskCount
- Завершено: $completedCount
- Категории: $categories
- Уровень: ${stats['level']}
- XP: ${stats['xp']}
- Стрик: ${stats['streak']}

Задачи (JSON):
${jsonEncode(tasks)}

Верни JSON массив с предложениями:
{
  "suggestions": [
    {
      "title": "Заголовок",
      "description": "Описание",
      "type": "workloadBalancing|deadlineOptimization|taskGrouping|priorityAdjustment|taskCreation",
      "priority": 1,
      "confidence": 0.8,
      "reasons": ["причина1", "причина2"]
    }
  ]
}
Ограничения:
- 3-5 предложений
- Разные типы
- Приоритеты: 1=низкий, 2=средний, 3=высокий
- Уверенность: 0.0-1.0
''';
  }

  /// Строит промпт для рекомендаций
  String _buildRecommendationsPrompt(
    List<dynamic> tasks,
    Map<String, dynamic> stats,
  ) {
    return '''
На основе задач пользователя предложи новые задачи для добавления.

Статистика:
- Уровень: ${stats['level']}
- XP: ${stats['xp']}
- Стрик: ${stats['streak']}

Текущие задачи:
${jsonEncode(tasks)}

Верни JSON с рекомендациями:
{
  "recommendations": [
    {
      "title": "Заголовок задачи",
      "description": "Описание",
      "estimatedDuration": 60,
      "suggestedPriority": 2,
      "suggestedCategory": "Work|Personal|Health|Shopping|General",
      "tags": ["тег1", "тег2"],
      "matchScore": 0.85
    }
  ]
}
Ограничения:
- 2-3 рекомендации
- Разные категории
- Время в минутах: 15-240
- Приоритеты: 1=низкий, 2=средний, 3=высокий
- Match Score: 0.0-1.0
''';
  }

  /// Парсит ответ GLM для предложений
  List<AISuggestion> _parseSuggestionsResponse(String response) {
    try {
      final json = jsonDecode(response);
      final suggestionsJson = json['suggestions'] as List;

      return suggestionsJson
          .map(
            (s) => AISuggestion(
              id: 'glm_${DateTime.now().millisecondsSinceEpoch}_${suggestionsJson.indexOf(s)}',
              title: s['title'] as String,
              description: s['description'] as String,
              type: _parseSuggestionType(s['type'] as String),
              priority: s['priority'] as int,
              confidence: (s['confidence'] as num).toDouble(),
              createdAt: DateTime.now(),
              reasons: List<String>.from(s['reasons'] ?? []),
            ),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// Парсит ответ GLM для рекомендаций
  List<TaskRecommendation> _parseRecommendationsResponse(String response) {
    try {
      final json = jsonDecode(response);
      final recommendationsJson = json['recommendations'] as List;

      return recommendationsJson
          .map(
            (r) => TaskRecommendation(
              id: 'glm_rec_${DateTime.now().millisecondsSinceEpoch}_${recommendationsJson.indexOf(r)}',
              title: r['title'] as String,
              description: r['description'] as String,
              estimatedDuration: r['estimatedDuration'] as int,
              recommendedDueDate: DateTime.now().add(
                Duration(days: r['estimatedDuration'] ~/ 60),
              ),
              suggestedPriority: r['suggestedPriority'] as int,
              suggestedCategory: r['suggestedCategory'] as String,
              tags: List<String>.from(r['tags'] ?? []),
              matchScore: (r['matchScore'] as num).toDouble(),
            ),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// Fallback: локальные алгоритмы при недоступности GLM
  List<AISuggestion> _generateLocalSuggestions(
    List<dynamic> tasks,
    Map<String, dynamic> stats,
  ) {
    final suggestions = <AISuggestion>[];

    final activeTasks = tasks.where((t) => t['status'] != 'completed').length;

    if (activeTasks > 10) {
      suggestions.add(
        AISuggestion(
          id: 'local_${DateTime.now().millisecondsSinceEpoch}_1',
          title: 'Много активных задач',
          description: 'Рекомендуем приоритизировать задачи (локальный анализ)',
          type: AISuggestionType.workloadBalancing,
          priority: 3,
          confidence: 0.75,
          createdAt: DateTime.now(),
          reasons: ['Активных задач: $activeTasks'],
        ),
      );
    }

    return suggestions;
  }

  List<TaskRecommendation> _generateLocalRecommendations(
    List<dynamic> tasks,
    Map<String, dynamic> stats,
  ) {
    return [
      TaskRecommendation(
        id: 'local_rec_${DateTime.now().millisecondsSinceEpoch}',
        title: 'Рекомендуемая задача',
        description: 'Задача создана локальным анализом',
        estimatedDuration: 60,
        recommendedDueDate: DateTime.now().add(const Duration(days: 3)),
        suggestedPriority: 2,
        suggestedCategory: 'Work',
        tags: ['local', 'generated'],
        matchScore: 0.7,
      ),
    ];
  }

  AISuggestionType _parseSuggestionType(String type) {
    switch (type) {
      case 'workloadBalancing':
        return AISuggestionType.workloadBalancing;
      case 'deadlineOptimization':
        return AISuggestionType.deadlineOptimization;
      case 'taskGrouping':
        return AISuggestionType.taskGrouping;
      case 'priorityAdjustment':
        return AISuggestionType.priorityAdjustment;
      case 'taskCreation':
        return AISuggestionType.taskCreation;
      default:
        return AISuggestionType.taskCreation;
    }
  }
}
