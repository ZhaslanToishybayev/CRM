part of '../../../main.dart';

class TaskDetailsBottomSheet extends StatelessWidget {
  final Task task;

  const TaskDetailsBottomSheet({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    Color priorityColor;
    String priorityText;

    switch (task.priority) {
      case TaskPriority.low:
        priorityColor = const Color(0xFF10B981);
        priorityText = 'Низкий';
        break;
      case TaskPriority.medium:
        priorityColor = const Color(0xFFF59E0B);
        priorityText = 'Средний';
        break;
      case TaskPriority.high:
        priorityColor = const Color(0xFFF44336);
        priorityText = 'Высокий';
        break;
    }

    return Container(
      key: const Key('add_task_sheet'),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.4,
        maxChildSize: 0.8,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      task.isCompleted ? Icons.check_circle : Icons.circle,
                      color: task.isCompleted ? Colors.green : Colors.grey,
                      size: 28,
                    ),
                  ],
                ),
                if (task.description.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    task.description,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                _buildDetailRow(
                  'Приоритет',
                  priorityText,
                  Icons.flag,
                  priorityColor,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Категория',
                  task.category,
                  Icons.category,
                  const Color(0xFF6366F1),
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Статус',
                  task.isCompleted ? 'Выполнена' : 'В работе',
                  task.isCompleted ? Icons.check : Icons.hourglass_empty,
                  task.isCompleted ? Colors.green : Colors.orange,
                ),
                if (task.dueDate != null) ...[
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    'Срок',
                    '${task.dueDate!.day}/${task.dueDate!.month}/${task.dueDate!.year}',
                    Icons.calendar_today,
                    const Color(0xFF8B5CF6),
                  ),
                ],
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Создана',
                  '${task.createdAt.day}/${task.createdAt.month}/${task.createdAt.year}',
                  Icons.add_circle,
                  Colors.grey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ========== EDIT TASK BOTTOM SHEET ==========

class EditTaskBottomSheet extends ConsumerStatefulWidget {
  final Task task;
  final int index;

  const EditTaskBottomSheet({
    super.key,
    required this.task,
    required this.index,
  });

  @override
  ConsumerState<EditTaskBottomSheet> createState() =>
      _EditTaskBottomSheetState();
}

class _EditTaskBottomSheetState extends ConsumerState<EditTaskBottomSheet> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TaskPriority _selectedPriority;
  late String _selectedCategory;
  late String _selectedClientValue;
  DateTime? _selectedDueDate;
  bool _isSaving = false;

