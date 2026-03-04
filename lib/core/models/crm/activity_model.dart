import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_model.freezed.dart';
part 'activity_model.g.dart';

@freezed
class ActivityModel with _$ActivityModel {
  const factory ActivityModel({
    required String id,
    required String title,
    String? description,

    // Type of activity
    required ActivityType type,

    // Relations
    required String clientId,
    String? clientName,
    String? companyId,
    String? companyName,
    String? dealId,
    String? dealName,
    String? taskId,

    // Activity details
    ActivityDirection? direction,
    String? subject,
    String? outcome,

    // Participants
    @Default([]) List<String> participants,
    @Default([]) List<String> emailRecipients,
    String? callPhoneNumber,

    // Duration
    int? durationMinutes, // for calls, meetings

    // Date and time
    required DateTime createdAt,
    DateTime? scheduledAt,
    DateTime? completedAt,

    // User
    required String createdBy,
    String? createdByName,

    // Metadata
    Map<String, dynamic>? metadata,
    @Default([]) List<String> attachments,

    // Tags
    @Default([]) List<String> tags,
  }) = _ActivityModel;

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);
}

enum ActivityType {
  call,
  email,
  meeting,
  note,
  task,
  deal,
  sms,
  videoCall,
  social,
  other,
}

enum ActivityDirection {
  inbound,
  outbound,
}

extension ActivityTypeExtension on ActivityType {
  String get displayName {
    switch (this) {
      case ActivityType.call:
        return 'Phone Call';
      case ActivityType.email:
        return 'Email';
      case ActivityType.meeting:
        return 'Meeting';
      case ActivityType.note:
        return 'Note';
      case ActivityType.task:
        return 'Task';
      case ActivityType.deal:
        return 'Deal Update';
      case ActivityType.sms:
        return 'SMS';
      case ActivityType.videoCall:
        return 'Video Call';
      case ActivityType.social:
        return 'Social Media';
      case ActivityType.other:
        return 'Other';
    }
  }

  String get iconName {
    switch (this) {
      case ActivityType.call:
        return 'phone';
      case ActivityType.email:
        return 'email';
      case ActivityType.meeting:
        return 'event';
      case ActivityType.note:
        return 'note';
      case ActivityType.task:
        return 'task_alt';
      case ActivityType.deal:
        return 'trending_up';
      case ActivityType.sms:
        return 'sms';
      case ActivityType.videoCall:
        return 'videocam';
      case ActivityType.social:
        return 'share';
      case ActivityType.other:
        return 'info';
    }
  }
}

extension ActivityDirectionExtension on ActivityDirection {
  String get displayName {
    switch (this) {
      case ActivityDirection.inbound:
        return 'Inbound';
      case ActivityDirection.outbound:
        return 'Outbound';
    }
  }

  String get symbol {
    switch (this) {
      case ActivityDirection.inbound:
        return '↓';
      case ActivityDirection.outbound:
        return '↑';
    }
  }
}
