import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sample_app_with_restful_api/core/base/model/agent_model.dart';
import 'package:sample_app_with_restful_api/core/init/network/network_manager.dart';

import '../../../core/base/state/base_state.dart';

class SingleAgentScreen extends StatefulWidget {
  const SingleAgentScreen({Key? key}) : super(key: key);

  @override
  _SingleAgentScreenState createState() => _SingleAgentScreenState();
}

class _SingleAgentScreenState extends BaseState<SingleAgentScreen> {
  late NetworkManager service;
  AgentModel? singleAgent;
  bool isLoading = false;

  Future getAgent()async{
    Response response;
    try{
      isLoading=true;
      response = await service.getRequest<AgentModel>("/api/agent/getagentbyid/1");

      isLoading=false;
      print("status : "+response.statusCode.toString());
      if(response.statusCode==200){
        setState(() {
          singleAgent = AgentModel.fromJson(response.data);
          isLoading=true;
        });
      }
      else{
        print("Something went wrong. Status code not equal to 200.");
      }
    } on Exception catch (e){
      isLoading=false;
      print(e);
    }

  }

  @override
  void initState() {
    service = NetworkManager.instance;

    getAgent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Single Agent Screen"),
        centerTitle: true,
      ),
      body: (isLoading==false)
          ?Center(child: CircularProgressIndicator(),)
          : singleAgent!=null
            ?Center(child:Padding(
                padding: const EdgeInsets.only(top: 200,bottom: 200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                        "Agent Id: ${singleAgent?.agentId}"),
                    Text(
                        "Agent Name: ${singleAgent?.agentName}"),
                    Text(
                        "Agent Manager Name: ${singleAgent?.agentManagerName}"),
                    Text(
                        "Agent Address: ${singleAgent?.agentAddress}"),
                  ],

                ),
            )
          )
            :Center(child: Text("User not found!"),)
    );
  }
}
