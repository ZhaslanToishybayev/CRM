import 'package:flutter_test/flutter_test.dart';

/// Date utility functions for testing
class DateUtils {
  /// Format date to readable string
  static String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Calculate days between two dates
  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
           date.month == yesterday.month &&
           date.day == yesterday.day;
  }

  /// Check if date is this week
  static bool isThisWeek(DateTime date) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
           date.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  /// Get start of day (00:00:00)
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day (23:59:59)
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Check if date is overdue
  static bool isOverdue(DateTime dueDate) {
    return DateTime.now().isAfter(dueDate);
  }

  /// Get days until due date (negative if overdue)
  static int daysUntilDue(DateTime dueDate) {
    final now = DateTime.now();
    return daysBetween(now, dueDate);
  }
}

void main() {
  group('DateUtils', () {
    test('should format date correctly', () {
      final date = DateTime(2025, 11, 6);
      final formatted = DateUtils.formatDate(date);
      expect(formatted, '2025-11-06');
    });

    test('should calculate days between dates', () {
      final date1 = DateTime(2025, 11, 1);
      final date2 = DateTime(2025, 11, 6);
      final days = DateUtils.daysBetween(date1, date2);
      expect(days, 5);
    });

    test('should handle same day (returns 0)', () {
      final date = DateTime(2025, 11, 6);
      final days = DateUtils.daysBetween(date, date);
      expect(days, 0);
    });

    test('should handle negative days (past dates)', () {
      final date1 = DateTime(2025, 11, 6);
      final date2 = DateTime(2025, 11, 1);
      final days = DateUtils.daysBetween(date1, date2);
      expect(days, -5);
    });

    test('should check if date is today', () {
      final today = DateTime.now();
      expect(DateUtils.isToday(today), true);

      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(DateUtils.isToday(yesterday), false);
    });

    test('should check if date is yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(DateUtils.isYesterday(yesterday), true);

      final today = DateTime.now();
      expect(DateUtils.isYesterday(today), false);
    });

    test('should check if date is this week', () {
      final now = DateTime.now();
      expect(DateUtils.isThisWeek(now), true);

      final lastWeek = now.subtract(const Duration(days: 7));
      expect(DateUtils.isThisWeek(lastWeek), false);
    });

    test('should get start of day', () {
      final date = DateTime(2025, 11, 6, 15, 30, 45);
      final start = DateUtils.startOfDay(date);
      expect(start, DateTime(2025, 11, 6, 0, 0, 0));
    });

    test('should get end of day', () {
      final date = DateTime(2025, 11, 6, 10, 15, 30);
      final end = DateUtils.endOfDay(date);
      expect(end, DateTime(2025, 11, 6, 23, 59, 59, 999));
    });

    test('should detect overdue date', () {
      final pastDate = DateTime.now().subtract(const Duration(days: 1));
      expect(DateUtils.isOverdue(pastDate), true);

      final futureDate = DateTime.now().add(const Duration(days: 1));
      expect(DateUtils.isOverdue(futureDate), false);
    });

    test('should calculate days until due date', () {
      final futureDate = DateTime.now().add(const Duration(days: 3));
      final days = DateUtils.daysUntilDue(futureDate);
      expect(days, 3);

      final pastDate = DateTime.now().subtract(const Duration(days: 2));
      final overdueDays = DateUtils.daysUntilDue(pastDate);
      expect(overdueDays, -2);
    });

    test('should handle edge cases for week calculation', () {
      final now = DateTime.now();
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      final outsideWeek = startOfWeek.subtract(const Duration(days: 1));

      expect(DateUtils.isThisWeek(startOfWeek), true);
      expect(DateUtils.isThisWeek(endOfWeek), true);
      expect(DateUtils.isThisWeek(outsideWeek), false);
    });

    test('should handle time zones correctly', () {
      final date1 = DateTime(2025, 11, 6, 23, 59, 59);
      final date2 = DateTime(2025, 11, 7, 0, 0, 0);

      // Different days but close time
      expect(DateUtils.isToday(date1), false);
      expect(DateUtils.isToday(date2), false);
    });

    test('should handle leap year correctly', () {
      final leapYearDate = DateTime(2024, 2, 29); // 2024 is leap year
      final nextDay = DateTime(2024, 3, 1);
      final days = DateUtils.daysBetween(leapYearDate, nextDay);
      expect(days, 1);
    });

    test('should handle month boundaries', () {
      final jan31 = DateTime(2025, 1, 31);
      final feb1 = DateTime(2025, 2, 1);
      final days = DateUtils.daysBetween(jan31, feb1);
      expect(days, 1);
    });

    test('should handle year boundaries', () {
      final dec31 = DateTime(2024, 12, 31);
      final jan1 = DateTime(2025, 1, 1);
      final days = DateUtils.daysBetween(dec31, jan1);
      expect(days, 1);
    });

    test('should calculate exact duration with hours/minutes/seconds', () {
      final date1 = DateTime(2025, 11, 6, 10, 0, 0);
      final date2 = DateTime(2025, 11, 6, 12, 30, 45);

      // Different times on same day
      final days = DateUtils.daysBetween(date1, date2);
      expect(days, 0); // Same day, should be 0
    });
  });
}
