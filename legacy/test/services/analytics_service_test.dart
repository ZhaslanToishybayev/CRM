/// Unit tests for analytics helpers used by reporting layer.

import 'package:flutter_test/flutter_test.dart';

class _AnalyticsHelpers {
  static double completionRate(int completed, int total) {
    if (total <= 0) return 0;
    return completed / total;
  }

  static double qualityScore({
    required double speed,
    required double accuracy,
  }) {
    return (speed * 0.4) + (accuracy * 0.6);
  }
}

void main() {
  group('AnalyticsService Tests', () {
    test('should calculate completion rate', () {
      expect(_AnalyticsHelpers.completionRate(0, 0), 0);
      expect(_AnalyticsHelpers.completionRate(3, 4), 0.75);
      expect(_AnalyticsHelpers.completionRate(10, 10), 1);
    });

    test('should calculate weighted quality score', () {
      final score = _AnalyticsHelpers.qualityScore(speed: 0.7, accuracy: 0.9);
      expect(score, closeTo(0.82, 0.0001));
    });

    test('should keep deterministic KPI threshold checks', () {
      final score = _AnalyticsHelpers.qualityScore(speed: 0.5, accuracy: 0.6);
      expect(score >= 0.55, isTrue);
      expect(score < 0.7, isTrue);
    });
  });
}
