/// Settings Screen
/// Educational Project - Gamified Task Management App
/// Task 2.5: Navigation & Routing

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers.dart';
import '../../../core/router/app_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => AppRouter.goToHome(context),
        ),
      ),
      body: ListView(
        children: [
          // Account Section
          if (isLoggedIn) ...[
            const _SectionHeader(title: 'Account'),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              subtitle: const Text('View your profile information'),
              onTap: () => AppRouter.pushToProfile(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign Out'),
              subtitle: const Text('Sign out of your account'),
              onTap: () {
                ref.read(authProvider.notifier).logout();
                AppRouter.goToLogin(context);
              },
            ),
          ] else ...[
            const _SectionHeader(title: 'Account'),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Sign In'),
              subtitle: const Text('Sign in to your account'),
              onTap: () => AppRouter.goToLogin(context),
            ),
          ],

          const Divider(),

          // App Section
          const _SectionHeader(title: 'App'),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            subtitle: Text('Gamified Task Management v1.0'),
          ),
          ListTile(
            leading: const Icon(Icons.task_alt),
            title: const Text('Task Management'),
            subtitle: const Text('Manage your daily tasks'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => AppRouter.goToHome(context),
          ),

          const Divider(),

          // More Section
          const _SectionHeader(title: 'More'),
          const ListTile(
            leading: Icon(Icons.star, color: Colors.amber),
            title: Text('Rate App'),
            subtitle: const Text('Rate us on the store'),
          ),
          const ListTile(
            leading: Icon(Icons.share),
            title: Text('Share App'),
            subtitle: const Text('Share with friends'),
          ),
          const ListTile(
            leading: Icon(Icons.help),
            title: Text('Help & Support'),
            subtitle: const Text('Get help and support'),
          ),

          const SizedBox(height: 24),

          // Version Info
          const Center(
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              '© 2025 Gamified Tasks',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
