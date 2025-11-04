# 🗄️ SUPABASE INTEGRATION GUIDE

## Overview
This document explains how to set up Supabase database integration for the Gamified Task Management App.

## Prerequisites
1. Supabase account (free at https://supabase.com)
2. Flutter project with dependencies installed

## 📋 Setup Steps

### Step 1: Create Supabase Project
1. Go to https://supabase.com
2. Click "Start your project"
3. Sign up or log in with GitHub/Google
4. Click "New Project"
5. Choose organization
6. Enter project name: `gamified-tasks`
7. Enter database password (save it!)
8. Select region (closest to your location)
9. Click "Create new project"

### Step 2: Get API Keys
1. Go to your project dashboard
2. Click "Settings" (gear icon) in the left sidebar
3. Click "API"
4. Copy the following:
   - **Project URL** (starts with `https://`)
   - **anon public key** (starts with `eyJ`)

### Step 3: Configure Environment Variables
Create a `.env` file in the root of your Flutter project:

```bash
# .env
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
```

### Step 4: Create Database Schema
1. In Supabase dashboard, go to "SQL Editor"
2. Click "New Query"
3. Copy and paste the SQL from:
   `lib/core/supabase/database_schema.sql`
4. Click "Run" to execute the query
5. Verify tables were created in "Table Editor"

### Step 5: Enable Authentication
1. Go to "Authentication" in left sidebar
2. Go to "Settings" → "URL Configuration"
3. Add your site URL:
   - Development: `http://localhost:8083`
   - Production: `https://yourdomain.com`

### Step 6: Update App Configuration
Edit `lib/core/supabase/supabase_config.dart`:

```dart
// Replace the default values with your actual credentials
static const String supabaseUrl = 'https://your-project-id.supabase.co';
static const String supabaseAnonKey = 'your-anon-key-here';
```

**⚠️ IMPORTANT**: Don't commit these credentials to version control!

## 🏗️ Database Schema

### Tables Created:

1. **user_stats**
   - `id` (UUID, Primary Key)
   - `username` (Text)
   - `email` (Text)
   - `xp` (Integer, default: 0)
   - `level` (Integer, default: 1)
   - `streak` (Integer, default: 0)
   - `last_task_date` (Timestamp)
   - `created_at` (Timestamp)
   - `updated_at` (Timestamp)

2. **tasks**
   - `id` (UUID, Primary Key)
   - `user_id` (UUID, Foreign Key)
   - `title` (Text)
   - `description` (Text)
   - `priority` (Enum: low, medium, high)
   - `category` (Text)
   - `due_date` (Timestamp, Optional)
   - `created_at` (Timestamp)
   - `updated_at` (Timestamp)
   - `is_completed` (Boolean, default: false)

### Security (RLS Policies)
- Users can only access their own data
- Automatic user profile creation on signup
- Secure authentication via Supabase Auth

## 🎯 Features Enabled

### Real-time Synchronization
- Changes in one device instantly sync to others
- Live updates of tasks and statistics
- Automatic conflict resolution

### Offline Support
- App works offline with local caching
- Syncs with server when online
- No data loss during offline periods

### Authentication
- Email/Password signup and login
- Demo mode (anonymous sign-in)
- Secure session management
- Automatic profile creation

## 🚀 Usage

### In Flutter Code:

```dart
// Initialize Supabase
await SupabaseConfig.initialize();

// Access service
final supabaseService = SupabaseService();
supabaseService.initialize();

// Get current user
final user = supabaseService.currentUser;
if (user != null) {
  // User is logged in
}

// Get tasks
final tasks = await supabaseService.getTasks(user.id);

// Create task
final newTask = TaskModel.create(
  userId: user.id,
  title: 'My Task',
  description: 'Task description',
  priority: TaskPriority.high,
);
await supabaseService.createTask(newTask);
```

## 📦 Available Commands

### Via SupabaseService:
- `signUp(email, password, username)`
- `signIn(email, password)`
- `signInAnonymously()`
- `signOut()`
- `getTasks(userId)`
- `createTask(task)`
- `updateTask(task)`
- `deleteTask(taskId)`
- `completeTask(taskId)`
- `getUserStats(userId)`
- `updateUserStats(stats)`
- `addUserXP(userId, xp)`
- `updateUserStreak(userId)`

## 🧪 Testing

### Create Test User:
1. Open the app
2. Click "Sign Up"
3. Enter test credentials:
   - Email: test@example.com
   - Password: testpass123
   - Username: TestUser

### Verify Data:
1. In Supabase dashboard, go to "Table Editor"
2. Select "tasks" table
3. Verify your test data appears
4. Check "user_stats" table for user profile

## 🐛 Troubleshooting

### Common Issues:

**1. "Invalid API Key" Error**
- Verify your `SUPABASE_URL` and `SUPABASE_ANON_KEY`
- Check they match exactly (no extra spaces)

**2. "Row Level Security" Error**
- Verify RLS policies are set up correctly
- Check user is authenticated

**3. "Table not found" Error**
- Verify schema was created successfully
- Check table names match exactly

**4. Real-time not working**
- Check RLS policies allow access
- Verify user is authenticated

### Debug Steps:
1. Check Supabase logs (Dashboard → Logs)
2. Enable Flutter debug logging:
   ```dart
   Supabase.instance.client.onAuthStateChange.listen((data) {
     print('Auth event: ${data.event}');
   });
   ```
3. Test API manually via Supabase REST API

## 📚 Resources

- [Supabase Flutter Documentation](https://supabase.com/docs/reference/dart)
- [Supabase Auth Guide](https://supabase.com/docs/guides/auth)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Real-time Subscriptions](https://supabase.com/docs/guides/realtime)

## 🔐 Security Best Practices

1. **Never commit API keys** to version control
2. **Use environment variables** for sensitive data
3. **Enable RLS** on all tables
4. **Validate user input** on both client and server
5. **Use HTTPS** in production
6. **Regular backups** (Supabase Pro feature)

## 💡 Pro Tips

1. **Use indexes** for frequently queried fields
2. **Monitor performance** via Supabase Dashboard
3. **Set up alerts** for database usage
4. **Regular schema migrations** for changes
5. **Test with large datasets** early
6. **Use Supabase CLI** for local development

## 📞 Support

- Supabase Discord: https://discord.supabase.com
- GitHub Issues: https://github.com/supabase/supabase-flutter
- Email: support@supabase.com

---

**Happy Coding! 🎉**

Generated for Gamified Task Management App
