import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/core/supabase/supabase_service.dart';

void main() {
  group('SupabaseService Tests', () {
    test('uses singleton instance', () {
      final instance1 = SupabaseService();
      final instance2 = SupabaseService();
      expect(instance1, same(instance2));
    });

    test('exposes auth and tasks API methods', () {
      final service = SupabaseService();

      expect(service.signIn, isA<Function>());
      expect(service.signUp, isA<Function>());
      expect(service.getTasks, isA<Function>());
      expect(service.createTask, isA<Function>());
    });
  });
}
