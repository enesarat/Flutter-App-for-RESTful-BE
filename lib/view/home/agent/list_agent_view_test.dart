import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sample_app_with_restful_api/viewmodel/list_agent_view_model.dart';

import '../../../core/base/model/agent_model.dart';
import '../../../core/base/state/base_state.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/init/network/network_manager.dart';

class ListAgentScreen extends StatefulWidget {
  @override
  _ListAgentScreenState createState() => _ListAgentScreenState();
}

class _ListAgentScreenState extends BaseState<ListAgentScreen> {
  ListAgentScreenViewModel viewModel = ListAgentScreenViewModel();

  @override
  void initState() {
    viewModel.initService();

    viewModel.getAgentList();
    print("INIT STATE:"+viewModel.agents.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ListAgentScreenViewModel>(
        viewModel: ListAgentScreenViewModel(),
        onModelReady: (model){
          viewModel=model;
        },
        onPageBuilder: (context,value) => scaffoldBody,
        onDispose: (){}
    );
  }


    Widget get scaffoldBody=>Scaffold(
      appBar: AppBar(
        title: Text("Agent List Screen"),
        centerTitle: true,
      ),
      body: viewModel.isLoading
          ? getProgressIndicator
          : viewModel.agents != null
          ? buildListView
          : getStatusInfo,
    );

    Widget get getStatusInfo {
      return Center(
      child: Text("Not found any user!"),
    );
    }

    Widget get getProgressIndicator => Center(child: CircularProgressIndicator());

    Widget get buildListView {
      return Observer(
            builder: (BuildContext context) => ListView.builder(
            itemBuilder: (context, index) {
              final agent = viewModel.agents[index];

              return ListTile(
                title: Text(viewModel.agents[index].agentName.toString()),
                leading: Text(viewModel.agents[index].agentId.toString()),
                subtitle: Text(viewModel.agents[index].agentManagerName.toString()),
              );
            },
            itemCount: viewModel.agents.length,
        )
      );
    }

}