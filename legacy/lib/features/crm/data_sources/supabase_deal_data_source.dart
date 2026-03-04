import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/crm/deal_model.dart';

abstract class SupabaseDealDataSource {
  Future<List<DealModel>> getAllDeals();
  Future<DealModel?> getDealById(String id);
  Future<List<DealModel>> getDealsByStatus(DealStatus status);
  Future<List<DealModel>> getDealsByStage(String stageId);
  Future<DealModel> createDeal(DealModel deal);
  Future<DealModel> updateDeal(DealModel deal);
  Future<void> deleteDeal(String id);
  Future<List<DealModel>> searchDeals(String query);
  Future<double> getTotalDealsValue();
  Future<double> getWonDealsValue();
}

class SupabaseDealDataSourceImpl implements SupabaseDealDataSource {
  final SupabaseClient _supabase;

  SupabaseDealDataSourceImpl(this._supabase);

  @override
  Future<List<DealModel>> getAllDeals() async {
    final response = await _supabase
        .from('crm_deals')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((json) => DealModel.fromJson(json)).toList();
  }

  @override
  Future<DealModel?> getDealById(String id) async {
    final response = await _supabase
        .from('crm_deals')
        .select()
        .eq('id', id)
        .maybeSingle();

    return response != null ? DealModel.fromJson(response) : null;
  }

  @override
  Future<List<DealModel>> getDealsByStatus(DealStatus status) async {
    final response = await _supabase
        .from('crm_deals')
        .select()
        .eq('status', status.name)
        .order('created_at', ascending: false);

    return (response as List).map((json) => DealModel.fromJson(json)).toList();
  }

  @override
  Future<List<DealModel>> getDealsByStage(String stageId) async {
    final response = await _supabase
        .from('crm_deals')
        .select()
        .eq('stage_id', stageId)
        .order('created_at', ascending: false);

    return (response as List).map((json) => DealModel.fromJson(json)).toList();
  }

  @override
  Future<DealModel> createDeal(DealModel deal) async {
    final response = await _supabase
        .from('crm_deals')
        .insert(deal.toJson())
        .select()
        .single();

    return DealModel.fromJson(response);
  }

  @override
  Future<DealModel> updateDeal(DealModel deal) async {
    final response = await _supabase
        .from('crm_deals')
        .update(deal.toJson())
        .eq('id', deal.id)
        .select()
        .single();

    return DealModel.fromJson(response);
  }

  @override
  Future<void> deleteDeal(String id) async {
    await _supabase.from('crm_deals').delete().eq('id', id);
  }

  @override
  Future<List<DealModel>> searchDeals(String query) async {
    final response = await _supabase
        .from('crm_deals')
        .select()
        .or('title.ilike.%$query%,description.ilike.%$query%,client_name.ilike.%$query%')
        .order('created_at', ascending: false);

    return (response as List).map((json) => DealModel.fromJson(json)).toList();
  }

  @override
  Future<double> getTotalDealsValue() async {
    final response = await _supabase
        .from('crm_deals')
        .select('amount');

    return (response as List)
        .fold<double>(0, (sum, json) => sum + (json['amount'] as num).toDouble());
  }

  @override
  Future<double> getWonDealsValue() async {
    final response = await _supabase
        .from('crm_deals')
        .select('amount')
        .eq('status', 'won');

    return (response as List)
        .fold<double>(0, (sum, json) => sum + (json['amount'] as num).toDouble());
  }
}
