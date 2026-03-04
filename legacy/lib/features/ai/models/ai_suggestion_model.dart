import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_suggestion_model.freezed.dart';
part 'ai_suggestion_model.g.dart';

@freezed
class AISuggestion with _$AISuggestion {
  const factory AISuggestion({
    required String id,
    required String title,
    required String description,
    required AISuggestionType type,
    required int priority,
    required double confidence,
    required DateTime createdAt,
    @Default([]) List<String> reasons,
    Map<String, dynamic>? metadata,
  }) = _AISuggestion;

  factory AISuggestion.fromJson(Map<String, dynamic> json) =>
      _$AISuggestionFromJson(json);
}

enum AISuggestionType {
  taskCreation,
  taskScheduling,
  priorityAdjustment,
  taskGrouping,
  deadlineOptimization,
  workloadBalancing,
  skillMatching,
  timeEstimation,
  delegation,
  resourceOptimization,
}
