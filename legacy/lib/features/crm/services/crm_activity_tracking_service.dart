import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/crm/activity_model.dart';
import '../data_sources/supabase_activity_data_source.dart';

class CrmActivityTrackingService {
  late final SupabaseClient _supabase;
  late final SupabaseActivityDataSource _activityDataSource;

  CrmActivityTrackingService() {
    _supabase = Supabase.instance.client;
    _activityDataSource = SupabaseActivityDataSourceImpl(_supabase);
  }

  // Log a new activity
  Future<ActivityModel> logActivity(ActivityModel activity) async {
    try {
      return await _activityDataSource.createActivity(activity);
    } catch (e) {
      print('Error logging activity: $e');
      rethrow;
    }
  }

  // Get all activities for a client
  Future<List<ActivityModel>> getClientActivities(String clientId) async {
    try {
      return await _activityDataSource.getActivitiesByClientId(clientId);
    } catch (e) {
      print('Error getting client activities: $e');
      return [];
    }
  }

  // Get all activities for a deal
  Future<List<ActivityModel>> getDealActivities(String dealId) async {
    try {
      return await _activityDataSource.getActivitiesByDealId(dealId);
    } catch (e) {
      print('Error getting deal activities: $e');
      return [];
    }
  }

  // Get all recent activities
  Future<List<ActivityModel>> getRecentActivities({int limit = 50}) async {
    try {
      return await _activityDataSource.getRecentActivities(limit);
    } catch (e) {
      print('Error getting recent activities: $e');
      return [];
    }
  }

  // Get activities by date range
  Future<List<ActivityModel>> getActivitiesByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final response = await _supabase
          .from('crm_activities')
          .select()
          .gte('activity_date', startDate.toIso8601String())
          .lte('activity_date', endDate.toIso8601String())
          .order('activity_date', ascending: false);

      return (response as List)
          .map((json) => ActivityModel.fromJson(json))
          .toList();
    } catch (e) {
      print('Error getting activities by date range: $e');
      return [];
    }
  }

  // Get activities by type
  Future<List<ActivityModel>> getActivitiesByType(ActivityType type) async {
    try {
      final response = await _supabase
          .from('crm_activities')
          .select()
          .eq('type', type.name)
          .order('activity_date', ascending: false);

      return (response as List)
          .map((json) => ActivityModel.fromJson(json))
          .toList();
    } catch (e) {
      print('Error getting activities by type: $e');
      return [];
    }
  }
}

// Provider for the activity tracking service
final crmActivityTrackingServiceProvider = Provider<CrmActivityTrackingService>((ref) {
  return CrmActivityTrackingService();
});
