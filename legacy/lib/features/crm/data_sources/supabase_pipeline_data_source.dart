import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/crm/pipeline_model.dart';

abstract class SupabasePipelineDataSource {
  Future<List<PipelineModel>> getAllPipelines();
  Future<PipelineModel?> getPipelineById(String id);
  Future<PipelineModel> createPipeline(PipelineModel pipeline);
  Future<PipelineModel> updatePipeline(PipelineModel pipeline);
  Future<void> deletePipeline(String id);
}

class SupabasePipelineDataSourceImpl implements SupabasePipelineDataSource {
  final SupabaseClient _supabase;

  SupabasePipelineDataSourceImpl(this._supabase);

  @override
  Future<List<PipelineModel>> getAllPipelines() async {
    final response = await _supabase
        .from('crm_pipelines')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((json) => PipelineModel.fromJson(json)).toList();
  }

  @override
  Future<PipelineModel?> getPipelineById(String id) async {
    final response = await _supabase
        .from('crm_pipelines')
        .select()
        .eq('id', id)
        .maybeSingle();

    return response != null ? PipelineModel.fromJson(response) : null;
  }

  @override
  Future<PipelineModel> createPipeline(PipelineModel pipeline) async {
    final response = await _supabase
        .from('crm_pipelines')
        .insert(pipeline.toJson())
        .select()
        .single();

    return PipelineModel.fromJson(response);
  }

  @override
  Future<PipelineModel> updatePipeline(PipelineModel pipeline) async {
    final response = await _supabase
        .from('crm_pipelines')
        .update(pipeline.toJson())
        .eq('id', pipeline.id)
        .select()
        .single();

    return PipelineModel.fromJson(response);
  }

  @override
  Future<void> deletePipeline(String id) async {
    await _supabase.from('crm_pipelines').delete().eq('id', id);
  }
}
