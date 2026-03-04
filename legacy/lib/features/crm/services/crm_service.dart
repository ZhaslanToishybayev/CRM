import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/crm/client_model.dart';
import '../../../../core/models/crm/company_model.dart';
import '../../../../core/models/crm/deal_model.dart';
import '../../../../core/models/crm/crm_task_model.dart';
import '../../../../core/models/crm/activity_model.dart';
import '../../../../core/models/crm/pipeline_model.dart';
import '../data_sources/supabase_client_data_source.dart';
import '../data_sources/supabase_deal_data_source.dart';
import '../data_sources/supabase_company_data_source.dart';
import '../data_sources/supabase_crm_task_data_source.dart';
import '../data_sources/supabase_activity_data_source.dart';
import '../data_sources/supabase_pipeline_data_source.dart';

part 'crm_service.g.dart';

// CRM Service - Main service for all CRM operations
class CrmService {
  late final SupabaseClient _supabase;
  late final SupabaseClientDataSource _clientDataSource;
  late final SupabaseDealDataSource _dealDataSource;
  late final SupabaseCompanyDataSource _companyDataSource;
  late final SupabaseCrmTaskDataSource _taskDataSource;
  late final SupabaseActivityDataSource _activityDataSource;
  late final SupabasePipelineDataSource _pipelineDataSource;

  CrmService() {
    _supabase = Supabase.instance.client;
    _clientDataSource = SupabaseClientDataSourceImpl(_supabase);
    _dealDataSource = SupabaseDealDataSourceImpl(_supabase);
    _companyDataSource = SupabaseCompanyDataSourceImpl(_supabase);
    _taskDataSource = SupabaseCrmTaskDataSourceImpl(_supabase);
    _activityDataSource = SupabaseActivityDataSourceImpl(_supabase);
    _pipelineDataSource = SupabasePipelineDataSourceImpl(_supabase);
  }

  // Client operations
  Future<List<ClientModel>> getClients() async {
    try {
      return await _clientDataSource.getAllClients();
    } catch (e) {
      print('Error getting clients: $e');
      return [];
    }
  }

  Future<ClientModel?> getClientById(String id) async {
    try {
      return await _clientDataSource.getClientById(id);
    } catch (e) {
      print('Error getting client: $e');
      return null;
    }
  }

  Future<ClientModel> createClient(ClientModel client) async {
    try {
      return await _clientDataSource.createClient(client);
    } catch (e) {
      print('Error creating client: $e');
      rethrow;
    }
  }

  Future<ClientModel> updateClient(ClientModel client) async {
    try {
      return await _clientDataSource.updateClient(client);
    } catch (e) {
      print('Error updating client: $e');
      rethrow;
    }
  }

  Future<void> deleteClient(String id) async {
    try {
      await _clientDataSource.deleteClient(id);
    } catch (e) {
      print('Error deleting client: $e');
      rethrow;
    }
  }

  Future<List<ClientModel>> searchClients(String query) async {
    try {
      return await _clientDataSource.searchClients(query);
    } catch (e) {
      print('Error searching clients: $e');
      return [];
    }
  }

  // Deal operations
  Future<List<DealModel>> getDeals() async {
    try {
      return await _dealDataSource.getAllDeals();
    } catch (e) {
      print('Error getting deals: $e');
      return [];
    }
  }

  Future<DealModel?> getDealById(String id) async {
    try {
      return await _dealDataSource.getDealById(id);
    } catch (e) {
      print('Error getting deal: $e');
      return null;
    }
  }

  Future<List<DealModel>> getDealsByClient(String clientId) async {
    try {
      final allDeals = await _dealDataSource.getAllDeals();
      return allDeals.where((deal) => deal.clientId == clientId).toList();
    } catch (e) {
      print('Error getting deals by client: $e');
      return [];
    }
  }

  Future<DealModel> createDeal(DealModel deal) async {
    try {
      return await _dealDataSource.createDeal(deal);
    } catch (e) {
      print('Error creating deal: $e');
      rethrow;
    }
  }

  Future<DealModel> updateDeal(DealModel deal) async {
    try {
      return await _dealDataSource.updateDeal(deal);
    } catch (e) {
      print('Error updating deal: $e');
      rethrow;
    }
  }

  Future<void> deleteDeal(String id) async {
    try {
      await _dealDataSource.deleteDeal(id);
    } catch (e) {
      print('Error deleting deal: $e');
      rethrow;
    }
  }

