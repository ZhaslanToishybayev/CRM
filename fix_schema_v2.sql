-- =====================================================
-- SAFE SCHEMA EXECUTION - Version 2
-- Fixed: achievement_category casting issue
-- =====================================================

-- ====================
-- 1. CREATE TYPES (IF NOT EXISTS)
-- ====================

DO $$
BEGIN
    -- Task priorities
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'task_priority') THEN
        CREATE TYPE task_priority AS ENUM ('low', 'medium', 'high', 'urgent', 'critical');
    END IF;
    
    -- User roles
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'user_role') THEN
        CREATE TYPE user_role AS ENUM ('employee', 'manager', 'admin', 'super_admin');
    END IF;
    
    -- Task types
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'task_type') THEN
        CREATE TYPE task_type AS ENUM ('personal', 'project', 'team');
    END IF;
    
    -- Achievement categories
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'achievement_category') THEN
        CREATE TYPE achievement_category AS ENUM (
            'productivity', 'deadlines', 'teamwork', 'quality',
            'leadership', 'innovation', 'growth', 'communication',
            'team_achievement'
        );
    END IF;
    
    -- Report periods
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'report_period') THEN
        CREATE TYPE report_period AS ENUM ('daily', 'weekly', 'monthly', 'quarterly', 'yearly');
    END IF;
END $$;

-- ====================
-- 2. CREATE TABLES (IF NOT EXISTS)
-- ====================

-- Organizations
CREATE TABLE IF NOT EXISTS organizations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    logo_url TEXT,
    website TEXT,
    industry TEXT,
    size TEXT,
    timezone TEXT DEFAULT 'UTC',
    settings JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE
);

-- Departments
CREATE TABLE IF NOT EXISTS departments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    head_id UUID REFERENCES auth.users(id),
    budget DECIMAL(15,2),
    settings JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE,
    UNIQUE(organization_id, name)
);

