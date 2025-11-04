/// App Constants
/// Educational Project - Gamified Task Management App
///
/// This file contains all application constants including:
/// - API endpoints
/// - App configuration
/// - Gamification rules
/// - UI constants

import 'dart:math' as math;

class AppConstants {
  AppConstants._();

  // ==========================================
  // APP CONFIGURATION
  // ==========================================

  static const String appName = 'Gamified Tasks';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Educational Gamified Task Management App';

  // ==========================================
  // SUPABASE CONFIGURATION
  // ==========================================

  /// Supabase URL - Replace with your project URL
  /// Get from: https://supabase.com/dashboard/project/[YOUR_PROJECT]/settings/api
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';

  /// Supabase Anon Key - Replace with your anon key
  /// Get from: https://supabase.com/dashboard/project/[YOUR_PROJECT]/settings/api
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  // ==========================================
  // GAMIFICATION CONSTANTS
  // ==========================================

  /// XP values for different task priorities
  static const Map<String, int> taskPriorityXP = {
    'low': 10,
    'medium': 25,
    'high': 40,
    'urgent': 50,
  };

  /// XP multiplier for on-time completion
  static const double onTimeBonusMultiplier = 1.5;

  /// Level calculation formula
  /// Level = floor(sqrt(totalXP / 100))
  static int calculateLevel(int totalXP) {
    if (totalXP <= 0) return 1;
    return math.sqrt(totalXP / 100).floor();
  }

  /// XP needed for next level
  static int xpNeededForLevel(int currentLevel) {
    return (currentLevel + 1) * (currentLevel + 1) * 100;
  }

  /// XP needed from current level
  static int xpToNextLevel(int currentLevel, int currentXP) {
    final currentLevelXP = currentLevel * currentLevel * 100;
    final nextLevelXP = (currentLevel + 1) * (currentLevel + 1) * 100;
    return nextLevelXP - currentXP + currentLevelXP;
  }

  // ==========================================
  // TASK CONSTANTS
  // ==========================================

  static const List<String> taskPriorities = [
    'low',
    'medium',
    'high',
    'urgent',
  ];

  static const List<String> taskStatuses = [
    'pending',
    'completed',
  ];

  static const int maxTasksPerDay = 50;

  // ==========================================
  // ACHIEVEMENT CONSTANTS
  // ==========================================

  /// Achievement categories
  static const List<String> achievementCategories = [
    'streaks',
    'completions',
    'speed',
    'social',
    'special',
  ];

  /// Achievement badge IDs
  static const Map<String, List<String>> achievementBadges = {
    'streaks': [
      'streak_beginner',      // 3 days
      'streak_regular',       // 7 days
      'streak_pro',           // 14 days
      'streak_master',        // 30 days
      'streak_legend',        // 100 days
    ],
    'completions': [
      'first_task',           // First task completed
      'ten_tasks',            // 10 tasks
      'century',              // 100 tasks
      'millennium',           // 1000 tasks
      'marathon',             // 5000 tasks
    ],
    'speed': [
      'speed_demon',          // Complete 5 tasks in one hour
      'lightning_fast',       // Complete task within 5 minutes
      'early_bird',           // Complete task before 9 AM
      'night_owl',            // Complete task after 10 PM
    ],
    'special': [
      'perfect_week',         // 7 days, all tasks completed
      'comeback',             // Return after 7+ days away
      'goal_crusher',         // Complete 10 tasks in a day
    ],
  };

  // ==========================================
  // UI CONSTANTS
  // ==========================================

  /// Animation durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  /// Border radius values
  static const double smallBorderRadius = 8.0;
  static const double mediumBorderRadius = 12.0;
  static const double largeBorderRadius = 16.0;
  static const double extraLargeBorderRadius = 24.0;

  /// Spacing values (8px grid system)
  static const double xsSpacing = 4.0;
  static const double smSpacing = 8.0;
  static const double mdSpacing = 16.0;
  static const double lgSpacing = 24.0;
  static const double xlSpacing = 32.0;
  static const double xxlSpacing = 48.0;

