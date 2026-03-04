import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/models/crm/deal_model.dart';
import '../../../../core/models/crm/pipeline_model.dart';
import '../data_sources/supabase_pipeline_data_source.dart';

part 'crm_sales_funnel_service.g.dart';

class CrmSalesFunnelService {
  late final SupabaseClient _supabase;
  late final SupabasePipelineDataSource _pipelineDataSource;

  CrmSalesFunnelService() {
    _supabase = Supabase.instance.client;
    _pipelineDataSource = SupabasePipelineDataSourceImpl(_supabase);
  }

  // Get sales funnel data with analytics
  Future<SalesFunnelData> getSalesFunnelData({
    required String pipelineId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      // Get pipeline with stages
      final pipeline = await _pipelineDataSource.getPipelineById(pipelineId);
      if (pipeline == null) {
        throw Exception('Pipeline not found');
      }

      // Get deals for this pipeline
      final deals = await _getDealsForPipeline(pipelineId, startDate, endDate);

      // Build funnel stages
      final funnelStages = <FunnelStageData>[];
      final totalValue = deals.fold<double>(0, (sum, deal) => sum + deal.amount);

      for (final stage in pipeline.stages) {
        final stageDeals = deals.where((deal) => deal.stageId == stage.id).toList();
        final stageValue = stageDeals.fold<double>(0, (sum, deal) => sum + deal.amount);
        final stageCount = stageDeals.length;

        final conversionRate = _calculateConversionRate(
          stageCount,
          pipeline.stages.isEmpty ? 0 : pipeline.stages.first.id == stage.id
              ? stageCount
              : _getPreviousStageCount(pipeline, stage, deals),
        );

        funnelStages.add(
          FunnelStageData(
            stage: stage,
            deals: stageDeals,
            count: stageCount,
            value: stageValue,
            percentageOfTotal: totalValue > 0 ? (stageValue / totalValue) * 100 : 0,
            conversionRate: conversionRate.toDouble(),
            dropOffRate: 100 - conversionRate,
          ),
        );
      }

      // Calculate overall metrics
      final totalDeals = deals.length;
      final wonDeals = deals.where((d) => d.status == DealStatus.won).length;
      final lostDeals = deals.where((d) => d.status == DealStatus.lost).length;
      final openDeals = deals.where((d) => d.status == DealStatus.open).length;

      final overallConversionRate = totalDeals > 0 ? (wonDeals / totalDeals) * 100 : 0;
      final totalWonValue = deals
          .where((d) => d.status == DealStatus.won)
          .fold<double>(0, (sum, deal) => sum + deal.amount);

      final averageDealSize = wonDeals > 0 ? totalWonValue / wonDeals : 0;

      return SalesFunnelData(
        pipeline: pipeline,
        stages: funnelStages,
        totalDeals: totalDeals,
        wonDeals: wonDeals,
        lostDeals: lostDeals,
        openDeals: openDeals,
        totalValue: totalValue,
        wonValue: totalWonValue,
        averageDealSize: averageDealSize.toDouble(),
        overallConversionRate: overallConversionRate.toDouble(),
        startDate: startDate ?? DateTime.now().subtract(Duration(days: 30)),
        endDate: endDate ?? DateTime.now(),
      );
    } catch (e) {
      print('Error getting sales funnel data: $e');
      rethrow;
    }
  }

  // Move deal to new stage
  Future<DealModel> moveDealToStage(
    String dealId,
    String newStageId,
    String userId,
  ) async {
    try {
      // Get deal
      final dealResponse = await _supabase
          .from('crm_deals')
          .select()
          .eq('id', dealId)
          .single();

      final deal = DealModel.fromJson(dealResponse);
      final oldStageId = deal.stageId;

      // Update deal stage
      final updatedDeal = deal.copyWith(stageId: newStageId);

      final response = await _supabase
          .from('crm_deals')
          .update(updatedDeal.toJson())
          .eq('id', dealId)
          .select()
          .single();

      final result = DealModel.fromJson(response);

      // Log activity
      // In a real app, you'd use the activity tracking service here
      // await _activityTrackingService.logDealStatusChanged(...);

      return result;
    } catch (e) {
      print('Error moving deal to stage: $e');
      rethrow;
    }
  }

  // Get funnel insights
  Future<FunnelInsights> getFunnelInsights(String pipelineId) async {
    try {
      final funnelData = await getSalesFunnelData(pipelineId: pipelineId);

      // Find bottlenecks (stages with highest drop-off rates)
      final bottlenecks = funnelData.stages
          .where((stage) => stage.dropOffRate > 50)
          .map((stage) => stage.stage.name)
          .toList();

      // Find best performing stage
      final bestStage = funnelData.stages.isNotEmpty
          ? funnelData.stages.reduce((a, b) =>
              a.conversionRate > b.conversionRate ? a : b)
          : null;

      // Calculate velocity (average time in pipeline)
      final velocity = _calculateVelocity(funnelData.stages);

      // Get stage trends (compare to previous period)
      final trends = _calculateTrends(funnelData.stages);

      return FunnelInsights(
        bottlenecks: bottlenecks,
        bestPerformingStage: bestStage?.stage.name,
        averageVelocity: velocity,
        trends: trends,
        recommendations: _generateRecommendations(funnelData),
      );
    } catch (e) {
      print('Error getting funnel insights: $e');
      rethrow;
    }
  }

