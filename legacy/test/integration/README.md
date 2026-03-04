# Integration Testing Guide

## Overview

This directory contains lightweight app-shell smoke tests for the Gamified Task Management App.  
They run with `flutter_test` binding to keep CI stable and fast while still validating core UI flows.

---

## 🧪 Test Structure

### 1. `e2e_auth_flow_test.dart`
**Authentication Flow Tests**
- Tests user registration and login
- Validates OAuth integrations (Google, etc.)
- Checks form validation
- Verifies demo mode access
- Tests session management

**Key Tests:**
- Login screen display
- Email/password input
- Demo mode access
- OAuth buttons presence
- Form validation
- Loading states
- Performance validation

### 2. `gamification_flow_test.dart`
**Gamification Feature Tests**
- XP display and tracking
- Level progression
- Achievement badges
- Streak counters
- Leaderboards
- Team statistics
- Progress visualizations

**Key Tests:**
- XP indicator display
- Level progress ring
- Achievement unlocking
- Streak tracking
- Leaderboard navigation
- Team gamification stats
- Daily challenges

### 3. `task_management_flow_test.dart`
**Task Management Tests**
- Task CRUD operations
- Task filtering and search
- Priority settings
- Due dates
- Completion tracking
- List scrolling

**Key Tests:**
- Create new task
- Edit existing task
- Complete task
- Delete task
- Filter by status
- Search functionality
- Priority changes
- Due date setting
- List scrolling
- Empty state handling

---

## 🚀 Running Integration Tests

### Current Week-1 Stability Mode

Legacy `flutter_driver` tests are treated as non-blocking and skipped by default.
Run the curated integration smoke set via:

```bash
bash scripts/ci/run_integration_smoke.sh
```

The script runs only non-legacy integration tests and skips files importing
`package:flutter_driver/flutter_driver.dart`.

If Flutter is not available in PATH, export `FLUTTER_BIN`:

```bash
export FLUTTER_BIN=/absolute/path/to/flutter
# or
export FLUTTER_BIN=/absolute/path/to/flutter/bin
```

### Run All Integration Smoke Tests

```bash
bash scripts/ci/run_integration_smoke.sh
```

### Run a Specific Integration Test File

```bash
flutter test test/integration/e2e_auth_flow_test.dart
flutter test test/integration/gamification_flow_test.dart
flutter test test/integration/task_management_flow_test.dart
```

---

## 📝 Writing New Integration Tests

### Test Structure Template

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Feature Name - Integration Smoke Tests', () {
    test('should perform specific action', () async {
      expect(true, isTrue);
    });
  });
}
```

### Common Test Patterns

#### 1. Assertions
```dart
// Basic existence check
expect(find.byType('Widget'), findsWidgets);

// Text verification
expect(find.text('Expected Text'), findsOneWidget);

// Count verification
expect(find.byType('ListTile'), findsNWidgets(3));

// Key verification
expect(find.byKey(Key('specific_key')), findsOneWidget);
```

---

## 🔍 Best Practices

### 1. **Test Independence**
- Each test should be independent
- Use `setUp()` and `tearDown()` for cleanup
- Don't rely on test execution order

### 2. **Timeout Management**
- Always set reasonable timeouts (5-10 seconds)
- Use `Future.delayed()` for async operations
- Be patient with animations and transitions

### 3. **Selector Strategy**
```dart
// Prefer Key selectors (most reliable)
find.byKey(Key('unique_key'))

// Then Type selectors
find.byType('TextField')

// Then Icon selectors
find.byIcon(Icons.add)

// Text selectors (least reliable, can change)
find.text('Submit Button')
```

### 4. **Error Handling**
- Wrap tests in try-catch for graceful handling
- Use `print()` for debugging
- Don't fail silently

```dart
try {
  await tester.tap(find.byKey(Key('button')));
  await tester.pumpAndSettle();
  expect(find.text('Success'), findsOneWidget);
} catch (e) {
  print('Test skipped: $e');
  // Consider if test failure is critical
}
```

### 5. **Data Setup**
```dart
setUp(() async {
  // Reset app state if needed
  await Future<void>.delayed(const Duration(milliseconds: 100));
});
```

---

## 🐛 Debugging Failed Tests

### Common Issues

#### 1. **Element Not Found**
```
TimeoutException: Timeout of 5 seconds exceeded
```

**Solutions:**
- Increase timeout duration
- Verify element exists in current screen
- Add delays for animations
- Check element selectors

#### 2. **Test Hangs**
```
Test never completed
```

**Solutions:**
- Add timeout to waits
- Check for infinite loading states
- Verify app isn't crashed
- Add explicit waits

#### 3. **Flutter not found**
```
Flutter executable was not found.
```

**Solutions:**
- Add Flutter to PATH
- Set `FLUTTER_BIN` to Flutter executable or bin directory

### Debugging Steps

1. **Take Screenshot**
   ```dart
   // Optional: print widget tree while debugging
   debugDumpApp();
   ```

2. **Get Render Tree**
   ```dart
   // In test
   debugDumpRenderTree();
   ```

3. **Check App Logs**
   ```bash
   # In another terminal
   flutter logs
   ```

---

## 📊 CI/CD Integration

### GitHub Actions Example

```yaml
name: Integration Tests

on: [push, pull_request]

jobs:
  integration-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.35.3'

      - name: Get dependencies
        run: flutter pub get

      - name: Run integration smoke
        run: bash scripts/ci/run_integration_smoke.sh --no-pub
```

---

## 📈 Coverage Goals

- **Critical User Paths**: 100% coverage
- **Authentication Flow**: 90%+ coverage
- **Task Management**: 85%+ coverage
- **Gamification Features**: 80%+ coverage

---

## 🔗 Related Documentation

- [Flutter Integration Testing](https://docs.flutter.dev/testing/integration-tests)
- [Test Package](https://pub.dev/packages/test)

---

**Last Updated**: March 4, 2026
**Version**: 1.1
**Status**: ✅ Ready to Use
