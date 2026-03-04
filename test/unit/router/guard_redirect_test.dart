import 'package:flutter_test/flutter_test.dart';
import 'package:gamified_task_app/main.dart';

void main() {
  group('appRouteRedirect', () {
    test('unauth on /app -> /login', () {
      expect(
        appRouteRedirect(isAuthenticated: false, matchedLocation: '/app'),
        '/login',
      );
    });

    test('auth on /login -> /app', () {
      expect(
        appRouteRedirect(isAuthenticated: true, matchedLocation: '/login'),
        '/app',
      );
    });

    test('auth on /app -> no redirect', () {
      expect(
        appRouteRedirect(isAuthenticated: true, matchedLocation: '/app'),
        isNull,
      );
    });
  });
}
