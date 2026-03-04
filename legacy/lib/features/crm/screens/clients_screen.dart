import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/crm/client_model.dart';
import '../services/crm_service.dart';

class ClientsScreen extends ConsumerStatefulWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends ConsumerState<ClientsScreen> {
  final TextEditingController _searchController = TextEditingController();
  ClientStatus? _selectedFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterMenu,
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters
          _buildFilters(),
          const Divider(height: 1),

          // Client List
          Expanded(
            child: _buildClientList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/crm/clients/new');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Status Filter Chips
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All', null),
                  const SizedBox(width: 8),
                  _buildFilterChip('Active', ClientStatus.active),
                  const SizedBox(width: 8),
                  _buildFilterChip('Leads', ClientStatus.lead),
                  const SizedBox(width: 8),
                  _buildFilterChip('Prospects', ClientStatus.prospect),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, ClientStatus? status) {
    final isSelected = _selectedFilter == status;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? status : null;
        });
      },
      backgroundColor: isSelected
          ? Theme.of(context).colorScheme.primaryContainer
          : null,
      checkmarkColor: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildClientList() {
    final crmService = ref.read(crmServiceProvider);

    return FutureBuilder<List<ClientModel>>(
      future: crmService.getClients(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'Error loading clients',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        }

        final clients = snapshot.data ?? [];

        if (clients.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.people_outline, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'No clients found',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Add your first client to get started',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    context.push('/crm/clients/new');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Client'),
                ),
              ],
            ),
          );
        }

        // Filter clients based on selected filter
        final filteredClients = _selectedFilter != null
            ? clients.where((c) => c.status == _selectedFilter).toList()
            : clients;

        if (filteredClients.isEmpty) {
          return const Center(
            child: Text('No clients match the selected filter'),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: filteredClients.length,
            itemBuilder: (context, index) {
              final client = filteredClients[index];
              return _buildClientCard(context, client);
            },
          ),
        );
      },
    );
  }

  Widget _buildClientCard(BuildContext context, ClientModel client) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: client.avatarUrl != null
              ? NetworkImage(client.avatarUrl!)
              : null,
          child: client.avatarUrl == null
              ? Text(
                  '${client.firstName[0]}${client.lastName[0]}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              : null,
        ),
        title: Text('${client.firstName} ${client.lastName}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (client.companyName != null)
              Text(
                client.companyName!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            if (client.email.isNotEmpty)
              Text(
                client.email,
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
        trailing: client.status != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(int.parse(client.status!.color)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  client.status!.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        onTap: () {
          context.push('/crm/clients/${client.id}');
        },
      ),
    );
  }

  void _showFilterMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Clients',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.all_inclusive),
              title: const Text('All Clients'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedFilter = null;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Active'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedFilter = ClientStatus.active;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Leads'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedFilter = ClientStatus.lead;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.visibility),
              title: const Text('Prospects'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedFilter = ClientStatus.prospect;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Clients'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Enter name, email, or company...',
            prefixIcon: Icon(Icons.search),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _searchController.clear();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _performSearch();
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      // TODO: Implement search functionality
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Searching for: $query'),
        ),
      );
    }
  }
}
