/// Supabase Initialization Utility
/// Educational Project - Gamified Task Management App
/// Run this ONCE to create database schema

import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/supabase/supabase_config.dart';
import 'core/supabase/database_schema.dart';

class SupabaseInitializer {
  static Future<void> initialize() async {
    try {
      // Initialize Supabase
      await SupabaseConfig.initialize();
      print('✅ Supabase initialized');

      // Get current user (should be logged in as admin)
      final user = SupabaseConfig.client.auth.currentUser;
      if (user == null) {
        print('⚠️ Warning: No user logged in. Some operations may fail.');
      } else {
        print('✅ User logged in: ${user.email}');
      }

      // Try to create the schema
      final result = await DatabaseSchema.create();
      print(result);

      print('\n🎉 Supabase initialization complete!');
      print('You can now use the app with cloud database.');
    } catch (e) {
      print('❌ Initialization failed: $e');
      rethrow;
    }
  }
}

void main() async {
  await SupabaseInitializer.initialize();
}
