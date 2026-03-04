/// Email Notification Service
/// Handles email notifications using mailer package

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailNotificationService {
  static const String _smtpHost = String.fromEnvironment(
    'SMTP_HOST',
    defaultValue: 'smtp.gmail.com',
  );
  static const String _smtpPortRaw = String.fromEnvironment(
    'SMTP_PORT',
    defaultValue: '587',
  );
  static const String _senderEmail = String.fromEnvironment(
    'SMTP_SENDER_EMAIL',
    defaultValue: '',
  );
  static const String _smtpUsername = String.fromEnvironment(
    'SMTP_USERNAME',
    defaultValue: '',
  );
  static const String _senderPassword = String.fromEnvironment(
    'SMTP_PASSWORD',
    defaultValue: '',
  );

  static int get _smtpPort => int.tryParse(_smtpPortRaw) ?? 587;
  static bool get _isConfigured =>
      _senderEmail.isNotEmpty &&
      _smtpUsername.isNotEmpty &&
      _senderPassword.isNotEmpty;

  static SmtpServer get _smtpServer => SmtpServer(
    _smtpHost,
    port: _smtpPort,
    username: _smtpUsername,
    password: _senderPassword,
  );

  /// Send achievement notification email
  static Future<void> sendAchievementEmail({
    required String recipientEmail,
    required String username,
    required String achievementName,
  }) async {
    if (!_isConfigured) return;

    final message = Message()
      ..from = Address(_senderEmail, 'Gamified Tasks')
      ..recipients.add(recipientEmail)
      ..subject = 'Achievement Unlocked: $achievementName!'
      ..html =
          '''
        <div style="font-family: Arial, sans-serif; padding: 20px;">
          <h1 style="color: #6366f1;">Congratulations, $username!</h1>
          <p>You've unlocked a new achievement:</p>
          <div style="background: #f3f4f6; padding: 15px; border-radius: 8px; margin: 20px 0;">
            <h2 style="color: #10b981; margin: 0;">$achievementName</h2>
          </div>
          <p>Keep up the great work!</p>
          <p style="color: #6b7280; font-size: 14px;">
            This is an automated message from Gamified Tasks.
          </p>
        </div>
      ''';

    try {
      await send(message, _smtpServer);
    } on MailerException {
      // Optional integration: fail silently to avoid leaking email metadata.
    }
  }

  /// Send task reminder email
  static Future<void> sendTaskReminderEmail({
    required String recipientEmail,
    required String username,
    required String taskTitle,
    required DateTime dueDate,
  }) async {
    if (!_isConfigured) return;

    final dueDateStr = dueDate.toString().split(' ')[0];
    final message = Message()
      ..from = Address(_senderEmail, 'Gamified Tasks')
      ..recipients.add(recipientEmail)
      ..subject = 'Task Reminder: $taskTitle'
      ..html =
          '''
        <div style="font-family: Arial, sans-serif; padding: 20px;">
          <h1 style="color: #6366f1;">Task Reminder, $username</h1>
          <p>This is a reminder about your task:</p>
          <div style="background: #fef3c7; padding: 15px; border-radius: 8px; margin: 20px 0;">
            <h2 style="color: #f59e0b; margin: 0;">$taskTitle</h2>
            <p><strong>Due:</strong> $dueDateStr</p>
          </div>
          <p>Don't forget to complete it!</p>
        </div>
      ''';

    try {
      await send(message, _smtpServer);
    } catch (_) {
      // Optional integration: fail silently to avoid leaking email metadata.
    }
  }
}
