import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// import "./learning/1.appBar.dart";
// import "./learning/2.body.dart";
// import "./learning/3.rowAndColumn.dart";
// import "./learning/4.tabs.dart";
// import "./learning/5.form.dart";
// import "./learning/6.http.dart";
// import "./learning/7.stateFullAndStateLess.dart";
// import "./learning/8.navigation.dart";
import "./learning/9.state_management.dart";

void main() async {
  await dotenv.load(fileName: ".env");
  
  runApp(MyApp());
}