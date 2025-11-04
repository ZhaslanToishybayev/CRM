/// Task List Screen
/// Educational Project - Gamified Task Management App
///
/// Main screen for viewing and managing tasks

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../../providers.dart';
import '../providers/task_provider.dart';
import '../models/task_model.dart';
import '../widgets/task_card.dart';
import '../../gamification/providers/gamification_provider.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authStateProvider);
    final tasks = ref.watch(tasksListProvider);
    final searchProvider = ref.watch(taskSearchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push('/tasks/new');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.primaryVariant]),
              ),
              accountName: Text(
                currentUser?.username ?? 'User',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              accountEmail: Text(currentUser?.email ?? ''),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  (currentUser?.username ?? 'U')[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.emoji_events),
              title: const Text('Achievements'),
              onTap: () {
                context.push('/achievements');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign Out'),
              onTap: () async {
                // Clear all providers
                ref.read(authProvider.notifier).logout();
                ref.read(taskNotifierProvider.notifier).clearTasks();
                ref.read(gamificationNotifierProvider.notifier).reset();

                // Navigate to sign in
                if (context.mounted) {
                  context.go('/sign-in');
                }
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                ref.read(taskSearchNotifierProvider.notifier).updateSearch(value);
              },
            ),
          ),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterChip('all', 'All'),
                const SizedBox(width: 8),
                _buildFilterChip('pending', 'Pending'),
                const SizedBox(width: 8),
                _buildFilterChip('completed', 'Completed'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Tasks List
          Expanded(
            child: tasks.when(
              data: (taskList) {
                final filteredTasks = _filterTasks(taskList);
                if (filteredTasks.isEmpty) {
                  return const Center(
                    child: Text('No tasks found'),
                  );
                }
                return ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    return TaskCard(task: task);
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFilter = value;
          });
        }
      },
    );
  }

  List<TaskModel> _filterTasks(List<TaskModel> tasks) {
    var filtered = tasks;

    // Filter by status
    if (_selectedFilter == 'pending') {
      filtered = filtered.where((t) => t.status == TaskStatus.pending).toList();
    } else if (_selectedFilter == 'completed') {
      filtered = filtered.where((t) => t.status == TaskStatus.completed).toList();
    }

    // Filter by search
    final search = _searchController.text.trim();
    if (search.isNotEmpty) {
      filtered = filtered
          .where((t) =>
              t.title.toLowerCase().contains(search.toLowerCase()) ||
              (t.description?.toLowerCase().contains(search.toLowerCase()) ??
                  false))
          .toList();
    }

    return filtered;
  }
}
