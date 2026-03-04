/// Unit Tests for SupabaseService

import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/core/supabase/supabase_service.dart';

void main() {
  group('SupabaseService Tests', () {
    late SupabaseService supabaseService;

    setUp(() {
      supabaseService = SupabaseService();
    });

    test('should create singleton instance', () {
      final instance1 = SupabaseService();
      final instance2 = SupabaseService();
      expect(instance1, same(instance2));
    });

    test('should expose auth state fields', () {
      expect(supabaseService.currentUser, anyOf(isNull, isA<Object>()));
      expect(supabaseService.isAuthenticated, isA<bool>());
    });

    test('should support demo mode toggle', () {
      supabaseService.enableDemoMode();
      expect(supabaseService.isDemoMode, isTrue);
    });

    test('should return mock stats in demo mode', () async {
      supabaseService.enableDemoMode();

      final stats = await supabaseService.getUserStats('demo-user-uuid');

      expect(stats, isNotNull);
      expect(stats!.level, isA<int>());
      expect(stats.xp, isA<int>());
    });

    test('should return mock tasks in demo mode', () async {
      supabaseService.enableDemoMode();

      final tasks = await supabaseService.getTasks('demo-user-uuid');

      expect(tasks, isA<List<dynamic>>());
      expect(tasks, isNotEmpty);
    });
  });
}
