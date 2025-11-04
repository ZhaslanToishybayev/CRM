# 📋 План трансформации в корпоративное приложение для управления рабочими задачами

**Дата создания**: 3 ноября 2025
**Текущий статус**: Gamified Task App (80% готовности)
**Цель**: Полноценное корпоративное мобильное приложение для организации рабочих задач с геймификацией

---

## 🎯 **ТЕКУЩЕЕ СОСТОЯНИЕ ПРОЕКТА**

### ✅ Что уже готово:
- ✅ Базовое управление задачами (CRUD)
- ✅ Система геймификации (XP, уровни, стрики, достижения)
- ✅ Аутентификация (Supabase)
- ✅ Локальное хранилище (Hive)
- ✅ Модульная архитектура (features)
- ✅ Riverpod state management
- ✅ Material Design UI

### ⚠️ Что нужно трансформировать:
- Переориентировать с личных задач на рабочие
- Добавить командные функции
- Внедрить роли и права доступа
- Создать систему проектов
- Добавить отчетность и аналитику
- Интегрировать с корпоративными инструментами
- Усилить безопасность

---

## 📊 **ЭТАПЫ ТРАНСФОРМАЦИИ**

### **ЭТАП 1: Анализ требований и планирование архитектуры** ⏱️ 3-5 дней

#### 1.1 Исследование корпоративных требований
**Цель**: Определить специфику рабочих задач vs личных задач

**Задачи**:
- [ ] Изучить лучшие практики управления проектами (Jira, Asana, Monday.com)
- [ ] Определить ключевые отличия рабочих задач:
  - Привязка к проектам/департаментам
  - Задачи от менеджеров/коллег
  - Сроки и deadline'ы критичны
  - Отчетность и прозрачность
  - Командная координация
- [ ] Проанализировать потребности в геймификации:
  - Мотивация продуктивности
  - Командные достижения
  - KPI и метрики

#### 1.2 Проектирование новой архитектуры
**Модули для добавления/расширения**:

```
lib/features/
├── organizations/          # 🆕 Организации/Компании
│   ├── models/            # Organization, Department
│   ├── providers/         # OrganizationProvider
│   └── repositories/      # OrganizationRepository
├── projects/              # 🆕 Проекты
│   ├── models/            # Project, ProjectStatus
│   ├── screens/           # ProjectList, ProjectDetails
│   └── services/          # ProjectService
├── teams/                 # 🆕 Команды
│   ├── models/            # Team, TeamMember, Role
│   ├── screens/           # TeamList, TeamDetails
│   └── services/          # TeamService
├── assignments/           # 🆕 Назначение задач
│   ├── models/            # Assignment, Assignee
│   └── services/          # AssignmentService
├── reports/               # 🆕 Отчетность
│   ├── models/            # Report, Analytics
│   ├── screens/           # Dashboard, Reports
│   └── services/          # ReportService
├── notifications/         # 🆕 Уведомления
│   ├── services/          # NotificationService
│   └── providers/         # NotificationProvider
└── integrations/          # 🆕 Интеграции
    ├── calendar/          # Google Calendar, Outlook
    ├── messaging/         # Slack, Teams
    └── email/             # Email notifications
```

#### 1.3 Обновление моделей данных

**Текущая TaskModel** → **Новая WorkTaskModel**:
```dart
@freezed
class WorkTaskModel with _$WorkTaskModel {
  const factory WorkTaskModel({
    required String id,
    required String userId,
    required String title,
    String? description,
    required int xp,
    required TaskPriority priority,
    required TaskStatus status,
    DateTime? dueDate,
    String? category,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,

    // 🆕 Новые поля для корпоративного использования
    required String organizationId,
    String? projectId,           // Привязка к проекту
    String? departmentId,        // Департамент
    String? assignedBy,          // Кто назначил
    List<String>? assignedTo,    // Кому назначено (команда)
    required TaskType type,      // Тип: personal/project/team
    int? estimatedHours,         // Оценка времени
    int? actualHours,            // Фактическое время
    TaskSource source,           // Источник: manual/email/calendar
    bool billable,               // Оплачиваемая задача
    String? parentTaskId,        // Подзадачи
  }) = _WorkTaskModel;
}

// 🆕 Новые enum'ы
enum TaskType {
  personal,  // Личная задача
  project,   // Проектная задача
  team,      // Командная задача
}

enum TaskSource {
  manual,    // Создана вручную
  email,     // Из email
  calendar,  // Из календаря
  slack,     // Из Slack
}
```