  /// Elevation values
  static const double smallElevation = 2.0;
  static const double mediumElevation = 4.0;
  static const double largeElevation = 8.0;

  // ==========================================
  // DATE & TIME CONSTANTS
  // ==========================================

  static const int maxStreakFreezeDays = 3;

  // ==========================================
  // VALIDATION CONSTANTS
  // ==========================================

  static const int minTaskTitleLength = 3;
  static const int maxTaskTitleLength = 100;
  static const int minTaskDescriptionLength = 0;
  static const int maxTaskDescriptionLength = 500;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;

  // ==========================================
  // API CONSTANTS
  // ==========================================

  static const Duration apiTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;

  // ==========================================
  // STORAGE CONSTANTS
  // ==========================================

  static const String hiveBoxName = 'gamified_tasks_box';
  static const String cachedTasksKey = 'cached_tasks';
  static const String cachedUserKey = 'cached_user';

  // ==========================================
  // DEBUG CONSTANTS
  // ==========================================

  static const bool isDebugMode = true;
  static const bool enableLogging = true;
  static const bool enableDevTools = true;

  // ==========================================
  // LEADERBOARD CONSTANTS
  // ==========================================

  static const int leaderboardLimit = 100;
  static const int friendsLeaderboardLimit = 50;

  // ==========================================
  // NOTIFICATION CONSTANTS
  // ==========================================

  static const String taskReminderChannelId = 'task_reminders';
  static const String achievementNotificationChannelId = 'achievements';
  static const String streakReminderChannelId = 'streak_reminders';

  // ==========================================
  // ASSET PATHS
  // ==========================================

  static const String imagesPath = 'assets/images/';
  static const String iconsPath = 'assets/icons/';
  static const String animationsPath = 'assets/animations/';
  static const String fontsPath = 'assets/fonts/';

  // ==========================================
  // APP LIMITS
  // ==========================================

  static const int maxOfflineTasks = 1000;
  static const int maxCachedDays = 30;
  static const int maxProfilePhotoSize = 5 * 1024 * 1024; // 5MB

  // ==========================================
  // ERROR CODES
  // ==========================================

  static const String errorNetwork = 'NETWORK_ERROR';
  static const String errorAuth = 'AUTH_ERROR';
  static const String errorDatabase = 'DATABASE_ERROR';
  static const String errorValidation = 'VALIDATION_ERROR';
  static const String errorUnknown = 'UNKNOWN_ERROR';

  // ==========================================
  // ANALYTICS CONSTANTS
  // ==========================================

  static const String analyticsTaskCompleted = 'task_completed';
  static const String analyticsAchievementUnlocked = 'achievement_unlocked';
  static const String analyticsLevelUp = 'level_up';
  static const String analyticsStreakUpdated = 'streak_updated';

  // ==========================================
  // THEME CONSTANTS
  // ==========================================

  /// Color names for easy reference
  static const String colorPrimary = 'primary';
  static const String colorSecondary = 'secondary';
  static const String colorAccent = 'accent';
  static const String colorBackground = 'background';
  static const String colorSurface = 'surface';
  static const String colorError = 'error';
  static const String colorXP = 'xp';
  static const String colorLevel = 'level';
  static const String colorStreak = 'streak';

  // ==========================================
  // LOCALIZATION KEYS
  // ==========================================

  static const String localeKeyEn = 'en';
  static const String localeKeyEs = 'es';
  static const String localeKeyFr = 'fr';
  static const String localeKeyDe = 'de';

  // ==========================================
  // PREFERENCES KEYS
  // ==========================================

  static const String prefDarkMode = 'pref_dark_mode';
  static const String prefNotifications = 'pref_notifications';
  static const String prefStreakReminders = 'pref_streak_reminders';
  static const String prefLanguage = 'pref_language';
  static const String prefOnboardingCompleted = 'pref_onboarding_completed';
}
