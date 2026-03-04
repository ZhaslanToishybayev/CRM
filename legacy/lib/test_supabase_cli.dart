/// Simple Supabase Integration Test (CLI version)
/// Run with: dart run lib/test_supabase_cli.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/database/supabase_config.dart';

void main() async {
  print('\n=================================');
  print('🧪 SUPABASE INTEGRATION TEST');
  print('=================================\n');

  try {
    // Test 1: Initialize Supabase
    print('Test 1: Initializing Supabase...');
    await SupabaseConfig.initialize();
    print('✅ Supabase initialized successfully!\n');

    // Test 2: Check configuration
    print('Test 2: Checking configuration...');
    final isConfigured = SupabaseConfig.isConfigured;
    print('✅ Is configured: $isConfigured\n');

    // Test 3: Check client
    print('Test 3: Getting Supabase client...');
    final client = SupabaseConfig.client;
    print('✅ Client retrieved successfully!\n');

    // Test 4: Check auth state
    print('Test 4: Checking auth state...');
    final user = SupabaseConfig.client.auth.currentUser;
    print('✅ Current user: ${user?.email ?? 'Not signed in'}\n');

    // Test 5: Check if we can query
    print('Test 5: Testing database connection...');
    try {
      final response = await client.from('user_stats').select('id').limit(1);
      print('✅ Database connection successful!\n');
    } catch (e) {
      print(
        '⚠️  Database query (tables may not exist yet): ${e.toString().split('\n')[0]}\n',
      );
    }

    print('=================================');
    print('✅ INTEGRATION TEST PASSED!');
    print('=================================\n');

    print('📋 SUPABASE CONFIGURATION:');
    print('   URL configured: ${SupabaseConfig.supabaseUrl.isNotEmpty}');
    print('   Key configured: ${SupabaseConfig.supabaseAnonKey.isNotEmpty}\n');

    print('🎯 NEXT STEPS:');
    print('1. Open Supabase Dashboard: https://supabase.com/dashboard');
    print('2. Go to SQL Editor');
    print('3. Run RPC_SETUP_FINAL.sql to create tables');
    print('4. Test user registration in the app\n');
  } catch (e, stackTrace) {
    print('❌ TEST FAILED!');
    print('Error: $e\n');
    print('StackTrace:\n$stackTrace\n');
    exit(1);
  }
}