-- Teams
CREATE TABLE IF NOT EXISTS teams (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    department_id UUID REFERENCES departments(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    team_lead_id UUID REFERENCES auth.users(id),
    max_members INTEGER DEFAULT 10,
    avatar_url TEXT,
    settings JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE,
    UNIQUE(department_id, name)
);

-- Corporate Users
CREATE TABLE IF NOT EXISTS corporate_users (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    department_id UUID REFERENCES departments(id) ON DELETE SET NULL,
    team_id UUID REFERENCES teams(id) ON DELETE SET NULL,
    employee_id TEXT UNIQUE,
    email TEXT NOT NULL,
    username TEXT NOT NULL,
    full_name TEXT NOT NULL,
    job_title TEXT,
    role user_role DEFAULT 'employee',
    hire_date DATE DEFAULT CURRENT_DATE,
    avatar_url TEXT,
    phone TEXT,
    location TEXT,
    bio TEXT,
    skills TEXT[],
    preferences JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE,
    UNIQUE(user_id, organization_id)
);

-- Projects
CREATE TABLE IF NOT EXISTS projects (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    owner_id UUID REFERENCES auth.users(id),
    department_id UUID REFERENCES departments(id),
    status TEXT DEFAULT 'active',
    priority task_priority DEFAULT 'medium',
    start_date DATE,
    end_date DATE,
    budget DECIMAL(15,2),
    progress INTEGER DEFAULT 0,
    settings JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE
);

-- Team Members
CREATE TABLE IF NOT EXISTS team_members (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    team_id UUID REFERENCES teams(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    role user_role DEFAULT 'employee',
    joined_at TIMESTAMPTZ DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE,
    UNIQUE(team_id, user_id)
);

-- Work Tasks
CREATE TABLE IF NOT EXISTS work_tasks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    department_id UUID REFERENCES departments(id),
    team_id UUID REFERENCES teams(id),
    project_id UUID REFERENCES projects(id),
    assignee_id UUID REFERENCES auth.users(id),
    reporter_id UUID REFERENCES auth.users(id),
    title TEXT NOT NULL,
    description TEXT,
    task_type task_type DEFAULT 'personal',
    priority task_priority DEFAULT 'medium',
    category TEXT,
    status TEXT DEFAULT 'todo',
    due_date TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,
    estimated_hours DECIMAL(5,2),
    actual_hours DECIMAL(5,2),
    quality_rating INTEGER CHECK (quality_rating >= 1 AND quality_rating <= 5),
    feedback TEXT,
    xp_reward INTEGER DEFAULT 0,
    settings JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    is_completed BOOLEAN DEFAULT FALSE,
    is_archived BOOLEAN DEFAULT FALSE
);

-- Achievements
CREATE TABLE IF NOT EXISTS achievements (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    category achievement_category NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    icon TEXT,
    xp_reward INTEGER DEFAULT 0,
    badge_color TEXT,
    requirements JSONB NOT NULL,
    rarity TEXT DEFAULT 'common',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- User Achievements
CREATE TABLE IF NOT EXISTS user_achievements (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    achievement_id UUID REFERENCES achievements(id) ON DELETE CASCADE,
    unlocked_at TIMESTAMPTZ DEFAULT NOW(),
    progress INTEGER DEFAULT 0,
    metadata JSONB DEFAULT '{}',
    UNIQUE(user_id, achievement_id)
);

-- User XP
CREATE TABLE IF NOT EXISTS user_xp (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    total_xp INTEGER DEFAULT 0,
    current_level INTEGER DEFAULT 1,
    current_streak INTEGER DEFAULT 0,
    longest_streak INTEGER DEFAULT 0,
    last_activity_date DATE,
    xp_history JSONB DEFAULT '[]',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id)
);

-- Task Activity Log
CREATE TABLE IF NOT EXISTS task_activity_log (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    task_id UUID REFERENCES work_tasks(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id),
    action TEXT NOT NULL,
    description TEXT,
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Leaderboard Entries
CREATE TABLE IF NOT EXISTS leaderboard_entries (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    department_id UUID REFERENCES departments(id),
    team_id UUID REFERENCES teams(id),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    period_type report_period NOT NULL,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    total_xp INTEGER DEFAULT 0,
    tasks_completed INTEGER DEFAULT 0,
    tasks_on_time INTEGER DEFAULT 0,
    average_quality DECIMAL(3,2) DEFAULT 0,
    rank INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(organization_id, team_id, user_id, period_type, period_start, period_end)
);

-- Notifications
CREATE TABLE IF NOT EXISTS notifications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    type TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ====================
-- 3. RLS POLICIES
-- ====================

-- Enable RLS on all tables
ALTER TABLE organizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE departments ENABLE ROW LEVEL SECURITY;
ALTER TABLE teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE corporate_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE team_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE work_tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE achievements ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_achievements ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_xp ENABLE ROW LEVEL SECURITY;
ALTER TABLE task_activity_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE leaderboard_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- ====================
-- 4. TRIGGERS
-- ====================

-- Function to update updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply triggers
DROP TRIGGER IF EXISTS update_organizations_updated_at ON organizations;
CREATE TRIGGER update_organizations_updated_at
    BEFORE UPDATE ON organizations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_departments_updated_at ON departments;
CREATE TRIGGER update_departments_updated_at
    BEFORE UPDATE ON departments
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_teams_updated_at ON teams;
CREATE TRIGGER update_teams_updated_at
    BEFORE UPDATE ON teams
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_corporate_users_updated_at ON corporate_users;
CREATE TRIGGER update_corporate_users_updated_at
    BEFORE UPDATE ON corporate_users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_projects_updated_at ON projects;
CREATE TRIGGER update_projects_updated_at
    BEFORE UPDATE ON projects
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_work_tasks_updated_at ON work_tasks;
CREATE TRIGGER update_work_tasks_updated_at
    BEFORE UPDATE ON work_tasks
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_user_xp_updated_at ON user_xp;
CREATE TRIGGER update_user_xp_updated_at
    BEFORE UPDATE ON user_xp
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ====================
-- 5. HELPER FUNCTIONS
-- ====================

-- Function to calculate user level from XP
CREATE OR REPLACE FUNCTION calculate_level(total_xp INTEGER)
RETURNS INTEGER AS $$
BEGIN
    RETURN FLOOR(SQRT(total_xp / 100.0)) + 1;
END;
$$ LANGUAGE plpgsql;

-- ====================
-- 6. INSERT DEFAULT ACHIEVEMENTS (FIXED)
-- ====================

-- Insert achievements one by one to avoid enum casting issues

-- Productivity achievements
INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('productivity'::achievement_category, 'Daily Driver', 'Complete 5 tasks in a day', 300, '{"tasks_completed": 5, "period": "daily"}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('productivity'::achievement_category, 'Weekly Warrior', 'Complete 25 tasks in a week', 1000, '{"tasks_completed": 25, "period": "weekly"}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('productivity'::achievement_category, 'Monthly Master', 'Complete 100 tasks in a month', 5000, '{"tasks_completed": 100, "period": "monthly"}')
ON CONFLICT DO NOTHING;

-- Deadlines achievements
INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('deadlines'::achievement_category, 'Deadline Crusher', 'Complete 50 tasks before deadline', 10000, '{"tasks_before_deadline": 50}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('deadlines'::achievement_category, 'Zero Overdue', 'No overdue tasks for 14 days', 2500, '{"days_no_overdue": 14}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('deadlines'::achievement_category, 'On-Time Streak', 'Complete tasks on time for 30 days', 10000, '{"days_on_time": 30}')
ON CONFLICT DO NOTHING;

-- Teamwork achievements
INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('teamwork'::achievement_category, 'Team Player', 'Help colleagues with tasks', 500, '{"helped_colleagues": 5}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('teamwork'::achievement_category, 'Collaborator', 'Complete 10 team tasks', 800, '{"team_tasks": 10}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('teamwork'::achievement_category, 'Mentor', 'Mentor junior team members', 1500, '{"mentees": 3}')
ON CONFLICT DO NOTHING;

-- Quality achievements
INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('quality'::achievement_category, 'Quality Master', 'Receive 5 five-star ratings', 2000, '{"five_star_ratings": 5}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('quality'::achievement_category, 'Excellence Award', 'Exceed expectations 20 times', 4000, '{"exceeded_expectations": 20}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('quality'::achievement_category, 'Standards Keeper', 'Maintain high standards', 10000, '{"consistent_quality": 50}')
ON CONFLICT DO NOTHING;

-- Leadership achievements
INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('leadership'::achievement_category, 'Take Initiative', 'Lead 5 initiatives', 1000, '{"initiatives": 5}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('leadership'::achievement_category, 'Project Leader', 'Lead 3 successful projects', 2500, '{"projects_led": 3}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('leadership'::achievement_category, 'Leadership Recognition', 'Receive leadership award', 5000, '{"leadership_award": true}')
ON CONFLICT DO NOTHING;

-- Innovation achievements
INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('innovation'::achievement_category, 'Idea Generator', 'Submit 5 improvement ideas', 800, '{"ideas_submitted": 5}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('innovation'::achievement_category, 'Automation Expert', 'Automate 5 processes', 3000, '{"processes_automated": 5}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('innovation'::achievement_category, 'Innovation Award', 'Win innovation contest', 10000, '{"won_contest": true}')
ON CONFLICT DO NOTHING;

-- Growth achievements
INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('growth'::achievement_category, 'Skill Developer', 'Learn 5 new skills', 1000, '{"skills_learned": 5}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('growth'::achievement_category, 'Certified Professional', 'Earn 3 certifications', 5000, '{"certifications": 3}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('growth'::achievement_category, 'Subject Matter Expert', 'Become recognized expert', 15000, '{"expert_recognition": true}')
ON CONFLICT DO NOTHING;

-- Communication achievements
INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('communication'::achievement_category, 'Clear Communicator', 'Receive communication praise', 800, '{"positive_feedback": 10}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('communication'::achievement_category, 'Fast Responder', 'Respond within 1 hour 95% of time', 1500, '{"response_time": 0.95}')
ON CONFLICT DO NOTHING;

INSERT INTO achievements (category, title, description, xp_reward, requirements)
VALUES ('communication'::achievement_category, 'Mediator', 'Successfully mediate 3 conflicts', 2500, '{"conflicts_mediated": 3}')
ON CONFLICT DO NOTHING;

-- ====================
-- SUCCESS MESSAGE
-- ====================

SELECT 'Database schema updated successfully! Version 2 - Fixed enum casting' AS status;
