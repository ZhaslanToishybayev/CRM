-- =====================================================
-- ONE-TIME SETUP: RPC Functions for Auto-Setup
-- =====================================================
-- Instructions:
-- 1. Open https://supabase.com/dashboard
-- 2. Select your project: gamified-tasks
-- 3. Go to SQL Editor
-- 4. Create a New Query
-- 5. Copy and paste this entire file
-- 6. Click RUN
-- 7. You're done! Auto-setup will now work automatically
-- =====================================================

-- Create enum type for task priorities (if not exists)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'task_priority') THEN
        CREATE TYPE task_priority AS ENUM ('low', 'medium', 'high');
    END IF;
END
$$;

-- Enable RLS on public schema
CREATE OR REPLACE FUNCTION enable_rls_on_public()
RETURNS VOID AS $$
BEGIN
    NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create user_stats table
CREATE OR REPLACE FUNCTION create_user_stats_table()
RETURNS VOID AS $$
BEGIN
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

    ALTER TABLE user_stats ENABLE ROW LEVEL SECURITY;

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
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create tasks table
CREATE OR REPLACE FUNCTION create_tasks_table()
RETURNS VOID AS $$
BEGIN
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

    ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;

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
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create helper functions
CREATE OR REPLACE FUNCTION create_user_stats_functions()
RETURNS VOID AS $$
BEGIN
    DROP FUNCTION IF EXISTS update_updated_at_column();
    CREATE FUNCTION update_updated_at_column()
    RETURNS TRIGGER AS $$
    BEGIN
        NEW.updated_at = NOW();
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'update_user_stats_updated_at') THEN
        CREATE TRIGGER update_user_stats_updated_at
            BEFORE UPDATE ON user_stats
            FOR EACH ROW
            EXECUTE FUNCTION update_updated_at_column();
    END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create tasks functions
CREATE OR REPLACE FUNCTION create_tasks_functions()
RETURNS VOID AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'update_tasks_updated_at') THEN
        CREATE TRIGGER update_tasks_updated_at
            BEFORE UPDATE ON tasks
            FOR EACH ROW
            EXECUTE FUNCTION update_updated_at_column();
    END IF;

    CREATE OR REPLACE FUNCTION public.handle_new_user()
    RETURNS TRIGGER AS $$
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
    $$ LANGUAGE plpgsql SECURITY DEFINER;

    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'on_auth_user_created') THEN
        CREATE TRIGGER on_auth_user_created
            AFTER INSERT ON auth.users
            FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
    END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create RLS policies
CREATE OR REPLACE FUNCTION create_rls_policies()
RETURNS VOID AS $$
BEGIN
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

    GRANT SELECT ON user_task_stats TO authenticated;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

COMMENT ON TABLE user_stats IS 'User statistics including XP, level, and streak';
COMMENT ON TABLE tasks IS 'Tasks created by users with priority and category';
COMMENT ON COLUMN tasks.priority IS 'Task priority: low, medium, or high';
COMMENT ON COLUMN tasks.category IS 'Task category: Work, Personal, Shopping, Health, General';
COMMENT ON COLUMN tasks.due_date IS 'Optional due date for the task';
COMMENT ON COLUMN tasks.is_completed IS 'Whether the task has been completed';

SELECT 'RPC Functions created successfully! Auto-setup is now ready.' AS status;
