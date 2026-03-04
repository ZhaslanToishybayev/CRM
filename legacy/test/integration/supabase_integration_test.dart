/// Integration Tests for Supabase
/// Tests the complete Supabase integration

import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/core/database/supabase_config.dart';

void main() {
  group('Supabase Integration Tests', () {
    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    test('should expose deterministic configuration state', () async {
      final configured = SupabaseConfig.isConfigured;
      expect(configured, isA<bool>());

      if (configured) {
        expect(SupabaseConfig.supabaseUrl, isNotEmpty);
        expect(SupabaseConfig.supabaseAnonKey, isNotEmpty);
      } else {
        expect(SupabaseConfig.supabaseUrl, isEmpty);
        expect(SupabaseConfig.supabaseAnonKey, isEmpty);
      }
    });

    test('should fail fast without credentials', () async {
      if (SupabaseConfig.isConfigured) {
        expect(SupabaseConfig.client, isNotNull);
      } else {
        expect(() => SupabaseConfig.client, throwsA(isA<StateError>()));
      }
    });

    test('should require env during initialize', () async {
      if (SupabaseConfig.isConfigured) {
        await SupabaseConfig.initialize();
        expect(SupabaseConfig.client, isNotNull);
      } else {
        expect(() => SupabaseConfig.initialize(), throwsA(isA<StateError>()));
      }
    });
  });
}
