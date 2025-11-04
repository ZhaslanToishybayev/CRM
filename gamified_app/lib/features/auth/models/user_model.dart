/// User Model
/// Educational Project - Gamified Task Management App
///
/// Represents the authenticated user

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String username,
    String? fullName,
    String? avatarUrl,
    required int totalXP,
    required int currentLevel,
    required int streakCount,
    DateTime? lastTaskDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
