import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/crm/client_model.dart';

abstract class SupabaseClientDataSource {
  Future<List<ClientModel>> getAllClients();
  Future<ClientModel?> getClientById(String id);
  Future<List<ClientModel>> getClientsByStatus(ClientStatus status);
  Future<ClientModel> createClient(ClientModel client);
  Future<ClientModel> updateClient(ClientModel client);
  Future<void> deleteClient(String id);
  Future<List<ClientModel>> searchClients(String query);
}

class SupabaseClientDataSourceImpl implements SupabaseClientDataSource {
  final SupabaseClient _supabase;

  SupabaseClientDataSourceImpl(this._supabase);

  @override
  Future<List<ClientModel>> getAllClients() async {
    final response = await _supabase
        .from('crm_clients')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((json) => ClientModel.fromJson(json)).toList();
  }

  @override
  Future<ClientModel?> getClientById(String id) async {
    final response = await _supabase
        .from('crm_clients')
        .select()
        .eq('id', id)
        .maybeSingle();

    return response != null ? ClientModel.fromJson(response) : null;
  }

  @override
  Future<List<ClientModel>> getClientsByStatus(ClientStatus status) async {
    final response = await _supabase
        .from('crm_clients')
        .select()
        .eq('status', status.name)
        .order('created_at', ascending: false);

    return (response as List).map((json) => ClientModel.fromJson(json)).toList();
  }

  @override
  Future<ClientModel> createClient(ClientModel client) async {
    final response = await _supabase
        .from('crm_clients')
        .insert(client.toJson())
        .select()
        .single();

    return ClientModel.fromJson(response);
  }

  @override
  Future<ClientModel> updateClient(ClientModel client) async {
    final response = await _supabase
        .from('crm_clients')
        .update(client.toJson())
        .eq('id', client.id)
        .select()
        .single();

    return ClientModel.fromJson(response);
  }

  @override
  Future<void> deleteClient(String id) async {
    await _supabase.from('crm_clients').delete().eq('id', id);
  }

  @override
  Future<List<ClientModel>> searchClients(String query) async {
    final response = await _supabase
        .from('crm_clients')
        .select()
        .or('first_name.ilike.%$query%,last_name.ilike.%$query%,email.ilike.%$query%,company_name.ilike.%$query%')
        .order('created_at', ascending: false);

    return (response as List).map((json) => ClientModel.fromJson(json)).toList();
  }
}
