import 'package:flutter/material.dart';
import 'package:muslim_uz/HomePage.dart';

void main(){
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false,
      home: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}