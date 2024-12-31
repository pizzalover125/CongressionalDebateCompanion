// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/pages/dictionary.dart';
import 'package:myapp/pages/guide.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/timer.dart';
import 'package:myapp/pages/tournaments.dart';

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
        primarySwatch: Colors.blue
      ),
      home: Home(),
      routes: {
        '/home': (context) => Home(),
        '/timer': (context) => Timer(),
        '/guide': (context) => Guide(),
        '/dictionary': (context) => Dictionary(),
        '/tournaments': (context) => Tournaments(),
      },
    );
  }
}
  