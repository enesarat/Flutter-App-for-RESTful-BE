import 'package:flutter/material.dart';
import 'package:sample_app_with_restful_api/view/authentication/test/view/test_view.dart';
import 'package:sample_app_with_restful_api/view/home/agent/single_agent_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SingleAgentScreen(),
    );
  }
}
