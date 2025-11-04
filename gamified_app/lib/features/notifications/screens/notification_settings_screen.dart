/// Notification Settings Screen
/// Allows users to configure notification preferences

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/notification_settings_model.dart';
import '../providers/notification_provider.dart';

class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends ConsumerState<NotificationSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(notificationSettingsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: ListView(
        children: [
          // General settings
          _buildSection(
            'General',
            [
              SwitchListTile(
                title: const Text('Push Notifications'),
                value: settings.pushEnabled,
                onChanged: ref
                    .read(notificationSettingsNotifierProvider.notifier)
                    .updatePushEnabled,
              ),
              SwitchListTile(
                title: const Text('Email Notifications'),
                value: settings.emailEnabled,
                onChanged: ref
                    .read(notificationSettingsNotifierProvider.notifier)
                    .updateEmailEnabled,
              ),
              SwitchListTile(
                title: const Text('In-App Notifications'),
                value: settings.inAppEnabled,
                onChanged: ref
                    .read(notificationSettingsNotifierProvider.notifier)
                    .updateInAppEnabled,
              ),
            ],
          ),
          // Notification types
          _buildSection(
            'Notification Types',
            NotificationType.values.map((type) {
              final isEnabled = settings.typeSettings[type] ?? false;
              return SwitchListTile(
                title: Text(_getNotificationTypeName(type)),
                value: isEnabled,
                onChanged: (value) {
                  ref
                      .read(notificationSettingsNotifierProvider.notifier)
                      .updateTypeSetting(type, value);
                },
              );
            }).toList(),
          ),
          // Quiet hours
          _buildSection(
            'Quiet Hours',
            [
              SwitchListTile(
                title: const Text('Enable Quiet Hours'),
                value: settings.quietHoursEnabled,
                onChanged: (value) {
                  ref
                      .read(notificationSettingsNotifierProvider.notifier)
                      .updateQuietHours(
                        enabled: value,
                        start: settings.quietHoursStart,
                        end: settings.quietHoursEnd,
                      );
                },
              ),
              if (settings.quietHoursEnabled) ...[
                ListTile(
                  title: const Text('Start Time'),
                  subtitle: Text(
                    settings.quietHoursStart?.toString() ?? 'Not set',
                  ),
                  trailing: const Icon(Icons.schedule),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                        settings.quietHoursStart ?? DateTime.now(),
                      ),
                    );
                    if (time != null) {
                      final dateTime = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        time.hour,
                        time.minute,
                      );
                      ref
                          .read(notificationSettingsNotifierProvider.notifier)
                          .updateQuietHours(
                            enabled: true,
                            start: dateTime,
                            end: settings.quietHoursEnd,
                          );
                    }
                  },
                ),
                ListTile(
                  title: const Text('End Time'),
                  subtitle: Text(
                    settings.quietHoursEnd?.toString() ?? 'Not set',
                  ),
                  trailing: const Icon(Icons.schedule),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                        settings.quietHoursEnd ?? DateTime.now(),
                      ),
                    );
                    if (time != null) {
                      final dateTime = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        time.hour,
                        time.minute,
                      );
                      ref
                          .read(notificationSettingsNotifier.notifier)
                          .updateQuietHours(
                            enabled: true,
                            start: settings.quietHoursStart,
                            end: dateTime,
                          );
                    }
                  },
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          // Test notification button
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Test notification sent!')),
                );
              },
              icon: const Icon(Icons.send),
              label: const Text('Send Test Notification'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...children,
      ],
    );
  }

  String _getNotificationTypeName(NotificationType type) {
    switch (type) {
      case NotificationType.achievement:
        return 'Achievements';
      case NotificationType.taskReminder:
        return 'Task Reminders';
      case NotificationType.teamUpdate:
        return 'Team Updates';
      case NotificationType.levelUp:
        return 'Level Ups';
      case NotificationType.systemAlert:
        return 'System Alerts';
      case NotificationType.dailyDigest:
        return 'Daily Digest';
      case NotificationType.weeklyReport:
        return 'Weekly Reports';
    }
  }
}