**Новые модели**:
- OrganizationModel
- DepartmentModel
- ProjectModel
- TeamModel
- TeamMemberModel (с ролями: employee, manager, admin)
- ReportModel
- NotificationModel

---

### **ЭТАП 2: Система команд и коллаборации** ⏱️ 5-7 дней

#### 2.1 Роли и права доступа
**Роли пользователей**:
```
👤 EMPLOYEE (Сотрудник)
  ✅ Свои личные задачи
  ✅ Назначенные мне задачи
  ✅ Командные задачи (только просмотр/выполнение)
  ✅ Свой профиль и статистика

👥 MANAGER (Менеджер)
  ✅ Все права EMPLOYEE
  ✅ Создание задач для команды
  ✅ Назначение задач
  ✅ Просмотр отчетов команды
  ✅ Управление проектами
  ✅ Создание достижений для команды

🏢 ADMIN (Администратор)
  ✅ Все права MANAGER
  ✅ Создание организаций
  ✅ Управление департаментами
  ✅ Настройка системы
  ✅ Просмотр всех отчетов
  ✅ Управление пользователями
```

#### 2.2 Функции командной работы
**Задачи команды**:
- [ ] Создание задач с назначением на команду
- [ ] Делегирование задач между членами команды
- [ ] Комментарии и обсуждения к задачам
- [ ] @упоминания коллег
- [ ] Файловые вложения
- [ ] История изменений задачи

**Реализация**:
```dart
// team_service.dart
class TeamService {
  /// Создать команду
  Future<Team> createTeam({
    required String name,
    required String departmentId,
    required List<String> memberIds,
    required String createdBy,
  });

  /// Назначить задачу команде
  Future<void> assignTaskToTeam({
    required String taskId,
    required String teamId,
    String? assignedBy,
  });

  /// Переназначить задачу
  Future<void> reassignTask({
    required String taskId,
    required String newAssigneeId,
    String? reason,
  });

  /// Получить задачи команды
  Future<List<WorkTaskModel>> getTeamTasks(String teamId);

  /// Получить статистику команды
  Future<TeamStats> getTeamStats(String teamId);
}
```

#### 2.3 Система проектов
**Структура проектов**:
```
📁 Project (Проект)
├── name, description
├── startDate, endDate
├── status (planning/active/on-hold/completed)
├── department
├── team
├── budget
├── priority
└── tasks[]

📊 Project Dashboard
├── Прогресс (выполнено/всего)
├── Временные затраты (оценка/факт)
├── Команда проекта
├── Ближайшие deadline'ы
└── Геймификация проекта
```

---

### **ЭТАП 3: Улучшение системы геймификации** ⏱️ 4-6 дней

#### 3.1 Типы достижений для работы
**Рабочие достижения**:
```
🔥 PRODUCTIVITY (Продуктивность)
├── "Early Bird" - выполнил 5 задач до 9:00
├── "Night Owl" - выполнил 5 задач после 20:00
├── "Speed Demon" - завершил задачу за 1 час
├── "Marathon" - работал 8 часов подряд
└── "Consistency" - 30 дней подряд выполнил ≥1 задачу

👥 TEAMWORK (Командная работа)
├── "Team Player" - помог коллеге с задачей
├── "Mentor" - обучил нового сотрудника
├── "Problem Solver" - решил сложную задачу команды
├── "Collaboration" - участвовал в 10 командных задачах
└── "Leadership" - успешно завершил проект как тимлид

🎯 ACHIEVEMENT (Достижения)
├── "Deadline Crusher" - ни одной просроченной задачи за месяц
├── "Quality Master" - 100% оценка качества (рейтинг от менеджера)
├── "Initiative" - предложил 3 улучшения процесса
├── "Multi-tasker" - работает над 5 задачами одновременно
└── "Goal Crusher" - достиг всех целей квартала

📈 GROWTH (Рост)
├── "Level Up" - достиг 10 уровня
├── "Knowledge Seeker" - изучил 5 новых навыков
├── "Certificate Hunter" - получил 3 сертификата
├── "Expert" - стал экспертом в своей области
└── "Innovation" - предложил инновационное решение
```

