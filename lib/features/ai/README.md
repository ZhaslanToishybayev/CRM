# AI Planning Assistant Module

## 🧠 Обзор
AI Planning Assistant - это интеллектуальная система, которая помогает пользователям эффективно планировать и управлять своими задачами с помощью машинного обучения и анализа данных.

## ✨ Возможности

### 1. Умные Предложения (Smart Suggestions)
- Анализ загруженности работой
- Оптимизация дедлайнов
- Группировка задач по категориям
- Балансировка нагрузки
- Рекомендации по делегированию

### 2. Рекомендации Задач (Task Recommendations)
- Автоматическое создание задач
- Оценка времени выполнения
- Предложение приоритетов
- Рекомендации по категориям
- Подбор оптимального времени

### 3. Инсайты и Аналитика (AI Insights)
- Анализ продуктивности
- Выявление паттернов работы
- Рекомендации по улучшению
- Прогнозирование нагрузки
- Оптимизация рабочего процесса

## 🏗️ Архитектура

### Модели данных
- `AISuggestion` - Модель для умных предложений
- `TaskRecommendation` - Модель рекомендаций задач
- `AIInsight` - Модель инсайтов

### Сервисы
- `AIService` - Основной сервис для генерации AI-контента

### Провайдеры (Riverpod)
- `aiSuggestionsProvider` - Управление состоянием предложений
- `taskRecommendationsProvider` - Управление рекомендациями
- `aiInsightsProvider` - Управление инсайтами

### UI Компоненты
- `AIAssistantScreen` - Главный экран с вкладками
- `SuggestionCard` - Карточка предложения
- `RecommendationCard` - Карточка рекомендации
- `InsightCard` - Карточка инсайта

## 📁 Структура файлов

```
lib/features/ai/
├── models/
│   ├── ai_suggestion_model.dart
│   ├── ai_suggestion_model.freezed.dart
│   ├── ai_suggestion_model.g.dart
│   ├── task_recommendation_model.dart
│   ├── task_recommendation_model.freezed.dart
│   └── task_recommendation_model.g.dart
├── services/
│   └── ai_service.dart
├── providers/
│   └── ai_provider.dart
├── screens/
│   └── ai_assistant_screen.dart
├── widgets/
│   ├── suggestion_card.dart
│   ├── recommendation_card.dart
│   └── insight_card.dart
└── README.md
```

## 🎯 Использование

### Навигация
```dart
import 'package:gamified_task_app/core/router/app_router.dart';

// Переход к AI Assistant
AppRouter.goToAIAssistant(context);
```

### Получение предложений
```dart
final suggestionsAsync = ref.watch(aiSuggestionsProvider);

suggestionsAsync.when(
  data: (suggestions) => ...,
  loading: () => CircularProgressIndicator(),
  error: (error, _) => ...,
);
```

### Генерация новых рекомендаций
```dart
ref.read(taskRecommendationsProvider.notifier).refreshRecommendations();
```

## 🧪 Демо-данные

В текущей версии модуль использует демо-данные для демонстрации функциональности:
- 8 примеров задач
- Статистика пользователя
- Автоматическая генерация предложений на основе анализа

## 🔮 Планы развития

### Ближайшие обновления
- [ ] Интеграция с реальными данными из Supabase
- [ ] Машинное обучение для улучшения предложений
- [ ] Персонализация на основе истории пользователя
- [ ] Экспорт инсайтов в PDF

### Долгосрочные цели
- [ ] Интеграция с внешними AI API (OpenAI, Claude)
- [ ] Голосовой ассистент
- [ ] Предсказательное планирование
- [ ] Автоматизация рутинных задач

## 🤝 Вклад в проект

При разработке новых функций для AI модуля:
1. Следуйте архитектуре Clean Architecture
2. Используйте Riverpod для state management
3. Добавляйте тесты для новой логики
4. Документируйте изменения

## 📄 Лицензия

Все права защищены. Educational Project.
