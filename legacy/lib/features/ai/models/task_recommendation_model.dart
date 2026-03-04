import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_recommendation_model.freezed.dart';
part 'task_recommendation_model.g.dart';

@freezed
class TaskRecommendation with _$TaskRecommendation {
  const factory TaskRecommendation({
    required String id,
    required String title,
    required String description,
    required int estimatedDuration,
    required DateTime recommendedDueDate,
    required int suggestedPriority,
    required String suggestedCategory,
    @Default([]) List<String> tags,
    required double matchScore,
    Map<String, dynamic>? context,
  }) = _TaskRecommendation;

  factory TaskRecommendation.fromJson(Map<String, dynamic> json) =>
      _$TaskRecommendationFromJson(json);
}

@freezed
class AIInsight with _$AIInsight {
  const factory AIInsight({
    required String id,
    required String type,
    required String title,
    required String message,
    required double importance,
    required DateTime createdAt,
    @Default([]) List<String> actions,
    Map<String, dynamic>? data,
  }) = _AIInsight;

  factory AIInsight.fromJson(Map<String, dynamic> json) =>
      _$AIInsightFromJson(json);
}

enum InsightType {
  productivity,
  workload,
  deadline,
  performance,
  patterns,
  optimization,
}
