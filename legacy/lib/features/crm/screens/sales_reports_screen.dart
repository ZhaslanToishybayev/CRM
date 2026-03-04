import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../services/crm_reports_service.dart';

class SalesReportsScreen extends ConsumerStatefulWidget {
  const SalesReportsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SalesReportsScreen> createState() => _SalesReportsScreenState();
}

class _SalesReportsScreenState extends ConsumerState<SalesReportsScreen> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime _endDate = DateTime.now();
  ReportType _selectedReportType = ReportType.summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reportsService = ref.read(crmReportsServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Reports'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: _showDateRangePicker,
          ),
          PopupMenuButton<ReportType>(
            icon: const Icon(Icons.more_vert),
            onSelected: (type) {
              setState(() {
                _selectedReportType = type;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ReportType.summary,
                child: ListTile(
                  leading: Icon(Icons.summarize),
                  title: Text('Summary'),
                  subtitle: Text('Overall performance'),
                ),
              ),
              const PopupMenuItem(
                value: ReportType.pipeline,
                child: ListTile(
                  leading: Icon(Icons.account_tree),
                  title: Text('Pipeline'),
                  subtitle: Text('Stage performance'),
                ),
              ),
              const PopupMenuItem(
                value: ReportType.period,
                child: ListTile(
                  leading: Icon(Icons.timeline),
                  title: Text('By Period'),
                  subtitle: Text('Sales over time'),
                ),
              ),
              const PopupMenuItem(
                value: ReportType.performers,
                child: ListTile(
                  leading: Icon(Icons.emoji_events),
                  title: Text('Top Performers'),
                  subtitle: Text('Best clients'),
                ),
              ),
              const PopupMenuItem(
                value: ReportType.activity,
                child: ListTile(
                  leading: Icon(Icons.analytics),
                  title: Text('Activity'),
                  subtitle: Text('Activity metrics'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date range selector
            _buildDateRangeCard(),
            const SizedBox(height: 16),

            // Report type tabs
            _buildReportTypeTabs(),
            const SizedBox(height: 16),

            // Report content
            _buildReportContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangeCard() {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date Range',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      '${_formatDate(_startDate)} - ${_formatDate(_endDate)}',
                    ),
                    onPressed: _showDateRangePicker,
                  ),
                ),
                const SizedBox(width: 8),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.filter_list),
                  onSelected: (value) {
                    switch (value) {
                      case 'last7':
                        setState(() {
                          _startDate = DateTime.now().subtract(Duration(days: 7));
                          _endDate = DateTime.now();
                        });
                        break;
                      case 'last30':
                        setState(() {
                          _startDate = DateTime.now().subtract(Duration(days: 30));
                          _endDate = DateTime.now();
                        });
                        break;
                      case 'last90':
                        setState(() {
                          _startDate = DateTime.now().subtract(Duration(days: 90));
                          _endDate = DateTime.now();
                        });
                        break;
                      case 'thisYear':
                        setState(() {
                          _startDate = DateTime(DateTime.now().year, 1, 1);
                          _endDate = DateTime.now();
                        });
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'last7',
                      child: Text('Last 7 days'),
                    ),
                    const PopupMenuItem(
                      value: 'last30',
                      child: Text('Last 30 days'),
                    ),
                    const PopupMenuItem(
                      value: 'last90',
                      child: Text('Last 90 days'),
                    ),
                    const PopupMenuItem(
                      value: 'thisYear',
                      child: Text('This year'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportTypeTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildTab('Summary', ReportType.summary),
          const SizedBox(width: 8),
          _buildTab('Pipeline', ReportType.pipeline),
          const SizedBox(width: 8),
          _buildTab('Period', ReportType.period),
          const SizedBox(width: 8),
          _buildTab('Performers', ReportType.performers),
          const SizedBox(width: 8),
          _buildTab('Activity', ReportType.activity),
        ],
      ),
    );
  }

  Widget _buildTab(String label, ReportType type) {
    final isSelected = _selectedReportType == type;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedReportType = type;
          });
        }
      },
      backgroundColor: isSelected
          ? Theme.of(context).colorScheme.primaryContainer
          : null,
      checkmarkColor: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildReportContent() {
    switch (_selectedReportType) {
      case ReportType.summary:
        return _buildSummaryReport();
      case ReportType.pipeline:
        return _buildPipelineReport();
      case ReportType.period:
        return _buildPeriodReport();
      case ReportType.performers:
        return _buildPerformersReport();
      case ReportType.activity:
        return _buildActivityReport();
    }
  }

  Widget _buildSummaryReport() {
    final reportsService = ref.read(crmReportsServiceProvider);

    return FutureBuilder<SalesSummaryReport>(
      future: reportsService.getSalesSummaryReport(
        startDate: _startDate,
        endDate: _endDate,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final report = snapshot.data!;

        return Column(
          children: [
            // Key metrics
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildMetricCard(
                  'Total Revenue',
                  '\$${report.wonRevenue.toStringAsFixed(0)}',
                  Icons.attach_money,
                  Colors.green,
                ),
                _buildMetricCard(
                  'Total Deals',
                  report.totalDeals.toString(),
                  Icons.trending_up,
                  Colors.blue,
                ),
                _buildMetricCard(
                  'Won Deals',
                  report.wonDeals.toString(),
                  Icons.check_circle,
                  Colors.orange,
                ),
                _buildMetricCard(
                  'Conversion Rate',
                  '${report.conversionRate.toStringAsFixed(1)}%',
                  Icons.trending_up,
                  Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Additional stats
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Additional Metrics',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildStatRow('Average Deal Size', '\$${report.averageDealSize.toStringAsFixed(0)}'),
                    _buildStatRow('Win Rate', '${report.winRate.toStringAsFixed(1)}%'),
                    _buildStatRow('Loss Rate', '${report.lossRate.toStringAsFixed(1)}%'),
                    _buildStatRow('Open Deals', report.openDeals.toString()),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPipelineReport() {
    final reportsService = ref.read(crmReportsServiceProvider);

    return FutureBuilder<PipelinePerformanceReport>(
      future: reportsService.getPipelinePerformanceReport(
        startDate: _startDate,
        endDate: _endDate,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final report = snapshot.data!;

        if (report.stages.isEmpty) {
          return const Center(
            child: Text('No pipeline data available'),
          );
        }

        return Column(
          children: report.stages.map((stage) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stage.stageName,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${stage.conversionRate.toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildStatRow('Total Deals', stage.totalDeals.toString()),
                    _buildStatRow('Won Deals', stage.wonDeals.toString()),
                    _buildStatRow('Revenue', '\$${stage.revenue.toStringAsFixed(0)}'),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildPeriodReport() {
    final reportsService = ref.read(crmReportsServiceProvider);

    return FutureBuilder<SalesByPeriodReport>(
      future: reportsService.getSalesByPeriodReport(
        startDate: _startDate,
        endDate: _endDate,
        periodType: PeriodType.monthly,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final report = snapshot.data!;

        if (report.periods.isEmpty) {
          return const Center(
            child: Text('No period data available'),
          );
        }

        return Column(
          children: report.periods.map((period) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      period.period,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMiniStat('Deals', period.deals.length.toString()),
                        _buildMiniStat('Revenue', '\$${period.revenue.toStringAsFixed(0)}'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildPerformersReport() {
    final reportsService = ref.read(crmReportsServiceProvider);

    return FutureBuilder<TopPerformersReport>(
      future: reportsService.getTopPerformersReport(
        startDate: _startDate,
        endDate: _endDate,
        limit: 10,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final report = snapshot.data!;

        if (report.performers.isEmpty) {
          return const Center(
            child: Text('No performer data available'),
          );
        }

        return Column(
          children: report.performers.asMap().entries.map((entry) {
            final index = entry.key;
            final performer = entry.value;

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getRankColor(index),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(performer.name),
                subtitle: Text('${performer.wonDeals} deals won'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${performer.revenue.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Avg: \$${performer.averageDealSize.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildActivityReport() {
    final reportsService = ref.read(crmReportsServiceProvider);

    return FutureBuilder<ActivityReport>(
      future: reportsService.getActivityReport(
        startDate: _startDate,
        endDate: _endDate,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final report = snapshot.data!;

        if (report.activityCounts.isEmpty) {
          return const Center(
            child: Text('No activity data available'),
          );
        }

        return Column(
          children: report.activityCounts.entries.map((entry) {
            final activityType = entry.key;
            final count = entry.value;

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(_getActivityIcon(activityType), color: Colors.white),
                ),
                title: Text(_formatActivityType(activityType)),
                trailing: Text(
                  count.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
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

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
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

  Color _getRankColor(int index) {
    if (index == 0) return Colors.orange;
    if (index == 1) return Colors.grey;
    if (index == 2) return Colors.brown;
    return Colors.blue;
  }

  IconData _getActivityIcon(String activityType) {
    switch (activityType) {
      case 'call':
        return Icons.phone;
      case 'email':
        return Icons.email;
      case 'meeting':
        return Icons.people;
      case 'note':
        return Icons.note;
      default:
        return Icons.timeline;
    }
  }

  String _formatActivityType(String type) {
    return type.split('_').map((word) {
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
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
}

enum ReportType {
  summary,
  pipeline,
  period,
  performers,
  activity,
}
