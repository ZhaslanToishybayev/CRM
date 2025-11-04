/// CRM Data Models
/// Educational Project - Gamified CRM System

import 'package:freezed_annotation/freezed_annotation.dart';

part 'crm_models.freezed.dart';
part 'crm_models.g.dart';

@freezed
class Client with _$Client {
  const factory Client({
    required String id,
    required String name,
    required String company,
    required String email,
    required String phone,
    required ClientStatus status,
    required String source,
    required String assignedTo,
    required double value,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Client;

  factory Client.fromJson(Map<String, dynamic> json) =>
      _$ClientFromJson(json);
}

enum ClientStatus {
  lead,
  prospect,
  active,
  inactive,
}

@freezed
class Deal with _$Deal {
  const factory Deal({
    required String id,
    required String clientId,
    required String title,
    required String description,
    required double value,
    required DealStage stage,
    required int probability,
    required DateTime expectedCloseDate,
    required String assignedTo,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Deal;

  factory Deal.fromJson(Map<String, dynamic> json) =>
      _$DealFromJson(json);
}

enum DealStage {
  newLead,
  qualified,
  proposal,
  negotiation,
  closedWon,
  closedLost,
}

@freezed
class Activity with _$Activity {
  const factory Activity({
    required String id,
    required String clientId,
    required String? dealId,
    required ActivityType type,
    required String description,
    required DateTime scheduledAt,
    DateTime? completedAt,
    required ActivityStatus status,
    required String createdBy,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}

enum ActivityType {
  call,
  email,
  meeting,
  note,
  reminder,
}

enum ActivityStatus {
  pending,
  completed,
}

@freezed
class SalesStats with _$SalesStats {
  const factory SalesStats({
    required double totalRevenue,
    required int totalDeals,
    required double conversionRate,
    required double averageDealSize,
    required List<DealStageStats> stageStats,
    required List<MonthlyRevenue> monthlyRevenue,
  }) = _SalesStats;

  factory SalesStats.fromJson(Map<String, dynamic> json) =>
      _$SalesStatsFromJson(json);
}

@freezed
class DealStageStats with _$DealStageStats {
  const factory DealStageStats({
    required DealStage stage,
    required int count,
    required double totalValue,
  }) = _DealStageStats;

  factory DealStageStats.fromJson(Map<String, dynamic> json) =>
      _$DealStageStatsFromJson(json);
}

@freezed
class MonthlyRevenue with _$MonthlyRevenue {
  const factory MonthlyRevenue({
    required String month,
    required double revenue,
  }) = _MonthlyRevenue;

  factory MonthlyRevenue.fromJson(Map<String, dynamic> json) =>
      _$MonthlyRevenueFromJson(json);
}
