import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:sample_app_with_restful_api/view/authentication/login/login_view.dart';
import 'package:sample_app_with_restful_api/view/authentication/test/view/test_view.dart';
import 'package:sample_app_with_restful_api/view/home/agent/list_agent_view.dart';
import 'package:sample_app_with_restful_api/view/home/agent/single_agent_view.dart';
//import 'package:sample_app_with_restful_api/view/home/index/home_view_old.dart';
import 'package:sample_app_with_restful_api/view/home/index/home_view.dart';

import 'core/init/security/asymmetric_cryptography.dart';

final storage = FlutterSecureStorage();

///// Encryption Decryption test /////
/*void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  var e = new Encrypt();
  var encrypted = await e.textEncryptor("Important Information Here") as Encrypted;
  print("main=>encrypted=> "+encrypted.base64);
  print("main=>decrypted=> "+e.textDecryptor(encrypted));

}*/

void main() {
  runApp( MyApp());
}

/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}*/

class MyApp extends StatelessWidget {
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if(jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: jwtOrEmpty,
          builder: (context, snapshot) {
            if(!snapshot.hasData) return CircularProgressIndicator();
            if(snapshot.data != "") {
              String str = snapshot.data.toString();
              var jwt = str.split(".");

              if(jwt.length !=3) {
                return LoginPage();
              } else {
                var payload = json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));
                if(DateTime.fromMillisecondsSinceEpoch(payload["exp"]*1000).isAfter(DateTime.now())) {
                  return HomeView(str, payload);
                } else {

                  return LoginPage();
                }
              }
            } else {

              return LoginPage();
            }
          }
      ),
    );
  }
}

