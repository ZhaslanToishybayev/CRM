-- Database Schema for Gamified Task Management App
-- Run this in Supabase SQL Editor

-- ====================
-- 1. CUSTOM TYPES
-- ====================

-- Create enum for task priorities
CREATE TYPE task_priority AS ENUM ('low', 'medium', 'high');

-- ====================
-- 2. USER STATS TABLE
-- ====================

CREATE TABLE user_stats (
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

-- Enable RLS (Row Level Security)
ALTER TABLE user_stats ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for user_stats
CREATE POLICY "Users can view their own stats"
ON user_stats FOR SELECT
USING (auth.uid() = id);

CREATE POLICY "Users can update their own stats"
ON user_stats FOR UPDATE
USING (auth.uid() = id);

CREATE POLICY "Users can insert their own stats"
ON user_stats FOR INSERT
WITH CHECK (auth.uid() = id);

-- ====================
-- 3. TASKS TABLE
-- ====================

CREATE TABLE tasks (
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

-- Create RLS policies for tasks
CREATE POLICY "Users can view their own tasks"
ON tasks FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own tasks"
ON tasks FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own tasks"
ON tasks FOR UPDATE
USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own tasks"
ON tasks FOR DELETE
USING (auth.uid() = user_id);

-- ====================
-- 4. TRIGGERS FOR AUTO-UPDATE
-- ====================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply trigger to tasks table
CREATE TRIGGER update_tasks_updated_at
    BEFORE UPDATE ON tasks
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Apply trigger to user_stats table
CREATE TRIGGER update_user_stats_updated_at
    BEFORE UPDATE ON user_stats
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ====================
-- 5. INDEXES FOR PERFORMANCE
-- ====================

-- Index for tasks by user_id
CREATE INDEX idx_tasks_user_id ON tasks(user_id);

-- Index for tasks by user_id and is_completed
CREATE INDEX idx_tasks_user_completed ON tasks(user_id, is_completed);

-- Index for tasks by due_date
CREATE INDEX idx_tasks_due_date ON tasks(due_date);

-- Index for user_stats by user_id
CREATE INDEX idx_user_stats_user_id ON user_stats(id);

-- ====================
-- 6. HELPER VIEWS
-- ====================

-- View for user's task statistics
CREATE VIEW user_task_stats AS
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

-- ====================
-- 7. FUNCTION TO CREATE USER PROFILE
-- ====================

-- Function to automatically create user profile when user signs up
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.user_stats (id, username, email)
    VALUES (
        NEW.id,
        COALESCE(NEW.raw_user_meta_data->>'username', split_part(NEW.email, '@', 1)),
        NEW.email
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to call the function when a new user is created
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ====================
-- 8. COMMENTS FOR DOCUMENTATION
-- ====================

COMMENT ON TABLE user_stats IS 'User statistics including XP, level, and streak';
COMMENT ON TABLE tasks IS 'Tasks created by users with priority and category';
COMMENT ON COLUMN tasks.priority IS 'Task priority: low, medium, or high';
COMMENT ON COLUMN tasks.category IS 'Task category: Work, Personal, Shopping, Health, General';
COMMENT ON COLUMN tasks.due_date IS 'Optional due date for the task';
COMMENT ON COLUMN tasks.is_completed IS 'Whether the task has been completed';

-- ====================
-- 9. SAMPLE DATA (Optional - for testing)
-- ====================

-- This sample data will only work after a user is created
-- You can uncomment and modify after creating test users

/*
-- Insert sample tasks (only after user is authenticated)
INSERT INTO tasks (user_id, title, description, priority, category, due_date)
VALUES
    ('USER_UUID_HERE', 'Welcome Task', 'This is your first task!', 'medium', 'General', NOW() + INTERVAL '7 days'),
    ('USER_UUID_HERE', 'High Priority Task', 'Complete this task as soon as possible', 'high', 'Work', NOW() + INTERVAL '3 days'),
    ('USER_UUID_HERE', 'Personal Task', 'A personal task to organize', 'low', 'Personal', NOW() + INTERVAL '14 days');
*/
