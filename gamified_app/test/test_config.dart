/// Test Configuration
/// Central configuration for all tests

import 'package:flutter_test/flutter_test.dart';

/// Test configuration constants
class TestConfig {
  /// Test user credentials
  static const testEmail = 'test@example.com';
  static const testPassword = 'Test123456';
  static const testUsername = 'testuser';
  
  /// Mock data
  static const mockUserId = 'mock-user-id-123';
  static const mockTaskId = 'mock-task-id-456';
  static const mockTeamId = 'mock-team-id-789';
  
  /// Test timeouts
  static const defaultTimeout = Duration(seconds: 5);
  static const integrationTimeout = Duration(seconds: 30);
  
  /// Coverage thresholds
  static const minimumCoverage = 80; // 80%
}

/// Setup function to run before all tests
Future<void> testSetup() async {
  TestWidgetsFlutterBinding.ensureInitialized();
}
