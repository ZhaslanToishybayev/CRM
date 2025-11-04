/// Streak Provider
/// Educational Project - Gamified Task Management App
///
/// Manages daily task completion streaks

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'streak_provider.g.dart';

/// Model for streak data
class StreakModel {
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastTaskDate;
  final List<DateTime> completionDates;

  const StreakModel({
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastTaskDate,
    this.completionDates = const [],
  });

  StreakModel copyWith({
    int? currentStreak,
    int? longestStreak,
    DateTime? lastTaskDate,
    List<DateTime>? completionDates,
  }) {
    return StreakModel(
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastTaskDate: lastTaskDate ?? this.lastTaskDate,
      completionDates: completionDates ?? this.completionDates,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastTaskDate': lastTaskDate?.millisecondsSinceEpoch,
      'completionDates': completionDates
          .map((date) => date.millisecondsSinceEpoch)
          .toList(),
    };
  }

  factory StreakModel.fromJson(Map<String, dynamic> json) {
    return StreakModel(
      currentStreak: json['currentStreak'] ?? 0,
      longestStreak: json['longestStreak'] ?? 0,
      lastTaskDate: json['lastTaskDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['lastTaskDate'])
          : null,
      completionDates: (json['completionDates'] as List<dynamic>?)
              ?.map((timestamp) => DateTime.fromMillisecondsSinceEpoch(timestamp))
              .toList() ??
          [],
    );
  }
}

/// Provider for streak state
@Riverpod(keepAlive: true)
class StreakNotifier extends _$StreakNotifier {
  static const String _boxKey = 'streak';
  static const String _dataKey = 'streak_data';

  @override
  StreakModel build() {
    _loadStreak();
    return const StreakModel();
  }

  /// Load streak from local storage
  Future<void> _loadStreak() async {
    try {
      await Hive.initFlutter();
      final box = await Hive.openBox(_boxKey);
      final data = box.get(_dataKey);
      if (data != null) {
        state = StreakModel.fromJson(Map<String, dynamic>.from(data));
      }
    } catch (e) {
      print('Error loading streak: $e');
    }
  }

  /// Save streak to local storage
  Future<void> _saveStreak() async {
    try {
      final box = await Hive.openBox(_boxKey);
      await box.put(_dataKey, state.toJson());
    } catch (e) {
      print('Error saving streak: $e');
    }
  }

  /// Update streak when a task is completed
  Future<void> onTaskCompleted(DateTime completedAt) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastDate = state.lastTaskDate;

    int newStreak = state.currentStreak;

    // If no previous task, start streak
    if (lastDate == null) {
      newStreak = 1;
    } else {
      final lastTaskDay = DateTime(
        lastDate.year,
        lastDate.month,
        lastDate.day,
      );

      final difference = today.difference(lastTaskDay).inDays;

      if (difference == 0) {
        // Task already completed today, don't increment
        return;
      } else if (difference == 1) {
        // Consecutive day, increment streak
        newStreak = state.currentStreak + 1;
      } else {
        // Streak broken, reset to 1
        newStreak = 1;
      }
    }

    // Update completion dates
    final newCompletionDates = [...state.completionDates];
    if (!newCompletionDates.any((date) =>
        DateTime(date.year, date.month, date.day) == today)) {
      newCompletionDates.add(now);
    }

    state = state.copyWith(
      currentStreak: newStreak,
      longestStreak: newStreak > state.longestStreak
          ? newStreak
          : state.longestStreak,
      lastTaskDate: now,
      completionDates: newCompletionDates,
    );

    await _saveStreak();
  }

  /// Reset streak (for logout or testing)
  void reset() {
    state = const StreakModel();
    _saveStreak();
  }

  /// Check if user has a streak today
  bool hasCompletedToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return state.completionDates.any((date) =>
        DateTime(date.year, date.month, date.day) == today);
  }

  /// Get streak display text
  String getStreakText() {
    if (state.currentStreak == 0) {
      return 'Start your streak!';
    } else if (state.currentStreak == 1) {
      return '1 day streak';
    } else {
      return '${state.currentStreak} day streak';
    }
  }
}
