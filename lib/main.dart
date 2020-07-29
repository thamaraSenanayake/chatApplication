import 'package:flutter/material.dart';
import 'package:chat/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "chat app",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

