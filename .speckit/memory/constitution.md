# CRM Project Constitution

## 1. Vision & Goals
**Vision**: Create the most engaging CRM system that motivates employees through gamification while improving productivity and collaboration.

**Goals**:
- Increase employee productivity by 35-50%
- Improve deadline adherence by 25-28%
- Enhance team collaboration by 25-30%
- Achieve 85%+ user satisfaction

## 2. Architecture Principles

### Core Principles
- **Clean Architecture**: Separate concerns, testable, independent of frameworks
- **Feature-Based Structure**: Each feature is a self-contained module
- **Single Responsibility**: Each component has one reason to change
- **Dependency Inversion**: Depend on abstractions, not concretions

### Flutter-Specific
- **Widget Composition**: Build UIs from small, reusable components
- **Declarative UI**: React to state changes automatically
- **Immutable Models**: Use Freezed for predictability

## 3. Technology Choices

### Frontend Stack
- **Framework**: Flutter 3.35.3+ (Cross-platform: Web, iOS, Android)
- **Language**: Dart 3.9.2+
- **State Management**: Riverpod 2.5.1+ (Reactive, testable, provider pattern)
- **Models**: Freezed 2.4.7+ (Immutable data classes, pattern matching)
- **Navigation**: Go Router 14.2.7+ (Declarative routing, deep linking)

### Backend Stack
- **BaaS**: Supabase 2.5.6+ (PostgreSQL, Auth, Realtime, Storage)
- **Real-time**: Supabase Realtime for live updates
- **Authentication**: Supabase Auth with role-based access
- **Database**: PostgreSQL with RLS (Row Level Security)

### Development Tools
- **Code Generation**: build_runner, freezed, json_serializable
- **Local Storage**: Hive 2.2.3+ (Fast, lightweight)
- **Networking**: dio 5.4.4+ (HTTP client, interceptors)
- **Charts**: fl_chart 0.69.0+ (Beautiful charts for analytics)

## 4. Coding Standards

### File Organization
```
lib/
├── core/              # Shared code (theme, constants, utilities)
├── features/          # Feature modules
│   ├── auth/
│   ├── teams/
│   ├── tasks/
│   ├── gamification/
│   └── reports/
├── shared/            # Reusable widgets
└── main.dart
```

### Model Standards (Freezed)
```dart
@freezed
class ExampleModel with _$ExampleModel {
  const factory ExampleModel({
    required String id,
    required String name,
  }) = _ExampleModel;
  
  factory ExampleModel.fromJson(Map<String, dynamic> json) =>
      _$ExampleModelFromJson(json);
}
```

### Provider Standards (Riverpod)
```dart
@riverpod
class ExampleNotifier extends _$ExampleNotifier {
  @override
  Future<ExampleModel> build() async {
    return await _fetchData();
  }
}
```

### Naming Conventions
- **Files**: snake_case.dart
- **Classes**: PascalCase
- **Variables & Methods**: camelCase
- **Constants**: SCREAMING_SNAKE_CASE
- **Providers**: [Feature][Type]Provider (e.g., TaskListProvider)

## 5. Quality Requirements

### Performance Targets
- **Cold Start**: < 3 seconds
- **UI Response**: < 100ms for interactions
- **API Calls**: < 500ms average
- **Memory Usage**: < 150MB average
- **Battery**: Optimize for minimal drain

### Testing Requirements
- **Code Coverage**: Minimum 80%
- **Unit Tests**: All business logic
- **Widget Tests**: All UI components
- **Integration Tests**: Critical user flows

### Security Requirements
- **Authentication**: Mandatory for all features
- **Authorization**: Role-based access control (4 levels)
- **Data Validation**: Server-side and client-side
- **API Security**: HTTPS only, token validation
- **PII Protection**: Encrypt sensitive data

## 6. Integration Rules

### Supabase Integration
- Use Supabase for ALL backend needs
- Implement RLS policies for data security
- Use Realtime for live updates
- Implement proper error handling
- Cache frequently accessed data

### Gamification Integration
- Every feature should consider gamification
- Track XP for all user actions
- Award achievements appropriately
- Update leaderboards in real-time
- Maintain streak logic

### State Management Rules
- Use Riverpod for ALL state
- Providers should be testable
- Avoid setState in widgets
- Use StateNotifier for complex state
- Keep business logic out of widgets

## 7. Decision Log

### Why Flutter?
**Date**: 2025-11-03
**Decision**: Use Flutter for cross-platform development
**Rationale**: 
- Single codebase for Web, iOS, Android
- Excellent performance
- Hot reload for fast development
- Strong community and ecosystem

### Why Riverpod?
**Date**: 2025-11-03
**Decision**: Use Riverpod for state management
**Rationale**:
- Testable and maintainable
- No boilerplate
- Compile-time safety
- Better than Provider (scoping, testing)

### Why Supabase?
**Date**: 2025-11-03
**Decision**: Use Supabase as backend
**Rationale**:
- PostgreSQL database (ACID compliance)
- Built-in authentication
- Real-time capabilities
- No server management needed
- Excellent free tier

### Why Freezed?
**Date**: 2025-11-03
**Decision**: Use Freezed for models
**Rationale**:
- Immutable data (fewer bugs)
- Pattern matching
- toString, equality, hashCode generated
- JSON serialization built-in
- CopyWith methods

## 8. Development Practices

### Code Review Process
1. All code must be reviewed
2. Tests required for new features
3. Documentation must be updated
4. Performance impact assessed

### Git Workflow
1. Create feature branch from main
2. Implement feature with tests
3. Create Pull Request
4. Code review required
5. Merge after approval
6. Delete feature branch

### Documentation Requirements
- All public APIs documented
- README.md kept updated
- Architecture decisions recorded
- Setup instructions clear
- Examples provided

## 9. Guiding Principles

### When Making Decisions, Ask:
1. Does this align with our vision?
2. Is this maintainable?
3. Is this testable?
4. Does this follow our architecture?
5. Is the performance acceptable?
6. Is this secure?

### Non-Negotiables
- No global state (use Riverpod)
- No business logic in widgets
- All models immutable (Freezed)
- All features tested (80%+ coverage)
- Security always considered
- Performance monitored

## 10. Change Management

### Updating Constitution
- Changes require justification
- Impact on existing code assessed
- Team consensus required
- Version bump of constitution
- Migration plan created if needed

---

**Version**: 1.0.0
**Last Updated**: 2025-11-04
**Next Review**: 2025-12-04

This constitution is the source of truth for all technical decisions in the CRM project.
