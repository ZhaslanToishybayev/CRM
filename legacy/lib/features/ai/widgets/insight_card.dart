import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../models/task_recommendation_model.dart';

class InsightCard extends StatelessWidget {
  final AIInsight insight;

  const InsightCard({
    super.key,
    required this.insight,
  });

  @override
  Widget build(BuildContext context) {
    final importanceColor = _getImportanceColor(insight.importance);
    final icon = _getInsightIcon(insight.type);

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
                    color: importanceColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: importanceColor,
                    size: 24,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        insight.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'Важность: ${(insight.importance * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 12,
                          color: importanceColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildImportanceBadge(insight.importance),
              ],
            ),
            const Gap(12),
            Text(
              insight.message,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            if (insight.actions.isNotEmpty) ...[
              const Gap(12),
              _buildActionsList(context),
            ],
            if (insight.data != null) ...[
              const Gap(12),
              _buildDataPreview(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildImportanceBadge(double importance) {
    Color color;
    String label;

    if (importance >= 0.8) {
      color = Colors.red;
      label = 'Критично';
    } else if (importance >= 0.6) {
      color = Colors.orange;
      label = 'Важно';
    } else {
      color = Colors.blue;
      label = 'Инфо';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildActionsList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Рекомендуемые действия:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
          const Gap(8),
          ...insight.actions.map(
            (action) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  const Icon(
                    Icons.play_arrow,
                    size: 16,
                    color: Colors.blue,
                  ),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      _formatAction(action),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataPreview(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFullData(context),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Icon(
              Icons.data_object,
              size: 16,
              color: Colors.grey[600],
            ),
            const Gap(8),
            Expanded(
              child: Text(
                'Дополнительные данные (нажмите для просмотра)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  String _formatAction(String action) {
    return action
        .split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Color _getImportanceColor(double importance) {
    if (importance >= 0.8) return Colors.red;
    if (importance >= 0.6) return Colors.orange;
    return Colors.blue;
  }

  IconData _getInsightIcon(String type) {
    switch (type) {
      case 'productivity':
        return Icons.trending_up;
      case 'workload':
        return Icons.work;
      case 'deadline':
        return Icons.timer;
      case 'performance':
        return Icons.analytics;
      case 'patterns':
        return Icons.pattern;
      case 'optimization':
        return Icons.tune;
      default:
        return Icons.lightbulb;
    }
  }

  void _showFullData(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(insight.title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(insight.message),
              const Gap(16),
              const Text(
                'Данные:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Gap(8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _formatJson(insight.data!),
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
            ],
          ),
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

  String _formatJson(Map<String, dynamic> data) {
    String result = '';
    data.forEach((key, value) {
      result += '$key: $value\n';
    });
    return result;
  }
}
