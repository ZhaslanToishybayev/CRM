import 'package:shared_preferences/shared_preferences.dart';

class AISettingsService {
  static const String _apiKeyPref = 'zai_api_key';
  static const String _useLocalAI = 'use_local_ai';

  static final AISettingsService _instance = AISettingsService._internal();
  factory AISettingsService() => _instance;
  AISettingsService._internal();

  /// Получает сохраненный API ключ Z.AI
  Future<String?> getZAIApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_apiKeyPref);
  }

  /// Сохраняет API ключ Z.AI
  Future<bool> setZAIApiKey(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_apiKeyPref, apiKey);
  }

  /// Получает настройку использования локального AI
  Future<bool> getUseLocalAI() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_useLocalAI) ?? true; // По умолчанию локальный AI
  }

  /// Сохраняет настройку использования локального AI
  Future<bool> setUseLocalAI(bool useLocal) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_useLocalAI, useLocal);
  }

  /// Проверяет, настроен ли Z.AI API ключ
  Future<bool> isZAISetup() async {
    final apiKey = await getZAIApiKey();
    return apiKey != null && apiKey.isNotEmpty;
  }

  /// Очищает настройки
  Future<bool> clearSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final result1 = await prefs.remove(_apiKeyPref);
    final result2 = await prefs.remove(_useLocalAI);
    return result1 && result2;
  }

  /// Получает информацию о настройках
  Future<Map<String, dynamic>> getSettingsInfo() async {
    final apiKey = await getZAIApiKey();
    final useLocalAI = await getUseLocalAI();

    return {
      'hasApiKey': apiKey != null && apiKey.isNotEmpty,
      'apiKeyLength': apiKey?.length ?? 0,
      'useLocalAI': useLocalAI,
      'setupComplete': apiKey != null && apiKey.isNotEmpty,
    };
  }
}
