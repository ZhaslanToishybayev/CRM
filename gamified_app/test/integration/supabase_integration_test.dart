import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/core/database/supabase_config.dart';

void main() {
  group('Supabase Integration Safety', () {
    test('keeps integration disabled without dart-define credentials', () {
      expect(SupabaseConfig.isConfigured, isFalse);
      expect(SupabaseConfig.supabaseUrl, isEmpty);
      expect(SupabaseConfig.supabaseAnonKey, isEmpty);
    });

    test('fails fast when client requested while not configured', () {
      expect(() => SupabaseConfig.client, throwsA(isA<StateError>()));
    });

    test('throws clear message for missing configuration', () {
      try {
        SupabaseConfig.client;
        fail('Expected StateError to be thrown');
      } on StateError catch (e) {
        expect(e.message, contains('SUPABASE_URL'));
        expect(e.message, contains('SUPABASE_ANON_KEY'));
      }
    });
  });
}
