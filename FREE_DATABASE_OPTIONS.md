# 🗄️ FREE Database Options for Your Project

## 📊 **OVERVIEW: 100% Free Databases**

| Database | Type | Storage | Best For |
|----------|------|---------|----------|
| **Supabase** | PostgreSQL | 500MB-2GB free | Full-featured (best alternative to Firebase) |
| **PocketBase** | SQLite | Unlimited | Self-hosted, privacy-focused |
| **Appwrite** | MongoDB | 1GB free | Modern NoSQL alternative |
| **Firebase** | Firestore | 1GB free | Google's solution (you know this) |
| **Convex** | Custom | 1GB free | Real-time reactive database |
| **Rowy** | Firestore | Free tier | Visual database management |

---

## 🏆 **TOP RECOMMENDATIONS**

### **Option 1: Supabase (BEST ALTERNATIVE TO FIREBASE)**

**What is Supabase?**
Open-source Firebase alternative with PostgreSQL backend.

#### **Free Tier Limits**
```
✓ Database: 500MB storage
✓ API Requests: 50,000/month
✓ Realtime: 2 channels
✓ Auth: 50,000 monthly active users
✓ Storage: 1GB
✓ Bandwidth: 2GB/month
```

#### **Why Choose Supabase?**
✅ **PostgreSQL** (industry standard, ACID compliant)
✅ **Real-time subscriptions** (like Firebase)
✅ **Row Level Security** (built-in auth)
✅ **Auto-generated APIs** (REST + GraphQL)
✅ **Dashboard** (visual database management)
✅ **Flutter SDK** (excellent support)
✅ **Edge Functions** (serverless computing)
✅ **NoSQL-friendly** (JSONB support)
✅ **Open source** (self-hostable if needed)

#### **Perfect for Gamified Task App**
```dart
// Supabase Flutter Example
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

// Real-time task updates
supabase
  .from('tasks')
  .stream(primaryKey: ['id'])
  .eq('user_id', user.id)
  .listen((tasks) {
    // Update UI with real-time data
  });

// Insert new task
await supabase.from('tasks').insert({
  'title': 'Complete presentation',
  'xp': 25,
  'user_id': user.id,
});

// Get leaderboard
final leaderboard = await supabase
  .from('users')
  .select('name, total_xp, level')
  .order('total_xp', ascending: false)
  .limit(10);
```

#### **Gamification Features**
✅ **PostgreSQL JSON** - Store achievements as JSON
✅ **Real-time** - Live streak updates
✅ **Functions** - Calculate XP server-side
✅ **Triggers** - Award achievements automatically
✅ **Views** - Pre-computed leaderboards

#### **Cost: FREE** (Perfect for MVP!)

---

### **Option 2: PocketBase (MOST PRIVATE)**

**What is PocketBase?**
Self-hosted SQLite database with real-time features. Data stays on YOUR server.

#### **Free Tier**
```
✓ Storage: Unlimited (your server)
✓ Users: Unlimited
✓ Real-time: Unlimited
✓ API: Unlimited
✓ Auth: Unlimited
```

#### **Why Choose PocketBase?**
✅ **SQLite** (lightweight, fast)
✅ **Self-hosted** (total privacy)
✅ **Real-time** (WebSocket support)
✅ **Admin dashboard** (built-in UI)
✅ **Flutter SDK** (official)
✅ **Go backend** (blazing fast)
✅ **File uploads** (built-in)
✅ **Zero configuration** (works out of box)
✅ **Offline-first** (sync when online)

#### **Perfect for Gamified Task App**
```dart
// PocketBase Flutter Example
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('https://your-pocketbase.app');

// Real-time subscriptions
pb.collection('tasks').subscribe('*', (e) {
  // Handle real-time updates
});

// Create task
await pb.collection('tasks').create({
  'title': 'Complete presentation',
  'xp': 25,
  'user': pb.authStore.model.id,
  'status': 'pending',
});

// Get achievements
final achievements = await pb.collection('achievements').getFullList(
  filter: 'users.id ?= "${user.id}"',
);
```