  final List<String> _categories = [
    'General',
    'Work',
    'Personal',
    'Shopping',
    'Health',
    'Finance',
    'Education',
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(
      text: widget.task.description,
    );
    _selectedPriority = widget.task.priority;
    _selectedCategory = widget.task.category;
    _selectedClientValue = widget.task.clientId ?? kNoClientSelectionValue;
    _selectedDueDate = widget.task.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clients = ref.watch(clientsProvider);
    final clientSelectionItems = <DropdownMenuItem<String>>[
      const DropdownMenuItem(
        value: kNoClientSelectionValue,
        child: Text('No client (general task)'),
      ),
      ...clients.map(
        (client) =>
            DropdownMenuItem(value: client.id, child: Text(client.fullName)),
      ),
    ];
    final hasSelectedClient = clients.any(
      (client) => client.id == _selectedClientValue,
    );
    if (_selectedClientValue != kNoClientSelectionValue && !hasSelectedClient) {
      clientSelectionItems.add(
        DropdownMenuItem(
          value: _selectedClientValue,
          child: Text('Unknown client (deleted)'),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Редактировать задачу',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  key: const Key('task_title_field'),
                  controller: _titleController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    labelText: 'Название задачи',
                    hintText: 'Введите название задачи',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  key: const Key('task_description_field'),
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Описание',
                    hintText: 'Введите описание задачи',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Text(
                  'Приоритет',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: TaskPriority.values.map((priority) {
                    final color = priority == TaskPriority.low
                        ? const Color(0xFF10B981)
                        : priority == TaskPriority.medium
                        ? const Color(0xFFF59E0B)
                        : const Color(0xFFF44336);

                    return FilterChip(
                      label: Text(
                        priority == TaskPriority.low
                            ? 'Низкий'
                            : priority == TaskPriority.medium
                            ? 'Средний'
                            : 'Высокий',
                      ),
                      selected: _selectedPriority == priority,
                      onSelected: (selected) {
                        setState(() {
                          _selectedPriority = priority;
                        });
                      },
                      selectedColor: color.withValues(alpha: 0.1),
                      checkmarkColor: color,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  'Категория',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  key: const Key('task_category_dropdown'),
                  initialValue: _selectedCategory,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Клиент',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _selectedClientValue,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Выберите клиента или общий тип задачи',
                  ),
                  items: clientSelectionItems,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedClientValue = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Срок (необязательно)',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _selectedDueDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() {
                        _selectedDueDate = date;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey[600]),
                        const SizedBox(width: 12),
                        Text(
                          _selectedDueDate != null
                              ? '${_selectedDueDate!.day}/${_selectedDueDate!.month}/${_selectedDueDate!.year}'
                              : 'Выберите дату',
                          style: TextStyle(
                            color: _selectedDueDate != null
                                ? Colors.black
                                : Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ActionChip(
                      label: const Text('Сегодня'),
                      onPressed: () {
                        setState(() {
                          _selectedDueDate = DateTime.now();
                        });
                      },
                    ),
                    ActionChip(
                      label: const Text('Завтра'),
                      onPressed: () {
                        setState(() {
                          _selectedDueDate = DateTime.now().add(
                            const Duration(days: 1),
                          );
                        });
                      },
                    ),
                    ActionChip(
                      label: const Text('+7 дней'),
                      onPressed: () {
                        setState(() {
                          _selectedDueDate = DateTime.now().add(
                            const Duration(days: 7),
                          );
                        });
                      },
                    ),
                    if (_selectedDueDate != null)
                      ActionChip(
                        label: const Text('Очистить'),
                        onPressed: () {
                          setState(() {
                            _selectedDueDate = null;
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSaving || _titleController.text.trim().isEmpty
                        ? null
                        : () async {
                            final selectedClientId =
                                _selectedClientValue == kNoClientSelectionValue
                                ? null
                                : _selectedClientValue;
                            setState(() {
                              _isSaving = true;
                            });
                            final updatedTask = Task(
                              id: widget.task.id,
                              title: _titleController.text.trim(),
                              description: _descriptionController.text,
                              priority: _selectedPriority,
                              category: _selectedCategory,
                              clientId: selectedClientId,
                              dueDate: _selectedDueDate,
                              createdAt: widget.task.createdAt,
                              isCompleted: widget.task.isCompleted,
                            );

                            try {
                              await ref
                                  .read(tasksProvider.notifier)
                                  .updateTask(widget.index, updatedTask);
                              if (!context.mounted) return;
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Задача обновлена'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } catch (error) {
                              if (!context.mounted) return;
                              setState(() {
                                _isSaving = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    toUserFacingErrorMessage(error),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Сохранить изменения',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ========== BOTTOM SHEETS ==========

class AddTaskBottomSheet extends ConsumerStatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  ConsumerState<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends ConsumerState<AddTaskBottomSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  TaskPriority _selectedPriority = TaskPriority.medium;
  String _selectedCategory = 'General';
  String _selectedClientValue = '';
  DateTime? _selectedDueDate;
  bool _isSaving = false;

  final List<String> _categories = [
    'General',
    'Work',
    'Personal',
    'Shopping',
    'Health',
    'Finance',
    'Education',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clients = ref.watch(clientsProvider);
    final clientSelectionItems = <DropdownMenuItem<String>>[
      const DropdownMenuItem(
        value: kNoClientSelectionValue,
        child: Text('No client (general task)'),
      ),
      ...clients.map(
        (client) =>
            DropdownMenuItem(value: client.id, child: Text(client.fullName)),
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Новая задача',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _titleController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    labelText: 'Название задачи',
                    hintText: 'Введите название задачи',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Описание',
                    hintText: 'Введите описание задачи',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                // Priority Selection
                Text(
                  'Приоритет',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: TaskPriority.values.map((priority) {
                    final color = priority == TaskPriority.low
                        ? const Color(0xFF10B981)
                        : priority == TaskPriority.medium
                        ? const Color(0xFFF59E0B)
                        : const Color(0xFFF44336);

                    return FilterChip(
                      label: Text(
                        priority == TaskPriority.low
                            ? 'Низкий'
                            : priority == TaskPriority.medium
                            ? 'Средний'
                            : 'Высокий',
                      ),
                      selected: _selectedPriority == priority,
                      onSelected: (selected) {
                        setState(() {
                          _selectedPriority = priority;
                        });
                      },
                      selectedColor: color.withValues(alpha: 0.1),
                      checkmarkColor: color,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                // Category Selection
                Text(
                  'Категория',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Клиент',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  key: const Key('task_client_dropdown'),
                  initialValue: _selectedClientValue.isEmpty
                      ? null
                      : _selectedClientValue,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Выберите клиента или No client',
                  ),
                  items: clientSelectionItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedClientValue = value ?? '';
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Due Date Selection
                Text(
                  'Срок (необязательно)',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _selectedDueDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() {
                        _selectedDueDate = date;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey[600]),
                        const SizedBox(width: 12),
                        Text(
                          _selectedDueDate != null
                              ? '${_selectedDueDate!.day}/${_selectedDueDate!.month}/${_selectedDueDate!.year}'
                              : 'Выберите дату',
                          style: TextStyle(
                            color: _selectedDueDate != null
                                ? Colors.black
                                : Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ActionChip(
                      label: const Text('Сегодня'),
                      onPressed: () {
                        setState(() {
                          _selectedDueDate = DateTime.now();
                        });
                      },
                    ),
                    ActionChip(
                      label: const Text('Завтра'),
                      onPressed: () {
                        setState(() {
                          _selectedDueDate = DateTime.now().add(
                            const Duration(days: 1),
                          );
                        });
                      },
                    ),
                    ActionChip(
                      label: const Text('+7 дней'),
                      onPressed: () {
                        setState(() {
                          _selectedDueDate = DateTime.now().add(
                            const Duration(days: 7),
                          );
                        });
                      },
                    ),
                    if (_selectedDueDate != null)
                      ActionChip(
                        label: const Text('Очистить'),
                        onPressed: () {
                          setState(() {
                            _selectedDueDate = null;
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    key: const Key('task_save_button'),
                    onPressed: _isSaving || _titleController.text.trim().isEmpty
                        ? null
                        : () async {
                            if (_selectedClientValue.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Выберите клиента или No client перед созданием задачи.',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            final selectedClientId =
                                _selectedClientValue == kNoClientSelectionValue
                                ? null
                                : _selectedClientValue;
                            setState(() {
                              _isSaving = true;
                            });
                            final title = _titleController.text.trim();
                            final taskId = DateTime.now().millisecondsSinceEpoch
                                .toString();
                            final newTask = Task(
                              id: taskId,
                              title: title,
                              description: _descriptionController.text,
                              priority: _selectedPriority,
                              category: _selectedCategory,
                              clientId: selectedClientId,
                              dueDate: _selectedDueDate,
                              createdAt: DateTime.now(),
                            );

                            try {
                              await ref
                                  .read(tasksProvider.notifier)
                                  .addTask(newTask);
                              if (!context.mounted) return;
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Задача "$title" создана'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } catch (error) {
                              if (!context.mounted) return;
                              setState(() {
                                _isSaving = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    toUserFacingErrorMessage(error),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Создать задачу',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
