/// Sentry Configuration
/// Error tracking and monitoring

import 'package:sentry_flutter/sentry_flutter.dart';

class SentryConfig {
  static const String dsn = String.fromEnvironment(
    'SENTRY_DSN',
    defaultValue: '',
  );

  static Future<void> initialize() async {
    if (dsn.isEmpty) {
      print('⚠️ Sentry DSN not configured');
      return;
    }

    await SentryFlutter.init(
      (options) {
        options.dsn = dsn;
        options.debug = false;
        
        // Performance monitoring
        options.enablePerformanceTracking = true;
        options.tracesSampleRate = 1.0;
        
        // Release tracking
        options.environment = const String.fromEnvironment(
          'ENVIRONMENT',
          defaultValue: 'development',
        );
      },
    );
    
    print('✅ Sentry initialized');
  }

  static void captureException(Object exception, StackTrace stackTrace) {
    Sentry.captureException(exception, stackTrace: stackTrace);
  }

  static void captureMessage(String message) {
    Sentry.captureMessage(message);
  }
}
