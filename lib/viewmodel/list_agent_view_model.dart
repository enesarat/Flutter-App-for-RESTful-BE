import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../core/base/model/agent_model.dart';
import '../core/init/network/network_manager.dart';

part 'list_agent_view_model.g.dart';

class ListAgentScreenViewModel = _ListAgentScreenViewModelBase with _$ListAgentScreenViewModel;

abstract class _ListAgentScreenViewModelBase with Store {
  @observable
  NetworkManager? service;
  @observable
  AgentModel? singleAgent;
  @observable
  bool isLoading = false;
  @observable
  late List<dynamic> agents = <dynamic>[];

  @action
  void initService() {
    service=NetworkManager.instance;
    getAgentList();
  }

  @action
  Future getAgentList() async {
    Response? response;
    try {
      isLoading = true;

      response = await service?.getRequest("/api/agent");
      final responseBody = response?.data;
      isLoading = false;
      print("status : "+response!.statusCode.toString());
      if (response.statusCode == 200) {
        refreshAgents(responseBody);
        print("AGENTS CONTEXT 2:"+this.agents.toString());

      }
      else{
        print("Something went wrong. Status code not equal to 200.");
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @action // agents için setState olmuyor
  void refreshAgents(dynamic responseBody){
    print("RESPONSE BODY:"+responseBody.toString());
    try {
      agents = List.from(responseBody.map((e) => AgentModel.fromJson(e)).toList());
      print("AGENTS CONTEXT:" + this.agents.toString());
    }on  Exception catch(e){
      print("refreshAgents PATLADI"+e.toString());
    }
  }
}