#### 3.2 Командные достижения
**Геймификация команды**:
```
🏆 TEAM ACHIEVEMENTS
├── "Synchronized" - вся команда выполнила задачи за день
├── "Zero Debt" - команда без просроченных задач неделю
├── "Sprint Champions" - завершили проект досрочно
├── "Team Spirit" - 100% участие в командных задачах
└── "Department Pride" - лучший департамент компании

🎮 TEAM COMPETITION
├── Еженедельный рейтинг команд
├── Баллы за командные достижения
├── Специальные награды за сотрудничество
└── Общий лидерборд компании
```

#### 3.3 Система XP для работы
**Новые источники XP**:
```dart
class WorkXPService {
  /// Базовая XP за задачу
  static int getTaskXP(WorkTaskModel task) {
    int baseXP = task.xp;
    int priorityMultiplier = {
      TaskPriority.low: 1,
      TaskPriority.medium: 1.5,
      TaskPriority.high: 2,
      TaskPriority.urgent: 3,
    }[task.priority]!;

    int typeMultiplier = {
      TaskType.personal: 1,
      TaskType.project: 1.5,
      TaskType.team: 2,
    }[task.type]!;

    return (baseXP * priorityMultiplier * typeMultiplier).round();
  }

  /// Бонус за скорость
  static int getSpeedBonus(WorkTaskModel task) {
    if (task.completedAt == null || task.dueDate == null) return 0;

    final completedEarly = task.completedAt!.isBefore(task.dueDate!);
    if (!completedEarly) return 0;

    final daysEarly = task.dueDate!.difference(task.completedAt!).inDays;
    return daysEarly > 0 ? daysEarly * 10 : 0;
  }

  /// Бонус за качество (оценка менеджера)
  static int getQualityBonus(int managerRating) {
    return managerRating * 20; // 1-5 звезд = 20-100 XP
  }

  /// Командный бонус
  static int getTeamBonus(WorkTaskModel task) {
    return task.type == TaskType.team ? 50 : 0;
  }

  /// Общая XP за задачу
  static int calculateTotalXP(WorkTaskModel task, {int? managerRating}) {
    return getTaskXP(task) +
           getSpeedBonus(task) +
           (managerRating != null ? getQualityBonus(managerRating) : 0) +
           getTeamBonus(task);
  }
}
```

---

### **ЭТАП 4: Система аналитики и отчетности** ⏱️ 6-8 дней

#### 4.1 Дашборды для разных ролей

**EMPLOYEE Dashboard**:
```
📊 МОЯ СТАТИСТИКА

🔥 Продуктивность
├── Задач сегодня: 3/5
├── Выполнено неделю: 15/20
├── Просрочено: 2 задачи
└── Среднее время: 2.5 часа

⭐ Геймификация
├── Текущий уровень: 12
├── XP сегодня: 150
├── Стрик: 7 дней
├── Достижения: 8/15

📈 Тренды
├── График продуктивности (неделя)
├── Время выполнения задач
├── Качество работы (рейтинг)
└── Прогресс по целям
```

**MANAGER Dashboard**:
```
👥 КОМАНДА

📊 Общая статистика
├── Активные сотрудники: 8/10
├── Задач в работе: 45
├── Просрочено: 7 задач
└── Завершено сегодня: 12

🎯 Производительность
├── ТОП-3 сотрудника
├── Средняя скорость
├── Качество работы
└── Соблюдение сроков

📈 Проекты
├── В срок: 3 проекта
├── В риске: 1 проект
├── Завершено: 2 проекта
└── Новые: 4 проекта

🏆 Достижения команды
├── Командные достижения
├── Индивидуальные успехи
├── Стрики сотрудников
└── Ближайшие цели
```

**ADMIN Dashboard**:
```
🏢 ОРГАНИЗАЦИЯ

📊 Общие метрики
├── Всего сотрудников: 150
├── Активных сегодня: 120
├── Всего задач: 1,245
├── Выполнено: 987

🏢 Департаменты
├── IT: 45 сотрудников (95% выполнение)
├── Sales: 30 сотрудников (87% выполнение)
├── Marketing: 25 сотрудников (92% выполнение)
└── HR: 15 сотрудников (98% выполнение)

📈 Тренды компании
├── Продуктивность по неделям
├── Удовлетворенность сотрудников
├── Активность геймификации
└── ROI от геймификации
```

