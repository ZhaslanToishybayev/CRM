import 'package:flutter_test/flutter_test.dart';

bool isStrongPassword(String password) {
  final hasMinLength = password.length >= 12;
  final hasUpper = password.contains(RegExp(r'[A-Z]'));
  final hasLower = password.contains(RegExp(r'[a-z]'));
  final hasDigit = password.contains(RegExp(r'[0-9]'));
  final hasSpecial = password.contains(RegExp(r'[^A-Za-z0-9]'));
  return hasMinLength && hasUpper && hasLower && hasDigit && hasSpecial;
}

bool isValidEmail(String email) {
  return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
}

String sanitizeAuthLog(String input) {
  return input
      .replaceAll(RegExp(r'Bearer\s+[A-Za-z0-9\-._~+/]+=*'), 'Bearer [REDACTED]')
      .replaceAll(RegExp(r'password=[^&\s]+'), 'password=[REDACTED]');
}

bool canAccessAdminRoute({required String role}) {
  return role == 'admin' || role == 'super_admin';
}

void main() {
  group('Authentication Security Tests', () {
    test('validates strong password policy', () {
      expect(isStrongPassword('weakpass'), isFalse);
      expect(isStrongPassword('ValidPassword123!'), isTrue);
    });

    test('validates strict email format', () {
      expect(isValidEmail('invalid'), isFalse);
      expect(isValidEmail('valid@email.com'), isTrue);
      expect(isValidEmail('space @example.com'), isFalse);
    });

    test('redacts sensitive auth data in logs', () {
      final raw = 'Authorization: Bearer abc.def.ghi password=secret123';
      final sanitized = sanitizeAuthLog(raw);

      expect(sanitized, isNot(contains('abc.def.ghi')));
      expect(sanitized, isNot(contains('secret123')));
      expect(sanitized, contains('[REDACTED]'));
    });

    test('enforces role-based admin access', () {
      expect(canAccessAdminRoute(role: 'employee'), isFalse);
      expect(canAccessAdminRoute(role: 'manager'), isFalse);
      expect(canAccessAdminRoute(role: 'admin'), isTrue);
    });
  });
}
