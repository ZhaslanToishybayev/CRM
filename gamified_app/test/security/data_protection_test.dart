import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

String sanitizeInput(String raw) {
  return raw.replaceAll(RegExp("[<>\"';]"), '');
}

bool isSqlInjectionPayload(String input) {
  final lowered = input.toLowerCase();
  return lowered.contains(' or 1=1') ||
      lowered.contains('union select') ||
      lowered.contains('--') ||
      lowered.contains('drop table');
}

Map<String, dynamic> safeErrorResponse(String message) {
  return {
    'error': 'Request failed',
    'code': 'REQUEST_FAILED',
    'details': message.contains('timeout') ? 'timeout' : 'generic',
  };
}

String redactSecretsInJson(Map<String, dynamic> payload) {
  final cloned = Map<String, dynamic>.from(payload);
  for (final key in cloned.keys.toList()) {
    final lower = key.toLowerCase();
    if (lower.contains('token') || lower.contains('password') || lower.contains('secret')) {
      cloned[key] = '[REDACTED]';
    }
  }
  return jsonEncode(cloned);
}

void main() {
  group('Data Protection Tests', () {
    test('sanitizes potentially dangerous characters', () {
      expect(sanitizeInput('<script>alert(1)</script>'), 'scriptalert(1)/script');
    });

    test('detects common SQL injection patterns', () {
      expect(isSqlInjectionPayload("admin' OR 1=1 --"), isTrue);
      expect(isSqlInjectionPayload('normal input'), isFalse);
    });

    test('returns safe error response without internals', () {
      final response = safeErrorResponse('db timeout on shard 3');
      expect(response['error'], 'Request failed');
      expect(response['details'], 'timeout');
      expect(response.values.join(' '), isNot(contains('shard')));
    });

    test('redacts secrets before serializing logs', () {
      final json = redactSecretsInJson({
        'accessToken': 'abc',
        'password': '123',
        'payload': 'ok',
      });

      expect(json, isNot(contains('abc')));
      expect(json, isNot(contains('123')));
      expect(json, contains('[REDACTED]'));
    });
  });
}
