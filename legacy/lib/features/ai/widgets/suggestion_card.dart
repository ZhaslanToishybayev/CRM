import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../models/ai_suggestion_model.dart';

class SuggestionCard extends StatelessWidget {
  final AISuggestion suggestion;

  const SuggestionCard({
    super.key,
    required this.suggestion,
  });

  @override
  Widget build(BuildContext context) {
    final priorityColor = _getPriorityColor(suggestion.priority);
    final icon = _getSuggestionIcon(suggestion.type);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: priorityColor,
                    size: 24,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        suggestion.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'Уверенность: ${(suggestion.confidence * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildPriorityBadge(suggestion.priority),
              ],
            ),
            const Gap(12),
            Text(
              suggestion.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            if (suggestion.reasons.isNotEmpty) ...[
              const Gap(12),
              _buildReasonsList(),
            ],
            const Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _showDetails(context),
                  child: const Text('Подробнее'),
                ),
                const Gap(8),
                ElevatedButton(
                  onPressed: () => _applySuggestion(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: priorityColor,
                  ),
                  child: const Text('Применить'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(int priority) {
    final colors = {
      1: Colors.green,
      2: Colors.orange,
      3: Colors.red,
    };
    final labels = {
      1: 'Низкий',
      2: 'Средний',
      3: 'Высокий',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colors[priority]?.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        labels[priority] ?? 'Unknown',
        style: TextStyle(
          fontSize: 12,
          color: colors[priority],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildReasonsList() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Основания:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const Gap(4),
          ...suggestion.reasons.map((reason) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: Colors.green,
                    ),
                    const Gap(8),
                    Expanded(
                      child: Text(
                        reason,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getSuggestionIcon(AISuggestionType type) {
    switch (type) {
      case AISuggestionType.taskCreation:
        return Icons.add_circle_outline;
      case AISuggestionType.taskScheduling:
        return Icons.schedule;
      case AISuggestionType.priorityAdjustment:
        return Icons.priority_high;
      case AISuggestionType.taskGrouping:
        return Icons.folder_open;
      case AISuggestionType.deadlineOptimization:
        return Icons.timer;
      case AISuggestionType.workloadBalancing:
        return Icons.balance;
      case AISuggestionType.skillMatching:
        return Icons.person_search;
      case AISuggestionType.timeEstimation:
        return Icons.timelapse;
      case AISuggestionType.delegation:
        return Icons.share;
      case AISuggestionType.resourceOptimization:
        return Icons.tune;
    }
  }

  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(suggestion.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(suggestion.description),
            if (suggestion.metadata != null) ...[
              const Gap(16),
              const Text(
                'Дополнительные данные:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Gap(8),
              Text(
                suggestion.metadata.toString(),
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  void _applySuggestion(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Применено: ${suggestion.title}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
