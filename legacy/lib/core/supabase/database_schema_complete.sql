-- =====================================================
-- CORPORATE GAMIFIED TASK MANAGEMENT APP - DATABASE SCHEMA
-- Phases 1-3: Complete Corporate Structure
-- =====================================================

-- ====================
-- 1. CUSTOM TYPES (ENUMS)
-- ====================

-- Task priorities
CREATE TYPE task_priority AS ENUM ('low', 'medium', 'high', 'urgent', 'critical');

-- User roles in organization
CREATE TYPE user_role AS ENUM ('employee', 'manager', 'admin', 'super_admin');

-- Task types
CREATE TYPE task_type AS ENUM ('personal', 'project', 'team');

-- Achievement categories
CREATE TYPE achievement_category AS ENUM (
    'productivity', 'deadlines', 'teamwork', 'quality',
    'leadership', 'innovation', 'growth', 'communication',
    'team_achievement'
);

-- Report periods
CREATE TYPE report_period AS ENUM ('daily', 'weekly', 'monthly', 'quarterly', 'yearly');

-- ====================
-- 2. ORGANIZATIONS
-- ====================

CREATE TABLE organizations (
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

-- Enable RLS
ALTER TABLE organizations ENABLE ROW LEVEL SECURITY;

-- Only super admins can manage organizations
CREATE POLICY "Organizations are viewable by authenticated users"
ON organizations FOR SELECT
USING (auth.role() = 'authenticated');

-- ====================
-- 3. DEPARTMENTS
-- ====================

CREATE TABLE departments (
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

-- Enable RLS
ALTER TABLE departments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view departments in their organization"
ON departments FOR SELECT
USING (
    organization_id IN (
        SELECT organization_id
        FROM corporate_users
        WHERE user_id = auth.uid()
    )
);

-- ====================
-- 4. TEAMS
-- ====================

CREATE TABLE teams (
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

-- Enable RLS
ALTER TABLE teams ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view teams in their department"
ON teams FOR SELECT
USING (
    department_id IN (
        SELECT d.id
        FROM departments d
        JOIN corporate_users cu ON cu.organization_id = d.organization_id
        WHERE cu.user_id = auth.uid()
    )
);

-- ====================
-- 5. CORPORATE USERS
-- ====================

CREATE TABLE corporate_users (
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

-- Enable RLS
ALTER TABLE corporate_users ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own profile"
ON corporate_users FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own profile"
ON corporate_users FOR UPDATE
USING (auth.uid() = user_id);

CREATE POLICY "Managers can view team members"
ON corporate_users FOR SELECT
USING (
    team_id IN (
        SELECT id
        FROM teams
        WHERE team_lead_id = auth.uid()
    )
);

CREATE POLICY "Admins can view all users in their org"
ON corporate_users FOR SELECT
USING (
    organization_id IN (
        SELECT organization_id
        FROM corporate_users
        WHERE user_id = auth.uid() AND role IN ('admin', 'super_admin')
    )
);

-- ====================
-- 6. PROJECTS
-- ====================

CREATE TABLE projects (
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

-- Enable RLS
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view projects in their organization"
ON projects FOR SELECT
USING (
    organization_id IN (
        SELECT organization_id
        FROM corporate_users
        WHERE user_id = auth.uid()
    )
);

-- ====================
-- 7. TEAM MEMBERS
-- ====================

CREATE TABLE team_members (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    team_id UUID REFERENCES teams(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    role user_role DEFAULT 'employee',
    joined_at TIMESTAMPTZ DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE,
    UNIQUE(team_id, user_id)
);

-- Enable RLS
ALTER TABLE team_members ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their team memberships"
ON team_members FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Team leads can manage team members"
ON team_members FOR ALL
USING (
    team_id IN (
        SELECT id
        FROM teams
        WHERE team_lead_id = auth.uid()
    )
);

-- ====================
-- 8. WORK TASKS
-- ====================

CREATE TABLE work_tasks (
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

-- Enable RLS
ALTER TABLE work_tasks ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view tasks assigned to them or their teams"
ON work_tasks FOR SELECT
USING (
    assignee_id = auth.uid()
    OR team_id IN (
        SELECT team_id
        FROM team_members
        WHERE user_id = auth.uid() AND is_active = TRUE
    )
    OR reporter_id = auth.uid()
);

CREATE POLICY "Users can update tasks assigned to them"
ON work_tasks FOR UPDATE
USING (assignee_id = auth.uid());

CREATE POLICY "Users can create tasks"
ON work_tasks FOR INSERT
WITH CHECK (auth.uid() = reporter_id);

-- ====================
-- 9. ACHIEVEMENTS
-- ====================

CREATE TABLE achievements (
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

-- Enable RLS
ALTER TABLE achievements ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Achievements are viewable by authenticated users"
ON achievements FOR SELECT
USING (auth.role() = 'authenticated');

-- ====================
-- 10. USER ACHIEVEMENTS
-- ====================

CREATE TABLE user_achievements (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    achievement_id UUID REFERENCES achievements(id) ON DELETE CASCADE,
    unlocked_at TIMESTAMPTZ DEFAULT NOW(),
    progress INTEGER DEFAULT 0,
    metadata JSONB DEFAULT '{}',
    UNIQUE(user_id, achievement_id)
);

-- Enable RLS
ALTER TABLE user_achievements ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own achievements"
ON user_achievements FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "System can insert achievements"
ON user_achievements FOR INSERT
WITH CHECK (TRUE);

-- ====================
-- 11. USER XP & LEVELS
-- ====================

CREATE TABLE user_xp (
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

-- Enable RLS
ALTER TABLE user_xp ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own XP"
ON user_xp FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own XP"
ON user_xp FOR UPDATE
USING (auth.uid() = user_id);

-- ====================
-- 12. TASK ACTIVITY LOG
-- ====================

CREATE TABLE task_activity_log (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    task_id UUID REFERENCES work_tasks(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id),
    action TEXT NOT NULL,
    description TEXT,
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE task_activity_log ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view activity on their tasks"
ON task_activity_log FOR SELECT
USING (
    task_id IN (
        SELECT id FROM work_tasks
        WHERE assignee_id = auth.uid() OR reporter_id = auth.uid()
    )
);

CREATE POLICY "System can log activities"
ON task_activity_log FOR INSERT
WITH CHECK (TRUE);

-- ====================
-- 13. LEADERBOARD ENTRIES
-- ====================

CREATE TABLE leaderboard_entries (
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

-- Enable RLS
ALTER TABLE leaderboard_entries ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view leaderboard entries"
ON leaderboard_entries FOR SELECT
USING (
    organization_id IN (
        SELECT organization_id
        FROM corporate_users
        WHERE user_id = auth.uid()
    )
);

-- ====================
-- 14. NOTIFICATIONS
-- ====================

CREATE TABLE notifications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    type TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own notifications"
ON notifications FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own notifications"
ON notifications FOR UPDATE
USING (auth.uid() = user_id);

CREATE POLICY "System can create notifications"
ON notifications FOR INSERT
WITH CHECK (TRUE);

-- ====================
-- 15. TRIGGERS FOR AUTO-UPDATE
-- ====================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply triggers to all tables with updated_at
CREATE TRIGGER update_organizations_updated_at
    BEFORE UPDATE ON organizations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_departments_updated_at
    BEFORE UPDATE ON departments
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_teams_updated_at
    BEFORE UPDATE ON teams
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_corporate_users_updated_at
    BEFORE UPDATE ON corporate_users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_projects_updated_at
    BEFORE UPDATE ON projects
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_work_tasks_updated_at
    BEFORE UPDATE ON work_tasks
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_user_xp_updated_at
    BEFORE UPDATE ON user_xp
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ====================
-- 16. HELPER FUNCTIONS
-- ====================

-- Function to calculate user level from XP
CREATE OR REPLACE FUNCTION calculate_level(total_xp INTEGER)
RETURNS INTEGER AS $$
BEGIN
    -- Level = floor(sqrt(XP / 100)) + 1
    RETURN FLOOR(SQRT(total_xp / 100.0)) + 1;
END;
$$ LANGUAGE plpgsql;

-- Function to get team members
CREATE OR REPLACE FUNCTION get_team_members(team_uuid UUID)
RETURNS TABLE(
    user_id UUID,
    full_name TEXT,
    role TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        cu.user_id,
        cu.full_name,
        cu.role::TEXT
    FROM team_members tm
    JOIN corporate_users cu ON cu.user_id = tm.user_id
    WHERE tm.team_id = team_uuid AND tm.is_active = TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to get user organization
CREATE OR REPLACE FUNCTION get_user_organization(user_uuid UUID)
RETURNS UUID AS $$
DECLARE
    org_id UUID;
BEGIN
    SELECT organization_id INTO org_id
    FROM corporate_users
    WHERE user_id = user_uuid
    LIMIT 1;

    RETURN org_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ====================
-- 17. INITIAL DATA - DEFAULT ACHIEVEMENTS
-- ====================

INSERT INTO achievements (category, title, description, xp_reward, requirements) VALUES
-- Productivity achievements
('productivity', 'Daily Driver', 'Complete 5 tasks in a day', 300, '{"tasks_completed": 5, "period": "daily"}'),
('productivity', 'Weekly Warrior', 'Complete 25 tasks in a week', 1000, '{"tasks_completed": 25, "period": "weekly"}'),
('productivity', 'Monthly Master', 'Complete 100 tasks in a month', 5000, '{"tasks_completed": 100, "period": "monthly"}'),

-- Deadline achievements
('deadlines', 'Deadline Crusher', 'Complete 50 tasks before deadline', 10000, '{"tasks_before_deadline": 50}'),
('deadlines', 'Zero Overdue', 'No overdue tasks for 14 days', 2500, '{"days_no_overdue": 14}'),
('deadlines', 'On-Time Streak', 'Complete tasks on time for 30 days', 10000, '{"days_on_time": 30}'),

-- Teamwork achievements
('teamwork', 'Team Player', 'Help colleagues with tasks', 500, '{"helped_colleagues": 5}'),
('teamwork', 'Collaborator', 'Complete 10 team tasks', 800, '{"team_tasks": 10}'),
('teamwork', 'Mentor', 'Mentor junior team members', 1500, '{"mentees": 3}'),

-- Quality achievements
('quality', 'Quality Master', 'Receive 5 five-star ratings', 2000, '{"five_star_ratings": 5}'),
('quality', 'Excellence Award', 'Exceed expectations 20 times', 4000, '{"exceeded_expectations": 20}'),
('quality', 'Standards Keeper', 'Maintain high standards', 10000, '{"consistent_quality": 50}'),

-- Leadership achievements
('leadership', 'Project Leader', 'Lead 3 successful projects', 2500, '{"projects_led": 3}'),
('leadership', 'Team Mentor', 'Mentor team members', 1500, '{"mentoring": true}'),
('leadership', 'Change Leader', 'Drive organizational change', 5000, '{"change_initiatives": 5}'),

-- Innovation achievements
('innovation', 'Idea Generator', 'Submit 5 improvement ideas', 800, '{"ideas_submitted": 5}'),
('innovation', 'Automation Expert', 'Automate 5 processes', 3000, '{"processes_automated": 5}'),
('innovation', 'Innovation Award', 'Win innovation contest', 10000, '{"won_contest": true}'),

-- Growth achievements
('growth', 'Skill Developer', 'Learn 5 new skills', 1000, '{"skills_learned": 5}'),
('growth', 'Certified Professional', 'Earn 3 certifications', 5000, '{"certifications": 3}'),
('growth', 'Subject Matter Expert', 'Become recognized expert', 15000, '{"expert_recognition": true}'),

-- Communication achievements
('communication', 'Clear Communicator', 'Receive positive communication feedback', 800, '{"positive_feedback": 10}'),
('communication', 'Fast Responder', 'Respond within 1 hour 95% of time', 1500, '{"response_time": 0.95}'),
('communication', 'Mediator', 'Successfully mediate 3 conflicts', 2500, '{"conflicts_mediated": 3}');

-- ====================
-- 18. INDEXES FOR PERFORMANCE
-- ====================

-- User indexes
CREATE INDEX idx_corporate_users_org ON corporate_users(organization_id);
CREATE INDEX idx_corporate_users_dept ON corporate_users(department_id);
CREATE INDEX idx_corporate_users_team ON corporate_users(team_id);
CREATE INDEX idx_corporate_users_role ON corporate_users(role);

-- Task indexes
CREATE INDEX idx_work_tasks_assignee ON work_tasks(assignee_id);
CREATE INDEX idx_work_tasks_team ON work_tasks(team_id);
CREATE INDEX idx_work_tasks_project ON work_tasks(project_id);
CREATE INDEX idx_work_tasks_due_date ON work_tasks(due_date);
CREATE INDEX idx_work_tasks_status ON work_tasks(status);
CREATE INDEX idx_work_tasks_priority ON work_tasks(priority);

-- Achievement indexes
CREATE INDEX idx_user_achievements_user ON user_achievements(user_id);
CREATE INDEX idx_user_achievements_category ON achievements(category);

-- XP indexes
CREATE INDEX idx_user_xp_level ON user_xp(current_level);
CREATE INDEX idx_user_xp_streak ON user_xp(current_streak);

-- Leaderboard indexes
CREATE INDEX idx_leaderboard_org_period ON leaderboard_entries(organization_id, period_type, period_start);
CREATE INDEX idx_leaderboard_team_period ON leaderboard_entries(team_id, period_type, period_start);

-- Notification indexes
CREATE INDEX idx_notifications_user_read ON notifications(user_id, is_read);

-- ====================
-- 19. VIEWS FOR REPORTING
-- ====================

-- View for team performance
CREATE VIEW team_performance AS
SELECT
    t.id as team_id,
    t.name as team_name,
    COUNT(DISTINCT tm.user_id) as member_count,
    COUNT(wt.id) as total_tasks,
    COUNT(wt.id) FILTER (WHERE wt.is_completed = TRUE) as completed_tasks,
    AVG(wt.quality_rating) as average_quality,
    SUM(wt.xp_reward) as total_xp
FROM teams t
LEFT JOIN team_members tm ON t.id = tm.team_id AND tm.is_active = TRUE
LEFT JOIN work_tasks wt ON wt.team_id = t.id
WHERE t.is_active = TRUE
GROUP BY t.id, t.name;

-- View for employee performance
CREATE VIEW employee_performance AS
SELECT
    cu.user_id,
    cu.full_name,
    cu.job_title,
    cu.team_id,
    ux.current_level,
    ux.total_xp,
    ux.current_streak,
    COUNT(wt.id) as total_tasks,
    COUNT(wt.id) FILTER (WHERE wt.is_completed = TRUE) as completed_tasks,
    AVG(wt.quality_rating) as average_quality
FROM corporate_users cu
LEFT JOIN user_xp ux ON cu.user_id = ux.user_id
LEFT JOIN work_tasks wt ON wt.assignee_id = cu.user_id
WHERE cu.is_active = TRUE
GROUP BY cu.user_id, cu.full_name, cu.job_title, cu.team_id, ux.current_level, ux.total_xp, ux.current_streak;

-- ====================
-- SCHEMA COMPLETE
-- =====================================================

COMMIT;
