/// App Configuration
/// Environment-based configuration

class AppConfig {
  static const String appName = 'Gamified Task Manager';
  static const String appVersion = '1.0.0';
  
  // Environment
  static String get environment {
    return const String.fromEnvironment('ENVIRONMENT', defaultValue: 'development');
  }
  
  static bool get isProduction => environment == 'production';
  static bool get isStaging => environment == 'staging';
  static bool get isDevelopment => environment == 'development';
  
  // API Configuration
  static String get apiTimeout {
    if (isProduction) return '30000';
    if (isStaging) return '30000';
    return '60000';
  }
  
  static String get cacheDuration {
    if (isProduction) return '3600';
    if (isStaging) return '3600';
    return '1800';
  }
  
  // Build Configuration
  static bool get enableLogging => !isProduction;
  static bool get enableDebugMode => isDevelopment;
  
  // Feature Flags
  static bool get enableAnalytics => isProduction;
  static bool get enableCrashReporting => isProduction;
  static bool get enablePerformanceMonitoring => isProduction;
}
