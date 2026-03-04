part of '../../../main.dart';

class AddCRMItemBottomSheet extends StatefulWidget {
  const AddCRMItemBottomSheet({super.key});

  @override
  State<AddCRMItemBottomSheet> createState() => _AddCRMItemBottomSheetState();
}

class _AddCRMItemBottomSheetState extends State<AddCRMItemBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.5,
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
                Text(
                  'Add New CRM Item',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _buildCRMTypeCard(
                        context,
                        'Client',
                        Icons.person,
                        const Color(0xFF3B82F6),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildCRMTypeCard(
                        context,
                        'Deal',
                        Icons.trending_up,
                        const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildCRMTypeCard(
                        context,
                        'Company',
                        Icons.business,
                        const Color(0xFF8B5CF6),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildCRMTypeCard(
                        context,
                        'Lead',
                        Icons.person_add,
                        const Color(0xFFF59E0B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCRMTypeCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ========== CRM BOTTOM SHEETS ==========

class AddClientBottomSheet extends ConsumerStatefulWidget {
  const AddClientBottomSheet({super.key});

  @override
  ConsumerState<AddClientBottomSheet> createState() =>
      _AddClientBottomSheetState();
}

class _AddClientBottomSheetState extends ConsumerState<AddClientBottomSheet> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  ClientStatus _selectedStatus = ClientStatus.lead;
  ClientSource _selectedSource = ClientSource.other;
  bool _isSaving = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);

    String t(String key) {
      return LocalizationService.translate(locale, key);
    }

    return Container(
      key: const Key('add_client_sheet'),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
                  t('addNewClient'),
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        key: const Key('client_first_name_field'),
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: t('firstName'),
                          hintText: t('firstNameHint'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        key: const Key('client_last_name_field'),
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: t('lastName'),
                          hintText: t('lastNameHint'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  key: const Key('client_email_field'),
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: t('email'),
                    hintText: t('emailHint'),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  key: const Key('client_phone_field'),
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: t('phoneOptional'),
                    hintText: t('phoneHint'),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                TextField(
                  key: const Key('client_company_field'),
                  controller: _companyController,
                  decoration: InputDecoration(
                    labelText: t('companyOptional'),
                    hintText: t('companyHint'),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  key: const Key('client_position_field'),
                  controller: _positionController,
                  decoration: InputDecoration(
                    labelText: t('positionOptional'),
                    hintText: t('positionHint'),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  t('status'),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ClientStatus.values.map((status) {
                    final color = status == ClientStatus.lead
                        ? Colors.grey
                        : status == ClientStatus.prospect
                        ? Colors.orange
                        : status == ClientStatus.active
                        ? Colors.green
                        : Colors.red;

                    return FilterChip(
                      label: Text(t(status.name)),
                      selected: _selectedStatus == status,
                      onSelected: (selected) {
                        setState(() {
                          _selectedStatus = status;
                        });
                      },
                      selectedColor: color.withValues(alpha: 0.1),
                      checkmarkColor: color,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  t('source'),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<ClientSource>(
                  key: const Key('client_source_dropdown'),
                  initialValue: _selectedSource,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: ClientSource.values.map((source) {
                    return DropdownMenuItem(
                      value: source,
                      child: Text(t(source.name)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSource = value!;
                    });
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    key: const Key('client_save_button'),
                    onPressed: _isSaving
                        ? null
                        : () async {
                            setState(() {
                              _isSaving = true;
                            });

                            final firstName = _firstNameController.text.trim();
                            final lastName = _lastNameController.text.trim();
                            final email = _emailController.text.trim();
                            final phone = _phoneController.text.trim();
                            final company = _companyController.text.trim();
                            final position = _positionController.text.trim();

                            if (firstName.isEmpty ||
                                lastName.isEmpty ||
                                email.isEmpty) {
                              setState(() {
                                _isSaving = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Заполните обязательные поля: имя, фамилия, email.',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            final firstNameError =
                                ClientValidators.validateName(firstName);
                            final lastNameError = ClientValidators.validateName(
                              lastName,
                            );
                            final emailError = ClientValidators.validateEmail(
                              email,
                            );
                            final phoneError = ClientValidators.validatePhone(
                              phone,
                            );
                            final validationError =
                                firstNameError ??
                                lastNameError ??
                                emailError ??
                                phoneError;

                            if (validationError != null) {
                              setState(() {
                                _isSaving = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(validationError),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            final clientId = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            final newClient = Client(
                              id: clientId,
                              firstName: firstName,
                              lastName: lastName,
                              email: email,
                              phone: phone.isEmpty ? null : phone,
                              company: company.isEmpty ? null : company,
                              position: position.isEmpty ? null : position,
                              status: _selectedStatus,
                              source: _selectedSource,
                              createdAt: DateTime.now(),
                            );

                            try {
                              await ref
                                  .read(clientsProvider.notifier)
                                  .addClient(newClient);
                              if (!context.mounted) return;
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(t('clientCreated')),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } catch (error) {
                              setState(() {
                                _isSaving = false;
                              });
                              if (!context.mounted) return;
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
                      backgroundColor: const Color(0xFF8B5CF6),
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
                            t('createClient'),
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

class ClientDetailsBottomSheet extends ConsumerWidget {
  final Client client;

  const ClientDetailsBottomSheet({super.key, required this.client});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    final clientTasks =
        tasks.where((task) => task.clientId == client.id).toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    Color statusColor;
    switch (client.status) {
      case ClientStatus.lead:
        statusColor = Colors.grey;
        break;
      case ClientStatus.prospect:
        statusColor = Colors.orange;
        break;
      case ClientStatus.active:
        statusColor = Colors.green;
        break;
      case ClientStatus.inactive:
        statusColor = Colors.red;
        break;
    }

    return Container(
      key: const Key('client_details_sheet'),
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
                    CircleAvatar(
                      backgroundColor: const Color(0xFF8B5CF6),
                      radius: 30,
                      child: Text(
                        '${client.firstName[0]}${client.lastName[0]}',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            client.fullName,
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (client.company?.isNotEmpty == true)
                            Text(
                              client.company!,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildDetailRow(
                  'Email',
                  client.email,
                  Icons.email,
                  const Color(0xFF3B82F6),
                ),
                const SizedBox(height: 12),
                if (client.phone != null && client.phone!.isNotEmpty)
                  _buildDetailRow(
                    'Phone',
                    client.phone!,
                    Icons.phone,
                    const Color(0xFF10B981),
                  ),
                if (client.phone != null && client.phone!.isNotEmpty)
                  const SizedBox(height: 12),
                _buildDetailRow(
                  'Status',
                  client.status.name[0].toUpperCase() +
                      client.status.name.substring(1),
                  Icons.person,
                  statusColor,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Source',
                  client.source.name[0].toUpperCase() +
                      client.source.name.substring(1),
                  Icons.source,
                  const Color(0xFF8B5CF6),
                ),
                if (client.position != null && client.position!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    'Position',
                    client.position!,
                    Icons.work,
                    const Color(0xFF06B6D4),
                  ),
                ],
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Created',
                  '${client.createdAt.day}/${client.createdAt.month}/${client.createdAt.year}',
                  Icons.add_circle,
                  Colors.grey,
                ),
                const SizedBox(height: 24),
                Text(
                  'Связанные задачи',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                if (clientTasks.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      'Для этого клиента пока нет задач.',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  )
                else
                  ...clientTasks.map(_buildClientTaskRow),
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

  Widget _buildClientTaskRow(Task task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(
            task.isCompleted
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: task.isCompleted
                ? const Color(0xFF10B981)
                : const Color(0xFF94A3B8),
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                if (task.dueDate != null)
                  Text(
                    'Due: ${task.dueDate!.day}/${task.dueDate!.month}/${task.dueDate!.year}',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EditClientBottomSheet extends ConsumerStatefulWidget {
  final Client client;
  final int index;

  const EditClientBottomSheet({
    super.key,
    required this.client,
    required this.index,
  });

  @override
  ConsumerState<EditClientBottomSheet> createState() =>
      _EditClientBottomSheetState();
}

class _EditClientBottomSheetState extends ConsumerState<EditClientBottomSheet> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _companyController;
  late TextEditingController _positionController;
  late ClientStatus _selectedStatus;
  late ClientSource _selectedSource;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.client.firstName);
    _lastNameController = TextEditingController(text: widget.client.lastName);
    _emailController = TextEditingController(text: widget.client.email);
    _phoneController = TextEditingController(text: widget.client.phone ?? '');
    _companyController = TextEditingController(
      text: widget.client.company ?? '',
    );
    _positionController = TextEditingController(
      text: widget.client.position ?? '',
    );
    _selectedStatus = widget.client.status;
    _selectedSource = widget.client.source;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  'Edit Client',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          hintText: 'Enter first name',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          hintText: 'Enter last name',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone (Optional)',
                    hintText: 'Enter phone number',
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _companyController,
                  decoration: const InputDecoration(
                    labelText: 'Company (Optional)',
                    hintText: 'Enter company name',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _positionController,
                  decoration: const InputDecoration(
                    labelText: 'Position (Optional)',
                    hintText: 'Enter position',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Status',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ClientStatus.values.map((status) {
                    final color = status == ClientStatus.lead
                        ? Colors.grey
                        : status == ClientStatus.prospect
                        ? Colors.orange
                        : status == ClientStatus.active
                        ? Colors.green
                        : Colors.red;

                    return FilterChip(
                      label: Text(
                        status.name[0].toUpperCase() + status.name.substring(1),
                      ),
                      selected: _selectedStatus == status,
                      onSelected: (selected) {
                        setState(() {
                          _selectedStatus = status;
                        });
                      },
                      selectedColor: color.withValues(alpha: 0.1),
                      checkmarkColor: color,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  'Source',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<ClientSource>(
                  initialValue: _selectedSource,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: ClientSource.values.map((source) {
                    return DropdownMenuItem(
                      value: source,
                      child: Text(
                        source.name[0].toUpperCase() + source.name.substring(1),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSource = value!;
                    });
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _firstNameController.text.isEmpty ||
                            _lastNameController.text.isEmpty ||
                            _emailController.text.isEmpty
                        ? null
                        : () async {
                            final updatedClient = Client(
                              id: widget.client.id,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text.isEmpty
                                  ? null
                                  : _phoneController.text,
                              company: _companyController.text.isEmpty
                                  ? null
                                  : _companyController.text,
                              position: _positionController.text.isEmpty
                                  ? null
                                  : _positionController.text,
                              status: _selectedStatus,
                              source: _selectedSource,
                              createdAt: widget.client.createdAt,
                            );

                            try {
                              await ref
                                  .read(clientsProvider.notifier)
                                  .updateClient(widget.index, updatedClient);
                              if (!context.mounted) return;
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Client updated successfully!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } catch (error) {
                              if (!context.mounted) return;
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
                      backgroundColor: const Color(0xFF8B5CF6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Update Client',
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

// ========== AI ASSISTANT SCREEN ==========
