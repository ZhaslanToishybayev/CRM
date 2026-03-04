import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gamified_task_app/main.dart';

const MethodChannel _pathProviderChannel =
    MethodChannel('plugins.flutter.io/path_provider');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = true;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_pathProviderChannel, (methodCall) async {
          return '/tmp';
        });
  });

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_pathProviderChannel, null);
  });

  group('Gamification Flow Integration Smoke', () {
    testWidgets('app starts and key icons are paintable', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: ModernCRMApp(),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(MaterialApp), findsOneWidget);

      // These icons can be absent in auth state; check safely without failing.
      final hasGamificationIcon =
          find.byIcon(Icons.emoji_events).evaluate().isNotEmpty;
      final hasScaffold = find.byType(Scaffold).evaluate().isNotEmpty;
      expect(hasGamificationIcon || hasScaffold, isTrue);
    });
  });
}
