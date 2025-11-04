// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamMemberModelImpl _$$TeamMemberModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TeamMemberModelImpl(
      id: json['id'] as String,
      teamId: json['teamId'] as String,
      userId: json['userId'] as String,
      role: $enumDecode(_$TeamMemberRoleEnumMap, json['role']),
      status: $enumDecode(_$TeamMemberStatusEnumMap, json['status']),
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      lastActiveAt: json['lastActiveAt'] == null
          ? null
          : DateTime.parse(json['lastActiveAt'] as String),
      addedBy: json['addedBy'] as String?,
    );

Map<String, dynamic> _$$TeamMemberModelImplToJson(
        _$TeamMemberModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teamId': instance.teamId,
      'userId': instance.userId,
      'role': _$TeamMemberRoleEnumMap[instance.role]!,
      'status': _$TeamMemberStatusEnumMap[instance.status]!,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
      'addedBy': instance.addedBy,
    };

const _$TeamMemberRoleEnumMap = {
  TeamMemberRole.employee: 'employee',
  TeamMemberRole.manager: 'manager',
  TeamMemberRole.admin: 'admin',
};

const _$TeamMemberStatusEnumMap = {
  TeamMemberStatus.active: 'active',
  TeamMemberStatus.inactive: 'inactive',
  TeamMemberStatus.pending: 'pending',
};
