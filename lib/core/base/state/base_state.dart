import 'package:flutter/material.dart';

abstract class BaseState <T extends StatefulWidget> extends State<T>{
  ThemeData get themeData => Theme.of(context);

  double dynamicHeight(double value) => MediaQuery.of(context).size.height * value; // Dynamic height value for responsive design.
  double dynamicWidth(double value) => MediaQuery.of(context).size.width * value; // Dynamic width value for responsive design.
}