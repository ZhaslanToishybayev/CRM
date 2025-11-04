/// Unit Tests for UserModel
/// Tests the user data model

import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/features/auth/models/user_model.dart';

void main() {
  group('UserModel Tests', () {
    late UserModel userModel;

    setUp(() {
      userModel = UserModel(
        id: 'test-id',
        email: 'test@example.com',
        username: 'testuser',
        fullName: 'Test User',
        avatarUrl: 'https://example.com/avatar.jpg',
        totalXP: 1000,
        currentLevel: 5,
        streakCount: 7,
        lastTaskDate: DateTime.now(),
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 15),
      );
    });

    test('should create user model with required fields', () {
      expect(userModel.id, 'test-id');
      expect(userModel.email, 'test@example.com');
      expect(userModel.username, 'testuser');
      expect(userModel.totalXP, 1000);
      expect(userModel.currentLevel, 5);
    });

    test('should create user model with null optional fields', () {
      final user = UserModel(
        id: 'test-id',
        email: 'test@example.com',
        username: 'testuser',
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 15),
      );
      
      expect(user.fullName, isNull);
      expect(user.avatarUrl, isNull);
      expect(user.lastTaskDate, isNull);
    });

    test('should convert to JSON', () {
      final json = userModel.toJson();
      
      expect(json['id'], 'test-id');
      expect(json['email'], 'test@example.com');
      expect(json['username'], 'testuser');
      expect(json['total_xp'], 1000);
      expect(json['current_level'], 5);
    });

    test('should create from JSON', () {
      final json = {
        'id': 'test-id',
        'email': 'test@example.com',
        'username': 'testuser',
        'full_name': 'Test User',
        'avatar_url': 'https://example.com/avatar.jpg',
        'total_xp': 1000,
        'current_level': 5,
        'streak_count': 7,
        'last_task_date': DateTime.now().toIso8601String(),
        'created_at': DateTime(2024, 1, 1).toIso8601String(),
        'updated_at': DateTime(2024, 1, 15).toIso8601String(),
      };

      final user = UserModel.fromJson(json);
      
      expect(user.id, 'test-id');
      expect(user.email, 'test@example.com');
      expect(user.username, 'testuser');
      expect(user.totalXP, 1000);
    });

    test('should create copy with modified fields', () {
      final updatedUser = userModel.copyWith(
        username: 'newusername',
        totalXP: 2000,
      );
      
      expect(updatedUser.id, userModel.id);
      expect(updatedUser.username, 'newusername');
      expect(updatedUser.totalXP, 2000);
      expect(updatedUser.email, userModel.email);
    });
  });
}
