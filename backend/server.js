const express = require('express');
const { MongoClient, ObjectId } = require('mongodb');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
const PORT = 3002;
const MONGODB_URI = process.env.MONGODB_URI || 'mongodb://localhost:27017/gamified_tasks';

// Middleware
app.use(cors({
  origin: ['http://localhost:8085', 'http://127.0.0.1:8085', 'http://localhost:8080', 'http://127.0.0.1:8080'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));
app.use(bodyParser.json());

let db;
let tasksCollection;
let userStatsCollection;

// Connect to MongoDB
async function connectToMongoDB() {
  try {
    const client = await MongoClient.connect(MONGODB_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    db = client.db();
    tasksCollection = db.collection('tasks');
    userStatsCollection = db.collection('user_stats');
    console.log('✅ Connected to MongoDB');
  } catch (error) {
    console.error('❌ MongoDB connection error:', error);
    process.exit(1);
  }
}

// ====================
// TASKS API
// ====================

// Get all tasks
app.get('/api/tasks', async (req, res) => {
  try {
    const tasks = await tasksCollection.find({}).sort({ created_at: -1 }).toArray();
    res.json(tasks);
  } catch (error) {
    console.error('Error fetching tasks:', error);
    res.status(500).json({ error: 'Failed to fetch tasks' });
  }
});

// Create task
app.post('/api/tasks', async (req, res) => {
  try {
    const task = {
      ...req.body,
      created_at: new Date(),
      updated_at: new Date(),
    };
    const result = await tasksCollection.insertOne(task);
    const createdTask = await tasksCollection.findOne({ _id: result.insertedId });
    res.json(createdTask);
  } catch (error) {
    console.error('Error creating task:', error);
    res.status(500).json({ error: 'Failed to create task' });
  }
});

// Update task
app.put('/api/tasks/:id', async (req, res) => {
  try {
    const id = req.params.id;
    const update = {
      ...req.body,
      updated_at: new Date(),
    };
    await tasksCollection.updateOne(
      { _id: new ObjectId(id) },
      { $set: update }
    );
    const updatedTask = await tasksCollection.findOne({ _id: new ObjectId(id) });
    res.json(updatedTask);
  } catch (error) {
    console.error('Error updating task:', error);
    res.status(500).json({ error: 'Failed to update task' });
  }
});

// Delete task
app.delete('/api/tasks/:id', async (req, res) => {
  try {
    const id = req.params.id;
    await tasksCollection.deleteOne({ _id: new ObjectId(id) });
    res.json({ message: 'Task deleted successfully' });
  } catch (error) {
    console.error('Error deleting task:', error);
    res.status(500).json({ error: 'Failed to delete task' });
  }
});

// ====================
// USER STATS API
// ====================

// Get user stats
app.get('/api/user-stats/:userId', async (req, res) => {
  try {
    const userId = req.params.userId;
    let stats = await userStatsCollection.findOne({ userId: userId });

    // If no stats exist, create default
    if (!stats) {
      stats = {
        userId: userId,
        username: 'User',
        email: 'user@example.com',
        xp: 0,
        level: 1,
        streak: 0,
        lastTaskDate: null,
        created_at: new Date(),
        updated_at: new Date(),
      };
      await userStatsCollection.insertOne(stats);
    }

    res.json(stats);
  } catch (error) {
    console.error('Error fetching user stats:', error);
    res.status(500).json({ error: 'Failed to fetch user stats' });
  }
});

// Update user stats
app.put('/api/user-stats/:userId', async (req, res) => {
  try {
    const userId = req.params.userId;
    const update = {
      ...req.body,
      updated_at: new Date(),
    };
    await userStatsCollection.updateOne(
      { userId: userId },
      { $set: update, $setOnInsert: { created_at: new Date() } },
      { upsert: true }
    );
    const updatedStats = await userStatsCollection.findOne({ userId: userId });
    res.json(updatedStats);
  } catch (error) {
    console.error('Error updating user stats:', error);
    res.status(500).json({ error: 'Failed to update user stats' });
  }
});

// ====================
// AUTH API (Mock)
// ====================

// Simple mock authentication
app.post('/api/auth/login', async (req, res) => {
  const { email, password } = req.body;

  // Mock user - in real app, verify credentials
  const user = {
    id: 'mock-user-id-' + Date.now(),
    email: email,
    username: email.split('@')[0],
    created_at: new Date(),
  };

  res.json({
    user: user,
    session: {
      access_token: 'mock-token-' + Date.now(),
      expires_at: Date.now() + 3600000, // 1 hour
    },
  });
});

// Sign up
app.post('/api/auth/signup', async (req, res) => {
  const { email, password, username } = req.body;

  const user = {
    id: 'user-' + Date.now(),
    email: email,
    username: username || email.split('@')[0],
    created_at: new Date(),
  };

  res.json({
    user: user,
    session: {
      access_token: 'mock-token-' + Date.now(),
      expires_at: Date.now() + 3600000,
    },
  });
});

// ====================
// SEED SAMPLE DATA
// ====================

app.post('/api/seed', async (req, res) => {
  try {
    // Clear existing data
    await tasksCollection.deleteMany({});
    await userStatsCollection.deleteMany({});

    // Add sample task
    const sampleTask = {
      userId: 'demo-user',
      title: 'Добро пожаловать в MongoDB!',
      description: 'Это ваш первый шаг к работе с реальной базой данных MongoDB',
      category: 'General',
      priority: 2,
      status: 'pending',
      created_at: new Date(),
      updated_at: new Date(),
    };
    await tasksCollection.insertOne(sampleTask);

    // Add sample user stats
    const sampleStats = {
      userId: 'demo-user',
      username: 'Demo User',
      email: 'demo@example.com',
      xp: 0,
      level: 1,
      streak: 0,
      lastTaskDate: null,
      created_at: new Date(),
      updated_at: new Date(),
    };
    await userStatsCollection.insertOne(sampleStats);

    res.json({ message: 'Sample data seeded successfully' });
  } catch (error) {
    console.error('Error seeding data:', error);
    res.status(500).json({ error: 'Failed to seed data' });
  }
});

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'OK', database: db ? 'Connected' : 'Disconnected' });
});

// Start server
async function startServer() {
  await connectToMongoDB();
  app.listen(PORT, () => {
    console.log(`🚀 MongoDB API Server running on http://localhost:${PORT}`);
    console.log(`📊 MongoDB URI: ${MONGODB_URI}`);
    console.log(`\n📝 Available endpoints:`);
    console.log(`  GET    /api/tasks`);
    console.log(`  POST   /api/tasks`);
    console.log(`  PUT    /api/tasks/:id`);
    console.log(`  DELETE /api/tasks/:id`);
    console.log(`  GET    /api/user-stats/:userId`);
    console.log(`  PUT    /api/user-stats/:userId`);
    console.log(`  POST   /api/seed`);
    console.log(`  GET    /api/health\n`);
  });
}

startServer().catch(console.error);
