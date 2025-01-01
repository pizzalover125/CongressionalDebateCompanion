// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:congressional_debate_companion/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey, 
        ),
        useMaterial3: true, 
      ),
      home: Home(),
    );
  }
}
