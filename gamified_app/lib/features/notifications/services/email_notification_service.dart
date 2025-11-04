/// Email Notification Service
/// Handles email notifications using mailer package

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailNotificationService {
  static const String _smtpHost = 'smtp.gmail.com';
  static const int _smtpPort = 587;
  static const String _senderEmail = 'noreply@gamifiedtasks.com';
  static const String _senderPassword = 'your-app-password';

  static final SmtpServer _smtpServer = SmtpServer(
    _smtpHost,
    port: _smtpPort,
    username: _senderEmail,
    password: _senderPassword,
  );

  /// Send achievement notification email
  static Future<void> sendAchievementEmail({
    required String recipientEmail,
    required String username,
    required String achievementName,
  }) async {
    final message = Message()
      ..from = Address(_senderEmail, 'Gamified Tasks')
      ..recipients.add(recipientEmail)
      ..subject = 'Achievement Unlocked: $achievementName!'
      ..html = '''
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
      final sendReport = await send(message, _smtpServer);
      print('✅ Email sent: ${sendReport.validSentAddresses}');
    } on MailerException catch (e) {
      print('❌ Email error: $e');
    }
  }

  /// Send task reminder email
  static Future<void> sendTaskReminderEmail({
    required String recipientEmail,
    required String username,
    required String taskTitle,
    required DateTime dueDate,
  }) async {
    final dueDateStr = dueDate.toString().split(' ')[0];
    final message = Message()
      ..from = Address(_senderEmail, 'Gamified Tasks')
      ..recipients.add(recipientEmail)
      ..subject = 'Task Reminder: $taskTitle'
      ..html = '''
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
      final sendReport = await send(message, _smtpServer);
      print('✅ Task reminder sent');
    } catch (e) {
      print('❌ Task reminder error: $e');
    }
  }
}