  // Get funnel comparison (e.g., this period vs last period)
  Future<FunnelComparison> compareFunnelPeriods({
    required String pipelineId,
    required DateTime currentStart,
    required DateTime currentEnd,
    required DateTime previousStart,
    required DateTime previousEnd,
  }) async {
    try {
      final currentData = await getSalesFunnelData(
        pipelineId: pipelineId,
        startDate: currentStart,
        endDate: currentEnd,
      );

      final previousData = await getSalesFunnelData(
        pipelineId: pipelineId,
        startDate: previousStart,
        endDate: previousEnd,
      );

      return FunnelComparison(
        current: currentData,
        previous: previousData,
        dealChange: currentData.totalDeals - previousData.totalDeals,
        valueChange: currentData.wonValue - previousData.wonValue,
        conversionChange:
            currentData.overallConversionRate - previousData.overallConversionRate,
      );
    } catch (e) {
      print('Error comparing funnel periods: $e');
      rethrow;
    }
  }

  // Helper methods

  Future<List<DealModel>> _getDealsForPipeline(
    String pipelineId,
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    var query = _supabase
        .from('crm_deals')
        .select()
        .eq('stage_id', _getStageIdByPipeline(pipelineId));

    if (startDate != null) {
      query = query.gte('created_at', startDate.toIso8601String());
    }

    if (endDate != null) {
      query = query.lte('created_at', endDate.toIso8601String());
    }

    final response = await query;
    return (response as List).map((json) => DealModel.fromJson(json)).toList();
  }

  String _getStageIdByPipeline(String pipelineId) {
    // This is a simplified approach
    // In a real implementation, you'd get all stages for the pipeline
    // and return deals from any of those stages
    return pipelineId;
  }

  double _calculateConversionRate(int currentStageCount, int previousStageCount) {
    if (previousStageCount == 0) return 0;
    return (currentStageCount / previousStageCount) * 100;
  }

  int _getPreviousStageCount(
    PipelineModel pipeline,
    PipelineStage stage,
    List<DealModel> deals,
  ) {
    final stageIndex = pipeline.stages.indexOf(stage);
    if (stageIndex <= 0) return deals.length;

    final previousStage = pipeline.stages[stageIndex - 1];
    return deals.where((deal) => deal.stageId == previousStage.id).length;
  }

  double _calculateVelocity(List<FunnelStageData> stages) {
    // Simplified velocity calculation
    // In a real app, you'd track the time deals spend in each stage
    return 30; // days
  }

  Map<String, double> _calculateTrends(List<FunnelStageData> stages) {
    // Simplified trend calculation
    // In a real app, you'd compare current period to previous period
    final trends = <String, double>{};
    for (final stage in stages) {
      trends[stage.stage.name] = 0;
    }
    return trends;
  }

  List<String> _generateRecommendations(SalesFunnelData funnelData) {
    final recommendations = <String>[];

    // Find stages with low conversion rates
    for (final stage in funnelData.stages) {
      if (stage.conversionRate < 30) {
        recommendations.add(
          'Focus on improving conversion in "${stage.stage.name}" stage (currently ${stage.conversionRate.toStringAsFixed(1)}%)',
        );
      }
    }

    // Check for high-value deals stuck in early stages
    final earlyStage = funnelData.stages.first;
    if (earlyStage.value > funnelData.totalValue * 0.5) {
      recommendations.add(
        'High value deals in early stage - consider accelerating qualification process',
      );
    }

    // Overall conversion rate recommendation
    if (funnelData.overallConversionRate < 20) {
      recommendations.add(
        'Overall conversion rate is below 20% - review sales process and qualification criteria',
      );
    }

    return recommendations;
  }
}

// Data models

class SalesFunnelData {
  final PipelineModel pipeline;
  final List<FunnelStageData> stages;
  final int totalDeals;
  final int wonDeals;
  final int lostDeals;
  final int openDeals;
  final double totalValue;
  final double wonValue;
  final double averageDealSize;
  final double overallConversionRate;
  final DateTime startDate;
  final DateTime endDate;

  SalesFunnelData({
    required this.pipeline,
    required this.stages,
    required this.totalDeals,
    required this.wonDeals,
    required this.lostDeals,
    required this.openDeals,
    required this.totalValue,
    required this.wonValue,
    required this.averageDealSize,
    required this.overallConversionRate,
    required this.startDate,
    required this.endDate,
  });
}

class FunnelStageData {
  final PipelineStage stage;
  final List<DealModel> deals;
  final int count;
  final double value;
  final double percentageOfTotal;
  final double conversionRate;
  final double dropOffRate;

  FunnelStageData({
    required this.stage,
    required this.deals,
    required this.count,
    required this.value,
    required this.percentageOfTotal,
    required this.conversionRate,
    required this.dropOffRate,
  });
}

class FunnelInsights {
  final List<String> bottlenecks;
  final String? bestPerformingStage;
  final double averageVelocity;
  final Map<String, double> trends;
  final List<String> recommendations;

  FunnelInsights({
    required this.bottlenecks,
    required this.bestPerformingStage,
    required this.averageVelocity,
    required this.trends,
    required this.recommendations,
  });
}

class FunnelComparison {
  final SalesFunnelData current;
  final SalesFunnelData previous;
  final int dealChange;
  final double valueChange;
  final double conversionChange;

  FunnelComparison({
    required this.current,
    required this.previous,
    required this.dealChange,
    required this.valueChange,
    required this.conversionChange,
  });
}

// Riverpod provider
@Riverpod(keepAlive: true)
CrmSalesFunnelService crmSalesFunnelService(CrmSalesFunnelServiceRef ref) {
  return CrmSalesFunnelService();
}
