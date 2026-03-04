import 'package:freezed_annotation/freezed_annotation.dart';

part 'pipeline_model.freezed.dart';
part 'pipeline_model.g.dart';

@freezed
class PipelineModel with _$PipelineModel {
  const factory PipelineModel({
    required String id,
    required String name,
    String? description,
    required bool isDefault,

    // Stages
    @Default([]) List<PipelineStage> stages,

    // Metrics
    double? totalValue,
    int? totalDeals,
    int? wonDeals,
    int? lostDeals,

    // Dates
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PipelineModel;

  factory PipelineModel.fromJson(Map<String, dynamic> json) =>
      _$PipelineModelFromJson(json);
}

@freezed
class PipelineStage with _$PipelineStage {
  const factory PipelineStage({
    required String id,
    required String name,
    required int order,
    required double probability,
    String? description,
    int? color,
  }) = _PipelineStage;

  factory PipelineStage.fromJson(Map<String, dynamic> json) =>
      _$PipelineStageFromJson(json);
}

extension PipelineStageExtension on PipelineStage {
  String get displayProbability {
    return '${probability.toInt()}%';
  }

  int get colorHex {
    return color ?? 0xFF2196F3;
  }
}

// Predefined pipeline stages
class DefaultPipeline {
  static List<PipelineStage> get stages => [
        PipelineStage(
          id: '1',
          name: 'Lead',
          order: 1,
          probability: 10,
          color: 0xFF9E9E9E,
        ),
        PipelineStage(
          id: '2',
          name: 'Qualified',
          order: 2,
          probability: 25,
          color: 0xFFFFB74D,
        ),
        PipelineStage(
          id: '3',
          name: 'Proposal',
          order: 3,
          probability: 50,
          color: 0xFF2196F3,
        ),
        PipelineStage(
          id: '4',
          name: 'Negotiation',
          order: 4,
          probability: 75,
          color: 0xFF9C27B0,
        ),
        PipelineStage(
          id: '5',
          name: 'Closed Won',
          order: 5,
          probability: 100,
          color: 0xFF4CAF50,
        ),
      ];
}