#### **Deployment Options**
- **Free hosting**: Railway, Render, Fly.io
- **VPS**: DigitalOcean ($4/month)
- **Self-host**: Your own server

#### **Cost: FREE** (hosting varies)

---

### **Option 3: Appwrite (MODERN NOSQL)**

**What is Appwrite?**
Open-source backend-as-a-service with MongoDB.

#### **Free Tier**
```
✓ Database: 1GB
✓ Collections: Unlimited
✓ Users: Unlimited
✓ Storage: 1GB
✓ Bandwidth: 100GB/month
```

#### **Why Choose Appwrite?**
✅ **MongoDB** (flexible NoSQL)
✅ **Flutter SDK** (official)
✅ **Real-time** (WebSocket)
✅ **Auth** (multiple providers)
✅ **Functions** (Deno runtime)
✅ **Storage** (file uploads)
✅ **Teams & Permissions** (built-in)
✅ **GraphQL** (optional)

#### **Perfect for Gamified Task App**
```dart
// Appwrite Flutter Example
import 'package:appwrite/appwrite.dart';

final client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('YOUR_PROJECT_ID');

// Create document
final task = await databases.createDocument(
  databaseId: 'main',
  collectionId: 'tasks',
  documentId: ID.unique(),
  data: {
    'title': 'Complete presentation',
    'xp': 25,
    'user_id': userId,
    'status': 'pending',
  },
);

// Real-time updates
final subscription = realtime.subscribe(
  channels: ['collections.tasks.documents'],
);
subscription.stream.listen((event) {
  // Handle real-time task updates
});
```

#### **Cost: FREE** (Perfect for MVP!)

---

### **Option 4: Convex (REACTIVE DATABASE)**

**What is Convex?**
Custom reactive database with real-time sync.

#### **Free Tier**
```
✓ Storage: 1GB
✓ Bandwidth: 5GB/month
✓ Functions: 100,000 calls/month
✓ Realtime: Unlimited
```

#### **Why Choose Convex?**
✅ **Reactive** (automatic UI updates)
✅ **Real-time** (instant sync)
✅ **Type-safe** (TypeScript first)
✅ **Functions** (serverless)
✅ **Queries** (optimized)
✅ **Transactions** (ACID compliant)

#### **Perfect for Gamified Task App**
```dart
// Convex Flutter Example
import 'package:convex_flutter/convex_flutter.dart';

final convex = ConvexClient('YOUR_CONVEX_URL');

// Automatic reactive updates
final tasks = await convex.query('tasks:list');

// Mutations update UI automatically
await convex.mutation('tasks:create', {
  'title': 'Complete presentation',
  'xp': 25,
});

// Real-time leaderboard
final leaderboard = await convex.query('leaderboard:top10');
```

#### **Cost: FREE** (Generous limits!)

---

## 📊 **COMPARISON TABLE**

| Feature | Supabase | PocketBase | Appwrite | Firebase |
|---------|----------|------------|----------|----------|
| **Database** | PostgreSQL | SQLite | MongoDB | Firestore |
| **Real-time** | ✅ | ✅ | ✅ | ✅ |
| **Auth** | ✅ | ✅ | ✅ | ✅ |
| **Storage** | ✅ | ✅ | ✅ | ✅ |
| **Functions** | ✅ Edge | ✅ HTTP | ✅ Deno | ✅ Cloud |
| **Type Safety** | ✅ | ✅ | ✅ | ⚠️ |
| **Self-hosted** | ✅ | ✅ | ✅ | ❌ |
| **Free Tier** | 500MB DB | Unlimited | 1GB DB | 1GB DB |
| **Flutter SDK** | ✅ | ✅ | ✅ | ✅ |
| **Dashboard** | ✅ | ✅ | ✅ | ✅ |
| **Open Source** | ✅ | ✅ | ✅ | ❌ |

---

## 🎯 **MY RECOMMENDATIONS**

### **For Beginners: Supabase**
```
✅ Easiest to use (like Firebase)
✅ Great documentation
✅ Visual dashboard
✅ PostgreSQL power
✅ Free tier generous
```

