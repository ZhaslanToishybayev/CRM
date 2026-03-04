import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../models/task_recommendation_model.dart';

class RecommendationCard extends StatelessWidget {
  final TaskRecommendation recommendation;
  final VoidCallback? onAccept;

  const RecommendationCard({
    super.key,
    required this.recommendation,
    this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    final matchColor = _getMatchScoreColor(recommendation.matchScore);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.lightbulb,
                    color: Colors.blue,
                    size: 24,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recommendation.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'Соответствие: ${(recommendation.matchScore * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 12,
                          color: matchColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(12),
            Text(
              recommendation.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const Gap(12),
            _buildDetailsRow(),
            if (recommendation.tags.isNotEmpty) ...[
              const Gap(8),
              _buildTags(),
            ],
            const Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => _decline(context),
                  child: const Text('Отклонить'),
                ),
                const Gap(8),
                ElevatedButton.icon(
                  onPressed: () {
                    onAccept?.call();
                    _accept(context);
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Создать задачу'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsRow() {
    return Row(
      children: [
        _buildDetailChip(
          icon: Icons.timer,
          label: '${recommendation.estimatedDuration} мин',
        ),
        const Gap(8),
        _buildDetailChip(
          icon: Icons.flag,
          label: _getPriorityLabel(recommendation.suggestedPriority),
        ),
        const Gap(8),
        _buildDetailChip(
          icon: Icons.category,
          label: recommendation.suggestedCategory,
        ),
      ],
    );
  }

  Widget _buildDetailChip({
    required IconData icon,
    required String label,
  }) {
    return Chip(
      avatar: Icon(icon, size: 16, color: Colors.grey[600]),
      label: Text(
        label,
        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: recommendation.tags
          .map(
            (tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '#$tag',
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  String _getPriorityLabel(int priority) {
    switch (priority) {
      case 1:
        return 'Низкий';
      case 2:
        return 'Средний';
      case 3:
        return 'Высокий';
      default:
        return 'Normal';
    }
  }

  Color _getMatchScoreColor(double score) {
    if (score >= 0.8) return Colors.green;
    if (score >= 0.6) return Colors.orange;
    return Colors.red;
  }

  void _accept(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Задача "${recommendation.title}" добавлена!'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () {
            // TODO: реализовать отмену
          },
        ),
      ),
    );
  }

  void _decline(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Рекомендация отклонена'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