  Future<List<DealModel>> searchDeals(String query) async {
    try {
      return await _dealDataSource.searchDeals(query);
    } catch (e) {
      print('Error searching deals: $e');
      return [];
    }
  }

  Future<double> getTotalDealsValue() async {
    try {
      return await _dealDataSource.getTotalDealsValue();
    } catch (e) {
      print('Error getting total deals value: $e');
      return 0.0;
    }
  }

  Future<double> getWonDealsValue() async {
    try {
      return await _dealDataSource.getWonDealsValue();
    } catch (e) {
      print('Error getting won deals value: $e');
      return 0.0;
    }
  }

  // Company operations
  Future<List<CompanyModel>> getCompanies() async {
    try {
      return await _companyDataSource.getAllCompanies();
    } catch (e) {
      print('Error getting companies: $e');
      return [];
    }
  }

  Future<CompanyModel?> getCompanyById(String id) async {
    try {
      return await _companyDataSource.getCompanyById(id);
    } catch (e) {
      print('Error getting company: $e');
      return null;
    }
  }

  Future<CompanyModel> createCompany(CompanyModel company) async {
    try {
      return await _companyDataSource.createCompany(company);
    } catch (e) {
      print('Error creating company: $e');
      rethrow;
    }
  }

  Future<CompanyModel> updateCompany(CompanyModel company) async {
    try {
      return await _companyDataSource.updateCompany(company);
    } catch (e) {
      print('Error updating company: $e');
      rethrow;
    }
  }

  Future<void> deleteCompany(String id) async {
    try {
      await _companyDataSource.deleteCompany(id);
    } catch (e) {
      print('Error deleting company: $e');
      rethrow;
    }
  }

  Future<List<CompanyModel>> searchCompanies(String query) async {
    try {
      return await _companyDataSource.searchCompanies(query);
    } catch (e) {
      print('Error searching companies: $e');
      return [];
    }
  }

  // CRM Task operations
  Future<List<CrmTaskModel>> getCrmTasks() async {
    try {
      return await _taskDataSource.getAllTasks();
    } catch (e) {
      print('Error getting tasks: $e');
      return [];
    }
  }

  Future<CrmTaskModel?> getCrmTaskById(String id) async {
    try {
      return await _taskDataSource.getTaskById(id);
    } catch (e) {
      print('Error getting task: $e');
      return null;
    }
  }

  Future<List<CrmTaskModel>> getTasksByClient(String clientId) async {
    try {
      return await _taskDataSource.getTasksByClientId(clientId);
    } catch (e) {
      print('Error getting tasks by client: $e');
      return [];
    }
  }

  Future<List<CrmTaskModel>> getTasksByDeal(String dealId) async {
    try {
      final allTasks = await _taskDataSource.getAllTasks();
      return allTasks.where((task) => task.dealId == dealId).toList();
    } catch (e) {
      print('Error getting tasks by deal: $e');
      return [];
    }
  }

  Future<CrmTaskModel> createCrmTask(CrmTaskModel task) async {
    try {
      return await _taskDataSource.createTask(task);
    } catch (e) {
      print('Error creating task: $e');
      rethrow;
    }
  }

  Future<CrmTaskModel> updateCrmTask(CrmTaskModel task) async {
    try {
      return await _taskDataSource.updateTask(task);
    } catch (e) {
      print('Error updating task: $e');
      rethrow;
    }
  }

  Future<void> deleteCrmTask(String id) async {
    try {
      await _taskDataSource.deleteTask(id);
    } catch (e) {
      print('Error deleting task: $e');
      rethrow;
    }
  }

  Future<List<CrmTaskModel>> getTodaysTasks() async {
    try {
      return await _taskDataSource.getTodaysTasks();
    } catch (e) {
      print('Error getting today\'s tasks: $e');
      return [];
    }
  }

  Future<List<CrmTaskModel>> getUpcomingTasks() async {
    try {
      return await _taskDataSource.getUpcomingTasks();
    } catch (e) {
      print('Error getting upcoming tasks: $e');
      return [];
    }
  }

  // Activity operations
  Future<List<ActivityModel>> getActivities() async {
    try {
      return await _activityDataSource.getAllActivities();
    } catch (e) {
      print('Error getting activities: $e');
      return [];
    }
  }

  Future<ActivityModel?> getActivityById(String id) async {
    try {
      return await _activityDataSource.getActivityById(id);
    } catch (e) {
      print('Error getting activity: $e');
      return null;
    }
  }

