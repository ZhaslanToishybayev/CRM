import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/crm/company_model.dart';

abstract class SupabaseCompanyDataSource {
  Future<List<CompanyModel>> getAllCompanies();
  Future<CompanyModel?> getCompanyById(String id);
  Future<CompanyModel> createCompany(CompanyModel company);
  Future<CompanyModel> updateCompany(CompanyModel company);
  Future<void> deleteCompany(String id);
  Future<List<CompanyModel>> searchCompanies(String query);
}

class SupabaseCompanyDataSourceImpl implements SupabaseCompanyDataSource {
  final SupabaseClient _supabase;

  SupabaseCompanyDataSourceImpl(this._supabase);

  @override
  Future<List<CompanyModel>> getAllCompanies() async {
    final response = await _supabase
        .from('crm_companies')
        .select()
        .order('created_at', ascending: false);

    return (response as List).map((json) => CompanyModel.fromJson(json)).toList();
  }

  @override
  Future<CompanyModel?> getCompanyById(String id) async {
    final response = await _supabase
        .from('crm_companies')
        .select()
        .eq('id', id)
        .maybeSingle();

    return response != null ? CompanyModel.fromJson(response) : null;
  }

  @override
  Future<CompanyModel> createCompany(CompanyModel company) async {
    final response = await _supabase
        .from('crm_companies')
        .insert(company.toJson())
        .select()
        .single();

    return CompanyModel.fromJson(response);
  }

  @override
  Future<CompanyModel> updateCompany(CompanyModel company) async {
    final response = await _supabase
        .from('crm_companies')
        .update(company.toJson())
        .eq('id', company.id)
        .select()
        .single();

    return CompanyModel.fromJson(response);
  }

  @override
  Future<void> deleteCompany(String id) async {
    await _supabase.from('crm_companies').delete().eq('id', id);
  }

  @override
  Future<List<CompanyModel>> searchCompanies(String query) async {
    final response = await _supabase
        .from('crm_companies')
        .select()
        .or('name.ilike.%$query%,industry.ilike.%$query%,website.ilike.%$query%')
        .order('created_at', ascending: false);

    return (response as List).map((json) => CompanyModel.fromJson(json)).toList();
  }
}
