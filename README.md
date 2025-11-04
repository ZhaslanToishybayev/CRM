# CRM - Customer Relationship Management System

A comprehensive CRM system with gamification features for enhanced employee engagement and productivity.

## 📱 Applications

### Gamified Task App (`/gamified_app/`)
A Flutter-based mobile application that gamifies task management and team collaboration.

**Key Features:**
- 🎮 Gamification system with XP and levels
- 🏆 Achievements and rewards
- 👥 Team management
- 📊 Task tracking with corporate incentives
- ☁️ Supabase backend integration

**Tech Stack:**
- Flutter (Mobile & Web)
- Dart
- Supabase (Database & Auth)
- Freezed (Code generation)
- Json Annotation

**Getting Started:**
```bash
cd gamified_app
flutter pub get
flutter run
```

**Configuration:**
1. Copy `.env.example` to `.env`
2. Update Supabase credentials
3. Run SQL setup scripts from `/database/` folder

**Documentation:**
- `PROJECT_COMPLETION.md` - Complete project overview
- `DEPLOYMENT_GUIDE.md` - Deployment instructions
- `QUICK_START_SUPABASE.md` - Supabase setup guide

## 📁 Project Structure

```
/gamified_app/          # Flutter application
  /lib/                # Source code
    /features/         # Feature modules
      /achievements/   # Achievement system
      /gamification/   # Core gamification
      /teams/          # Team management
      /tasks/          # Task management
  /android/            # Android specific code
  /ios/                # iOS specific code
  /web/                # Web version
  /test/               # Test files
  *.sql                # Database setup scripts
```

## 🚀 Quick Start

### Gamified Task App

1. **Install Flutter:**
   ```bash
   # Follow instructions at https://flutter.dev/docs/get-started/install
   ```

2. **Setup project:**
   ```bash
   cd gamified_app
   flutter pub get
   ```

3. **Configure Supabase:**
   - Copy `.env.example` to `.env`
   - Add your Supabase credentials
   - Run database setup:
     ```bash
     # Execute SQL scripts in order:
     # 1. RPC_SETUP_FINAL.sql
     # 2. fix_schema_v2.sql
     ```

4. **Run app:**
   ```bash
   flutter run
   ```

## 📋 Features

### Gamified Task App
- ✅ XP (Experience Points) System
- ✅ Level progression
- ✅ Achievement badges
- ✅ Team collaboration
- ✅ Corporate gamification
- ✅ Real-time updates via Supabase
- ✅ Cross-platform (iOS, Android, Web)

## 🛠️ Development

### Tech Stack
- **Frontend:** Flutter, Dart
- **Backend:** Supabase (PostgreSQL, Auth, Realtime)
- **State Management:** Provider pattern
- **Code Generation:** Freezed, JSON Annotation
- **CI/CD:** GitHub Actions

### Project Status
See individual application folders for detailed documentation:
- `/gamified_app/PROJECT_COMPLETION.md`
- `/gamified_app/TASK_STATUS.md`

## 📄 Documentation

All project documentation is included in this repository:
- Architecture decisions
- Setup guides
- API documentation
- Deployment instructions

## 🤝 Contributing

1. Clone the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📝 License

Proprietary - All rights reserved

## 🔗 Links

- **GitHub Repository:** https://github.com/ZhaslanToishybayev/CRM

## 📞 Support

For issues and questions, please refer to the documentation in each application folder or create an issue in the repository.

---

**Author:** Zhaslan Toishybayev
**Last Updated:** November 2025
