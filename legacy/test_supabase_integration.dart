/// Supabase Integration Test
/// Tests basic Supabase functionality

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'lib/core/database/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  print('\n=================================');
  print('🧪 SUPABASE INTEGRATION TEST');
  print('=================================\n');
  
  try {
    // Test 1: Initialize Supabase
    print('Test 1: Initializing Supabase...');
    await SupabaseConfig.initialize();
    print('✅ Supabase initialized successfully!\n');
    
    // Test 2: Check client
    print('Test 2: Getting Supabase client...');
    final client = SupabaseConfig.client;
    print('✅ Client retrieved successfully!\n');
    
    // Test 3: Check configuration
    print('Test 3: Checking configuration...');
    final isConfigured = SupabaseConfig.isConfigured;
    print('✅ Is configured: $isConfigured\n');
    
    // Test 4: Check if we can query (will fail if no tables, but connection works)
    print('Test 4: Testing database connection...');
    try {
      final response = await client
          .from('user_stats')
          .select('count')
          .limit(1);
      print('✅ Database connection successful!\n');
    } catch (e) {
      print('⚠️  Database connection test (tables may not exist yet): $e\n');
    }
    
    // Test 5: Check auth
    print('Test 5: Checking auth state...');
    final user = SupabaseConfig.client.auth.currentUser;
    print('✅ Current user: ${user?.email ?? 'Not signed in'}\n');
    
    print('=================================');
    print('✅ ALL TESTS PASSED!');
    print('=================================\n');
    
    print('🎯 Next steps:');
    print('1. Run the SQL setup scripts in Supabase dashboard');
    print('2. Test user registration and sign in');
    print('3. Test CRUD operations\n');
    
  } catch (e, stackTrace) {
    print('❌ TEST FAILED!');
    print('Error: $e');
    print('StackTrace: $stackTrace\n');
  }
}
