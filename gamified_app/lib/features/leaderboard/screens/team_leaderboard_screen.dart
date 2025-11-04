/// Team Leaderboard Screen
/// Displays individual and team performance rankings

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/team_leaderboard_service.dart';
import '../../gamification/services/work_xp_calculator.dart';

class TeamLeaderboardScreen extends ConsumerStatefulWidget {
  final String? teamId;
  final String? organizationId;

  const TeamLeaderboardScreen({
    Key? key,
    this.teamId,
    this.organizationId,
  }) : super(key: key);

  @override
  ConsumerState<TeamLeaderboardScreen> createState() => _TeamLeaderboardScreenState();
}

class _TeamLeaderboardScreenState extends ConsumerState<TeamLeaderboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  LeaderboardPeriod _selectedPeriod = LeaderboardPeriod.monthly;
  LeaderboardSortBy _selectedSort = LeaderboardSortBy.xp;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboards'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Individual', icon: Icon(Icons.person)),
            Tab(text: 'Teams', icon: Icon(Icons.group)),
            Tab(text: 'Department', icon: Icon(Icons.business)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter controls
          _buildFilterControls(),
          const Divider(height: 1),
          // Tab views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildIndividualTab(),
                _buildTeamsTab(),
                _buildDepartmentTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterControls() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Period selector
          Expanded(
            child: DropdownButtonFormField<LeaderboardPeriod>(
              value: _selectedPeriod,
              decoration: const InputDecoration(
                labelText: 'Period',
                prefixIcon: Icon(Icons.calendar_today),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: LeaderboardPeriod.weekly,
                  child: Text('Weekly'),
                ),
                DropdownMenuItem(
                  value: LeaderboardPeriod.monthly,
                  child: Text('Monthly'),
                ),
                DropdownMenuItem(
                  value: LeaderboardPeriod.yearly,
                  child: Text('Yearly'),
                ),
                DropdownMenuItem(
                  value: LeaderboardPeriod.allTime,
                  child: Text('All Time'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedPeriod = value ?? LeaderboardPeriod.monthly;
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          // Sort selector
          Expanded(
            child: DropdownButtonFormField<LeaderboardSortBy>(
              value: _selectedSort,
              decoration: const InputDecoration(
                labelText: 'Sort By',
                prefixIcon: Icon(Icons.sort),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: LeaderboardSortBy.xp,
                  child: Text('XP'),
                ),
                DropdownMenuItem(
                  value: LeaderboardSortBy.tasks,
                  child: Text('Tasks'),
                ),
                DropdownMenuItem(
                  value: LeaderboardSortBy.quality,
                  child: Text('Quality'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedSort = value ?? LeaderboardSortBy.xp;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndividualTab() {
    // Mock data for demonstration
    final mockEntries = _generateMockIndividualEntries();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockEntries.length,
      itemBuilder: (context, index) {
        final entry = mockEntries[index];
        return _buildIndividualLeaderboardCard(entry, isCurrentUser: index == 0);
      },
    );
  }

  Widget _buildTeamsTab() {
    // Mock data for demonstration
    final mockEntries = _generateMockTeamEntries();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockEntries.length,
      itemBuilder: (context, index) {
        final entry = mockEntries[index];
        return _buildTeamLeaderboardCard(entry, isTopTeam: index == 0);
      },
    );
  }

  Widget _buildDepartmentTab() {
    // Mock data for demonstration
    final mockEntries = _generateMockDepartmentEntries();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockEntries.length,
      itemBuilder: (context, index) {
        final entry = mockEntries[index];
        return _buildDepartmentLeaderboardCard(entry, isTopDepartment: index == 0);
      },
    );
  }

  Widget _buildIndividualLeaderboardCard(
    IndividualLeaderboardEntry entry, {
    bool isCurrentUser = false,
  }) {
    return Card(
      elevation: isCurrentUser ? 8 : 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to user profile
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Rank badge
              _buildRankBadge(entry.rank),
              const SizedBox(width: 16),
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: _getRankColor(entry.rank).withOpacity(0.2),
                child: Text(
                  entry.username[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _getRankColor(entry.rank),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          entry.fullName ?? entry.username,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isCurrentUser) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'You',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text('Level ${entry.level}'),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.verified,
                          size: 16,
                          color: _getRoleColor(entry.role),
                        ),
                        const SizedBox(width: 4),
                        Text(entry.role?.displayName ?? 'Employee'),
                      ],
                    ),
                  ],
                ),
              ),
              // Stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${WorkXPCalculatorService.formatWorkXP(entry.totalXP)} XP',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${entry.tasksCompleted} tasks',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (entry.qualityRating != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          entry.qualityRating!.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamLeaderboardCard(
    TeamLeaderboardEntry entry, {
    bool isTopTeam = false,
  }) {
    return Card(
      elevation: isTopTeam ? 8 : 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: isTopTeam ? Colors.amber[50] : null,
      child: InkWell(
        onTap: () {
          // TODO: Navigate to team details
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Rank badge
              _buildRankBadge(entry.rank),
              const SizedBox(width: 16),
              // Team icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _parseColor(entry.teamColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getTeamIcon(entry.teamIcon),
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // Team info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.teamName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${entry.memberCount} members',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Progress bar for completion rate
                    LinearProgressIndicator(
                      value: entry.completionRate,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _parseColor(entry.teamColor),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${(entry.completionRate * 100).toStringAsFixed(0)}% completion',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              // Stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${WorkXPCalculatorService.formatWorkXP(entry.totalXP)} XP',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${entry.tasksCompleted} tasks',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (entry.averageQualityRating != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          entry.averageQualityRating!.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDepartmentLeaderboardCard(
    DepartmentLeaderboardEntry entry, {
    bool isTopDepartment = false,
  }) {
    return Card(
      elevation: isTopDepartment ? 8 : 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: isTopDepartment ? Colors.green[50] : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Rank badge
            _buildRankBadge(entry.rank),
            const SizedBox(width: 16),
            // Department icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.business,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Department info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.departmentName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${entry.teamCount} teams • ${entry.totalMembers} members',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Stats
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${WorkXPCalculatorService.formatWorkXP(entry.totalXP)} XP',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${entry.tasksCompleted} tasks',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankBadge(int rank) {
    Color color;
    String rankText;

    if (rank == 1) {
      color = Colors.amber;
      rankText = '🥇';
    } else if (rank == 2) {
      color = Colors.grey;
      rankText = '🥈';
    } else if (rank == 3) {
      color = Colors.brown;
      rankText = '🥉';
    } else {
      color = _getRankColor(rank);
      rankText = rank.toString();
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: Center(
        child: rank <= 3
            ? Text(
                rankText,
                style: const TextStyle(fontSize: 20),
              )
            : Text(
                rank.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    if (rank <= 3) return Colors.amber;
    if (rank <= 10) return Colors.blue;
    if (rank <= 20) return Colors.green;
    return Colors.grey;
  }

  Color _getRoleColor(CorporateUserRole? role) {
    switch (role) {
      case CorporateUserRole.admin:
        return Colors.purple;
      case CorporateUserRole.manager:
        return Colors.blue;
      case CorporateUserRole.employee:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _parseColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    final color = int.parse(hexColor, radix: 16);
    return Color(color | 0xFF000000);
  }

  IconData _getTeamIcon(String? iconName) {
    if (iconName == null) return Icons.group;
    // Add more icons as needed
    return Icons.group;
  }

  // Mock data generators (replace with actual data from service)
  List<IndividualLeaderboardEntry> _generateMockIndividualEntries() {
    return List.generate(10, (index) {
      return IndividualLeaderboardEntry(
        userId: 'user_$index',
        username: 'user$index',
        fullName: 'User $index',
        avatarUrl: null,
        rank: index + 1,
        level: 5 + index * 2,
        totalXP: 5000 - index * 400,
        tasksCompleted: 50 - index * 3,
        onTimeRate: 0.8 + (index * 0.02),
        qualityRating: 3.5 + (index * 0.1),
        streakDays: 7 + index,
        teamId: 'team_1',
        role: index == 0 ? CorporateUserRole.manager : CorporateUserRole.employee,
        departmentId: 'dept_1',
      );
    });
  }

  List<TeamLeaderboardEntry> _generateMockTeamEntries() {
    return List.generate(8, (index) {
      return TeamLeaderboardEntry(
        teamId: 'team_$index',
        teamName: 'Team ${String.fromCharCode(65 + index)}',
        teamColor: ['#2196F3', '#4CAF50', '#FF9800', '#9C27B0'][index % 4],
        teamIcon: 'group',
        rank: index + 1,
        organizationId: 'org_1',
        departmentId: 'dept_1',
        memberCount: 5 + index,
        totalXP: 10000 - index * 1000,
        tasksCompleted: 100 - index * 8,
        completionRate: 0.85 - index * 0.05,
        averageQualityRating: 3.5 + (index * 0.1),
        onTimeRate: 0.9 - index * 0.05,
        activeStreak: 10 + index * 3,
      );
    });
  }

  List<DepartmentLeaderboardEntry> _generateMockDepartmentEntries() {
    return List.generate(5, (index) {
      return DepartmentLeaderboardEntry(
        departmentId: 'dept_$index',
        departmentName: 'Department ${index + 1}',
        rank: index + 1,
        teamCount: 3 + index,
        totalMembers: 20 + index * 5,
        totalXP: 50000 - index * 8000,
        tasksCompleted: 500 - index * 60,
        averageQualityRating: 3.5 + (index * 0.1),
        onTimeRate: 0.85 - index * 0.05,
      );
    });
  }
}
