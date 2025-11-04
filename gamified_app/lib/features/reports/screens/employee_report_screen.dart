/// Employee Report Screen
/// Detailed performance report for individual employees

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:open_file/open_file.dart';
import '../models/employee_report_model.dart';
import '../services/analytics_service.dart';
import '../services/pdf_export_service.dart';
import '../providers/report_provider.dart';

class EmployeeReportScreen extends ConsumerStatefulWidget {
  final String userId;

  const EmployeeReportScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  ConsumerState<EmployeeReportScreen> createState() => _EmployeeReportScreenState();
}

class _EmployeeReportScreenState extends ConsumerState<EmployeeReportScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  Period _selectedPeriod = Period.monthly;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reportAsync = ref.watch(employeeReportProvider(widget.userId, _selectedPeriod));
    final exportNotifier = ref.read(pdfExportNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Report'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              final report = _generateMockReport();
              try {
                final filePath = await exportNotifier.exportEmployeeReport(reportData: report);

                if (context.mounted) {
                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Report exported successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  // Open the file
                  OpenFile.open(filePath);
                }
              } catch (error) {
                if (context.mounted) {
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
            Tab(text: 'Tasks', icon: Icon(Icons.task_alt)),
            Tab(text: 'Goals', icon: Icon(Icons.flag)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Period selector
          _buildPeriodSelector(),
          const Divider(height: 1),
          // Report content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildTasksTab(),
                _buildGoalsTab(),
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
    final mockReport = _generateMockReport();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Personal info card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue[100],
                    child: Text(
                      mockReport.username[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mockReport.fullName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          mockReport.jobTitle,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Level ${mockReport.currentLevel}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.local_fire_department,
                              size: 16,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${mockReport.currentStreak} day streak',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Key metrics
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Tasks Completed',
                  mockReport.tasksCompleted.toString(),
                  Icons.task_alt,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMetricCard(
                  'XP Earned',
                  '${mockReport.xpEarnedThisPeriod}',
                  Icons.explore,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMetricCard(
                  'On-Time Rate',
                  '${mockReport.onTimeRate.toStringAsFixed(0)}%',
                  Icons.schedule,
                  Colors.orange,
                ),
              ),
            ],
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
                    'Quality Metrics',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildQualityItem(
                        'Avg Rating',
                        mockReport.averageQualityRating.toStringAsFixed(1),
                        Icons.star,
                      ),
                      _buildQualityItem(
                        '5-Star Tasks',
                        mockReport.fiveStarRatings.toString(),
                        Icons.star_rate,
                      ),
                      _buildQualityItem(
                        'No Revisions',
                        mockReport.tasksWithoutRevisions.toString(),
                        Icons.check_circle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Achievements
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Achievements',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${mockReport.unlockedAchievements.length} unlocked',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${mockReport.totalAchievements} total achievements',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Recommendations
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommendations',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  if (mockReport.recommendations.isEmpty)
                    Text(
                      'Great job! No specific recommendations at this time.',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  else
                    ...mockReport.recommendations.map((recommendation) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.lightbulb,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(recommendation),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksTab() {
    final mockReport = _generateMockReport();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task Breakdown',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          // Completion vs Overdue
          Row(
            children: [
              Expanded(
                child: _buildCompletionCard(
                  'Completed',
                  mockReport.tasksCompleted,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildCompletionCard(
                  'Overdue',
                  mockReport.tasksCompletedOverdue,
                  Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Tasks by priority
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tasks by Priority',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  ...mockReport.tasksByPriority.entries.map((entry) {
                    final priority = entry.key;
                    final count = entry.value;
                    return _buildTaskByPriorityItem(
                      priority.displayNameRu,
                      count,
                      _getPriorityColor(priority),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flag,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Goals tracking coming soon',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildQualityItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.amber, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildCompletionCard(String label, int value, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskByPriorityItem(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label),
          ),
          Text(
            count.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(WorkTaskPriority priority) {
    switch (priority) {
      case WorkTaskPriority.low:
        return Colors.blue;
      case WorkTaskPriority.medium:
        return Colors.orange;
      case WorkTaskPriority.high:
        return Colors.red;
      case WorkTaskPriority.urgent:
        return Colors.deepRed;
      case WorkTaskPriority.critical:
        return Colors.purple;
    }
  }

  EmployeeReportModel _generateMockReport() {
    return EmployeeReportModel(
      userId: widget.userId,
      organizationId: 'org_1',
      departmentId: 'dept_1',
      teamId: 'team_1',
      generatedAt: DateTime.now(),
      period: _selectedPeriod,
      periodStart: DateTime.now().subtract(Duration(days: 30)),
      periodEnd: DateTime.now(),
      username: 'john_doe',
      fullName: 'John Doe',
      email: 'john.doe@company.com',
      avatarUrl: null,
      jobTitle: 'Senior Developer',
      hireDate: DateTime(2020, 1, 15),
      currentLevel: 15,
      totalXP: 15000,
      xpEarnedThisPeriod: 2500,
      currentStreak: 7,
      longestStreak: 30,
      tasksCompleted: 45,
      tasksCompletedOnTime: 42,
      tasksCompletedOverdue: 3,
      averageQualityRating: 4.2,
      fiveStarRatings: 15,
      tasksWithoutRevisions: 30,
      managerFeedback: 'Great work this period!',
      completedTasks: [],
      overdueTasks: [],
      upcomingTasks: [],
      tasksByPriority: {
        WorkTaskPriority.low: 5,
        WorkTaskPriority.medium: 15,
        WorkTaskPriority.high: 20,
        WorkTaskPriority.urgent: 5,
      },
      tasksByType: {
        WorkTaskType.personal: 10,
        WorkTaskType.project: 25,
        WorkTaskType.team: 10,
      },
      tasksByCategory: {
        'Development': 20,
        'Bug Fixes': 10,
        'Code Review': 10,
        'Meetings': 5,
      },
      averageTaskTime: 2.5,
      totalTimeSpent: 6750, // in minutes
      estimatedTime: 7200, // in minutes
      timeAccuracy: 93.5,
      unlockedAchievements: [],
      nearAchievements: [],
      totalAchievements: 25,
      productivityTrend: 12.5,
      qualityTrend: 7.3,
      xpTrend: 15.8,
      goals: [],
      goalProgress: [],
      recommendations: [
        'Focus on completing overdue tasks to improve your on-time rate',
        'Consider asking for feedback to improve work quality',
      ],
      strengths: [
        'Excellent at meeting deadlines',
        'Consistently high quality work',
      ],
      improvements: [
        'Work on time management to reduce overdue tasks',
      ],
    );
  }
}
