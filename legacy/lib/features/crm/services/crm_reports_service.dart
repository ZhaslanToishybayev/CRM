import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/crm/deal_model.dart';
import '../../../../core/models/crm/client_model.dart';

part 'crm_reports_service.g.dart';

class CrmReportsService {
  late final SupabaseClient _supabase;

  CrmReportsService() {
    _supabase = Supabase.instance.client;
  }

  // Get sales summary report
  Future<SalesSummaryReport> getSalesSummaryReport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final deals = await _getDealsInDateRange(startDate, endDate);

      final totalDeals = deals.length;
      final wonDeals = deals.where((d) => d.status == DealStatus.won).toList();
      final lostDeals = deals.where((d) => d.status == DealStatus.lost).toList();
      final openDeals = deals.where((d) => d.status == DealStatus.open).toList();

      final totalRevenue = deals.fold<double>(0, (sum, deal) => sum + deal.amount);
      final wonRevenue = wonDeals.fold<double>(0, (sum, deal) => sum + deal.amount);

      final averageDealSize = wonDeals.isNotEmpty ? wonRevenue / wonDeals.length : 0;
      final conversionRate = totalDeals > 0 ? (wonDeals.length / totalDeals) * 100 : 0;
      final winRate = totalDeals > 0 ? (wonDeals.length / totalDeals) * 100 : 0;
      final lossRate = totalDeals > 0 ? (lostDeals.length / totalDeals) * 100 : 0;