#### 4.2 Отчеты

**Типы отчетов**:
1. **Индивидуальный отчет сотрудника**
   - Выполненные задачи
   - Время работы
   - Достижения
   - Прогресс целей
   - Рекомендации

2. **Отчет команды**
   - Производительность команды
   - Сравнение с другими командами
   - Проблемы и риски
   - Возможности улучшения

3. **Отчет проекта**
   - Статус проекта
   - Временные затраты
   - Качество выполнения
   - Ресурсы команды

4. **Отчет департамента**
   - Общая статистика
   - Сравнение с KPI
   - Тренды
   - Рекомендации

#### 4.3 Экспорт данных
```dart
class ReportService {
  /// Экспорт в Excel/PDF
  Future<File> exportIndividualReport({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
    ReportFormat format, // pdf, excel, csv
  });

  /// Генерация PDF отчета
  Future<File> generatePDFReport({
    required String reportType,
    required Map<String, dynamic> data,
  });

  /// Интеграция с BI системами
  Future<void> sendToBI(String reportId);

  /// Расписание автоматических отчетов
  Future<void> scheduleReport({
    required String userId,
    required ReportType type,
    required Schedule schedule, // daily, weekly, monthly
  });
}
```

---

### **ЭТАП 5: Интеграция с корпоративными инструментами** ⏱️ 7-10 дней

#### 5.1 Календарные интеграции
**Google Calendar / Outlook Calendar**:
```dart
class CalendarIntegration {
  /// Синхронизация задач с календарем
  Future<void> syncTaskToCalendar(WorkTaskModel task) async {
    // Создать событие в календаре на основе dueDate
    final event = CalendarEvent(
      title: task.title,
      description: task.description,
      startTime: task.dueDate,
      endTime: task.dueDate?.add(Duration(hours: task.estimatedHours ?? 1)),
      attendees: task.assignedTo.map((id) => getUserEmail(id)).toList(),
    );

    await calendarAPI.createEvent(event);
  }

  /// Получить задачи из календаря
  Future<List<WorkTaskModel>> importFromCalendar(DateTime date) async {
    final events = await calendarAPI.getEventsForDate(date);
    return events.map(convertEventToTask).toList();
  }
}
```

#### 5.2 Интеграция с мессенджерами
**Slack / Microsoft Teams**:
```dart
class MessagingIntegration {
  /// Уведомления в Slack
  Future<void> sendSlackNotification({
    required String channelId,
    required String message,
    required String taskId,
    List<String>? mentions,
  });

  /// Создание задачи из Slack
  Future<WorkTaskModel?> createTaskFromSlackMessage({
    required String message,
    required String userId,
    required String channelId,
  });

  /// Обновление задачи в Slack
  Future<void> updateSlackTaskStatus({
    required String taskId,
    required TaskStatus status,
  });
}
```

#### 5.3 Email интеграция
```dart
class EmailIntegration {
  /// Создание задачи из email
  Future<WorkTaskModel> createTaskFromEmail(Email email);

  /// Уведомления о deadline'ах
  Future<void> sendDeadlineReminders();

  /// Еженедельные отчеты
  Future<void> sendWeeklyReports();

  /// Уведомления менеджеров
  Future<void> notifyManager({
    required String managerId,
    required String employeeId,
    required String message,
  });
}
```

#### 5.4 Интеграция с Jira/Trello (опционально)
```dart
class ProjectManagementIntegration {
  /// Синхронизация с Jira
  Future<void> syncWithJira(String projectId);

  /// Импорт задач из Jira
  Future<List<WorkTaskModel>> importFromJira(String projectId);

  /// Обновление статуса в Jira при изменении в приложении
  Future<void> updateJiraIssue(String taskId, TaskStatus status);
}
```

---

### **ЭТАП 6: UI/UX дизайн для рабочих процессов** ⏱️ 5-7 дней

#### 6.1 Новые экраны
**Основные экраны**:
1. **Dashboard** (обновленный)
2. **My Tasks** (личные задачи)
3. **Team Tasks** (командные задачи)
4. **Projects** (список проектов)
5. **Reports** (отчеты)
6. **Settings** (настройки)

