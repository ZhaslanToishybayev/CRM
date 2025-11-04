/// Manager Dashboard Screen
/// Main dashboard view for managers to monitor team performance

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';
import '../models/manager_dashboard_model.dart';
import '../services/analytics_service.dart';
import '../services/pdf_export_service.dart';
import '../widgets/performance_chart.dart';
import '../widgets/top_performers_widget.dart';
import '../widgets/problem_areas_widget.dart';
import '../providers/report_provider.dart';

class ManagerDashboardScreen extends ConsumerStatefulWidget {
  final String organizationId;
  final String departmentId;
  final String managerId;

  const ManagerDashboardScreen({
    Key? key,
    required this.organizationId,
    required this.departmentId,
    required this.managerId,
  }) : super(key: key);

  @override
  ConsumerState<ManagerDashboardScreen> createState() => _ManagerDashboardScreenState();
}

class _ManagerDashboardScreenState extends ConsumerState<ManagerDashboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  Period _selectedPeriod = Period.monthly;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exportNotifier = ref.read(pdfExportNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Dashboard'),
        elevation: 0,
        actions: [
          IconButton(
            icon: _isRefreshing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
            onPressed: _isRefreshing
                ? null
                : () async {
                    setState(() {
                      _isRefreshing = true;
                    });

                    // Simulate data refresh
                    await Future.delayed(const Duration(seconds: 1));

                    if (mounted) {
                      setState(() {
                        _isRefreshing = false;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Dashboard data refreshed!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              final dashboardData = _generateMockDashboardData();
              try {
                final filePath = await exportNotifier.exportManagerDashboard(
                  dashboardData: dashboardData,
                  managerName: 'Manager',
                );

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Dashboard exported successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  OpenFile.open(filePath);
                }
              } catch (error) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Export failed: $error'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview', icon: Icon(Icons.dashboard)),
            Tab(text: 'Performance', icon: Icon(Icons.trending_up)),
            Tab(text: 'Teams', icon: Icon(Icons.group)),
            Tab(text: 'Analytics', icon: Icon(Icons.analytics)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Period selector
          _buildPeriodSelector(),
          const Divider(height: 1),
          // Dashboard content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildPerformanceTab(),
                _buildTeamsTab(),
                _buildAnalyticsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, size: 20),
          const SizedBox(width: 8),
          const Text(
            'Period:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<Period>(
              value: _selectedPeriod,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: Period.daily,
                  child: Text('Daily'),
                ),
                DropdownMenuItem(
                  value: Period.weekly,
                  child: Text('Weekly'),
                ),
                DropdownMenuItem(
                  value: Period.monthly,
                  child: Text('Monthly'),
                ),
                DropdownMenuItem(
                  value: Period.quarterly,
                  child: Text('Quarterly'),
                ),
                DropdownMenuItem(
                  value: Period.yearly,
                  child: Text('Yearly'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedPeriod = value ?? Period.monthly;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    // Mock data for demonstration
    final mockData = _generateMockDashboardData();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Key metrics cards
          _buildMetricsRow(mockData),
          const SizedBox(height: 16),
          // Charts row
          Row(
            children: [
              Expanded(
                child: PerformanceChart(
                  dashboardData: mockData,
                  chartType: ChartType.completionRate,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PerformanceChart(
                  dashboardData: mockData,
                  chartType: ChartType.productivityTrend,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Top performers and problem areas
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TopPerformersWidget(performers: mockData.topPerformers),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ProblemAreasWidget(
                  overdueByMember: mockData.overdueTasksByMember,
                  lowPerformers: mockData.lowPerformers,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    final mockData = _generateMockDashboardData();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Metrics',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          // Quality metrics
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quality Overview',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetricCard(
                        'Average Quality',
                        mockData.averageQualityRating.toStringAsFixed(1),
                        Icons.star,
                        Colors.amber,
                      ),
                      _buildMetricCard(
                        'On-Time Rate',
                        '${(mockData.onTimeRate * 100).toStringAsFixed(0)}%',
                        Icons.schedule,
                        Colors.green,
                      ),
                      _buildMetricCard(
                        'Completion Rate',
                        '${(mockData.completionRate * 100).toStringAsFixed(0)}%',
                        Icons.check_circle,
                        Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Quality trend chart
          PerformanceChart(
            dashboardData: mockData,
            chartType: ChartType.qualityTrend,
          ),
          const SizedBox(height: 16),
          // XP distribution
          PerformanceChart(
            dashboardData: mockData,
            chartType: ChartType.xpDistribution,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamsTab() {
    final mockData = _generateMockDashboardData();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Teams Overview',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          // Team stats cards
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _buildStatCard(
                'Total Teams',
                mockData.totalTeams.toString(),
                Icons.groups,
                Colors.blue,
              ),
              _buildStatCard(
                'Active Teams',
                mockData.activeTeams.toString(),
                Icons.group_work,
                Colors.green,
              ),
              _buildStatCard(
                'Total Members',
                mockData.totalMembers.toString(),
                Icons.people,
                Colors.purple,
              ),
              _buildStatCard(
                'Active Members',
                mockData.activeMembers.toString(),
                Icons.person,
                Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Top teams
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Top Performing Teams',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ...mockData.topPerformers.take(5).map((performer) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        child: Text(performer.username[0].toUpperCase()),
                      ),
                      title: Text(performer.fullName),
                      subtitle: Text('Team: ${performer.teamId}'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${performer.xpEarned} XP',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            '${performer.tasksCompleted} tasks',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    final mockData = _generateMockDashboardData();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analytics & Trends',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          // Trend indicators
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Performance Trends',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  _buildTrendItem(
                    'Productivity',
                    mockData.productivityTrend,
                    Icons.productivity,
                  ),
                  _buildTrendItem(
                    'Quality',
                    mockData.qualityTrend,
                    Icons.quality,
                  ),
                  _buildTrendItem(
                    'Completion Rate',
                    mockData.completionTrend,
                    Icons.completion,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Tasks over time chart
          PerformanceChart(
            dashboardData: mockData,
            chartType: ChartType.tasksOverTime,
          ),
          const SizedBox(height: 16),
          // Gamification stats
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gamification Stats',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetricCard(
                        'Achievements Unlocked',
                        mockData.achievementsUnlocked.toString(),
                        Icons.emoji_events,
                        Colors.amber,
                      ),
                      _buildMetricCard(
                        'Active Streaks',
                        mockData.activeStreaks.toString(),
                        Icons.local_fire_department,
                        Colors.red,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Team Achievements:',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: mockData.teamAchievements.map((achievement) {
                      return Chip(
                        label: Text(achievement),
                        avatar: const Icon(Icons.emoji_events, size: 16),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsRow(ManagerDashboardModel data) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            'Total Tasks',
            data.totalTasks.toString(),
            Icons.task_alt,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildMetricCard(
            'Completed',
            data.completedTasks.toString(),
            Icons.check_circle,
            Colors.green,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildMetricCard(
            'Overdue',
            data.overdueTasks.toString(),
            Icons.warning,
            Colors.red,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildMetricCard(
            'In Progress',
            data.inProgressTasks.toString(),
            Icons.pending,
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendItem(String label, double trend, IconData icon) {
    final isPositive = trend > 0;
    return ListTile(
      leading: Icon(icon, color: isPositive ? Colors.green : Colors.red),
      title: Text(label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.trending_up : Icons.trending_down,
            color: isPositive ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(
            '${isPositive ? '+' : ''}${trend.toStringAsFixed(1)}%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isPositive ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  ManagerDashboardModel _generateMockDashboardData() {
    return ManagerDashboardModel(
      managerId: 'manager_1',
      organizationId: widget.organizationId,
      departmentId: widget.departmentId,
      generatedAt: DateTime.now(),
      period: _selectedPeriod,
      periodStart: DateTime.now().subtract(Duration(days: 30)),
      periodEnd: DateTime.now(),
      totalTeams: 5,
      activeTeams: 4,
      totalMembers: 28,
      activeMembers: 25,
      totalTasks: 150,
      completedTasks: 120,
      inProgressTasks: 20,
      overdueTasks: 10,
      tasksCompletedToday: 8,
      tasksCompletedThisWeek: 45,
      tasksCompletedThisMonth: 120,
      completionRate: 0.8,
      onTimeRate: 0.92,
      averageQualityRating: 4.2,
      totalXPEarned: 25000,
      averageTaskTime: 2.5,
      topPerformers: List.generate(5, (index) {
        return TopPerformer(
          userId: 'user_$index',
          username: 'user$index',
          fullName: 'User $index',
          teamId: 'team_1',
          xpEarned: 5000 - index * 500,
          tasksCompleted: 25 - index * 2,
          qualityRating: 4.0 + index * 0.1,
          rank: index + 1,
        );
      }),
      topTeams: ['team_1', 'team_2', 'team_3'],
      overdueTasksByMember: [
        PerformanceIssue(
          userId: 'user_5',
          username: 'user5',
          fullName: 'User 5',
          teamId: 'team_2',
          overdueTasksCount: 3,
          daysOverdue: 5,
        ),
      ],
      lowPerformers: ['user_5'],
      projectsAtRisk: [],
      productivityTrend: 15.5,
      qualityTrend: 8.2,
      completionTrend: 12.3,
      achievementsUnlocked: 45,
      activeStreaks: 12,
      teamAchievements: ['Synchronized', 'Zero Debt', 'Sprint Champions'],
    );
  }
}
