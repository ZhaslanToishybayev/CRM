/// Push Notification Service
/// Handles local notifications and push permission bootstrap.

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  PushNotificationService._();

  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> initializeLocalNotifications() async {
    if (_initialized) return;

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
      macOS: iosSettings,
    );

    await _localNotifications.initialize(settings);
    _initialized = true;
  }

  static Future<void> initialize() async {
    if (kIsWeb) return;

    try {
      await FirebaseMessaging.instance.requestPermission();
      await FirebaseMessaging.instance.getToken();
    } catch (_) {
      // Push setup should not break app bootstrap.
    }
  }

  static Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await initializeLocalNotifications();

    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default',
      channelDescription: 'General notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
      macOS: iosDetails,
    );

    await _localNotifications.show(id, title, body, details);
  }
}
