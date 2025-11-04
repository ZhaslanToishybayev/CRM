/// Main entry point - Final Version with GoRouter + Supabase
/// Educational Project - Gamified Task Management App
/// Using: Riverpod State Management + GoRouter Navigation + Supabase Database

import 'dart:math' as math;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';
import 'providers.dart';
import 'core/supabase/supabase_config.dart';
import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive (local storage)
  await Hive.initFlutter();

  // Initialize Supabase (cloud database)
  await SupabaseConfig.initialize();

  runApp(
    const ProviderScope(
      child: GamifiedTasksApp(),
    ),
  );
}

class GamifiedTasksApp extends ConsumerWidget {
  const GamifiedTasksApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Gamified Tasks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      routerConfig: router,
    );
  }
}
