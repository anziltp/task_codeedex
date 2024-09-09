


import 'package:flutter/material.dart';
import 'package:task_codeedex/splash/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}
///MediaQuery
var w;
var h;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return  MaterialApp(
      home:SplashScreenPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
