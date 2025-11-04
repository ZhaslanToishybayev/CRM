---
name: flutter-dev-guidelines
description: Flutter/Dart development patterns for CRM project with Riverpod, Freezed, and Supabase
---

# Flutter Dev Guidelines for CRM

Production-tested Flutter patterns for the gamified CRM project with focus on Riverpod, Freezed, and Supabase integration.

## When to Use This Skill

**Auto-activates for:**
- Creating/modifying Flutter widgets
- Working with Riverpod providers
- Building Freezed models
- Integrating with Supabase
- State management implementation
- Routing with Go Router

**Use when:**
- Building UI components
- Implementing state changes
- Creating data models
- Setting up navigation
- Integrating backend

## Quick Reference

### Project Structure
```
lib/
├── core/                    # Shared (theme, constants, errors)
│   ├── constants/          # App constants
│   ├── theme/              # App theme
│   ├── errors/             # Error handling
│   └── supabase/           # Supabase config
├── features/               # Feature modules
│   ├── auth/
│   ├── teams/
│   ├── tasks/
│   ├── gamification/
│   ├── achievements/
│   ├── leaderboard/
│   ├── organizations/
│   └── reports/
├── shared/
│   └── widgets/            # Reusable widgets
└── main.dart
```

### Model Pattern (Freezed)
```dart
@freezed
class ExampleModel with _$ExampleModel {
  const factory ExampleModel({
    required String id,
    required String name,
    int? count,
    @Default([]) List<String> tags,
  }) = _ExampleModel;

  factory ExampleModel.fromJson(Map<String, dynamic> json) =>
      _$ExampleModelFromJson(json);
}
```

### Provider Pattern (Riverpod)
```dart
@riverpod
class ExampleNotifier extends _$ExampleNotifier {
  @override
  Future<List<ExampleModel>> build() async {
    return await _fetchExamples();
  }

  Future<void> createExample(String name) async {
    final newExample = ExampleModel(id: DateTime.now().toString(), name: name);
    await _saveExample(newExample);
    state = AsyncData([...state.value ?? [], newExample]);
  }
}
```

## Architecture Rules

### 1. State Management
- ✅ **DO**: Use Riverpod for ALL state
- ✅ **DO**: Keep business logic in providers/notifiers
- ❌ **DON'T**: Use setState in widgets
- ❌ **DON'T**: Put business logic in widgets

### 2. Models
- ✅ **DO**: Use Freezed for all data models
- ✅ **DO**: Make models immutable
- ❌ **DON'T**: Use mutable classes
- ❌ **DON'T**: Forget toJson/fromJson

### 3. Supabase Integration
- ✅ **DO**: Use service classes for Supabase calls
- ✅ **DO**: Handle errors properly
- ✅ **DO**: Use Realtime for live updates
- ❌ **DON'T**: Make Supabase calls directly in widgets
- ❌ **DON'T**: Ignore RLS policies

## Resource Files

- [Riverpod Patterns](resources/riverpod-patterns.md)
- [Freezed Models](resources/freezed-models.md)
- [Supabase Integration](resources/supabase-integration.md)
- [UI Best Practices](resources/ui-best-practices.md)

---

**Version**: 1.0.0
**For**: CRM Flutter Project
