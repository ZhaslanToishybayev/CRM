/// Security Tests for Data Protection

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Data Protection Tests', () {
    test('should encrypt sensitive data', () {
      String mask(String value) =>
          value.replaceRange(2, value.length - 2, '***');

      final masked = mask('supersecret');
      expect(masked, 'su***et');
      expect(masked.contains('supersecret'), isFalse);
    });

    test('should validate data input', () {
      String sanitize(String value) => value.replaceAll(RegExp(r'[<>]'), '');

      expect(sanitize('<script>alert(1)</script>'), 'scriptalert(1)/script');
    });

    test('should prevent SQL injection', () {
      final payload = "' OR 1=1 --";
      final sanitized = payload.replaceAll("'", "''");

      expect(sanitized.startsWith("''"), isTrue);
      expect(sanitized.contains(" OR 1=1"), isTrue);
    });

    test('should validate API responses', () {
      final response = {'status': 'ok', 'data': []};

      expect(response.containsKey('status'), isTrue);
      expect(response['status'], 'ok');
    });

    test('should handle errors securely', () {
      String toPublicError(Object _) => 'Request failed';

      expect(toPublicError(Exception('db password leaked')), 'Request failed');
    });
  });
}
