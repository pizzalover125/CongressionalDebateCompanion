// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/pages/dictionary.dart';
import 'package:myapp/pages/timer.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/guide.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tournaments extends StatefulWidget {
  const Tournaments({super.key});

  @override
  State<Tournaments> createState() => _TournamentsState();
}

class _TournamentsState extends State<Tournaments> {
  List _tournaments = [];

  @override
  void initState() {
    super.initState();
    _fetchTournaments();
  }

  Future<void> _fetchTournaments() async {
    final response = await http
        .get(Uri.parse('https://api.tabroom.com/v1/public/invite/upcoming'));
    if (response.statusCode == 200) {
      setState(() {
        _tournaments = jsonDecode(response.body);

        _tournaments = _tournaments.where((tournament) {
          return tournament['country'] == 'US';
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tournaments',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: _tournaments.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: _tournaments.length,
                itemBuilder: (context, index) {
                  final tournament = _tournaments[index];
                  return ListTile(
                    title: Text(tournament['name']),
                    subtitle: Text(tournament['city'] +
                        ', ' +
                        tournament['state']), 
                    trailing: Text(tournament['start']), 
                    onTap: () {
                      
                    },
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Resources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Dictionary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_kabaddi_outlined),
            label: 'Tournaments',
          ),
        ],
        onTap: (index) {
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Timer()));
              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dictionary()));
              break;
            case 4:
              break;
          }
        },
      ),
    );
  }
}
