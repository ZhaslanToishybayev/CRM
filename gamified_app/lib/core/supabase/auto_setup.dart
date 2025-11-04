/// Automatic Supabase Setup
/// Educational Project - Gamified Task Management App
/// Automatically creates database schema on first run

import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_config.dart';

class AutoSupabaseSetup {
  static const String _setupFlagKey = 'supabase_setup_completed';

  /// Check if Supabase is already set up
  static Future<bool> isAlreadySetup() async {
    try {
      final box = await SupabaseConfig.openLocalBox();
      return box.get(_setupFlagKey, defaultValue: false) ?? false;
    } catch (e) {
      print('⚠️ Error checking setup status: $e');
      return false;
    }
  }

  /// Perform automatic setup if needed
  static Future<SetupResult> performAutoSetup() async {
    print('🔧 Starting automatic Supabase setup...');

    try {
      // Check if already setup
      final alreadySetup = await isAlreadySetup();
      if (alreadySetup) {
        print('✅ Supabase already configured');
        return SetupResult(
          success: true,
          message: 'Supabase already configured',
          alreadySetup: true,
        );
      }

      print('📦 Initializing Supabase client...');
      // Initialize Supabase
      await SupabaseConfig.initialize();
      print('✅ Supabase client initialized');

      // Check if user is logged in
      final user = SupabaseConfig.client.auth.currentUser;
      if (user == null) {
        print('⚠️ No authenticated user. Please log in first.');
        return SetupResult(
          success: false,
          message: 'Please log in to configure database',
          requiresAuth: true,
        );
      }

      print('👤 Authenticated as: ${user.email}');
      print('🗄️ Creating database schema...');

      // Create database schema
      final schemaResult = await _createDatabaseSchema();
      if (!schemaResult.success) {
        return schemaResult;
      }

      print('✅ Database schema created successfully');
      print('🎉 Supabase auto-setup completed!');

      // Mark as setup completed
      await _markAsSetupCompleted();

      return SetupResult(
        success: true,
        message: 'Setup completed successfully',
      );

    } catch (e, stackTrace) {
      print('❌ Auto-setup failed: $e');
      print('Stack trace: $stackTrace');
      return SetupResult(
        success: false,
        message: 'Setup failed: ${e.toString()}',
      );
    }
  }

  /// Create the database schema
  static Future<SetupResult> _createDatabaseSchema() async {
    try {
      print('📦 Creating database schema...');

      // Enable RLS on public schema
      await _safeExecuteRPC('enable_rls_on_public', {});
      print('✅ RLS enabled on public schema');

      // Create user_stats table
      await _safeExecuteRPC('create_user_stats_table', {});
      print('✅ user_stats table created');

      // Create tasks table
      await _safeExecuteRPC('create_tasks_table', {});
      print('✅ tasks table created');

      // Create user_stats functions
      await _safeExecuteRPC('create_user_stats_functions', {});
      print('✅ user_stats functions created');

      // Create tasks functions
      await _safeExecuteRPC('create_tasks_functions', {});
      print('✅ tasks functions created');

      // Create RLS policies
      await _safeExecuteRPC('create_rls_policies', {});
      print('✅ RLS policies created');

      return SetupResult(
        success: true,
        message: 'Database schema created',
      );

    } catch (e) {
      print('❌ Schema creation failed: $e');
      return SetupResult(
        success: false,
        message: 'Schema creation failed: ${e.toString()}',
      );
    }
  }

  /// Safely execute RPC function (ignore if already exists)
  static Future<void> _safeExecuteRPC(String functionName, Map<String, dynamic> params) async {
    try {
      await SupabaseConfig.client.rpc(functionName, params: params);
    } catch (e) {
      // If function already exists or table already exists, ignore
      if (e.toString().contains('already exists') ||
          e.toString().contains('duplicate') ||
          e.toString().contains('relation')) {
        print('⚠️  $functionName: Already exists (skipping)');
        return;
      }
      // Otherwise rethrow
      rethrow;
    }
  }

  /// Mark setup as completed
  static Future<void> _markAsSetupCompleted() async {
    try {
      final box = await SupabaseConfig.openLocalBox();
      await box.put(_setupFlagKey, true);
      print('✅ Setup flag saved');
    } catch (e) {
      print('⚠️ Could not save setup flag: $e');
    }
  }

  /// Get database connection status
  static Future<DatabaseStatus> checkConnection() async {
    try {
      await SupabaseConfig.initialize();
      final user = SupabaseConfig.client.auth.currentUser;

      if (user == null) {
        return DatabaseStatus(
          connected: false,
          message: 'Not authenticated',
        );
      }

      // Try to query tables
      final result = await SupabaseConfig.client
          .from('user_stats')
          .select('count')
          .limit(1);

      return DatabaseStatus(
        connected: true,
        message: 'Connected to database',
        user: user.email,
      );

    } catch (e) {
      return DatabaseStatus(
        connected: false,
        message: 'Connection failed: ${e.toString()}',
      );
    }
  }

  /// Reset setup (for development/testing)
  static Future<void> resetSetup() async {
    try {
      final box = await SupabaseConfig.openLocalBox();
      await box.delete(_setupFlagKey);
      print('🗑️ Setup flag reset. Auto-setup will run on next launch.');
    } catch (e) {
      print('⚠️ Could not reset setup flag: $e');
    }
  }
}

/// Result of setup operation
class SetupResult {
  final bool success;
  final String message;
  final bool alreadySetup;
  final bool requiresAuth;

  SetupResult({
    required this.success,
    required this.message,
    this.alreadySetup = false,
    this.requiresAuth = false,
  });
}

/// Status of database connection
class DatabaseStatus {
  final bool connected;
  final String message;
  final String? user;

  DatabaseStatus({
    required this.connected,
    required this.message,
    this.user,
  });
}
