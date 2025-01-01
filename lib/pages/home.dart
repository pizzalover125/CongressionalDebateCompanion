import 'package:flutter/material.dart';
import 'package:congressional_debate_companion/pages/dictionary.dart';
import 'package:congressional_debate_companion/pages/guide.dart';
import 'package:congressional_debate_companion/pages/timer.dart';
import 'package:congressional_debate_companion/pages/tournaments.dart';
import 'package:congressional_debate_companion/pages/notes.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.gavel,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Congressional Debate Companion',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Your one-stop shop for all things Congressional Debate. This app provides resources, tools, and information to help you succeed in your next tournament.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.book),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.abc),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_kabaddi_outlined),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.note),
            label: '',
          ),
        ],
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Guide()));
              break;
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Timer()));
              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Dictionary()));
              break;
            case 4:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Tournaments()));
              break;
            case 5:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Notes()));
              break;
          }
        },
      ),
    );
  }
}
