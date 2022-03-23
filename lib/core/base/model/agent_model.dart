import 'package:json_annotation/json_annotation.dart';
import 'package:sample_app_with_restful_api/core/base/model/base_model.dart';
part 'agent_model.g.dart';

@JsonSerializable()
class AgentModel implements BaseModel{
  @JsonKey(name:"agentId")
  int? agentId;

  @JsonKey(name:"agentName")
  String? agentName;

  @JsonKey(name:"agentManagerName")
  String? agentManagerName;

  @JsonKey(name:"agentAddress")
  String? agentAddress;

  AgentModel({this.agentId,this.agentName,this.agentManagerName,this.agentAddress});

  @override
  Map<String, dynamic> toJson() => _$AgentModelToJson(this);

  @override
  fromJson(Map<String,dynamic> json) {
    _$AgentModelFromJson(json);
  }

  factory AgentModel.fromJson(Map<String,dynamic> json){
    return _$AgentModelFromJson(json);
  }

 
}