#### 6.2 Компоненты UI
**Новые виджеты**:
```dart
// team_task_card.dart
class TeamTaskCard extends StatelessWidget {
  final WorkTaskModel task;
  final List<String> assignees;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Заголовок задачи
          ListTile(
            title: Text(task.title),
            subtitle: Text('${task.assignedBy} • ${task.department}'),
            trailing: _buildPriorityBadge(task.priority),
          ),

          // Аватары исполнителей
          Row(
            children: assignees
                .map((id) => UserAvatar(userId: id))
                .toList(),
          ),

          // Прогресс
          LinearProgressIndicator(value: task.progress),

          // Сроки
          _buildDueDateChip(task.dueDate),
        ],
      ),
    );
  }
}

// department_selector.dart
class DepartmentSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: departments.map((dept) {
        return DropdownMenuItem(
          value: dept.id,
          child: Row(
            children: [
              Icon(dept.icon),
              SizedBox(width: 8),
              Text(dept.name),
              Spacer(),
              Text('${dept.memberCount} чел.'),
            ],
          ),
        );
      }).toList(),
    );
  }
}
```

#### 6.3 Цветовая схема для рабочих задач
```
🎨 ЦВЕТА ДЛЯ РАБОЧИХ ЗАДАЧ

Приоритет:
├── Low:      Blue (#2196F3)
├── Medium:   Orange (#FF9800)
├── High:     Red (#F44336)
└── Urgent:   Deep Red (#B71C1C)

Статус:
├── Pending:      Gray (#9E9E9E)
├── In Progress:  Blue (#2196F3)
├── Completed:    Green (#4CAF50)
├── Overdue:      Red (#F44336)
└── On Hold:      Amber (#FFC107)

Тип задачи:
├── Personal:   Purple (#9C27B0)
├── Project:    Teal (#009688)
└── Team:       Indigo (#3F51B5)

Департаменты:
├── IT:         Blue
├── Sales:      Green
├── Marketing:  Orange
├── HR:         Pink
├── Finance:    Yellow
└── Operations: Brown
```

---

### **ЭТАП 7: Функции для менеджеров** ⏱️ 5-7 дней

#### 7.1 Управление командой
**Функции менеджера**:
```dart
class ManagerService {
  /// Назначить задачу сотруднику
  Future<void> assignTaskToEmployee({
    required String taskId,
    required String employeeId,
    required DateTime dueDate,
    int? estimatedHours,
    String? instructions,
  });

  /// Массовое назначение задач
  Future<void> batchAssignTasks({
    required List<String> taskIds,
    required String employeeId,
    required DateTime dueDate,
  });

  /// Оценить качество работы
  Future<void> rateEmployeeWork({
    required String taskId,
    required int rating, // 1-5
    required String feedback,
  });

  /// Установить цель для сотрудника
  Future<void> setEmployeeGoal({
    required String employeeId,
    required Goal goal,
  });

  /// Создать командное достижение
  Future<void> createTeamAchievement({
    required String teamId,
    required Achievement achievement,
  });
}
```

#### 7.2 Планирование и распределение
**Планировщик задач**:
```
📅 ПЛАНИРОВЩИК

Календарь задач:
├── Вид по дням/неделям/месяцам
├── Drag & Drop для переноса
├── Цветовое кодирование по департаментам
└── Конфликты и перегрузка

Ресурсное планирование:
├── Нагрузка сотрудников
├── Распределение времени
├── Выявление перегрузки
└── Оптимизация распределения
```

