/// App Router with GoRouter + Animations + Supabase
/// Educational Project - Gamified Task Management App

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers_supabase.dart';
import 'screens/login_screen.dart';
import 'screens/tasks_screen.dart';
import 'screens/profile_screen.dart';
import 'features/tasks/screens/task_detail_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(isAuthenticatedProvider);

  return GoRouter(
    initialLocation: authState ? '/tasks' : '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          child: const LoginScreen(),
          state: state,
        ),
      ),
      GoRoute(
        path: '/tasks',
        name: 'tasks',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          child: const TasksScreen(),
          state: state,
        ),
        routes: [
          GoRoute(
            path: 'detail/:taskId',
            name: 'taskDetail',
            pageBuilder: (context, state) {
              final taskId = state.pathParameters['taskId']!;
              return _buildPageWithAnimation(
                child: TaskDetailScreen(taskId: taskId),
                state: state,
              );
            },
          ),
          GoRoute(
            path: 'profile',
            name: 'profile',
            pageBuilder: (context, state) => _buildPageWithAnimation(
              child: const ProfileScreen(),
              state: state,
            ),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = ref.read(isAuthenticatedProvider);
      final isOnLogin = state.uri.path == '/login';

      if (!isLoggedIn && !isOnLogin) {
        return '/login';
      }

      if (isLoggedIn && isOnLogin) {
        return '/tasks';
      }

      return null;
    },
  );
});

Page<T> _buildPageWithAnimation<T>({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Slide transition
      const Offset begin = Offset(1.0, 0.0);
      const Offset end = Offset.zero;
      const Curve curve = Curves.easeInOut;

      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
