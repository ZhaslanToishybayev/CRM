/// Team List Screen
/// Displays list of teams and allows management

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/team_model.dart';
import '../models/team_member_model.dart';
import '../providers/team_provider.dart';
import '../widgets/team_card.dart';
import 'team_details_screen.dart';
import 'create_team_screen.dart';

class TeamListScreen extends ConsumerStatefulWidget {
  final String? organizationId;
  final String? departmentId;

  const TeamListScreen({
    Key? key,
    this.organizationId,
    this.departmentId,
  }) : super(key: key);

  @override
  ConsumerState<TeamListScreen> createState() => _TeamListScreenState();
}

class _TeamListScreenState extends ConsumerState<TeamListScreen> {
  String _searchQuery = '';
  String? _selectedFilter; // 'active', 'inactive', 'all'

  @override
  Widget build(BuildContext context) {
    final teamsAsync = _getTeams();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToCreateTeam(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search teams...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Filter chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: _selectedFilter == null,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = null;
                    });
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Active'),
                  selected: _selectedFilter == 'active',
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = 'active';
                    });
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('With Members'),
                  selected: _selectedFilter == 'with_members',
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = 'with_members';
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Teams list
          Expanded(
            child: teamsAsync.when(
              data: (teams) {
                final filteredTeams = _filterTeams(teams);
                if (filteredTeams.isEmpty) {
                  return _buildEmptyState();
                }
                return ListView.builder(
                  itemCount: filteredTeams.length,
                  itemBuilder: (context, index) {
                    final team = filteredTeams[index];
                    return TeamCard(
                      team: team,
                      onTap: () => _navigateToTeamDetails(team.id),
                      onEdit: () => _navigateToEditTeam(team),
                      onDelete: () => _deleteTeam(team.id),
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<TeamModel>> _getTeams() async {
    if (widget.departmentId != null) {
      return ref.watch(departmentTeamsProvider(widget.departmentId!)).value ?? [];
    } else if (widget.organizationId != null) {
      return ref.watch(organizationTeamsProvider(widget.organizationId!)).value ?? [];
    } else {
      // Get user's teams
      // TODO: Get current user ID from auth provider
      final userId = 'current_user_id';
      return ref.watch(userTeamsProvider(userId)).value ?? [];
    }
  }

  List<TeamModel> _filterTeams(List<TeamModel> teams) {
    var filtered = teams;

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((team) =>
              team.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Filter by status
    if (_selectedFilter != null) {
      switch (_selectedFilter) {
        case 'active':
          filtered = filtered.where((team) => team.totalTasks > 0).toList();
          break;
        case 'with_members':
          filtered = filtered.where((team) => team.activeMembers > 0).toList();
          break;
      }
    }

    return filtered;
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.group_work,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No teams found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first team to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _navigateToCreateTeam(),
            icon: const Icon(Icons.add),
            label: const Text('Create Team'),
          ),
        ],
      ),
    );
  }

  void _navigateToCreateTeam() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTeamScreen(
          organizationId: widget.organizationId,
          departmentId: widget.departmentId,
        ),
      ),
    );
  }

  void _navigateToTeamDetails(String teamId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailsScreen(teamId: teamId),
      ),
    );
  }

  void _navigateToEditTeam(TeamModel team) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTeamScreen(
          team: team,
        ),
      ),
    );
  }

  void _deleteTeam(String teamId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Team'),
        content: const Text(
          'Are you sure you want to delete this team? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(teamNotifierProvider.notifier).deleteTeam(teamId);
              setState(() {}); // Refresh UI
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
