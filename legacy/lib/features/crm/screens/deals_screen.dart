import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/crm/deal_model.dart';
import '../../../../core/models/crm/pipeline_model.dart';
import '../services/crm_service.dart';

class DealsScreen extends ConsumerStatefulWidget {
  const DealsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends ConsumerState<DealsScreen> {
  DealStatus? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Deals & Sales'),
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pipeline'),
              Tab(text: 'List'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showFilterMenu,
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // Pipeline View
            _buildPipelineView(),
            // List View
            _buildListView(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push('/crm/deals/new');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildPipelineView() {
    final crmService = ref.read(crmServiceProvider);

    return FutureBuilder<List<PipelineModel>>(
      future: crmService.getPipelines(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final pipelines = snapshot.data ?? [];
        if (pipelines.isEmpty) {
          return const Center(
            child: Text('No pipelines found'),
          );
        }

        // For simplicity, show the first pipeline
        final pipeline = pipelines.first;

        return FutureBuilder<List<DealModel>>(
          future: crmService.getDeals(),
          builder: (context, dealsSnapshot) {
            if (dealsSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final deals = dealsSnapshot.data ?? [];

            return _buildKanbanBoard(context, pipeline.stages, deals);
          },
        );
      },
    );
  }

  Widget _buildKanbanBoard(
    BuildContext context,
    List<PipelineStage> stages,
    List<DealModel> deals,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columnWidth = screenWidth / stages.length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: stages.map((stage) {
          final stageDeals = deals
              .where((deal) => deal.stageId == stage.id)
              .where((deal) => _selectedFilter == null || deal.status == _selectedFilter)
              .toList();

          final totalValue = stageDeals.fold<double>(
            0,
            (sum, deal) => sum + deal.amount,
          );

          return Container(
            width: columnWidth,
            constraints: BoxConstraints(
              minWidth: 280,
              maxWidth: 320,
            ),
            margin: const EdgeInsets.all(8),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stage Header
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: () {
                        final stageColor = stage.color as dynamic;
                        final colorValue = stageColor?.value as int?;
                        return colorValue != null ? Color(colorValue) : Colors.grey;
                      }(),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stage.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${stageDeals.length} deals • \$${totalValue.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Deals in Stage
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: stageDeals.length,
                      itemBuilder: (context, index) {
                        final deal = stageDeals[index];
                        return _buildDealCard(context, deal);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDealCard(BuildContext context, DealModel deal) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          context.push('/crm/deals/${deal.id}');
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deal.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '\$${deal.amount.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              if (deal.clientName != null)
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        deal.clientName!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: () {
                    if (deal.status == null || deal.status!.color == null) {
                      return Colors.grey;
                    }
                    final colorStr = deal.status!.color as String;
                    return Color(int.parse(colorStr));
                  }(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  deal.status?.displayName ?? 'Unknown',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    final crmService = ref.read(crmServiceProvider);

    return FutureBuilder<List<DealModel>>(
      future: crmService.getDeals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final deals = snapshot.data ?? [];

        if (deals.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.trending_up_outlined, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'No deals found',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Create your first deal to start tracking sales',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    context.push('/crm/deals/new');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Create Deal'),
                ),
              ],
            ),
          );
        }

        // Filter deals
        final filteredDeals = _selectedFilter != null
            ? deals.where((d) => d.status == _selectedFilter).toList()
            : deals;

        // Sort by amount descending
        filteredDeals.sort((a, b) => b.amount.compareTo(a.amount));

        return RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: filteredDeals.length,
            itemBuilder: (context, index) {
              final deal = filteredDeals[index];
              return _buildDealListTile(context, deal);
            },
          ),
        );
      },
    );
  }

  Widget _buildDealListTile(BuildContext context, DealModel deal) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: () {
            if (deal.status == null || deal.status!.color == null) {
              return Colors.grey;
            }
            final colorStr = deal.status!.color as String;
            return Color(int.parse(colorStr));
          }(),
          child: Text(
            deal.title[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(deal.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (deal.clientName != null)
              Text(deal.clientName!),
            Text(
              '\$${deal.amount.toStringAsFixed(0)}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: () {
              if (deal.status == null || deal.status!.color == null) {
                return Colors.grey;
              }
              final colorStr = deal.status!.color as String;
              return Color(int.parse(colorStr));
            }(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            deal.status?.displayName ?? 'Unknown',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onTap: () {
          context.push('/crm/deals/${deal.id}');
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
              'Filter Deals',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.all_inclusive),
              title: const Text('All Deals'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedFilter = null;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.play_circle_outline),
              title: const Text('Open'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedFilter = DealStatus.open;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text('Won'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedFilter = DealStatus.won;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Lost'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedFilter = DealStatus.lost;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
