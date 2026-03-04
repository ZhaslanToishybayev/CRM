part of '../../../main.dart';

class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage> {
  String _searchQuery = '';
  String _selectedCategoryFilter = 'All';
  String _selectedPriorityFilter = 'All';
  String _selectedStatusFilter = 'All';
  String _selectedSortOption = 'Newest';
  bool _isLoading = true;
  String? _loadError;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadInitialData());
  }

  Future<void> _loadInitialData() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _loadError = null;
      });
    }

    try {
      await ref.read(tasksProvider.notifier).loadAll();
      await ref.read(clientsProvider.notifier).loadAll();
      await ref.read(userStatsProvider.notifier).loadUserStats();
    } catch (error) {
      _loadError =
          'Не удалось загрузить данные задач: ${toUserFacingErrorMessage(error)}';
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Task> _filterTasks(List<Task> tasks) {
    final filtered = tasks.where((task) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          task.description.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesCategory =
          _selectedCategoryFilter == 'All' ||
          task.category == _selectedCategoryFilter;

      final matchesPriority =
          _selectedPriorityFilter == 'All' ||
          task.priority.name == _selectedPriorityFilter.toLowerCase();

      final matchesStatus =
          _selectedStatusFilter == 'All' ||
          (_selectedStatusFilter == 'Completed' && task.isCompleted) ||
          (_selectedStatusFilter == 'Active' && !task.isCompleted);

      return matchesSearch &&
          matchesCategory &&
          matchesPriority &&
          matchesStatus;
    }).toList();

    filtered.sort((a, b) {
      switch (_selectedSortOption) {
        case 'Oldest':
          return a.createdAt.compareTo(b.createdAt);
        case 'Priority':
          final byPriority = _priorityWeight(
            b.priority,
          ).compareTo(_priorityWeight(a.priority));
          if (byPriority != 0) return byPriority;
          return b.createdAt.compareTo(a.createdAt);
        case 'Newest':
        default:
          return b.createdAt.compareTo(a.createdAt);
      }
    });

    return filtered;
  }

  int _priorityWeight(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return 3;
      case TaskPriority.medium:
        return 2;
      case TaskPriority.low:
        return 1;
    }
  }

  void _showAddTaskDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddTaskBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(tasksProvider);
    final clients = ref.watch(clientsProvider);
    final userStatsAsync = ref.watch(userStatsProvider);
    final clientNameById = <String, String>{
      for (final client in clients) client.id: client.fullName,
    };

    // Получаем список уникальных категорий
    final categories = <String>{'All'};
    for (var task in tasks) {
      categories.add(task.category);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Задачи',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(categories.toList()),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _loadInitialData();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _loadError != null
          ? _buildLoadErrorState(_loadError!)
          : Column(
              children: [
                // Статистика пользователя
                _buildUserStats(userStatsAsync),
                _buildTaskOverview(tasks),

                // Поиск
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Поиск задач...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),

                // Фильтры
                _buildFilterChips(tasks),

                // Список задач
                Expanded(child: _buildTasksList(tasks, clientNameById)),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  Widget _buildUserStats(UserStats userStats) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2F6366F1),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Уровень ${userStats.level}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                Text(
                  '${userStats.xp} XP',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: Colors.orange,
                  size: 20,
                ),
                Text(
                  '${userStats.streak}',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'серия',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Color(0xFFEF4444)),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF334155),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _loadInitialData(),
              icon: const Icon(Icons.refresh),
              label: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskOverview(List<Task> tasks) {
    final completed = tasks.where((task) => task.isCompleted).length;
    final active = tasks.length - completed;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final overdue = tasks
        .where(
          (task) =>
              !task.isCompleted &&
              task.dueDate != null &&
              DateTime(
                task.dueDate!.year,
                task.dueDate!.month,
                task.dueDate!.day,
              ).isBefore(today),
        )
        .length;
    final progress = tasks.isEmpty ? 0.0 : completed / tasks.length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A0F172A),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildOverviewItem(
                'Всего',
                tasks.length.toString(),
                const Color(0xFF6366F1),
              ),
              _buildOverviewItem(
                'Активные',
                active.toString(),
                const Color(0xFF0EA5E9),
              ),
              _buildOverviewItem(
                'Готово',
                completed.toString(),
                const Color(0xFF10B981),
              ),
              _buildOverviewItem(
                'Просрочено',
                overdue.toString(),
                const Color(0xFFEF4444),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFE2E8F0),
              color: const Color(0xFF10B981),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(List<Task> tasks) {
    final hasCompletedTasks = tasks.any((task) => task.isCompleted);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          if (_selectedStatusFilter != 'All')
            Chip(
              label: Text(_tasksStatusLabel(_selectedStatusFilter)),
              onDeleted: () {
                setState(() {
                  _selectedStatusFilter = 'All';
                });
              },
            ),
          if (_selectedCategoryFilter != 'All')
            Chip(
              label: Text(_selectedCategoryFilter),
              onDeleted: () {
                setState(() {
                  _selectedCategoryFilter = 'All';
                });
              },
            ),
          if (_selectedPriorityFilter != 'All')
            Chip(
              label: Text(_tasksPriorityFilterLabel(_selectedPriorityFilter)),
              onDeleted: () {
                setState(() {
                  _selectedPriorityFilter = 'All';
                });
              },
            ),
          if (_selectedSortOption != 'Newest')
            Chip(
              label: Text('Сорт: ${_tasksSortLabel(_selectedSortOption)}'),
              onDeleted: () {
                setState(() {
                  _selectedSortOption = 'Newest';
                });
              },
            ),
          if (hasCompletedTasks)
            ActionChip(
              avatar: const Icon(Icons.cleaning_services, size: 16),
              label: const Text('Очистить выполненные'),
              onPressed: () => _clearCompletedTasks(),
            ),
          ActionChip(
            label: const Text('Сбросить фильтры'),
            onPressed: () {
              setState(() {
                _selectedCategoryFilter = 'All';
                _selectedPriorityFilter = 'All';
                _selectedStatusFilter = 'All';
                _selectedSortOption = 'Newest';
                _searchQuery = '';
                _searchController.clear();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(
    Task task,
    int index,
    Map<String, String> clientNameById,
  ) {
    final linkedClientName = task.clientId != null
        ? clientNameById[task.clientId!]
        : null;
    final clientLabel = linkedClientName ?? 'No client';

    return Container(
      key: Key('task_card_${task.id}'),
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 0,
        color: task.isCompleted ? const Color(0xFFF8FAFC) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: task.isCompleted
                ? const Color(0xFFD1FAE5)
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showTaskDetails(task),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        key: Key('task_title_${task.id}'),
                        task.title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: task.isCompleted
                              ? const Color(0xFF64748B)
                              : const Color(0xFF0F172A),
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          _showEditTaskDialog(task, index);
                        } else if (value == 'duplicate') {
                          _duplicateTask(task);
                        } else if (value == 'delete') {
                          _confirmDeleteTask(index);
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 8),
                              Text('Изменить'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'duplicate',
                          child: Row(
                            children: [
                              Icon(Icons.copy_outlined),
                              SizedBox(width: 8),
                              Text('Дублировать'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 8),
                              Text(
                                'Удалить',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (task.description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    task.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFF64748B),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 14,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        key: Key('task_client_label_${task.id}'),
                        'Клиент: $clientLabel',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (task.dueDate != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 14,
                        color: _dueDateColor(task),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _formatDueDate(task.dueDate!),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: _dueDateColor(task),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildPriorityChip(task.priority),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Text(
                        task.category,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        task.isCompleted
                            ? Icons.restart_alt_rounded
                            : Icons.check_circle,
                        color: task.isCompleted
                            ? const Color(0xFF64748B)
                            : const Color(0xFF10B981),
                      ),
                      onPressed: () => _toggleTaskComplete(task, index),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityChip(TaskPriority priority) {
    Color color;
    String text;

    switch (priority) {
      case TaskPriority.low:
        color = const Color(0xFF10B981);
        text = 'Низкий';
        break;
      case TaskPriority.medium:
        color = const Color(0xFFF59E0B);
        text = 'Средний';
        break;
      case TaskPriority.high:
        color = const Color(0xFFF44336);
        text = 'Высокий';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Future<void> _clearCompletedTasks() async {
    final previousTasks = List<Task>.from(ref.read(tasksProvider));
    final completedCount = previousTasks
        .where((task) => task.isCompleted)
        .length;
    if (completedCount == 0) return;

    try {
      await ref.read(tasksProvider.notifier).clearCompleted();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(toUserFacingErrorMessage(error)),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _showUndoSnackBar(
      message: 'Очищено выполненных задач: $completedCount',
      onUndo: () {
        unawaited(ref.read(tasksProvider.notifier).replaceTasks(previousTasks));
      },
    );
  }

  String _formatDueDate(DateTime dueDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    final days = due.difference(today).inDays;

    if (days < 0) return 'Просрочено на ${days.abs()} дн.';
    if (days == 0) return 'Срок: сегодня';
    if (days == 1) return 'Срок: завтра';
    return 'Срок через $days дн.';
  }

  Color _dueDateColor(Task task) {
    if (task.dueDate == null) return const Color(0xFF64748B);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(
      task.dueDate!.year,
      task.dueDate!.month,
      task.dueDate!.day,
    );
    final days = due.difference(today).inDays;

    if (days < 0 && !task.isCompleted) return Colors.red;
    if (days <= 1 && !task.isCompleted) return Colors.orange;
    return const Color(0xFF64748B);
  }

  void _showFilterDialog(List<String> categories) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Фильтр задач'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Category Filter
                const Text(
                  'Категория',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: categories.map((category) {
                    return FilterChip(
                      label: Text(category),
                      selected: _selectedCategoryFilter == category,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategoryFilter = category;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                // Priority Filter
                const Text(
                  'Приоритет',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['All', 'Low', 'Medium', 'High'].map((priority) {
                    return FilterChip(
                      label: Text(_tasksPriorityFilterLabel(priority)),
                      selected: _selectedPriorityFilter == priority,
                      onSelected: (selected) {
                        setState(() {
                          _selectedPriorityFilter = priority;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Статус',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['All', 'Active', 'Completed'].map((status) {
                    return FilterChip(
                      label: Text(_tasksStatusLabel(status)),
                      selected: _selectedStatusFilter == status,
                      onSelected: (selected) {
                        setState(() {
                          _selectedStatusFilter = status;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Сортировка',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['Newest', 'Oldest', 'Priority'].map((sort) {
                    return FilterChip(
                      label: Text(_tasksSortLabel(sort)),
                      selected: _selectedSortOption == sort,
                      onSelected: (selected) {
                        setState(() {
                          _selectedSortOption = sort;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  void _showTaskDetails(Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TaskDetailsBottomSheet(task: task),
    );
  }

  void _showEditTaskDialog(Task task, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditTaskBottomSheet(task: task, index: index),
    );
  }

  void _confirmDeleteTask(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Удалить задачу'),
          content: const Text('Вы уверены, что хотите удалить задачу?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () async {
                final previousTasks = List<Task>.from(ref.read(tasksProvider));
                try {
                  await ref.read(tasksProvider.notifier).deleteTask(index);
                } catch (error) {
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(toUserFacingErrorMessage(error)),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                if (!context.mounted) return;
                Navigator.pop(context);
                _showUndoSnackBar(
                  message: 'Задача удалена',
                  onUndo: () {
                    unawaited(
                      ref
                          .read(tasksProvider.notifier)
                          .replaceTasks(previousTasks),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _toggleTaskComplete(Task task, int index) async {
    final previousTasks = List<Task>.from(ref.read(tasksProvider));
    final previousStats = ref.read(userStatsProvider);
    final wasCompleted = task.isCompleted;

    try {
      await ref.read(tasksProvider.notifier).toggleComplete(index);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(toUserFacingErrorMessage(error)),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Добавляем XP только при переходе с НЕ выполненной на ВЫПОЛНЕННУЮ
    if (!wasCompleted) {
      final userStatsNotifier = ref.read(userStatsProvider.notifier);
      userStatsNotifier.addXP(25);
      userStatsNotifier.updateStreak();
    }

    _showUndoSnackBar(
      message: wasCompleted
          ? 'Задача снова активна'
          : 'Задача выполнена (+25 XP)',
      onUndo: () {
        unawaited(ref.read(tasksProvider.notifier).replaceTasks(previousTasks));
        ref.read(userStatsProvider.notifier).replaceStats(previousStats);
      },
    );
  }

  Future<void> _duplicateTask(Task task) async {
    final now = DateTime.now();
    final duplicatedTask = Task(
      id: now.microsecondsSinceEpoch.toString(),
      title: '${task.title} (копия)',
      description: task.description,
      priority: task.priority,
      category: task.category,
      clientId: task.clientId,
      dueDate: task.dueDate,
      createdAt: now,
      isCompleted: false,
    );
    try {
      await ref.read(tasksProvider.notifier).addTask(duplicatedTask);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Задача продублирована')));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(toUserFacingErrorMessage(error)),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showUndoSnackBar({
    required String message,
    required VoidCallback onUndo,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(label: 'Отменить', onPressed: onUndo),
      ),
    );
  }

  Widget _buildTasksList(List<Task> tasks, Map<String, String> clientNameById) {
    final filteredTasks = _filterTasks(tasks);

    if (filteredTasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.task_alt_outlined, size: 80, color: Color(0xFF6366F1)),
            SizedBox(height: 16),
            Text(
              'Задачи не найдены',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'Добавьте первую задачу или измените фильтры',
              style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _showAddTaskDialog,
              icon: const Icon(Icons.add),
              label: const Text('Добавить задачу'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        final task = filteredTasks[index];
        final originalIndex = tasks.indexOf(task);
        return _buildTaskCard(task, originalIndex, clientNameById);
      },
    );
  }

  String _tasksStatusLabel(String value) {
    switch (value) {
      case 'Completed':
        return 'Выполненные';
      case 'Active':
        return 'Активные';
      case 'All':
      default:
        return 'Все';
    }
  }

  String _tasksPriorityFilterLabel(String value) {
    switch (value) {
      case 'High':
        return 'Высокий';
      case 'Medium':
        return 'Средний';
      case 'Low':
        return 'Низкий';
      case 'All':
      default:
        return 'Все';
    }
  }

  String _tasksSortLabel(String value) {
    switch (value) {
      case 'Oldest':
        return 'Сначала старые';
      case 'Priority':
        return 'По приоритету';
      case 'Newest':
      default:
        return 'Сначала новые';
    }
  }
}

// ========== CRM PAGE ==========
