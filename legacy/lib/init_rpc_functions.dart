/// Initialize RPC Functions for Auto-Setup
/// Run this ONCE to create the RPC functions in Supabase
/// After running this, the auto-setup will work automatically

import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/supabase/supabase_config.dart';
import 'core/supabase/rpc_functions.dart';

class RPCInitializer {
  static Future<void> initializeRPCFunctions() async {
    try {
      print('🚀 Initializing Supabase RPC Functions...');
      print('This needs to be run ONCE before using auto-setup.');

      // Initialize Supabase
      await SupabaseConfig.initialize();
      print('✅ Supabase client initialized');

      // Get current user (should be logged in as admin)
      final user = SupabaseConfig.client.auth.currentUser;
      if (user == null) {
        print('⚠️ Warning: No user logged in. Please log in first.');
        print('The RPC functions require authenticated user to create.');
        return;
      }

      print('👤 Authenticated as: ${user.email}');

      // Execute the SQL to create RPC functions
      print('📦 Creating RPC functions...');
      final sql = _getRPCFunctionsSQL();

      // Split SQL into individual statements
      final statements = sql.split(';').where((s) => s.trim().isNotEmpty);

      int successCount = 0;
      int errorCount = 0;

      for (final statement in statements) {
        try {
          // Clean up the statement
          final cleanStatement = statement.trim();
          if (cleanStatement.isEmpty) continue;

          // Skip comments
          if (cleanStatement.startsWith('--')) continue;

          // Execute the statement
          await SupabaseConfig.client.rpc('exec_sql', params: {
            'sql': '$cleanStatement;',
          });

          successCount++;
        } catch (e) {
          // Some functions may already exist, that's ok
          if (!e.toString().contains('already exists') &&
              !e.toString().contains('duplicate')) {
            errorCount++;
            print('⚠️ Warning executing statement: ${e.toString()}');
          }
        }
      }

      print('\n🎉 RPC Functions initialization complete!');
      print('✅ Successful: $successCount statements');
      if (errorCount > 0) {
        print('⚠️ Errors: $errorCount statements');
      }

      print('\n📋 Next Steps:');
      print('1. The auto-setup is now ready to use');
      print('2. Users can now run the app without manual SQL setup');
      print('3. Database schema will be created automatically on first run');

    } catch (e, stackTrace) {
      print('❌ RPC initialization failed: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  static String _getRPCFunctionsSQL() {
    // Read and return the RPC functions SQL
    return '''
-- RPC Functions for Auto-Setup
-- These functions are called by the app to create database schema

-- ====================
-- FUNCTION: Enable RLS on public schema
-- ====================
CREATE OR REPLACE FUNCTION enable_rls_on_public()
RETURNS VOID AS \$\$
BEGIN
    ALTER DATABASE postgres SET "app.jwt_secret" TO 'your-jwt-secret';
END;
\$\$ LANGUAGE plpgsql SECURITY DEFINER;

-- ====================
-- FUNCTION: Create user_stats table
-- ====================
CREATE OR REPLACE FUNCTION create_user_stats_table()
RETURNS VOID AS \$\$
BEGIN
    -- Create enum for task priorities if not exists
    DO \$\$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'task_priority') THEN
            CREATE TYPE task_priority AS ENUM ('low', 'medium', 'high');
        END IF;
    END
    \$\$;

    -- Create user_stats table if not exists
    CREATE TABLE IF NOT EXISTS user_stats (
        id UUID REFERENCES auth.users(id) PRIMARY KEY,
        username TEXT NOT NULL,
        email TEXT NOT NULL,
        xp INTEGER DEFAULT 0,
        level INTEGER DEFAULT 1,
        streak INTEGER DEFAULT 0,
        last_task_date TIMESTAMPTZ,
        created_at TIMESTAMPTZ DEFAULT NOW(),
        updated_at TIMESTAMPTZ DEFAULT NOW()
    );

    -- Enable RLS
    ALTER TABLE user_stats ENABLE ROW LEVEL SECURITY;

    -- Create RLS policies if not exist
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'user_stats' AND policyname = 'Users can view their own stats') THEN
        CREATE POLICY "Users can view their own stats"
        ON user_stats FOR SELECT
        USING (auth.uid() = id);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'user_stats' AND policyname = 'Users can update their own stats') THEN
        CREATE POLICY "Users can update their own stats"
        ON user_stats FOR UPDATE
        USING (auth.uid() = id);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'user_stats' AND policyname = 'Users can insert their own stats') THEN
        CREATE POLICY "Users can insert their own stats"
        ON user_stats FOR INSERT
        WITH CHECK (auth.uid() = id);
    END IF;
END;
\$\$ LANGUAGE plpgsql SECURITY DEFINER;

-- ====================
-- FUNCTION: Create tasks table
-- ====================
CREATE OR REPLACE FUNCTION create_tasks_table()
RETURNS VOID AS \$\$
BEGIN
    -- Create tasks table if not exists
    CREATE TABLE IF NOT EXISTS tasks (
        id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
        user_id UUID REFERENCES auth.users(id) NOT NULL,
        title TEXT NOT NULL,
        description TEXT DEFAULT '',
        priority task_priority DEFAULT 'medium',
        category TEXT DEFAULT 'General',
        due_date TIMESTAMPTZ,
        created_at TIMESTAMPTZ DEFAULT NOW(),
        updated_at TIMESTAMPTZ DEFAULT NOW(),
        is_completed BOOLEAN DEFAULT FALSE
    );

    -- Enable RLS
    ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;

    -- Create RLS policies if not exist
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'tasks' AND policyname = 'Users can view their own tasks') THEN
        CREATE POLICY "Users can view their own tasks"
        ON tasks FOR SELECT
        USING (auth.uid() = user_id);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'tasks' AND policyname = 'Users can insert their own tasks') THEN
        CREATE POLICY "Users can insert their own tasks"
        ON tasks FOR INSERT
        WITH CHECK (auth.uid() = user_id);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'tasks' AND policyname = 'Users can update their own tasks') THEN
        CREATE POLICY "Users can update their own tasks"
        ON tasks FOR UPDATE
        USING (auth.uid() = user_id);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'tasks' AND policyname = 'Users can delete their own tasks') THEN
        CREATE POLICY "Users can delete their own tasks"
        ON tasks FOR DELETE
        USING (auth.uid() = user_id);
    END IF;
END;
\$\$ LANGUAGE plpgsql SECURITY DEFINER;

-- ====================
-- FUNCTION: Create helper functions
-- ====================
CREATE OR REPLACE FUNCTION create_user_stats_functions()
RETURNS VOID AS \$\$
BEGIN
    -- Function to update updated_at timestamp
    CREATE OR REPLACE FUNCTION update_updated_at_column()
    RETURNS TRIGGER AS \$\$
    BEGIN
        NEW.updated_at = NOW();
        RETURN NEW;
    END;
    \$\$ LANGUAGE plpgsql;

    -- Apply trigger to user_stats table if not exists
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'update_user_stats_updated_at') THEN
        CREATE TRIGGER update_user_stats_updated_at
            BEFORE UPDATE ON user_stats
            FOR EACH ROW
            EXECUTE FUNCTION update_updated_at_column();
    END IF;
END;
\$\$ LANGUAGE plpgsql SECURITY DEFINER;

-- ====================
-- FUNCTION: Create tasks functions
-- ====================
CREATE OR REPLACE FUNCTION create_tasks_functions()
RETURNS VOID AS \$\$
BEGIN
    -- Apply trigger to tasks table if not exists
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'update_tasks_updated_at') THEN
        CREATE TRIGGER update_tasks_updated_at
            BEFORE UPDATE ON tasks
            FOR EACH ROW
            EXECUTE FUNCTION update_updated_at_column();
    END IF;

    -- Auto-create user profile function
    CREATE OR REPLACE FUNCTION public.handle_new_user()
    RETURNS TRIGGER AS \$\$
    BEGIN
        INSERT INTO public.user_stats (id, username, email)
        VALUES (
            NEW.id,
            COALESCE(NEW.raw_user_meta_data->>'username', split_part(NEW.email, '@', 1)),
            NEW.email
        )
        ON CONFLICT (id) DO NOTHING;
        RETURN NEW;
    END;
    \$\$ LANGUAGE plpgsql SECURITY DEFINER;

    -- Apply trigger if not exists
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'on_auth_user_created') THEN
        CREATE TRIGGER on_auth_user_created
            AFTER INSERT ON auth.users
            FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
    END IF;
END;
\$\$ LANGUAGE plpgsql SECURITY DEFINER;

-- ====================
-- FUNCTION: Create RLS policies
-- ====================
CREATE OR REPLACE FUNCTION create_rls_policies()
RETURNS VOID AS \$\$
BEGIN
    -- Create indexes if not exist
    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_tasks_user_id') THEN
        CREATE INDEX idx_tasks_user_id ON tasks(user_id);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_tasks_user_completed') THEN
        CREATE INDEX idx_tasks_user_completed ON tasks(user_id, is_completed);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_tasks_due_date') THEN
        CREATE INDEX idx_tasks_due_date ON tasks(due_date);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_user_stats_user_id') THEN
        CREATE INDEX idx_user_stats_user_id ON user_stats(id);
    END IF;

    -- Create view for user task statistics
    CREATE OR REPLACE VIEW user_task_stats AS
    SELECT
        u.id,
        u.username,
        u.email,
        u.xp,
        u.level,
        u.streak,
        COUNT(t.id) as total_tasks,
        COUNT(CASE WHEN t.is_completed = true THEN 1 END) as completed_tasks,
        COUNT(CASE WHEN t.is_completed = false THEN 1 END) as pending_tasks,
        u.updated_at
    FROM user_stats u
    LEFT JOIN tasks t ON u.id = t.user_id
    GROUP BY u.id, u.username, u.email, u.xp, u.level, u.streak, u.updated_at;

    -- Grant access to the view
    GRANT SELECT ON user_task_stats TO authenticated;
END;
\$\$ LANGUAGE plpgsql SECURITY DEFINER;
''';
  }
}

void main() async {
  await RPCInitializer.initializeRPCFunctions();
}