      return SalesSummaryReport(
        totalDeals: totalDeals,
        wonDeals: wonDeals.length,
        lostDeals: lostDeals.length,
        openDeals: openDeals.length,
        totalRevenue: totalRevenue,
        wonRevenue: wonRevenue,
        averageDealSize: averageDealSize.toDouble(),
        conversionRate: conversionRate.toDouble(),
        winRate: winRate.toDouble(),
        lossRate: lossRate.toDouble(),
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      print('Error generating sales summary report: $e');
      rethrow;
    }
  }

  // Get pipeline performance report
  Future<PipelinePerformanceReport> getPipelinePerformanceReport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final deals = await _getDealsInDateRange(startDate, endDate);

      final pipelineData = <String, List<DealModel>>{};
      for (final deal in deals) {
        // Group deals by stage
        // In a real implementation, you'd fetch stage names from database
        final stageName = deal.stageId; // This would be the stage name
        if (!pipelineData.containsKey(stageName)) {
          pipelineData[stageName] = [];
        }
        pipelineData[stageName]!.add(deal);
      }

      final stages = <PipelineStageReport>[];

      for (final entry in pipelineData.entries) {
        final stageDeals = entry.value;
        final stageWon = stageDeals.where((d) => d.status == DealStatus.won).toList();
        final stageRevenue = stageWon.fold<double>(0, (sum, deal) => sum + deal.amount);

        stages.add(
          PipelineStageReport(
            stageName: entry.key,
            totalDeals: stageDeals.length,
            wonDeals: stageWon.length,
            revenue: stageRevenue,
            conversionRate: stageDeals.isNotEmpty
                ? (stageWon.length / stageDeals.length) * 100
                : 0,
          ),
        );
      }

      // Sort stages by revenue (descending)
      stages.sort((a, b) => b.revenue.compareTo(a.revenue));

      return PipelinePerformanceReport(
        stages: stages,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      print('Error generating pipeline performance report: $e');
      rethrow;
    }
  }

  // Get sales by period report (monthly, quarterly, yearly)
  Future<SalesByPeriodReport> getSalesByPeriodReport({
    required DateTime startDate,
    required DateTime endDate,
    required PeriodType periodType,
  }) async {
    try {
      final deals = await _getDealsInDateRange(startDate, endDate);

      final periodData = <String, PeriodData>{};

      for (final deal in deals) {
        if (deal.createdAt == null) continue;
        final periodKey = _getPeriodKey(deal.createdAt!, periodType);

        if (!periodData.containsKey(periodKey)) {
          periodData[periodKey] = PeriodData(
            period: periodKey,
            deals: [],
            revenue: 0,
          );
        }

        final data = periodData[periodKey]!;
        data.deals.add(deal);
        data.revenue = data.revenue + deal.amount;
      }

      // Sort periods chronologically
      final periods = periodData.values.toList()
        ..sort((a, b) => a.period.compareTo(b.period));

      return SalesByPeriodReport(
        periods: periods,
        periodType: periodType,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      print('Error generating sales by period report: $e');
      rethrow;
    }
  }

  // Get top performers report
  Future<TopPerformersReport> getTopPerformersReport({
    required DateTime startDate,
    required DateTime endDate,
    int limit = 10,
  }) async {
    try {
      final deals = await _getDealsInDateRange(startDate, endDate);

      // Group deals by client
      final clientDeals = <String, List<DealModel>>{};
      for (final deal in deals) {
        if (deal.clientName == null) continue;

        if (!clientDeals.containsKey(deal.clientName!)) {
          clientDeals[deal.clientName!] = [];
        }
        clientDeals[deal.clientName!]!.add(deal);
      }

      // Calculate metrics for each client
      final performers = <PerformerData>[];

      for (final entry in clientDeals.entries) {
        final clientDealsList = entry.value;
        final wonDeals = clientDealsList.where((d) => d.status == DealStatus.won).toList();
        final revenue = wonDeals.fold<double>(0, (sum, deal) => sum + deal.amount);

        performers.add(
          PerformerData(
            name: entry.key,
            totalDeals: clientDealsList.length,
            wonDeals: wonDeals.length,
            revenue: revenue,
            averageDealSize: wonDeals.isNotEmpty ? revenue / wonDeals.length : 0,
          ),
        );
      }

      // Sort by revenue and limit
      performers.sort((a, b) => b.revenue.compareTo(a.revenue));
      final topPerformers = performers.take(limit).toList();

      return TopPerformersReport(
        performers: topPerformers,
        startDate: startDate,
        endDate: endDate,
        limit: limit,
      );
    } catch (e) {
      print('Error generating top performers report: $e');
      rethrow;
    }
  }

  // Get activity report
  Future<ActivityReport> getActivityReport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final response = await _supabase
          .from('crm_activities')
          .select()
          .gte('activity_date', startDate.toIso8601String())
          .lte('activity_date', endDate.toIso8601String());

      final activities = (response as List)
          .map((json) => json['type'] as String)
          .toList();

      // Count activities by type
      final activityCounts = <String, int>{};
      for (final activityType in activities) {
        activityCounts[activityType] = (activityCounts[activityType] ?? 0) + 1;
      }

      final totalActivities = activities.length;

      return ActivityReport(
        activityCounts: activityCounts,
        totalActivities: totalActivities,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      print('Error generating activity report: $e');
      rethrow;
    }
  }

  // Get detailed sales report with charts data
  Future<SalesDetailedReport> getDetailedSalesReport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final summary = await getSalesSummaryReport(
        startDate: startDate,
        endDate: endDate,
      );

      final byPeriod = await getSalesByPeriodReport(
        startDate: startDate,
        endDate: endDate,
        periodType: PeriodType.monthly,
      );

      final topPerformers = await getTopPerformersReport(
        startDate: startDate,
        endDate: endDate,
        limit: 5,
      );

      return SalesDetailedReport(
        summary: summary,
        byPeriod: byPeriod,
        topPerformers: topPerformers,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      print('Error generating detailed sales report: $e');
      rethrow;
    }
  }

  // Helper method to get deals in date range
  Future<List<DealModel>> _getDealsInDateRange(DateTime startDate, DateTime endDate) async {
    final response = await _supabase
        .from('crm_deals')
        .select()
        .gte('created_at', startDate.toIso8601String())
        .lte('created_at', endDate.toIso8601String());

    return (response as List)
        .map((json) => DealModel.fromJson(json))
        .toList();
  }

  // Helper method to get period key
  String _getPeriodKey(DateTime dateTime, PeriodType periodType) {
    switch (periodType) {
      case PeriodType.daily:
        return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
      case PeriodType.weekly:
        final weekNumber = ((dateTime.dayOfYear - 1) ~/ 7) + 1;
        return '${dateTime.year}-W$weekNumber';
      case PeriodType.monthly:
        return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}';
      case PeriodType.quarterly:
        final quarter = ((dateTime.month - 1) ~/ 3) + 1;
        return '${dateTime.year}-Q$quarter';
      case PeriodType.yearly:
        return '${dateTime.year}';
    }
  }
}

