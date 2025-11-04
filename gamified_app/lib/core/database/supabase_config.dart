/// Supabase Configuration - Consolidated
/// Educational Project - Gamified Task Management App
///
/// Database configuration and initialization

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Supabase configuration class
class SupabaseConfig {
  /// Supabase URL - configured with real credentials
  static const String supabaseUrl = 'https://fzuqogawfrfswqroiyyt.supabase.co';

  /// Supabase Anon Key - configured with real credentials
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ6dXFvZ2F3ZnJmc3dxcm9peXl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIwOTc2MDUsImV4cCI6MjA3NzY3MzYwNX0.g2Utt3zyOGemrWb0otn8c7aXhDEZtZC5qY97EFOAxqs';

  /// Supabase client instance
  static SupabaseClient? _client;

  /// Get Supabase client
  static SupabaseClient get client {
    _client ??= SupabaseClient(supabaseUrl, supabaseAnonKey);
    return _client!;
  }

  /// Initialize Supabase with real credentials
  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
      print('✅ Supabase initialized successfully!');
    } catch (e) {
      print('❌ Failed to initialize Supabase: $e');
      rethrow;
    }
  }

  /// Check if Supabase is properly configured
  static bool get isConfigured {
    return supabaseUrl.isNotEmpty &&
           supabaseAnonKey.isNotEmpty &&
           supabaseUrl != 'YOUR_SUPABASE_URL';
  }

  /// Get user profile from database
  static Future<Map<String, dynamic>?> getProfile(String userId) async {
    try {
      final response = await client
          .from('user_stats')
          .select()
          .eq('id', userId)
          .single();
      return response as Map<String, dynamic>;
    } catch (e) {
      print('Error getting profile: $e');
      return null;
    }
  }

  /// Create user profile
  static Future<void> createProfile({
    required String userId,
    required String username,
    required String email,
  }) async {
    try {
      await client.from('user_stats').insert({
        'id': userId,
        'username': username,
        'email': email,
        'xp': 0,
        'level': 1,
        'streak': 0,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
      print('✅ Profile created for user: $username');
    } catch (e) {
      print('❌ Error creating profile: $e');
      rethrow;
    }
  }

  /// Open local Hive box for offline data
  static Future<Box> openLocalBox() async {
    return await Hive.openBox('supabase_local');
  }
}
