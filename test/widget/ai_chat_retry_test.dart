import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/main.dart';

void main() {
  testWidgets('AI chat shows error and retry action when request fails', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: AIAssistantScreen()));

    await tester.enterText(
      find.byType(TextField),
      'Помоги спланировать задачи на неделю',
    );
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    expect(find.textContaining('AI сервис не настроен'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(find.textContaining('AI сервис не настроен'), findsWidgets);
  });
}
