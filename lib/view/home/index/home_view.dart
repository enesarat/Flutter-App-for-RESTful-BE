import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../core/base/state/base_state.dart';
import '../../../core/base/view/base_view.dart';
import '../../../viewmodel/home_view_model.dart';
import '../agent/list_agent_view.dart';
import '../agent/list_agent_view_test.dart';


class HomeView extends StatefulWidget {
  final String jwt;
  final Map<String,dynamic> payload;
  HomeView(this.jwt, this.payload);

  factory HomeView.fromBase64(String jwt) =>
      HomeView(
          jwt,
          json.decode(
              ascii.decode(
                  base64.decode(base64.normalize(jwt.split(".")[1]))
              )
          )
      );

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    viewModel.initService();
    //print("PAYLOAD====>"+widget.payload.toString());
    print("HOME WIEW");

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        viewModel: HomeViewModel(),
        onModelReady: (model){
          viewModel=model;
        },
        onPageBuilder: (context,value) => scaffoldBody,
        onDispose: (){}
    );
  }

  Widget get scaffoldBody=>Scaffold(
    appBar: AppBar(title: Text("Secret Data Screen")),
    body: Center(
      child: FutureBuilder(
          future: viewModel.service?.checkAuthorization(widget.payload,widget.jwt),
          builder: (context, snapshot) =>
          snapshot.hasData ?
          Column(
            children: <Widget>[
              Text("${widget.payload['nameid']}, here's the data:"),
              Text(snapshot.data.toString()),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListAgentScreen_()),
                  );
                },
                child: Text("All Agent"),
              )
            ],
          )
              :
          snapshot.hasError ? Text(" An error occurred") : CircularProgressIndicator()
      ),
    ),
  );
}
