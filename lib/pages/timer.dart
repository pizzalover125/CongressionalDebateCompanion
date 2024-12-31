// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/pages/dictionary.dart';
import 'package:myapp/pages/tournaments.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/guide.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Timer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text('Welcome to the Timer Page'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 2,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Resources',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer),
            label: 'Timer',
          ),
          NavigationDestination(
            icon: Icon(Icons.abc),
            label: 'Dictionary',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_kabaddi_outlined),
            label: 'Tournaments',
          ),
        ],
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
              break;
            case 1:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Guide()));
              break;
            case 2:
              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dictionary()));
              break;
            case 4:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Tournaments()));
              break;
          }
        },
      ),
    );
  }
}