  Future<List<ActivityModel>> getActivitiesByClient(String clientId) async {
    try {
      return await _activityDataSource.getActivitiesByClientId(clientId);
    } catch (e) {
      print('Error getting activities by client: $e');
      return [];
    }
  }

  Future<List<ActivityModel>> getActivitiesByDeal(String dealId) async {
    try {
      return await _activityDataSource.getActivitiesByDealId(dealId);
    } catch (e) {
      print('Error getting activities by deal: $e');
      return [];
    }
  }

  Future<List<ActivityModel>> getRecentActivities(int limit) async {
    try {
      return await _activityDataSource.getRecentActivities(limit);
    } catch (e) {
      print('Error getting recent activities: $e');
      return [];
    }
  }

  Future<ActivityModel> createActivity(ActivityModel activity) async {
    try {
      return await _activityDataSource.createActivity(activity);
    } catch (e) {
      print('Error creating activity: $e');
      rethrow;
    }
  }

  Future<ActivityModel> updateActivity(ActivityModel activity) async {
    try {
      return await _activityDataSource.updateActivity(activity);
    } catch (e) {
      print('Error updating activity: $e');
      rethrow;
    }
  }

  Future<void> deleteActivity(String id) async {
    try {
      await _activityDataSource.deleteActivity(id);
    } catch (e) {
      print('Error deleting activity: $e');
      rethrow;
    }
  }

  // Pipeline operations
  Future<List<PipelineModel>> getPipelines() async {
    try {
      return await _pipelineDataSource.getAllPipelines();
    } catch (e) {
      print('Error getting pipelines: $e');
      return [];
    }
  }

  Future<PipelineModel?> getPipelineById(String id) async {
    try {
      return await _pipelineDataSource.getPipelineById(id);
    } catch (e) {
      print('Error getting pipeline: $e');
      return null;
    }
  }

  Future<PipelineModel> createPipeline(PipelineModel pipeline) async {
    try {
      return await _pipelineDataSource.createPipeline(pipeline);
    } catch (e) {
      print('Error creating pipeline: $e');
      rethrow;
    }
  }

  Future<PipelineModel> updatePipeline(PipelineModel pipeline) async {
    try {
      return await _pipelineDataSource.updatePipeline(pipeline);
    } catch (e) {
      print('Error updating pipeline: $e');
      rethrow;
    }
  }

  Future<void> deletePipeline(String id) async {
    try {
      await _pipelineDataSource.deletePipeline(id);
    } catch (e) {
      print('Error deleting pipeline: $e');
      rethrow;
    }
  }

  // Analytics operations
  Future<CrmAnalytics> getAnalytics() async {
    try {
      final clients = await getClients();
      final deals = await getDeals();
      final wonDeals = deals.where((d) => d.status == DealStatus.won).toList();

      final totalClients = clients.length;
      final totalDeals = deals.length;
      final activeDeals = deals.where((d) => d.status == DealStatus.open).length;
      final totalRevenue = deals.fold<double>(0, (sum, deal) => sum + deal.amount);
      final wonRevenue = wonDeals.fold<double>(0, (sum, deal) => sum + deal.amount);
      final conversionRate = totalDeals > 0 ? (wonDeals.length / totalDeals) * 100 : 0;
      final averageDealSize = wonDeals.isNotEmpty ? wonRevenue / wonDeals.length : 0;

      return CrmAnalytics(
        totalClients: totalClients,
        totalDeals: totalDeals,
        totalRevenue: wonRevenue,
        conversionRate: conversionRate.toDouble(),
        averageDealSize: averageDealSize.toDouble(),
        activeDeals: activeDeals,
      );
    } catch (e) {
      print('Error getting analytics: $e');
      return const CrmAnalytics(
        totalClients: 0,
        totalDeals: 0,
        totalRevenue: 0,
        conversionRate: 0,
        averageDealSize: 0,
        activeDeals: 0,
      );
    }
  }
}

// Analytics model
class CrmAnalytics {
  final int totalClients;
  final int totalDeals;
  final double totalRevenue;
  final double conversionRate;
  final double averageDealSize;
  final int activeDeals;

  const CrmAnalytics({
    required this.totalClients,
    required this.totalDeals,
    required this.totalRevenue,
    required this.conversionRate,
    required this.averageDealSize,
    required this.activeDeals,
  });
}

// Riverpod provider
@Riverpod(keepAlive: true)
CrmService crmService(CrmServiceRef ref) {
  return CrmService();
}
