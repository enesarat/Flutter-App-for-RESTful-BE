// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgentModel _$AgentModelFromJson(Map<String, dynamic> json) => AgentModel(
      agentId: json['agentId'] as int?,
      agentName: json['agentName'] as String?,
      agentManagerName: json['agentManagerName'] as String?,
      agentAddress: json['agentAddress'] as String?,
    );

Map<String, dynamic> _$AgentModelToJson(AgentModel instance) =>
    <String, dynamic>{
      'agentId': instance.agentId,
      'agentName': instance.agentName,
      'agentManagerName': instance.agentManagerName,
      'agentAddress': instance.agentAddress,
    };
