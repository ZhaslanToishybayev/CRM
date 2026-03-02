import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/core/database/supabase_config.dart';

void main() {
  group('SupabaseConfig', () {
    test('is not configured by default in test environment', () {
      expect(SupabaseConfig.isConfigured, isFalse);
    });

    test('throws clear error when client requested without config', () {
      expect(
        () => SupabaseConfig.client,
        throwsA(isA<StateError>()),
      );
    });
  });
}
