/// User Statistics Model for Supabase
/// Educational Project - Gamified Task Management App

import 'package:json_annotation/json_annotation.dart';

part 'user_stats_model.g.dart';

@JsonSerializable()
class UserStatsModel {
  /// MongoDB ObjectId (optional for backward compatibility)
  final String? sId;
  @JsonKey(name: '_id')
  final String? id;
  final String userId;
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

  /// Get effective ID (use sId if id is null, otherwise use id)
  String get effectiveId => sId ?? id ?? userId;

  UserStatsModel({
    this.sId,
    this.id,
    required this.userId,
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
      sId: json['_id'],
      id: json['id'],
      userId: json['userId'] ?? json['user_id'] ?? 'demo-user',
      username: json['username'] ?? 'User',
      email: json['email'] ?? 'user@example.com',
      xp: json['xp'] ?? 0,
      level: json['level'] ?? 1,
      streak: json['streak'] ?? 0,
      lastTaskDate: json['last_task_date'] != null
          ? DateTime.parse(json['last_task_date'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
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
    String? sId,
    String? id,
    String? userId,
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
      sId: sId ?? this.sId,
      id: id ?? this.id,
      userId: userId ?? this.userId,
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
      userId: id,
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
    return 'UserStatsModel(id: $effectiveId, username: $username, level: $level, xp: $xp, streak: $streak)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStatsModel &&
          runtimeType == other.runtimeType &&
          effectiveId == other.effectiveId;

  @override
  int get hashCode => effectiveId.hashCode;
}