// Report models

class SalesSummaryReport {
  final int totalDeals;
  final int wonDeals;
  final int lostDeals;
  final int openDeals;
  final double totalRevenue;
  final double wonRevenue;
  final double averageDealSize;
  final double conversionRate;
  final double winRate;
  final double lossRate;
  final DateTime startDate;
  final DateTime endDate;

  SalesSummaryReport({
    required this.totalDeals,
    required this.wonDeals,
    required this.lostDeals,
    required this.openDeals,
    required this.totalRevenue,
    required this.wonRevenue,
    required this.averageDealSize,
    required this.conversionRate,
    required this.winRate,
    required this.lossRate,
    required this.startDate,
    required this.endDate,
  });
}

class PipelinePerformanceReport {
  final List<PipelineStageReport> stages;
  final DateTime startDate;
  final DateTime endDate;

  PipelinePerformanceReport({
    required this.stages,
    required this.startDate,
    required this.endDate,
  });
}

class PipelineStageReport {
  final String stageName;
  final int totalDeals;
  final int wonDeals;
  late final double revenue;
  final double conversionRate;

  PipelineStageReport({
    required this.stageName,
    required this.totalDeals,
    required this.wonDeals,
    required this.revenue,
    required this.conversionRate,
  });
}

class SalesByPeriodReport {
  final List<PeriodData> periods;
  final PeriodType periodType;
  final DateTime startDate;
  final DateTime endDate;

  SalesByPeriodReport({
    required this.periods,
    required this.periodType,
    required this.startDate,
    required this.endDate,
  });
}

class PeriodData {
  final String period;
  final List<DealModel> deals;
  late final double revenue;

  PeriodData({
    required this.period,
    required this.deals,
    required this.revenue,
  });
}

class TopPerformersReport {
  final List<PerformerData> performers;
  final DateTime startDate;
  final DateTime endDate;
  final int limit;

  TopPerformersReport({
    required this.performers,
    required this.startDate,
    required this.endDate,
    required this.limit,
  });
}

class PerformerData {
  final String name;
  final int totalDeals;
  final int wonDeals;
  late final double revenue;
  final double averageDealSize;

  PerformerData({
    required this.name,
    required this.totalDeals,
    required this.wonDeals,
    required this.revenue,
    required this.averageDealSize,
  });
}

class ActivityReport {
  final Map<String, int> activityCounts;
  final int totalActivities;
  final DateTime startDate;
  final DateTime endDate;

  ActivityReport({
    required this.activityCounts,
    required this.totalActivities,
    required this.startDate,
    required this.endDate,
  });
}

class SalesDetailedReport {
  final SalesSummaryReport summary;
  final SalesByPeriodReport byPeriod;
  final TopPerformersReport topPerformers;
  final DateTime startDate;
  final DateTime endDate;

  SalesDetailedReport({
    required this.summary,
    required this.byPeriod,
    required this.topPerformers,
    required this.startDate,
    required this.endDate,
  });
}

enum PeriodType {
  daily,
  weekly,
  monthly,
  quarterly,
  yearly,
}

// Extension for DateTime
extension DateTimeExtensions on DateTime {
  int get dayOfYear {
    final startOfYear = DateTime(year);
    return difference(startOfYear).inDays + 1;
  }
}

// Riverpod provider
@Riverpod(keepAlive: true)
CrmReportsService crmReportsService(CrmReportsServiceRef ref) {
  return CrmReportsService();
}
