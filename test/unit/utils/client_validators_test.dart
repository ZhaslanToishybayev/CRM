import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/features/crm/utils/client_validators.dart';

void main() {
  group('ClientValidators', () {
    test('validateName accepts valid names and rejects invalid ones', () {
      expect(ClientValidators.validateName('Ada Lovelace'), isNull);
      expect(ClientValidators.validateName('A'), isNotNull);
      expect(ClientValidators.validateName(''), isNotNull);
      expect(ClientValidators.validateName('1234'), isNotNull);
    });

    test('validateEmail accepts valid email and rejects malformed email', () {
      expect(ClientValidators.validateEmail('client@example.com'), isNull);
      expect(ClientValidators.validateEmail('bad-email-format'), isNotNull);
      expect(ClientValidators.validateEmail(''), isNotNull);
    });

    test('validatePhone accepts empty/valid phone and rejects bad phone', () {
      expect(ClientValidators.validatePhone(''), isNull);
      expect(ClientValidators.validatePhone('+1 (555) 123-4567'), isNull);
      expect(ClientValidators.validatePhone('abc'), isNotNull);
    });
  });
}