### **For Privacy: PocketBase**
```
✅ Self-hosted
✅ Data stays with you
✅ SQLite (simple)
✅ Zero config
✅ Total control
```

### **For Flexibility: Appwrite**
```
✅ MongoDB flexibility
✅ Modern features
✅ Multiple auth providers
✅ Good free tier
✅ Open source
```

### **For Reactivity: Convex**
```
✅ Automatic updates
✅ Type-safe
✅ Fast queries
✅ Modern approach
✅ Good free tier
```

---

## 💻 **FLUTTER INTEGRATION EXAMPLES**

### **Supabase Setup**
```yaml
# pubspec.yaml
dependencies:
  supabase_flutter: ^1.10.25
  riverpod: ^2.4.9
  hive: ^2.2.3
```

```dart
// lib/core/database/supabase_provider.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

@riverpod
class TaskNotifier extends _$TaskNotifier {
  @override
  Future<List<Task>> build() async {
    final supabase = ref.read(supabaseClientProvider);
    final user = supabase.auth.currentUser;

    final data = await supabase
        .from('tasks')
        .select()
        .eq('user_id', user?.id ?? '');

    return data.map((e) => Task.fromJson(e)).toList();
  }

  Future<void> addTask(Task task) async {
    final supabase = ref.read(supabaseClientProvider);

    await supabase.from('tasks').insert(task.toJson());

    // Invalidate and refetch
    ref.invalidate(taskListProvider);
  }
}
```

### **PocketBase Setup**
```yaml
# pubspec.yaml
dependencies:
  pocketbase: ^0.18.0
  hive: ^2.2.3
```

```dart
// lib/core/database/pocketbase_provider.dart
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final pocketBaseProvider = Provider<PocketBase>((ref) {
  return PocketBase('https://your-pocketbase.app');
});

@riverpod
class AchievementNotifier extends _$AchievementNotifier {
  @override
  Future<List<Achievement>> build() async {
    final pb = ref.read(pocketBaseProvider);
    final user = pb.authStore.model;

    final records = await pb.collection('achievements').getFullList(
      filter: 'users.id ?= "${user.id}"',
    );

    return records.map((e) => Achievement.fromJson(e.toMap())).toList();
  }
}
```

---

## 🏗️ **DATABASE SCHEMA EXAMPLES**

### **For Supabase (PostgreSQL)**

```sql
-- Users table (extends auth.users)
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users PRIMARY KEY,
  username TEXT UNIQUE,
  full_name TEXT,
  avatar_url TEXT,
  total_xp INTEGER DEFAULT 0,
  current_level INTEGER DEFAULT 1,
  streak_count INTEGER DEFAULT 0,
  last_task_date DATE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tasks table
CREATE TABLE public.tasks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  xp INTEGER NOT NULL DEFAULT 10,
  priority TEXT CHECK (priority IN ('low', 'medium', 'high', 'urgent')) DEFAULT 'medium',
  status TEXT CHECK (status IN ('pending', 'completed')) DEFAULT 'pending',
  due_date TIMESTAMP WITH TIME ZONE,
  category TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Achievements table
CREATE TABLE public.achievements (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  badge_id TEXT NOT NULL,
  badge_name TEXT NOT NULL,
  badge_category TEXT NOT NULL,
  unlocked_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Leaderboard view
CREATE VIEW public.leaderboard AS
SELECT
  username,
  full_name,
  total_xp,
  current_level,
  RANK() OVER (ORDER BY total_xp DESC) as rank
FROM public.profiles
ORDER BY total_xp DESC;
```

### **For PocketBase (Collections)**

```
Collection: profiles
{
  "id": "...",
  "username": "john_doe",
  "full_name": "John Doe",
  "avatar": "file_id",
  "total_xp": 150,
  "current_level": 2,
  "streak_count": 5,
  "last_task_date": "2025-10-31"
}

Collection: tasks
{
  "id": "...",
  "title": "Complete presentation",
  "description": "Finish slides for meeting",
  "xp": 25,
  "priority": "high",
  "status": "pending",
  "due_date": "2025-11-01T10:00:00Z",
  "category": "work",
  "user": "relation_to_profiles"
}

Collection: achievements
{
  "id": "...",
  "badge_id": "streak_week",
  "badge_name": "Weekly Streak",
  "badge_category": "streaks",
  "unlocked_at": "2025-10-31T10:00:00Z",
  "user": "relation_to_profiles"
}
```

