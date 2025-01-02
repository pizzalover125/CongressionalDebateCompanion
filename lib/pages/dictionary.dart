// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:congressional_debate_companion/pages/timer.dart';
import 'package:congressional_debate_companion/pages/tournaments.dart';
import 'package:congressional_debate_companion/pages/home.dart';
import 'package:congressional_debate_companion/pages/guide.dart';
import 'package:congressional_debate_companion/pages/notes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dictionary extends StatefulWidget {
  const Dictionary({super.key});

  @override
  State<Dictionary> createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  String _word = '';
  Map<String, dynamic> _wordData = {};

  Future<void> _getDefinition() async {
    final response = await http.get(
        Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$_word'));

    if (response.statusCode == 200) {
      setState(() {
        _wordData = jsonDecode(response.body)[0];
      });
    } else {
      setState(() {
        _wordData = {};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(
        'Dictionary',
        style: TextStyle(
        fontWeight: FontWeight.bold,
        ),
      ),
      automaticallyImplyLeading: false,
      ),
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
        TextField(
          style: TextStyle(color: Colors.black),
          onChanged: (text) {
          setState(() {
            _word = text;
          });
          },
          decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          hintText: 'Enter Word',
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle: TextStyle(fontSize: 18),
          ),
          onPressed: _getDefinition,
          child: Text('Get Definition'),
          ),
        ),
        SizedBox(height: 20),
        if (_wordData.isNotEmpty)
          Expanded(
          child: ListView(
            children: [
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                ListTile(
                  title: Text(
                  _wordData['word'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
                ..._wordData['meanings'].map((meaning) => ListTile(
                    title: Text(
                      '(${meaning['partOfSpeech']}) ${meaning['definitions'][0]['definition']}'),
                    subtitle: meaning['definitions'][0]['example'] != null
                      ? Text(
                        'Example: ${meaning['definitions'][0]['example']}')
                      : null,
                  )),
                ],
              ),
              ),
            ),
            ],
          ),
          )
        ],
      ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 3,
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
              break;
            case 4:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Tournaments()));
              break;
            case 5:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Notes()));
              break;
          }
        },
      ),
    );
  }
}
