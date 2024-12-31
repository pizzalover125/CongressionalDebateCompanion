// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:myapp/pages/dictionary.dart';
import 'package:myapp/pages/timer.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/guide.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Tournaments extends StatefulWidget {
  const Tournaments({super.key});

  @override
  State<Tournaments> createState() => _TournamentsState();
}

class _TournamentsState extends State<Tournaments> {
  List _tournaments = [];
  String? _selectedState;

  @override
  void initState() {
    super.initState();
    _fetchTournaments();
  }

  Future<void> _fetchTournaments() async {
    final response = await http.get(
        Uri.parse('https://api.tabroom.com/v1/public/invite/upcoming'),
        headers: {
          "Origin": "https://www.tabroom.com",
          "Referer": "https://www.tabroom.com",
        });
    if (response.statusCode == 200) {
      setState(() {
        _tournaments = jsonDecode(response.body);

        _tournaments = _tournaments.where((tournament) {
          return tournament['country'] == 'US';
        }).toList();
      });
    }
  }

  List<String> getStates() {
    return _tournaments
        .map<String>((tournament) => tournament['state'] ?? "No State")
        .toSet()
        .toList()
      ..sort();
  }

  @override
  Widget build(BuildContext context) {
    List filteredTournaments = _selectedState == null
        ? _tournaments
        : _tournaments
            .where((tournament) => tournament['state'] == _selectedState)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tournaments',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButton<String>(
              hint: Text("Select State"),
              value: _selectedState,
              items: getStates().map((String state) {
                return DropdownMenuItem<String>(
                  value: state,
                  child: Text(state),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedState = newValue;
                });
              },
              underline: SizedBox(),
            ),
          ),
          Expanded(
            child: _tournaments.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredTournaments.length,
                    itemBuilder: (context, index) {
                      final tournament = filteredTournaments[index];
                      return ListTile(
                        title: Text(tournament['name']),
                        subtitle: Text(
                          (tournament['location'] ?? "No City") +
                              ', ' +
                              (tournament['state'] ?? "No State"),
                        ),
                        trailing: Text(tournament['start'].substring(0, 10)),
                        onTap: () => launchUrl(Uri.parse(
                            'https://www.tabroom.com/index/tourn/index.mhtml?tourn_id=${tournament['id']}')),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 4,
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
