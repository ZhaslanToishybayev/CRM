/// Analytics Service
/// Tracks user behavior and app metrics

class AnalyticsService {
  static bool _isEnabled = true;

  static void trackEvent(String eventName, Map<String, dynamic>? properties) {
    if (!_isEnabled) return;
    
    // In production, integrate with:
    // - Firebase Analytics
    // - Google Analytics
    // - Custom analytics service
    
    print('📊 Event: $eventName ${properties ?? {}}');
  }

  static void trackScreenView(String screenName) {
    trackEvent('screen_view', {'screen_name': screenName});
  }

  static void trackUserAction(String action, Map<String, dynamic>? properties) {
    trackEvent('user_action_$action', properties);
  }

  static void trackPerformance(String component, Duration duration) {
    trackEvent('performance', {
      'component': component,
      'duration_ms': duration.inMilliseconds,
    });
  }

  static void setUserId(String userId) {
    trackEvent('user_identified', {'user_id': userId});
  }
}