#### 7.3 Аналитика для менеджера
**Метрики команды**:
```dart
class TeamAnalytics {
  /// Производительность сотрудника
  EmployeePerformance getEmployeePerformance(String employeeId) {
    return EmployeePerformance(
      tasksCompleted: getCompletedTasksCount(employeeId),
      averageTime: getAverageTaskTime(employeeId),
      onTimeRate: getOnTimeCompletionRate(employeeId),
      qualityScore: getAverageQualityRating(employeeId),
      xpEarned: getTotalXP(employeeId),
      streak: getCurrentStreak(employeeId),
    );
  }

  /// Сравнение с другими сотрудниками
  BenchmarkResult benchmark(String employeeId) {
    final performance = getEmployeePerformance(employeeId);
    final teamAverage = getTeamAverage();
    final companyAverage = getCompanyAverage();

    return BenchmarkResult(
      vsTeam: calculatePercentile(performance, teamAverage),
      vsCompany: calculatePercentile(performance, companyAverage),
    );
  }

  /// Рекомендации для улучшения
  List<Recommendation> getRecommendations(String employeeId) {
    final performance = getEmployeePerformance(employeeId);
    return [
      if (performance.onTimeRate < 0.8)
        Recommendation(
          type: 'time_management',
          message: 'Рекомендуется улучшить планирование времени',
          action: 'Настроить напоминания',
        ),
      if (performance.qualityScore < 4)
        Recommendation(
          type: 'quality',
          message: 'Улучшить качество работы',
          action: 'Дополнительное обучение',
        ),
    ];
  }
}
```

---

### **ЭТАП 8: Безопасность для корпоративного использования** ⏱️ 3-5 дней

#### 8.1 Аутентификация и авторизация
```dart
class SecurityService {
  /// SSO (Single Sign-On) интеграция
  Future<User> authenticateWithSSO({
    required String provider, // Google, Microsoft, Okta
    required String token,
  });

  /// Multi-Factor Authentication (MFA)
  Future<bool> verifyMFA({
    required String userId,
    required String code,
  });

  /// Проверка прав доступа
  Future<bool> hasPermission({
    required String userId,
    required String resource,
    required String action, // read, write, delete, admin
  });

  /// Refresh Token
  Future<String> refreshToken(String refreshToken);
}
```

#### 8.2 Шифрование данных
- Шифрование чувствительных данных в БД
- Безопасная передача (HTTPS/WSS)
- Хеширование паролей (bcrypt)
- Защита API ключей

#### 8.3 Аудит и логирование
```dart
class AuditService {
  /// Логирование действий пользователя
  Future<void> logAction({
    required String userId,
    required String action,
    required String resource,
    Map<String, dynamic>? metadata,
  });

  /// Получение логов для администратора
  Future<List<AuditLog>> getAuditLogs({
    required DateTime startDate,
    required DateTime endDate,
    String? userId,
    String? action,
  });

  /// Уведомления о подозрительной активности
  Future<void> detectSuspiciousActivity(String userId);
}
```

#### 8.4 Соответствие GDPR/корпоративным требованиям
- Право на удаление данных
- Экспорт данных пользователя
- Ограничение доступа по ролям
- Журналирование доступа к данным

---

### **ЭТАП 9: Уведомления и коммуникации** ⏱️ 3-5 дней

#### 9.1 Push-уведомления
**Типы уведомлений**:
```dart
enum NotificationType {
  taskAssigned,      // Новая задача назначена
  taskOverdue,       // Задача просрочена
  deadlineApproaching, // Скоро deadline
  teamAchievement,   // Достижение команды
  levelUp,           // Повышение уровня
  weeklyReport,      // Недельный отчет
  managerFeedback,   // Обратная связь от менеджера
}

class NotificationService {
  /// Отправить push-уведомление
  Future<void> sendPushNotification({
    required String userId,
    required NotificationType type,
    required String title,
    required String message,
    Map<String, dynamic>? data,
  });

  /// Настройка уведомлений
  Future<void> updateNotificationSettings({
    required String userId,
    required NotificationSettings settings,
  });

  /// Получение токена устройства
  Future<void> registerDeviceToken({
    required String userId,
    required String token,
  });
}
```

#### 9.2 In-app уведомления
```dart
class InAppNotificationService {
  /// Показать уведомление в приложении
  void showNotification({
    required BuildContext context,
    required String message,
    NotificationType type,
  });

  /// Центр уведомлений
  Widget buildNotificationCenter();

  /// История уведомлений
  Future<List<Notification>> getNotifications(String userId);
}
```

#### 9.3 Напоминания
```dart
class ReminderService {
  /// Установить напоминание о задаче
  Future<void> setTaskReminder({
    required String taskId,
    required DateTime reminderTime,
    ReminderType type, // push, email, sms
  });

  /// Напоминания о deadline'ах
  Future<void> scheduleDeadlineReminders(WorkTaskModel task) {
    // За 24 часа
    // За 2 часа
    // За 30 минут
  }

  /// Ежедневные напоминания
  Future<void> scheduleDailyReminder(String userId);
}
```

