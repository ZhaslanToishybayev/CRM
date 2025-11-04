/// Supabase Configuration
/// Educational Project - Gamified Task Management App

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://fzuqogawfrfswqroiyyt.supabase.co';

  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ6dXFvZ2F3ZnJmc3dxcm9peXl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIwOTc2MDUsImV4cCI6MjA3NzY3MzYwNX0.g2Utt3zyOGemrWb0otn8c7aXhDEZtZC5qY97EFOAxqs';

  static SupabaseClient? _client;

  static SupabaseClient get client {
    _client ??= SupabaseClient(supabaseUrl, supabaseAnonKey);
    return _client!;
  }

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static bool get isConfigured {
    return supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
  }

  /// Open local Hive box for Supabase settings
  static Future<Box> openLocalBox() async {
    return await Hive.openBox('supabase_local');
  }
}