---

## 🚀 **DEPLOYMENT OPTIONS (FREE)**

### **Supabase Hosting**
- **Free**: 500MB database
- **Pro**: $25/month (8GB database)
- **Deploy**: supabase.com

### **PocketBase Hosting**
- **Railway**: Free tier (512MB RAM)
- **Render**: Free tier (512MB RAM)
- **Fly.io**: Free tier (2 apps)
- **Your VPS**: Any provider ($4-10/month)

### **Appwrite Hosting**
- **Cloud**: Free tier
- **Self-hosted**: Docker

### **Convex Hosting**
- **Cloud**: Free tier (1GB)
- **Deploy**: convex.dev

---

## 💡 **GAMIFICATION FEATURES WITH EACH DB**

### **Supabase: PostgreSQL Power**
```sql
-- Trigger to award XP on task completion
CREATE OR REPLACE FUNCTION award_xp()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status = 'completed' AND OLD.status = 'pending' THEN
    UPDATE profiles
    SET total_xp = total_xp + NEW.xp
    WHERE id = NEW.user_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER task_completed
  AFTER UPDATE ON tasks
  FOR EACH ROW
  EXECUTE FUNCTION award_xp();
```

### **PocketBase: Real-time Achievements**
```dart
// Listen for task completion
pb.collection('tasks').subscribe('*', (e) async {
  if (e.action == 'update' && e.record?.data['status'] == 'completed') {
    // Check for streak achievements
    await checkStreakAchievements(userId);

    // Award achievement badge
    await pb.collection('achievements').create({
      'badge_id': 'task_completed',
      'user': userId,
    });
  }
});
```

---

## 📱 **OFFLINE SUPPORT**

All databases work great with **Hive** for offline caching:

```dart
// Offline-first pattern
class TaskRepository {
  final SupabaseClient supabase;
  final HiveRepository hive;

  Future<List<Task>> getTasks() async {
    try {
      // Try network first
      final networkTasks = await supabase.from('tasks').select();

      // Cache to Hive
      await hive.saveTasks(networkTasks);

      return networkTasks;
    } catch (e) {
      // Fallback to offline
      return hive.getCachedTasks();
    }
  }
}
```

---

## 🎯 **FINAL RECOMMENDATION**

### **For Your Project: Supabase**

**Why?**
1. ✅ **Easiest migration** from Firebase
2. ✅ **PostgreSQL** (powerful, reliable)
3. ✅ **Excellent Flutter support**
4. ✅ **Great free tier** (500MB is enough!)
5. ✅ **Real-time** built-in
6. ✅ **Dashboard** for easy management
7. ✅ **Type safety** with generated types

### **Alternative: PocketBase**
If you want **total privacy** and don't mind self-hosting.

---

## 📊 **COST COMPARISON**

| Database | Free Tier | Paid Plan | Recommended For |
|----------|-----------|-----------|-----------------|
| **Supabase** | 500MB DB | $25/month | Most users |
| **PocketBase** | Unlimited* | $4/month VPS | Privacy-focused |
| **Appwrite** | 1GB DB | $15/month | NoSQL lovers |
| **Convex** | 1GB DB | $35/month | Reactive apps |
| **Firebase** | 1GB DB | $25/month | Google ecosystem |

**All 100% free to start!**

---

## 🚀 **READY TO CHOOSE?**

### **Which Database Do You Want?**
1. **Supabase** (PostgreSQL - Best overall)
2. **PocketBase** (SQLite - Most private)
3. **Appwrite** (MongoDB - Flexible)
4. **Convex** (Reactive - Modern)
5. **Stay with Firebase** (Firestore)

### **Just Say**
**"I want [Database Name]"**

**Example**: "I want Supabase"

**I'll integrate it immediately into the project!** 🎯