---

### **ЭТАП 10: Тестирование и оптимизация** ⏱️ 5-7 дней

#### 10.1 Модульное тестирование
```dart
// test/features/tasks/work_task_service_test.dart
void main() {
  group('WorkTaskService', () {
    test('should assign task to employee', () async {
      // Arrange
      final task = createTestTask();
      final employeeId = 'emp_123';

      // Act
      await service.assignTaskToEmployee(task, employeeId);

      // Assert
      expect(task.assignedTo, contains(employeeId));
    });

    test('should calculate XP for team task', () async {
      // Arrange
      final teamTask = createTestTeamTask();

      // Act
      final xp = WorkXPService.calculateTotalXP(teamTask);

      // Assert
      expect(xp, greaterThan(teamTask.xp));
    });
  });
}
```

#### 10.2 Интеграционное тестирование
- Тестирование Supabase интеграции
- Тестирование уведомлений
- Тестирование интеграций с календарем/Slack

#### 10.3 UI тестирование (Widget Tests)
```dart
// test/widget/team_task_card_test.dart
void main() {
  testWidgets('should display team task information',
      (WidgetTester tester) async {
    // Arrange
    final task = createTestTeamTask();

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: TeamTaskCard(task: task),
      ),
    );

    // Assert
    expect(find.text(task.title), findsOneWidget);
    expect(find.byType(UserAvatar), findsNWidgets(task.assignedTo.length));
  });
}
```

#### 10.4 Производительность
**Оптимизация**:
- [ ] Lazy loading для списков задач
- [ ] Кэширование данных
- [ ] Оптимизация изображений
- [ ] Сжатие JSON данных
- [ ] Индексация БД
- [ ] Пагинация для больших списков

#### 10.5 Пользовательское тестирование
- [ ] Создание тестовых сценариев
- [ ] Сбор обратной связи
- [ ] Исправление UX проблем
- [ ] A/B тестирование геймификации

---

## 📈 **ОЖИДАЕМЫЕ РЕЗУЛЬТАТЫ**

### Функциональность:
- ✅ Полноценное корпоративное приложение
- ✅ Управление проектами и командами
- ✅ Роли и права доступа
- ✅ Интеграции с корпоративными инструментами
- ✅ Аналитика и отчетность
- ✅ Система мотивации и геймификации

### Бизнес-ценность:
- 📈 Повышение продуктивности на 25-40%
- 🎯 Улучшение соблюдения сроков на 30%
- 👥 Повышение командной эффективности на 20%
- 💰 ROI от геймификации: 3-5x
- 😊 Увеличение удовлетворенности сотрудников

### Технические метрики:
- ⚡ Производительность: <2 сек загрузка
- 📱 Поддержка: iOS 13+, Android 8+
- 🔒 Безопасность: SOC 2, GDPR compliance
- ♿ Доступность: WCAG 2.1 AA
- 🌍 Локализация: 10+ языков

---

## 🗓️ **ОБЩИЙ ТАЙМЛАЙН**

| Этап | Длительность | Статус |
|------|--------------|--------|
| 1. Анализ и архитектура | 3-5 дней | ✅ |
| 2. Система команд | 5-7 дней | ⏳ |
| 3. Геймификация | 4-6 дней | ⏳ |
| 4. Аналитика | 6-8 дней | ⏳ |
| 5. Интеграции | 7-10 дней | ⏳ |
| 6. UI/UX | 5-7 дней | ⏳ |
| 7. Функции менеджеров | 5-7 дней | ⏳ |
| 8. Безопасность | 3-5 дней | ⏳ |
| 9. Уведомления | 3-5 дней | ⏳ |
| 10. Тестирование | 5-7 дней | ⏳ |

**Итого**: 46-67 дней (7-10 недель)

---

## 🎯 **СЛЕДУЮЩИЕ ШАГИ**

1. ✅ Подтвердить план с заинтересованными сторонами
2. ✅ Приоритизировать функции (MVP vs хорошие-to-have)
3. ✅ Настроить среду разработки
4. ✅ Начать с Этапа 2: Система команд
5. ✅ Создать детальные технические спецификации

---

**Документ подготовлен**: 3 ноября 2025
**Версия**: 1.0
**Ответственный**: Claude Code Assistant
