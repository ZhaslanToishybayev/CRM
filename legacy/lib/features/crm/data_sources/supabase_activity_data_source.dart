import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/crm/activity_model.dart';

abstract class SupabaseActivityDataSource {
  Future<List<ActivityModel>> getAllActivities();
  Future<ActivityModel?> getActivityById(String id);
  Future<List<ActivityModel>> getActivitiesByClientId(String clientId);
  Future<List<ActivityModel>> getActivitiesByDealId(String dealId);
  Future<List<ActivityModel>> getRecentActivities(int limit);
  Future<ActivityModel> createActivity(ActivityModel activity);
  Future<ActivityModel> updateActivity(ActivityModel activity);
  Future<void> deleteActivity(String id);
}

class SupabaseActivityDataSourceImpl implements SupabaseActivityDataSource {
  final SupabaseClient _supabase;

  SupabaseActivityDataSourceImpl(this._supabase);

  @override
  Future<List<ActivityModel>> getAllActivities() async {
    final response = await _supabase
        .from('crm_activities')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((json) => ActivityModel.fromJson(json)).toList();
  }

  @override
  Future<ActivityModel?> getActivityById(String id) async {
    final response = await _supabase
        .from('crm_activities')
        .select()
        .eq('id', id)
        .maybeSingle();

    return response != null ? ActivityModel.fromJson(response) : null;
  }

  @override
  Future<List<ActivityModel>> getActivitiesByClientId(String clientId) async {
    final response = await _supabase
        .from('crm_activities')
        .select()
        .eq('client_id', clientId)
        .order('created_at', ascending: false);

    return (response as List).map((json) => ActivityModel.fromJson(json)).toList();
  }

  @override
  Future<List<ActivityModel>> getActivitiesByDealId(String dealId) async {
    final response = await _supabase
        .from('crm_activities')
        .select()
        .eq('deal_id', dealId)
        .order('created_at', ascending: false);

    return (response as List).map((json) => ActivityModel.fromJson(json)).toList();
  }

  @override
  Future<List<ActivityModel>> getRecentActivities(int limit) async {
    final response = await _supabase
        .from('crm_activities')
        .select()
        .order('created_at', ascending: false)
        .limit(limit);

    return (response as List).map((json) => ActivityModel.fromJson(json)).toList();
  }

  @override
  Future<ActivityModel> createActivity(ActivityModel activity) async {
    final response = await _supabase
        .from('crm_activities')
        .insert(activity.toJson())
        .select()
        .single();

    return ActivityModel.fromJson(response);
  }

  @override
  Future<ActivityModel> updateActivity(ActivityModel activity) async {
    final response = await _supabase
        .from('crm_activities')
        .update(activity.toJson())
        .eq('id', activity.id)
        .select()
        .single();

    return ActivityModel.fromJson(response);
  }

  @override
  Future<void> deleteActivity(String id) async {
    await _supabase.from('crm_activities').delete().eq('id', id);
  }
}
