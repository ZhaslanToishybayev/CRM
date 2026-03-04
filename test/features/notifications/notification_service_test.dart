import 'package:flutter_test/flutter_test.dart';

class _FakeNotificationService {
  bool initialized = false;
  final List<String> sent = [];

  void initialize() {
    initialized = true;
  }

  bool sendPush(String message) {
    if (!initialized) return false;
    sent.add('push:$message');
    return true;
  }

  bool sendEmail(String message) {
    if (!initialized) return false;
    sent.add('email:$message');
    return true;
  }
}

void main() {
  group('NotificationService Tests', () {
    test('should initialize notification service', () {
      final service = _FakeNotificationService();

      service.initialize();

      expect(service.initialized, isTrue);
    });

    test('should send push notification', () {
      final service = _FakeNotificationService()..initialize();

      final success = service.sendPush('Task created');

      expect(success, isTrue);
      expect(service.sent, contains('push:Task created'));
    });

    test('should send email notification', () {
      final service = _FakeNotificationService()..initialize();

      final success = service.sendEmail('Client updated');

      expect(success, isTrue);
      expect(service.sent, contains('email:Client updated'));
    });
  });
}
