import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/crm/crm_task_model.dart';

abstract class SupabaseCrmTaskDataSource {
  Future<List<CrmTaskModel>> getAllTasks();
  Future<CrmTaskModel?> getTaskById(String id);
  Future<List<CrmTaskModel>> getTasksByStatus(TaskStatus status);
  Future<List<CrmTaskModel>> getTasksByType(TaskType type);
  Future<List<CrmTaskModel>> getTasksByClientId(String clientId);
  Future<List<CrmTaskModel>> getTodaysTasks();
  Future<List<CrmTaskModel>> getUpcomingTasks();
  Future<CrmTaskModel> createTask(CrmTaskModel task);
  Future<CrmTaskModel> updateTask(CrmTaskModel task);
  Future<void> deleteTask(String id);
}

class SupabaseCrmTaskDataSourceImpl implements SupabaseCrmTaskDataSource {
  final SupabaseClient _supabase;

  SupabaseCrmTaskDataSourceImpl(this._supabase);

  @override
  Future<List<CrmTaskModel>> getAllTasks() async {
    final response = await _supabase
        .from('crm_tasks')
        .select()
        .order('due_date', ascending: true);

    return (response as List).map((json) => CrmTaskModel.fromJson(json)).toList();
  }

  @override
  Future<CrmTaskModel?> getTaskById(String id) async {
    final response = await _supabase
        .from('crm_tasks')
        .select()
        .eq('id', id)
        .maybeSingle();

    return response != null ? CrmTaskModel.fromJson(response) : null;
  }

  @override
  Future<List<CrmTaskModel>> getTasksByStatus(TaskStatus status) async {
    final response = await _supabase
        .from('crm_tasks')
        .select()
        .eq('status', status.name)
        .order('due_date', ascending: true);

    return (response as List).map((json) => CrmTaskModel.fromJson(json)).toList();
  }

  @override
  Future<List<CrmTaskModel>> getTasksByType(TaskType type) async {
    final response = await _supabase
        .from('crm_tasks')
        .select()
        .eq('type', type.name)
        .order('due_date', ascending: true);

    return (response as List).map((json) => CrmTaskModel.fromJson(json)).toList();
  }

  @override
  Future<List<CrmTaskModel>> getTasksByClientId(String clientId) async {
    final response = await _supabase
        .from('crm_tasks')
        .select()
        .eq('client_id', clientId)
        .order('due_date', ascending: true);

    return (response as List).map((json) => CrmTaskModel.fromJson(json)).toList();
  }

  @override
  Future<List<CrmTaskModel>> getTodaysTasks() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final response = await _supabase
        .from('crm_tasks')
        .select()
        .gte('due_date', startOfDay.toIso8601String())
        .lt('due_date', endOfDay.toIso8601String())
        .order('due_date', ascending: true);

    return (response as List).map((json) => CrmTaskModel.fromJson(json)).toList();
  }

  @override
  Future<List<CrmTaskModel>> getUpcomingTasks() async {
    final now = DateTime.now();

    final response = await _supabase
        .from('crm_tasks')
        .select()
        .gte('due_date', now.toIso8601String())
        .order('due_date', ascending: true)
        .limit(10);

    return (response as List).map((json) => CrmTaskModel.fromJson(json)).toList();
  }

  @override
  Future<CrmTaskModel> createTask(CrmTaskModel task) async {
    final response = await _supabase
        .from('crm_tasks')
        .insert(task.toJson())
        .select()
        .single();

    return CrmTaskModel.fromJson(response);
  }

  @override
  Future<CrmTaskModel> updateTask(CrmTaskModel task) async {
    final response = await _supabase
        .from('crm_tasks')
        .update(task.toJson())
        .eq('id', task.id)
        .select()
        .single();

    return CrmTaskModel.fromJson(response);
  }

  @override
  Future<void> deleteTask(String id) async {
    await _supabase.from('crm_tasks').delete().eq('id', id);
  }
}
