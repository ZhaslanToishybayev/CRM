/// App Router Configuration
/// Educational Project - Gamified Task Management App
/// Task 2.5: Navigation & Routing

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../screens/navigation/login_screen.dart';
import '../../screens/navigation/home_screen.dart';
import '../../screens/navigation/profile_screen.dart';
import '../../screens/navigation/settings_screen.dart';

/// Enum for navigation destinations
enum AppRoute {
  login,
  home,
  profile,
  settings,
}

/// App Router class
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      // Login Screen
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Home Screen (Tasks)
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // Profile Screen
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      // Settings Screen
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );

  /// Navigate to login screen
  static void goToLogin(BuildContext context) {
    context.go('/login');
  }

  /// Navigate to home screen
  static void goToHome(BuildContext context) {
    context.go('/home');
  }

  /// Navigate to profile screen
  static void goToProfile(BuildContext context) {
    context.go('/profile');
  }

  /// Navigate to settings screen
  static void goToSettings(BuildContext context) {
    context.go('/settings');
  }

  /// Push to profile screen (keeps current in stack)
  static void pushToProfile(BuildContext context) {
    context.push('/profile');
  }

  /// Push to settings screen (keeps current in stack)
  static void pushToSettings(BuildContext context) {
    context.push('/settings');
  }
}
