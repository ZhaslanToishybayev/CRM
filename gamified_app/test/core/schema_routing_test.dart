import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/core/database/supabase_config.dart';

void main() {
  group('Schema routing defaults', () {
    test('uses legacy defaults when table defines are absent', () {
      expect(SupabaseConfig.tasksTable, 'tasks');
      expect(SupabaseConfig.userStatsTable, 'user_stats');
      expect(SupabaseConfig.profilesTable, 'profiles');
    });

    test('maps user id column for default schema', () {
      expect(SupabaseConfig.isCorporateTasksSchema, isFalse);
      expect(SupabaseConfig.taskUserIdColumn, 'user_id');
      expect(SupabaseConfig.taskReporterIdColumn, 'user_id');
    });
  });
}
