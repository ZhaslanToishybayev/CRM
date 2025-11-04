/// Top Performers Widget
/// Displays list of top performing team members

import 'package:flutter/material.dart';
import '../models/manager_dashboard_model.dart';

class TopPerformersWidget extends StatelessWidget {
  final List<TopPerformer> performers;

  const TopPerformersWidget({
    Key? key,
    required this.performers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Performers',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (performers.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'No performance data available',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              )
            else
              ...performers.map((performer) {
                return _buildPerformerItem(performer);
              }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformerItem(TopPerformer performer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: performer.rank == 1
            ? Colors.amber[50]
            : performer.rank == 2
                ? Colors.grey[50]
                : performer.rank == 3
                    ? Colors.brown[50]
                    : null,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: performer.rank <= 3
              ? (performer.rank == 1
                  ? Colors.amber
                  : performer.rank == 2
                      ? Colors.grey
                      : Colors.brown)
              : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Rank badge
          _buildRankBadge(performer.rank),
          const SizedBox(width: 12),
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: _getRankColor(performer.rank).withOpacity(0.2),
            child: Text(
              performer.username[0].toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _getRankColor(performer.rank),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  performer.fullName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 14,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${performer.qualityRating.toStringAsFixed(1)} quality',
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
          // Stats
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${performer.xpEarned} XP',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${performer.tasksCompleted} tasks',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
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
      width: 40,
      height: 40,
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
                style: const TextStyle(fontSize: 16),
              )
            : Text(
                rank.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    if (rank == 1) return Colors.amber;
    if (rank <= 3) return Colors.brown;
    if (rank <= 10) return Colors.blue;
    return Colors.grey;
  }
}
