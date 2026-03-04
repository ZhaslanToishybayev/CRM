part of '../../../main.dart';

class CRMPage extends ConsumerStatefulWidget {
  const CRMPage({super.key});

  @override
  ConsumerState<CRMPage> createState() => _CRMPageState();
}

class _CRMPageState extends ConsumerState<CRMPage>
    with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  String _selectedStatusFilter = 'All';
  String _selectedSourceFilter = 'All';
  bool _isLoading = true;
  String? _loadError;
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadInitialData());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showAddClientDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddClientBottomSheet(),
    );
  }

  Future<void> _loadInitialData() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _loadError = null;
      });
    }

    try {
      await ref.read(clientsProvider.notifier).loadAll();
      await ref.read(tasksProvider.notifier).loadAll();
    } catch (error) {
      _loadError =
          'Не удалось загрузить CRM данные: ${toUserFacingErrorMessage(error)}';
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final clients = ref.watch(clientsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CRM и клиенты',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _loadInitialData(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: const Color(0xFF8B5CF6),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF8B5CF6),
          tabs: const [
            Tab(text: 'Все'),
            Tab(text: 'Лиды'),
            Tab(text: 'Активные'),
            Tab(text: 'Неактивные'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _loadError != null
          ? _buildLoadErrorState(_loadError!)
          : Column(
              children: [
                // Статистика
                _buildStatsCard(clients),

                // Поиск
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Поиск клиентов...',
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
                _buildFilterChips(),

                // Список клиентов
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildClientsList(clients, 'All'),
                      _buildClientsList(clients, 'lead'),
                      _buildClientsList(clients, 'active'),
                      _buildClientsList(clients, 'inactive'),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddClientDialog(),
        backgroundColor: const Color(0xFF8B5CF6),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, size: 28),
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

  Widget _buildStatsCard(List<Client> clients) {
    final total = clients.length;
    final leads = clients.where((c) => c.status == ClientStatus.lead).length;
    final active = clients.where((c) => c.status == ClientStatus.active).length;
    final inactive = clients
        .where((c) => c.status == ClientStatus.inactive)
        .length;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2F8B5CF6),
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
                  'Всего клиентов',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                Text(
                  '$total',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          _buildStatItem('Лиды', leads.toString()),
          _buildStatItem('Активные', active.toString()),
          _buildStatItem('Неактивные', inactive.toString()),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          if (_selectedStatusFilter != 'All')
            Chip(
              label: Text(_crmStatusLabel(_selectedStatusFilter)),
              onDeleted: () {
                setState(() {
                  _selectedStatusFilter = 'All';
                });
              },
            ),
          if (_selectedSourceFilter != 'All')
            Chip(
              label: Text(_crmSourceLabel(_selectedSourceFilter)),
              onDeleted: () {
                setState(() {
                  _selectedSourceFilter = 'All';
                });
              },
            ),
          ActionChip(
            label: const Text('Сбросить фильтры'),
            onPressed: () {
              setState(() {
                _selectedStatusFilter = 'All';
                _selectedSourceFilter = 'All';
                _searchQuery = '';
                _searchController.clear();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildClientsList(List<Client> clients, String status) {
    final filteredClients = clients.where((client) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          client.firstName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          client.lastName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          client.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (client.company?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false);

      final matchesStatus = status == 'All' || client.status.name == status;

      final matchesFilterStatus =
          _selectedStatusFilter == 'All' ||
          client.status.name == _selectedStatusFilter.toLowerCase();

      final matchesFilterSource =
          _selectedSourceFilter == 'All' ||
          client.source.name == _selectedSourceFilter.toLowerCase();

      return matchesSearch &&
          matchesStatus &&
          matchesFilterStatus &&
          matchesFilterSource;
    }).toList();

    if (filteredClients.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 80, color: Color(0xFF8B5CF6)),
            SizedBox(height: 16),
            Text(
              'Клиенты не найдены',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'Добавьте первого клиента или измените фильтры',
              style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _showAddClientDialog,
              icon: const Icon(Icons.person_add_alt_1),
              label: const Text('Добавить клиента'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredClients.length,
      itemBuilder: (context, index) {
        final client = filteredClients[index];
        final originalIndex = clients.indexOf(client);
        return _buildClientCard(client, originalIndex);
      },
    );
  }

  Widget _buildClientCard(Client client, int index) {
    Color statusColor;
    switch (client.status) {
      case ClientStatus.lead:
        statusColor = const Color(0xFF9E9E9E);
        break;
      case ClientStatus.prospect:
        statusColor = const Color(0xFFFFB74D);
        break;
      case ClientStatus.active:
        statusColor = const Color(0xFF4CAF50);
        break;
      case ClientStatus.inactive:
        statusColor = const Color(0xFFFF9800);
        break;
    }

    return Container(
      key: Key('crm_client_card_${client.id}'),
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showClientDetails(client),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFFEDE9FE),
                      child: Text(
                        '${client.firstName[0]}${client.lastName[0]}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6D28D9),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            client.fullName,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (client.company?.isNotEmpty == true)
                            Text(
                              client.company!,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          _showEditClientDialog(client, index);
                        } else if (value == 'delete') {
                          _confirmDeleteClient(index);
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
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: statusColor.withValues(alpha: 0.28),
                        ),
                      ),
                      child: Text(
                        _crmClientStatusLabel(client.status),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: statusColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              client.email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.hub_outlined, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 6),
                    Text(
                      'Источник: ${_crmClientSourceLabel(client.source)}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                if (client.phone?.isNotEmpty == true) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Text(
                        client.phone!,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Фильтр клиентов'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Status Filter
                const Text(
                  'Статус',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['All', 'Lead', 'Prospect', 'Active', 'Inactive']
                      .map((status) {
                        return FilterChip(
                          label: Text(_crmStatusLabel(status)),
                          selected: _selectedStatusFilter == status,
                          onSelected: (selected) {
                            setState(() {
                              _selectedStatusFilter = status;
                            });
                          },
                        );
                      })
                      .toList(),
                ),
                const SizedBox(height: 16),
                // Source Filter
                const Text(
                  'Источник',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children:
                      [
                        'All',
                        'Website',
                        'Referral',
                        'Email',
                        'Social Media',
                        'Event',
                      ].map((source) {
                        return FilterChip(
                          label: Text(_crmSourceLabel(source)),
                          selected: _selectedSourceFilter == source,
                          onSelected: (selected) {
                            setState(() {
                              _selectedSourceFilter = source;
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

  void _showClientDetails(Client client) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ClientDetailsBottomSheet(client: client),
    );
  }

  void _showEditClientDialog(Client client, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditClientBottomSheet(client: client, index: index),
    );
  }

  void _confirmDeleteClient(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Удалить клиента'),
          content: const Text('Вы уверены, что хотите удалить клиента?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () async {
                final previousClients = List<Client>.from(
                  ref.read(clientsProvider),
                );
                try {
                  await ref.read(clientsProvider.notifier).deleteClient(index);
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
                _showClientUndoSnackBar(
                  message: 'Клиент удален',
                  onUndo: () {
                    unawaited(
                      ref
                          .read(clientsProvider.notifier)
                          .replaceClients(previousClients),
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

  void _showClientUndoSnackBar({
    required String message,
    required VoidCallback onUndo,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: 'Отменить', onPressed: onUndo),
      ),
    );
  }

  String _crmStatusLabel(String value) {
    switch (value) {
      case 'Lead':
      case 'lead':
        return 'Лид';
      case 'Prospect':
      case 'prospect':
        return 'Перспектива';
      case 'Active':
      case 'active':
        return 'Активный';
      case 'Inactive':
      case 'inactive':
        return 'Неактивный';
      case 'All':
      default:
        return 'Все';
    }
  }

  String _crmSourceLabel(String value) {
    switch (value) {
      case 'Website':
      case 'website':
        return 'Сайт';
      case 'Referral':
      case 'referral':
        return 'Рекомендация';
      case 'Email':
      case 'email':
        return 'Email';
      case 'Social Media':
      case 'socialMedia':
        return 'Соцсети';
      case 'Event':
      case 'event':
        return 'Событие';
      case 'All':
      default:
        return 'Все';
    }
  }

  String _crmClientStatusLabel(ClientStatus status) {
    switch (status) {
      case ClientStatus.lead:
        return 'Лид';
      case ClientStatus.prospect:
        return 'Перспектива';
      case ClientStatus.active:
        return 'Активный';
      case ClientStatus.inactive:
        return 'Неактивный';
    }
  }

  String _crmClientSourceLabel(ClientSource source) {
    switch (source) {
      case ClientSource.website:
        return 'Сайт';
      case ClientSource.referral:
        return 'Рекомендация';
      case ClientSource.coldCall:
        return 'Холодный звонок';
      case ClientSource.email:
        return 'Email';
      case ClientSource.socialMedia:
        return 'Соцсети';
      case ClientSource.event:
        return 'Событие';
      case ClientSource.advertisement:
        return 'Реклама';
      case ClientSource.partner:
        return 'Партнер';
      case ClientSource.other:
        return 'Другое';
    }
  }
}

// ========== REPORTS PAGE ==========
