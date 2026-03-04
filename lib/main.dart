import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers.dart';
import 'providers_crm.dart';
import 'core/config/runtime_flags.dart';
import 'features/ai/services/minimax_ai_service.dart';
import 'features/crm/utils/client_validators.dart';
import 'features/theme/theme_provider.dart';
import 'features/localization/localization_provider.dart';
import 'auth/auth_service.dart';
import 'auth/login_screen.dart';

part 'app/root_layout.dart';
part 'features/dashboard/presentation/dashboard_page.dart';
part 'features/tasks/presentation/tasks_page.dart';
part 'features/tasks/presentation/task_bottom_sheets.dart';
part 'features/crm/presentation/crm_page.dart';
part 'features/crm/presentation/crm_bottom_sheets.dart';
part 'features/reports/presentation/reports_page.dart';
part 'features/profile/presentation/profile_page.dart';
part 'features/profile/presentation/profile_bottom_sheets.dart';
part 'features/ai/presentation/ai_assistant_screen.dart';

const String kNoClientSelectionValue = '__no_client__';

String toUserFacingErrorMessage(Object error) {
  final raw = error.toString().replaceAll('Exception: ', '').trim();
  final normalized = raw.toLowerCase();

  if (normalized.contains('relation') &&
      normalized.contains('crm_clients') &&
      normalized.contains('does not exist')) {
    return 'Таблица crm_clients не найдена в Supabase. Примените supabase_crm_schema.sql.';
  }

  if (normalized.contains('relation') &&
      normalized.contains('tasks') &&
      normalized.contains('does not exist')) {
    return 'Таблица tasks не найдена в Supabase. Примените supabase_schema.sql.';
  }

  if (normalized.contains('pgrst205') &&
      normalized.contains('could not find the table') &&
      normalized.contains('tasks')) {
    return 'Таблица tasks отсутствует в схеме Supabase API cache. '
        'Создайте public.tasks и обновите schema cache.';
  }

  if (normalized.contains('column') &&
      normalized.contains('user_id') &&
      normalized.contains('does not exist')) {
    return 'В таблице tasks отсутствует колонка user_id. Обновите схему базы.';
  }

  if (normalized.contains('row-level security') ||
      normalized.contains('violates row-level security')) {
    return 'Запрос заблокирован RLS policy. Проверьте политики Supabase для authenticated пользователя.';
  }

  if (normalized.contains('invalid input syntax for type uuid')) {
    return 'Некорректный идентификатор (UUID) в запросе. Перезайдите в аккаунт и повторите.';
  }

  if (normalized.contains('jwt') && normalized.contains('expired')) {
    return 'Сессия истекла. Выполните вход заново.';
  }

  return raw.isEmpty ? 'Неизвестная ошибка запроса.' : raw;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Keep Hive initialized for demo mode and local caches.
  await Hive.initFlutter();

  // Register Hive adapters
  _registerHiveAdaptersSafely();

  // Backend-first runtime: initialize auth/supabase upfront.
  await AuthService.initialize();

  // Demo data is opt-in only via --dart-define=DEMO_MODE=true
  if (kDemoMode) {
    await _initializeTestData();
  }

  runApp(const ProviderScope(child: ModernCRMApp()));
}

void _registerHiveAdaptersSafely() {
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ClientAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(ClientStatusAdapter());
  }
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(ClientSourceAdapter());
  }
}

Future<void> _initializeTestData() async {
  try {
    final clientsBox = await Hive.openBox<Client>('clients');

    // If no clients exist, add some test data
    if (clientsBox.isEmpty) {
      final testClients = [
        Client(
          id: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          phone: '+1234567890',
          company: 'Acme Corp',
          position: 'CEO',
          status: ClientStatus.active,
          source: ClientSource.website,
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
        Client(
          id: '2',
          firstName: 'Jane',
          lastName: 'Smith',
          email: 'jane.smith@example.com',
          phone: '+1234567891',
          company: 'Tech Solutions',
          position: 'Developer',
          status: ClientStatus.prospect,
          source: ClientSource.referral,
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
        Client(
          id: '3',
          firstName: 'Bob',
          lastName: 'Johnson',
          email: 'bob.johnson@example.com',
          phone: '+1234567892',
          company: 'Design Studio',
          position: 'Designer',
          status: ClientStatus.lead,
          source: ClientSource.socialMedia,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        Client(
          id: '4',
          firstName: 'Alice',
          lastName: 'Williams',
          email: 'alice.williams@example.com',
          phone: '+1234567893',
          company: 'Marketing Pro',
          position: 'Manager',
          status: ClientStatus.inactive,
          source: ClientSource.email,
          createdAt: DateTime.now().subtract(const Duration(days: 20)),
        ),
      ];

      for (final client in testClients) {
        await clientsBox.add(client);
      }
    }
  } catch (e) {
    // Non-critical seed step: continue app startup even if it fails.
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(authStateProvider) != null;

  return GoRouter(
    initialLocation: '/app',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/app',
        name: 'app',
        builder: (context, state) => const RootLayout(),
      ),
    ],
    redirect: (context, state) {
      return appRouteRedirect(
        isAuthenticated: isAuthenticated,
        matchedLocation: state.matchedLocation,
      );
    },
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Страница не найдена'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.go('/app'),
              child: const Text('На главную'),
            ),
          ],
        ),
      ),
    ),
  );
});

String? appRouteRedirect({
  required bool isAuthenticated,
  required String matchedLocation,
}) {
  final onLogin = matchedLocation == '/login';

  if (!isAuthenticated && !onLogin) {
    return '/login';
  }
  if (isAuthenticated && onLogin) {
    return '/app';
  }
  return null;
}

class ModernCRMApp extends ConsumerWidget {
  const ModernCRMApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Modern CRM',
      debugShowCheckedModeBanner: false,
      locale: locale,
      themeMode: themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: router,
      builder: (context, child) {
        if (!kDemoMode) return child ?? const SizedBox.shrink();
        return Stack(
          children: [
            Positioned.fill(child: child ?? const SizedBox.shrink()),
            Positioned(
              left: 12,
              right: 12,
              top: 8,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3CD),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFFFE69C)),
                  ),
                  child: Text(
                    'Demo mode: используется локальная mock-авторизация и локальное хранилище.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF7A5C00),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
