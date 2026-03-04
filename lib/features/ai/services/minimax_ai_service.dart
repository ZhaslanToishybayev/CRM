// Minimax M2 AI service for chat assistant.

import 'dart:developer' as developer;

import 'package:dio/dio.dart';

enum AIChatErrorType { configuration, timeout, network, server, unknown }

class AIChatException implements Exception {
  final AIChatErrorType type;
  final String userMessage;

  const AIChatException(this.type, this.userMessage);

  @override
  String toString() => userMessage;
}

class MinimaxAIService {
  // Minimax API Endpoint
  static const String _baseUrl =
      'https://api.minimax.chat/v1/text/chatcompletion_v2';

  // Configure via --dart-define=MINIMAX_API_KEY=...
  static const String _apiKey = String.fromEnvironment(
    'MINIMAX_API_KEY',
    defaultValue: '',
  );

  // Optional explicit demo mode for presentations.
  static const bool _demoMode = bool.fromEnvironment(
    'AI_DEMO_MODE',
    defaultValue: false,
  );

  static final MinimaxAIService _instance = MinimaxAIService._internal();
  factory MinimaxAIService() => _instance;
  MinimaxAIService._internal();

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 25),
      sendTimeout: const Duration(seconds: 10),
    ),
  );

  /// Sends a chat message to Minimax API.
  Future<String> sendMessage(
    String message,
    List<Map<String, String>> conversationHistory,
  ) async {
    if (_demoMode) {
      developer.log('event=ai_request_demo provider=minimax');
      return _getDemoResponse(message);
    }

    if (_apiKey.isEmpty) {
      developer.log(
        'event=ai_request_fail provider=minimax reason=missing_api_key',
      );
      throw const AIChatException(
        AIChatErrorType.configuration,
        'AI сервис не настроен. Добавьте MINIMAX_API_KEY и перезапустите приложение.',
      );
    }

    try {
      final response = await _callMinimax(message, conversationHistory);
      developer.log('event=ai_request_success provider=minimax');
      return response;
    } on DioException catch (error) {
      developer.log(
        'event=ai_request_fail provider=minimax reason=${error.type.name}',
      );
      throw _mapDioException(error);
    } on AIChatException {
      rethrow;
    } catch (_) {
      developer.log('event=ai_request_fail provider=minimax reason=unknown');
      throw const AIChatException(
        AIChatErrorType.unknown,
        'Не удалось получить ответ AI. Повторите попытку.',
      );
    }
  }

  AIChatException _mapDioException(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return const AIChatException(
        AIChatErrorType.timeout,
        'Таймаут AI сервиса. Проверьте сеть и попробуйте снова.',
      );
    }

    if (error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.unknown) {
      return const AIChatException(
        AIChatErrorType.network,
        'Нет подключения к AI сервису. Проверьте интернет и попробуйте снова.',
      );
    }

    final statusCode = error.response?.statusCode;
    if (statusCode != null && statusCode >= 500) {
      return const AIChatException(
        AIChatErrorType.server,
        'AI сервис временно недоступен (5xx). Попробуйте еще раз.',
      );
    }

    return const AIChatException(
      AIChatErrorType.server,
      'AI сервис вернул ошибку. Попробуйте еще раз.',
    );
  }

  Future<String> _callMinimax(
    String message,
    List<Map<String, String>> history,
  ) async {
    final messages = <Map<String, String>>[
      {
        'role': 'system',
        'content': '''Ты - AI ассистент в CRM системе управления задачами.
Твоя роль:
- Помогать пользователям с организацией задач
- Давать советы по продуктивности
- Отвечать на вопросы о работе с CRM
- Предлагать решения проблем

Всегда отвечай на русском языке.
Будь дружелюбным, полезным и кратким.
Если не знаешь ответа - честно скажи об этом.''',
      },
      ...history,
      {'role': 'user', 'content': message},
    ];

    final response = await _dio.post(
      _baseUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'model': 'abab6.5s-chat',
        'messages': messages,
        'temperature': 0.7,
        'top_p': 0.9,
        'max_tokens': 1024,
        'stream': false,
      },
    );

    if (response.statusCode != 200) {
      throw const AIChatException(
        AIChatErrorType.server,
        'AI сервис вернул ошибку. Попробуйте еще раз.',
      );
    }

    final content = response.data['choices']?[0]?['message']?['content'];
    if (content is! String || content.trim().isEmpty) {
      throw const AIChatException(
        AIChatErrorType.server,
        'AI сервис вернул пустой ответ. Попробуйте еще раз.',
      );
    }

    return content;
  }

  String _getDemoResponse(String message) {
    return 'DEMO MODE: запрос "$message" принят. Для реального ответа отключите AI_DEMO_MODE и задайте MINIMAX_API_KEY.';
  }

  bool get isConfigured => _apiKey.isNotEmpty;
  bool get isDemoMode => _demoMode;

  void setApiKey(String apiKey) {
    // Runtime mutation is intentionally not supported for security reasons.
    // Use --dart-define=MINIMAX_API_KEY=... on startup.
    if (apiKey.isEmpty) return;
  }
}
