// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskRepositoryHash() => r'82d534b2ae82c05f56f1207fc5f42ca2c3f5e042';

/// See also [taskRepository].
@ProviderFor(taskRepository)
final taskRepositoryProvider = Provider<TaskRepository>.internal(
  taskRepository,
  name: r'taskRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TaskRepositoryRef = ProviderRef<TaskRepository>;
String _$supabaseTaskDataSourceHash() =>
    r'9fbd861614bc77dcc4a638237f29520f47f0a437';

/// See also [supabaseTaskDataSource].
@ProviderFor(supabaseTaskDataSource)
final supabaseTaskDataSourceProvider =
    Provider<SupabaseTaskDataSource>.internal(
  supabaseTaskDataSource,
  name: r'supabaseTaskDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$supabaseTaskDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SupabaseTaskDataSourceRef = ProviderRef<SupabaseTaskDataSource>;
String _$localTaskDataSourceHash() =>
    r'e37038c2b96a93bee90ea2c31fa1c5c4d30c6314';

/// See also [localTaskDataSource].
@ProviderFor(localTaskDataSource)
final localTaskDataSourceProvider = Provider<LocalTaskDataSource>.internal(
  localTaskDataSource,
  name: r'localTaskDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localTaskDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocalTaskDataSourceRef = ProviderRef<LocalTaskDataSource>;
String _$filteredTasksHash() => r'695b3bd46c8ea8da1d3f782b280ca0de6148a04f';

/// See also [filteredTasks].
@ProviderFor(filteredTasks)
final filteredTasksProvider = Provider<List<TaskModel>>.internal(
  filteredTasks,
  name: r'filteredTasksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredTasksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilteredTasksRef = ProviderRef<List<TaskModel>>;
String _$taskFilterHash() => r'7c72bc8f563559f1e814d250bb95d7c50c8ff811';

/// See also [taskFilter].
@ProviderFor(taskFilter)
final taskFilterProvider = Provider<TaskFilter>.internal(
  taskFilter,
  name: r'taskFilterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TaskFilterRef = ProviderRef<TaskFilter>;
String _$tasksListHash() => r'7ff2b7b2e9f956369679efd1e576837107377b9f';

/// See also [tasksList].
@ProviderFor(tasksList)
final tasksListProvider = AutoDisposeFutureProvider<List<TaskModel>>.internal(
  tasksList,
  name: r'tasksListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tasksListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TasksListRef = AutoDisposeFutureProviderRef<List<TaskModel>>;
String _$taskSearchHash() => r'27c19593b8237557277ec6f3df8859f1949fb5e2';

/// See also [taskSearch].
@ProviderFor(taskSearch)
final taskSearchProvider = AutoDisposeProvider<String>.internal(
  taskSearch,
  name: r'taskSearchProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskSearchHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TaskSearchRef = AutoDisposeProviderRef<String>;
String _$taskNotifierHash() => r'4824ab18ef0ce1cf9734c4c4c3ef87afa0d05116';

/// See also [TaskNotifier].
@ProviderFor(TaskNotifier)
final taskNotifierProvider =
    NotifierProvider<TaskNotifier, List<TaskModel>>.internal(
  TaskNotifier.new,
  name: r'taskNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TaskNotifier = Notifier<List<TaskModel>>;
String _$taskSearchNotifierHash() =>
    r'0260265f7036b9cd97a156206c8d1fdb3e5987a1';

/// See also [TaskSearchNotifier].
@ProviderFor(TaskSearchNotifier)
final taskSearchNotifierProvider =
    AutoDisposeNotifierProvider<TaskSearchNotifier, String>.internal(
  TaskSearchNotifier.new,
  name: r'taskSearchNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskSearchNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TaskSearchNotifier = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
