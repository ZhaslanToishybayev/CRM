/// User Statistics Model for Supabase
/// Educational Project - Gamified Task Management App

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserStatsModel {
  final String id;
  final String username;
  final String email;
  final int xp;
  final int level;
  final int streak;
  @JsonKey(name: 'last_task_date')
  final DateTime? lastTaskDate;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  UserStatsModel({
    required this.id,
    required this.username,
    required this.email,
    this.xp = 0,
    this.level = 1,
    this.streak = 0,
    this.lastTaskDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      xp: json['xp'] ?? 0,
      level: json['level'] ?? 1,
      streak: json['streak'] ?? 0,
      lastTaskDate: json['last_task_date'] != null
          ? DateTime.parse(json['last_task_date'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'xp': xp,
      'level': level,
      'streak': streak,
      'last_task_date': lastTaskDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserStatsModel copyWith({
    String? id,
    String? username,
    String? email,
    int? xp,
    int? level,
    int? streak,
    DateTime? lastTaskDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserStatsModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      streak: streak ?? this.streak,
      lastTaskDate: lastTaskDate ?? this.lastTaskDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Create a new user stats model
  factory UserStatsModel.create({
    required String id,
    required String username,
    required String email,
  }) {
    final now = DateTime.now();
    return UserStatsModel(
      id: id,
      username: username,
      email: email,
      xp: 0,
      level: 1,
      streak: 0,
      lastTaskDate: null,
      createdAt: now,
      updatedAt: now,
    );
  }

  @override
  String toString() {
    return 'UserStatsModel(id: $id, username: $username, level: $level, xp: $xp, streak: $streak)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStatsModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
