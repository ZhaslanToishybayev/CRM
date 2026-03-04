import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/crm/deal_model.dart';
import '../services/crm_sales_funnel_service.dart';

class SalesFunnelScreen extends ConsumerStatefulWidget {
  const SalesFunnelScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SalesFunnelScreen> createState() => _SalesFunnelScreenState();
}

class _SalesFunnelScreenState extends ConsumerState<SalesFunnelScreen> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 90));
  DateTime _endDate = DateTime.now();
  String _selectedPipelineId = 'default';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final funnelService = ref.read(crmSalesFunnelServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Funnel'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: _showDateRangePicker,
          ),
          IconButton(
            icon: const Icon(Icons.insights),
            onPressed: _showInsightsDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Pipeline selector and date range
          _buildHeader(),
          const Divider(height: 1),

          // Funnel metrics
          _buildFunnelMetrics(),

          // Funnel visualization
          Expanded(
            child: _buildFunnelVisualization(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pipeline',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  value: _selectedPipelineId,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'default',
                      child: Text('Default Sales Pipeline'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedPipelineId = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date Range',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  '${_formatDate(_startDate)} - ${_formatDate(_endDate)}',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunnelMetrics() {
    final funnelService = ref.read(crmSalesFunnelServiceProvider);

    return FutureBuilder<SalesFunnelData>(
      future: funnelService.getSalesFunnelData(
        pipelineId: _selectedPipelineId,
        startDate: _startDate,
        endDate: _endDate,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Error loading funnel data'),
          );
        }

        final data = snapshot.data!;

        return Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Total Deals',
                  data.totalDeals.toString(),
                  Icons.trending_up,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  'Conversion Rate',
                  '${data.overallConversionRate.toStringAsFixed(1)}%',
                  Icons.trending_up,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  'Won Value',
                  '\$${data.wonValue.toStringAsFixed(0)}',
                  Icons.attach_money,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  'Avg Deal Size',
                  '\$${data.averageDealSize.toStringAsFixed(0)}',
                  Icons.analytics,
                  Colors.purple,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFunnelVisualization() {
    final funnelService = ref.read(crmSalesFunnelServiceProvider);

    return FutureBuilder<SalesFunnelData>(
      future: funnelService.getSalesFunnelData(
        pipelineId: _selectedPipelineId,
        startDate: _startDate,
        endDate: _endDate,
      ),
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
                Text('Error loading funnel: ${snapshot.error}'),
              ],
            ),
          );
        }

        final data = snapshot.data!;

        if (data.stages.isEmpty) {
          return const Center(
            child: Text('No pipeline data available'),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: data.stages.map((stageData) {
              return _buildFunnelStage(stageData);
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildFunnelStage(FunnelStageData stageData) {
    final theme = Theme.of(context);
    final stage = stageData.stage;
    final stageWidth = _calculateStageWidth(stageData);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stage header
          Container(
            width: stageWidth,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: stage.color != null ? Color(stage.color!) : Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stage.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: Colors.white70,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${stageData.conversionRate.toStringAsFixed(1)}% conversion',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Stage metrics
          Container(
            width: stageWidth,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: stage.color != null ? Color(stage.color!) : Colors.grey),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStageMetric('Deals', stageData.count.toString()),
                    _buildStageMetric('Value', '\$${stageData.value.toStringAsFixed(0)}'),
                    _buildStageMetric('% of Total', '${stageData.percentageOfTotal.toStringAsFixed(1)}%'),
                  ],
                ),
                const SizedBox(height: 12),
                // Conversion rate bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Conversion Rate',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: stageData.conversionRate / 100,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        stage.color != null ? Color(stage.color!) : Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Drop-off: ${stageData.dropOffRate.toStringAsFixed(1)}%',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: stageData.dropOffRate > 50 ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Deals list
          if (stageData.deals.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              width: stageWidth,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                children: stageData.deals.take(5).map((deal) {
                  return ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      backgroundColor: stage.color != null ? Color(stage.color!).withOpacity(0.2) : Colors.grey,
                      child: Text(
                        deal.title[0].toUpperCase(),
                        style: TextStyle(
                          color: stage.color != null ? Color(stage.color!) : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      deal.title,
                      style: const TextStyle(fontSize: 14),
                    ),
                    subtitle: Text(
                      '\$${deal.amount.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: deal.status != null ? _getStatusColor(deal.status!) : Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        deal.status?.displayName ?? 'Unknown',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (stageData.deals.length > 5)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'And ${stageData.deals.length - 5} more deals...',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageMetric(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  double _calculateStageWidth(FunnelStageData stageData) {
    // First stage is full width, subsequent stages are narrower
    final index = stageData.stage.order;
    final baseWidth = MediaQuery.of(context).size.width - 32;
    return baseWidth - ((index - 1) * 40);
  }

  Color _getStatusColor(DealStatus status) {
    switch (status) {
      case DealStatus.open:
        return Colors.blue;
      case DealStatus.won:
        return Colors.green;
      case DealStatus.lost:
        return Colors.red;
      case DealStatus.onHold:
        return Colors.orange;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showDateRangePicker() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: _startDate,
        end: _endDate,
      ),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  void _showInsightsDialog() {
    final funnelService = ref.read(crmSalesFunnelServiceProvider);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: FutureBuilder<FunnelInsights>(
          future: funnelService.getFunnelInsights(_selectedPipelineId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (!snapshot.hasData) {
              return const Padding(
                padding: EdgeInsets.all(24),
                child: Text('No insights available'),
              );
            }

            final insights = snapshot.data!;

            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Funnel Insights',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (insights.bestPerformingStage != null) ...[
                    Text(
                      'Best Performing Stage',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(insights.bestPerformingStage!),
                    const SizedBox(height: 16),
                  ],

                  if (insights.bottlenecks.isNotEmpty) ...[
                    Text(
                      'Bottlenecks',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...insights.bottlenecks.map((bottleneck) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(Icons.warning, color: Colors.orange, size: 16),
                            const SizedBox(width: 8),
                            Expanded(child: Text(bottleneck)),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                  ],

                  if (insights.recommendations.isNotEmpty) ...[
                    Text(
                      'Recommendations',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...insights.recommendations.map((recommendation) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.lightbulb, color: Colors.blue, size: 16),
                            const SizedBox(width: 8),
                            Expanded(child: Text(recommendation)),
                          ],
                        ),
                      );
                    }),
                  ],

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
