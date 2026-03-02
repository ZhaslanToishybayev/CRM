import 'package:flutter_test/flutter_test.dart';

enum _NotificationType {
  achievement,
  taskReminder,
  teamUpdate,
  levelUp,
  systemAlert,
  dailyDigest,
  weeklyReport,
}

String buildNotificationTopic(String userId, _NotificationType type) {
  return 'users.$userId.notifications.${type.name}';
}

bool shouldSendDigest({
  required _NotificationType type,
  required bool quietHoursEnabled,
  required bool isWithinQuietHours,
}) {
  if (quietHoursEnabled && isWithinQuietHours) return false;
  return type == _NotificationType.dailyDigest ||
      type == _NotificationType.weeklyReport;
}

void main() {
  group('NotificationService Contracts', () {
    test('builds stable notification topic', () {
      final topic = buildNotificationTopic('user-42', _NotificationType.levelUp);
      expect(topic, 'users.user-42.notifications.levelUp');
    });

    test('sends digest when not in quiet hours', () {
      final shouldSend = shouldSendDigest(
        type: _NotificationType.dailyDigest,
        quietHoursEnabled: true,
        isWithinQuietHours: false,
      );
      expect(shouldSend, isTrue);
    });

    test('blocks digest during quiet hours', () {
      final shouldSend = shouldSendDigest(
        type: _NotificationType.weeklyReport,
        quietHoursEnabled: true,
        isWithinQuietHours: true,
      );
      expect(shouldSend, isFalse);
    });
  });
}
