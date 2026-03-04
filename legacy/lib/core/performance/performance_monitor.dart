/// Performance Monitor
/// Tracks app performance metrics

import 'dart:developer';

class PerformanceMonitor {
  static void logBuildTime(String component, Duration duration) {
    if (duration.inMilliseconds > 100) {
      log('⚠️ Slow build detected: $component took ${duration.inMilliseconds}ms');
    }
  }
  
  static void logMemoryUsage(String component, int bytes) {
    final mb = (bytes / (1024 * 1024)).toStringAsFixed(2);
    log('📊 Memory usage: $component - ${mb}MB');
  }
  
  static void logApiCall(String endpoint, Duration duration, bool success) {
    final status = success ? '✅' : '❌';
    log('$status API Call: $endpoint (${duration.inMilliseconds}ms)');
  }
  
  static void logCacheHit(String cacheKey) {
    log('💾 Cache hit: $cacheKey');
  }
  
  static void logCacheMiss(String cacheKey) {
    log('💾 Cache miss: $cacheKey');
  }
}
