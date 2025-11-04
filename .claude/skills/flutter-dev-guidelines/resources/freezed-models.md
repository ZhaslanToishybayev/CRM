# Freezed Models

Immutable data models for the CRM Flutter project using Freezed.

## Basic Model Pattern

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String username,
    String? fullName,
    String? avatarUrl,
    required int totalXP,
    required int currentLevel,
    required int streakCount,
    DateTime? lastTaskDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

// Extension for custom methods
extension UserModelX on UserModel {
  bool get isActive => streakCount > 0;
  
  int get nextLevelXP => (currentLevel + 1) * 1000;
  
  double get progressToNextLevel => totalXP / nextLevelXP;
}
```

## CRM-Specific Models

### Team Model
```dart
@freezed
class TeamModel with _$TeamModel {
  const factory TeamModel({
    required String id,
    required String name,
    required String organizationId,
    required String departmentId,
    String? description,
    required int memberCount,
    required int projectCount,
    @Default([]) List<TeamMemberModel> members,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TeamModel;

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);
}

@freezed
class TeamMemberModel with _$TeamMemberModel {
  const factory TeamMemberModel({
    required String id,
    required String teamId,
    required String userId,
    required TeamRole role,
    DateTime? joinedAt,
  }) = _TeamMemberModel;

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMemberModelFromJson(json);
}

enum TeamRole { member, leader, manager, admin }
```

### Task Model
```dart
@freezed
class WorkTaskModel with _$WorkTaskModel {
  const factory WorkTaskModel({
    required String id,
    required String title,
    String? description,
    required TaskPriority priority,
    required TaskType type,
    required TaskStatus status,
    required String assigneeId,
    String? assigneeName,
    required String teamId,
    String? projectId,
    required DateTime dueDate,
    DateTime? completedAt,
    required int xpValue,
    int? qualityScore,
    @Default([]) List<String> tags,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WorkTaskModel;

  factory WorkTaskModel.fromJson(Map<String, dynamic> json) =>
      _$WorkTaskModelFromJson(json);
}

enum TaskPriority { low, medium, high, urgent }
enum TaskType { feature, bugfix, documentation, meeting }
enum TaskStatus { todo, inProgress, review, completed, cancelled }

extension WorkTaskModelX on WorkTaskModel {
  bool get isOverdue => status != TaskStatus.completed && 
                        DateTime.now().isAfter(dueDate);
  
  bool get isCompleted => status == TaskStatus.completed;
  
  int get finalXP {
    if (!isCompleted) return 0;
    
    int baseXP = xpValue;
    
    // Quality bonus
    if (qualityScore != null) {
      baseXP += (qualityScore! / 10).round();
    }
    
    // On-time bonus
    if (completedAt != null && completedAt!.isBefore(dueDate)) {
      baseXP += 25;
    }
    
    return baseXP;
  }
}
```

### Achievement Model
```dart
@freezed
class AchievementDefinition with _$AchievementDefinition {
  const factory AchievementDefinition({
    required String id,
    required String name,
    required String description,
    required AchievementCategory category,
    required int xpReward,
    required String iconName,
    @Default(false) bool isHidden,
  }) = _AchievementDefinition;

  factory AchievementDefinition.fromJson(Map<String, dynamic> json) =>
      _$AchievementDefinitionFromJson(json);
}

enum AchievementCategory {
  productivity,
  deadlines,
  teamwork,
  quality,
  leadership,
  innovation,
  growth,
  communication,
  teamAchievements,
}

@freezed
class UserAchievement with _$UserAchievement {
  const factory UserAchievement({
    required String id,
    required String userId,
    required String achievementId,
    required DateTime unlockedAt,
    Map<String, dynamic>? metadata,
  }) = _UserAchievement;

  factory UserAchievement.fromJson(Map<String, dynamic> json) =>
      _$UserAchievementFromJson(json);
}
```

## CopyWith Pattern

```dart
final task = WorkTaskModel(
  id: '1',
  title: 'Old Title',
  priority: TaskPriority.medium,
  // ... other fields
);

// Update just the title
final updatedTask = task.copyWith(
  title: 'New Title',
);

// Update multiple fields
final fullyUpdated = task.copyWith(
  title: 'New Title',
  priority: TaskPriority.high,
  status: TaskStatus.completed,
  completedAt: DateTime.now(),
);
```

## Union Types (Sealed Classes)

```dart
@freezed
class TaskState with _$TaskState {
  const factory TaskState.loading() = TaskLoading;
  const factory TaskState.loaded(List<WorkTaskModel> tasks) = TaskLoaded;
  const factory TaskState.error(String message) = TaskError;
  const factory TaskState.empty() = TaskEmpty;
}

// Usage in widget
class TaskListWidget extends ConsumerWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskProvider);

    return taskState.when(
      loading: () => const CircularProgressIndicator(),
      loaded: (tasks) => ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => TaskCard(task: tasks[index]),
      ),
      error: (message) => ErrorMessage(message: message),
      empty: () => const EmptyState(),
    );
  }
}
```

## Best Practices

### DO
- ✅ Use const constructors when possible
- ✅ Add extensions for custom methods
- ✅ Use copyWith for immutable updates
- ✅ Add fromJson/toJson methods
- ✅ Use sealed classes for state
- ✅ Document complex logic

### DON'T
- ❌ Make mutable fields
- ❌ Forget part declarations
- ❌ Skip code generation
- ❌ Mix mutable and immutable patterns

---

**Version**: 1.0.0
