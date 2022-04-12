import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/init/network/network_manager.dart';
import '../../../main.dart';
import '../../home/index/home_view.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  late NetworkManager service;

  @override
  void initState() {
    service = NetworkManager.instance;

    super.initState();
  }

  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
            title: Text(title),
            content: Text(text)
        ),
  );

  Future<Response?> tryLogin(String username, String password)async{
    Response? response;

    try{
      response = await service.postRequestToLogIn(username, password);
      if (response!.statusCode == 200) {
        //print(response.data.toString());
        return response;
      } else {
        print("Something went wrong. Status code not equal to 200.");
        return null;
      }
    }on Exception catch (e){
      //isLoading=false;
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Log In"),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: 'Username'
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    var jwt = await tryLogin(username, password);
                    if(jwt != null) {
                      storage.write(key: "jwt", value: jwt.data);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen.fromBase64(jwt.data)
                          )
                      );
                    } else {
                      displayDialog(context, "An Error Occurred", "No account was found matching that username and password");
                    }
                  },
                  child: Text("Log In")
              ),
            ],
          ),
        )
    );
  }
}