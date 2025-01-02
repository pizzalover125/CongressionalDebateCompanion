// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:congressional_debate_companion/pages/dictionary.dart';
import 'package:congressional_debate_companion/pages/timer.dart';
import 'package:congressional_debate_companion/pages/home.dart';
import 'package:congressional_debate_companion/pages/guide.dart';
import 'package:congressional_debate_companion/pages/notes.dart';
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
  String? _selectedMonth;

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

  List<String> getMonths() {
    return [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
  }

  String? getMonthNumber(String? monthName) {
    if (monthName == null) return null;
    final months = getMonths();
    final index = months.indexOf(monthName);
    return (index + 1).toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    List filteredTournaments = _tournaments;

    if (_selectedState != null) {
      filteredTournaments = filteredTournaments
          .where((tournament) => tournament['state'] == _selectedState)
          .toList();
    }

    if (_selectedMonth != null) {
      final monthNumber = getMonthNumber(_selectedMonth);
      filteredTournaments = filteredTournaments
          .where((tournament) =>
              tournament['start'].substring(5, 7) == monthNumber)
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tournaments',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
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
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    hint: Text("Select Month"),
                    value: _selectedMonth,
                    items: getMonths().map((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedMonth = newValue;
                      });
                    },
                  ),
                ),
              ],
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
            case 5:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Notes()));
          }
        },
      ),
    );
  }
}
