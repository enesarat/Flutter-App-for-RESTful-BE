import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/base/model/agent_model.dart';
import '../../../core/init/network/network_manager.dart';

class ListAgentScreen extends StatefulWidget {
  @override
  _ListAgentScreenState createState() => _ListAgentScreenState();
}

class _ListAgentScreenState extends State<ListAgentScreen> {
  late NetworkManager service;
  AgentModel? singleAgent;
  bool isLoading = false;

  late List<dynamic> agents;

  Future getAgentList() async {
    Response response;
    try {
      isLoading = true;

      response = await service.getRequest("/api/agent");
      final responseBody = response.data;
      isLoading = false;
      print("status : "+response.statusCode.toString());
      if (response.statusCode == 200) {
        setState(() {
          agents = responseBody.map((e)=>AgentModel.fromJson(e)).toList();
        });
      }
      else{
        print("Something went wrong. Status code not equal to 200.");
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    service = NetworkManager.instance;

    getAgentList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agent List Screen"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : agents != null
          ? ListView.builder(
        itemBuilder: (context, index) {
          final agent = agents[index];

          return ListTile(
            title: Text(agent.agentName.toString()),
            leading: Text(agent.agentId.toString()),
            subtitle: Text(agent.agentManagerName.toString()),
          );
        },
        itemCount: agents.length,
      )
          : Center(
        child: Text("Not found any user!"),
      ),
    );
  }
}