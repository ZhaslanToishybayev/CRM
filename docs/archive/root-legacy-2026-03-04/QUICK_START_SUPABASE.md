# 🚀 QUICK START - SUPABASE SETUP

## ✅ What's Already Done:
- ✅ Supabase URL configured
- ✅ Anon key configured
- ✅ App updated with Supabase integration
- ✅ Ready to run!

## ⚡ Quick Steps (5 minutes):

### Step 1: Create Database Schema
1. Open your Supabase dashboard: https://supabase.com/dashboard
2. Go to your project: **gamified-tasks**
3. Click **"SQL Editor"** in left sidebar
4. Click **"New Query"**
5. Copy and paste this SQL:

```sql
-- Create enum for task priorities
CREATE TYPE task_priority AS ENUM ('low', 'medium', 'high');

-- User stats table
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

-- Tasks table
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
ALTER TABLE user_stats ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;

-- RLS Policies for user_stats
CREATE POLICY "Users can view their own stats"
ON user_stats FOR SELECT
USING (auth.uid() = id);

CREATE POLICY "Users can update their own stats"
ON user_stats FOR UPDATE
USING (auth.uid() = id);

CREATE POLICY "Users can insert their own stats"
ON user_stats FOR INSERT
WITH CHECK (auth.uid() = id);

-- RLS Policies for tasks
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

-- Auto-update timestamps
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_tasks_updated_at
    BEFORE UPDATE ON tasks
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_user_stats_updated_at
    BEFORE UPDATE ON user_stats
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Auto-create user profile
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

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
```

6. Click **"Run"** ✅

### Step 2: Launch the App
```bash
cd /home/zhaslan/code/gamified_task_app
flutter run -d web-server --target lib/main_final.dart --web-port 8083
```

### Step 3: Open Browser
Navigate to: **http://localhost:8083**

### Step 4: Test
- Click **"Try Demo Mode"** for instant access
- Or create account with email/password

---

## 🎯 What Happens Next:
1. ✅ App connects to Supabase
2. ✅ User authentication via Supabase Auth
3. ✅ Tasks stored in PostgreSQL
4. ✅ Real-time sync enabled
5. ✅ User stats tracked

---

## 📱 Test Features:
- ✅ Sign up with email/password
- ✅ Sign in
- ✅ Demo mode
- ✅ Create tasks
- ✅ Complete tasks
- ✅ View stats
- ✅ Real-time updates

---

## 🔧 Troubleshooting:

**"Table doesn't exist"**
→ Run the SQL schema above

**"Authentication failed"**
→ Check if email confirmation is enabled (can disable for testing)

**"RLS Policy violation"**
→ RLS is working correctly! User can only access their own data.

---

## 📊 View Your Data:
1. Go to Supabase Dashboard → Table Editor
2. See all your tables: `user_stats`, `tasks`
3. View real-time data changes

---

**Ready to go! 🚀**
