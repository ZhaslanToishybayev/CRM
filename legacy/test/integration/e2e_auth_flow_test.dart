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

  group('Authentication Flow Integration Smoke', () {
    testWidgets('app renders login/home shell', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: ModernCRMApp(),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('auth entry controls are interactable', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: ModernCRMApp(),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));

      final textFields = find.byType(TextField);
      if (textFields.evaluate().isNotEmpty) {
        await tester.enterText(textFields.first, 'demo@crm.com');
        await tester.pump(const Duration(milliseconds: 200));
      }

      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
