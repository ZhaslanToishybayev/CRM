# Riverpod Patterns

Comprehensive Riverpod patterns for the CRM Flutter project.

## Provider Types

### 1. StateNotifierProvider (Complex State)
```dart
@riverpod
class TaskNotifier extends StateNotifier<TaskState> {
  TaskNotifier(this._taskService) : super(const TaskState.loading()) {
    loadTasks();
  }

  final TaskService _taskService;

  Future<void> loadTasks() async {
    try {
      final tasks = await _taskService.getTasks();
      state = TaskState.loaded(tasks);
    } catch (e) {
      state = TaskState.error(e.toString());
    }
  }

  Future<void> createTask(Task task) async {
    await _taskService.createTask(task);
    state = TaskState.loaded([...state.tasks, task]);
  }

  Future<void> updateTask(Task task) async {
    await _taskService.updateTask(task);
    state = TaskState.loaded(
      state.tasks.map((t) => t.id == task.id ? task : t).toList(),
    );
  }
}

@freezed
class TaskState with _$TaskState {
  const factory TaskState.loading() = _Loading;
  const factory TaskState.loaded(List<Task> tasks) = _Loaded;
  const factory TaskState.error(String message) = _Error;
}

final taskNotifierProvider = StateNotifierProvider<TaskNotifier, TaskState>(
  (ref) => TaskNotifier(TaskService()),
);
```

### 2. FutureProvider (Async Data)
```dart
@riverpod
class UserProfileNotifier extends FutureNotifier<UserProfile> {
  @override
  Future<UserProfile> build() async {
    final userId = ref.watch(authUserIdProvider);
    return await _fetchUserProfile(userId);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}

final userProfileProvider = FutureProvider<UserProfile>((ref) {
  return UserProfileNotifier(ref);
});
```

### 3. StreamProvider (Realtime)
```dart
@riverpod
Stream<List<Task>> taskStream(TaskStreamRef ref) {
  final taskService = ref.watch(taskServiceProvider);
  return taskService.watchTasks();
}

final taskStreamProvider = StreamProvider<List<Task>>((ref) {
  return ref.watch(taskStreamProvider.notifier).stream;
});
```

## State Management Patterns

### 1. Loading State
```dart
class TaskListWidget extends ConsumerWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskNotifierProvider);

    return taskState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (tasks) => TaskList(tasks: tasks),
      error: (message) => ErrorMessage(message: message),
    );
  }
}
```

### 2. Refresh Pattern
```dart
class RefreshableWidget extends ConsumerWidget {
  const RefreshableWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.refresh(userProfileProvider.future),
      child: profile.when(
        data: (data) => ProfileWidget(profile: data),
        loading: () => const SkeletonLoader(),
        error: (error, _) => ErrorWidget(error.toString()),
      ),
    );
  }
}
```

### 3. Auto-refresh on Event
```dart
@riverpod
class AuthController extends StateNotifier<AsyncValue<User?>> {
  AuthController(this._authService) : super(const AsyncValue.loading()) {
    _init();
  }

  final AuthService _authService;

  void _init() {
    _authService.authStateChanges().listen((user) {
      state = AsyncData(user);
    });
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = const AsyncValue.data(null);
  }
}
```

## Provider Scoping

### 1. Scoped to Widget
```dart
class TaskDetailsPage extends ConsumerStatefulWidget {
  final String taskId;

  const TaskDetailsPage({super.key, required this.taskId});

  @override
  ConsumerState<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends ConsumerState<TaskDetailsPage> {
  @override
  void initState() {
    super.initState();
    ref.read(taskProvider(widget.taskId));
  }

  @override
  Widget build(BuildContext context) {
    final task = ref.watch(taskProvider(widget.taskId));
    return task.when(
      data: (task) => TaskDetails(task: task),
      loading: () => const CircularProgressIndicator(),
      error: (error, _) => ErrorWidget(error.toString()),
    );
  }
}
```

### 2. Auto-dispose
```dart
@riverpod
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
}

final counterProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier(),
  // Auto-dispose when no longer needed
  // (default behavior)
);
```

### 3. Keep Alive
```dart
@riverpod
class DataNotifier extends StateNotifier<AsyncValue<Data>> {
  DataNotifier(this._dataService) : super(const AsyncValue.loading()) {
    loadData();
  }

  final DataService _dataService;

  Future<void> loadData() async {
    // Load data
  }
}

final dataProvider = StateNotifierProvider<DataNotifier, AsyncValue<Data>>(
  (ref) => DataNotifier(DataService()),
  // Keep alive to avoid re-loading when navigating back
  // (use when data doesn't change frequently)
);
```

## Best Practices

### DO
- ✅ Use StateNotifier for complex state
- ✅ Use FutureProvider for async data
- ✅ Use StreamProvider for realtime data
- ✅ Keep business logic in providers
- ✅ Handle loading and error states
- ✅ Use ref.watch for reactive data
- ✅ Use ref.read for one-time reads

### DON'T
- ❌ Use StateProvider for complex objects
- ❌ Mutate state directly (use StateNotifier)
- ❌ Put business logic in widgets
- ❌ Forget to handle loading states
- ❌ Use ref.watch when ref.read suffices
- ❌ Create providers in build methods

## Testing Providers

### 1. Unit Test
```dart
void main() {
  group('TaskNotifier', () {
    late TaskNotifier notifier;
    late MockTaskService mockTaskService;

    setUp(() {
      mockTaskService = MockTaskService();
      notifier = TaskNotifier(mockTaskService);
    });

    test('should load tasks', () async {
      // Arrange
      when(() => mockTaskService.getTasks()).thenAnswer((_) async => [task1, task2]);

      // Act
      await notifier.loadTasks();

      // Assert
      expect(notifier.state, isA<Loaded>());
      expect(notifier.state.tasks.length, 2);
    });
  });
}
```

### 2. Widget Test
```dart
void main() {
  testWidgets('should display tasks', (tester) async {
    // Arrange
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(taskNotifierProvider.notifier).loadTasks();

    // Act
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: TaskListScreen()),
      ),
    );

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
```

## Common Patterns

### Pagination
```dart
@riverpod
class TaskListNotifier extends StateNotifier<AsyncValue<PaginatedTasks>> {
  TaskListNotifier(this._taskService) : super(const AsyncValue.loading()) {
    loadInitial();
  }

  final TaskService _taskService;

  Future<void> loadInitial() async {
    state = const AsyncValue.loading();
    final tasks = await _taskService.getTasks(page: 1);
    state = AsyncValue.data(tasks);
  }

  Future<void> loadMore() async {
    final current = state.value!;
    final nextPage = current.currentPage + 1;
    final newTasks = await _taskService.getTasks(page: nextPage);
    state = AsyncValue.data(
      current.copyWith(
        tasks: [...current.tasks, ...newTasks.tasks],
        currentPage: nextPage,
        hasMore: newTasks.hasMore,
      ),
    );
  }
}
```

### Filtered List
```dart
@riverpod
class FilteredTaskListNotifier extends StateNotifier<List<Task>> {
  FilteredTaskListNotifier(this._allTasksProvider) : super([]) {
    _filter();
  }

  final Provider<List<Task>> _allTasksProvider;

  void _filter() {
    final allTasks = ref.read(_allTasksProvider);
    state = allTasks.where((task) => task.isCompleted).toList();
  }

  void setFilter(TaskFilter filter) {
    final allTasks = ref.read(_allTasksProvider);
    state = allTasks.where(filter.predicate).toList();
  }
}
```

---

**Pattern Library**: Riverpod for CRM
**Version**: 1.0.0
