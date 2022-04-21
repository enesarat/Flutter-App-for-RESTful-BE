import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/init/network/network_manager.dart';
import '../../../main.dart';

class HomeScreen extends StatefulWidget {
  final String jwt;
  final Map<String,dynamic> payload;
  HomeScreen(this.jwt, this.payload);

  factory HomeScreen.fromBase64(String jwt) =>
      HomeScreen(
          jwt,
          json.decode(
              ascii.decode(
                  base64.decode(base64.normalize(jwt.split(".")[1]))
              )
          )
      );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NetworkManager service;
  late String loginTime;

  @override
  void initState() {
    service = NetworkManager.instance;
    getLoginTime;
    //print("PAYLOAD====>"+widget.payload.toString());
    super.initState();
  }

  void get getLoginTime async {
    var loginTime_ = await storage.read(key: "loginTime");
    setState(() {
      loginTime=loginTime_!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Secret Data Screen")),
      body: Center(
        child: FutureBuilder(
            future: service.checkAuthorization(widget.payload,widget.jwt),
            builder: (context, snapshot) =>
            snapshot.hasData ?
            Column(
              children: <Widget>[
                Text("${widget.payload['nameid']}, here's the data:"),
                Text(snapshot.data.toString())
              ],
            )
                :
            snapshot.hasError ? Text(DateTime.now().toString()+" -- "+loginTime+" An error occurred") : CircularProgressIndicator()
        ),
      ),
    );
  }
}
