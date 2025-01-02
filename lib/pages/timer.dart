// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:congressional_debate_companion/pages/dictionary.dart';
import 'package:congressional_debate_companion/pages/tournaments.dart';
import 'package:congressional_debate_companion/pages/home.dart';
import 'package:congressional_debate_companion/pages/guide.dart';
import 'package:congressional_debate_companion/pages/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async' as async;
import 'package:flutter_beep/flutter_beep.dart';
import 'package:vibration/vibration.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  TextEditingController _speechNameController = TextEditingController();
  TextEditingController _speechDescriptionController = TextEditingController();
  List<Map<String, dynamic>> _speechTimes = [];
  bool _isTiming = false;
  DateTime? _startTime;
  Duration _elapsedTime = Duration.zero;
  async.Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadSpeechTimes();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _loadSpeechTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? times = prefs.getStringList('speechTimes');
    if (times != null) {
      setState(() {
        _speechTimes = times.map((e) => Map<String, dynamic>.from(jsonDecode(e))).toList();
      });
    }
  }

  void _saveSpeechTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> times = _speechTimes.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList('speechTimes', times);
  }

  void _startTiming() {
    if (_speechNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a speech name')),
      );
      return;
    }

    setState(() {
      _isTiming = true;
      _startTime = DateTime.now();
      _elapsedTime = Duration.zero;
    });

    _timer = async.Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = DateTime.now().difference(_startTime!);
        if (_elapsedTime.inSeconds == 120) {
          FlutterBeep.beep();
          Vibration.vibrate();
        }
        if (_elapsedTime.inSeconds == 150) {
          FlutterBeep.beep();
          FlutterBeep.beep();
          Vibration.vibrate();
          Vibration.vibrate();
        }
        if (_elapsedTime.inSeconds == 180) {
          FlutterBeep.beep();
          FlutterBeep.beep();
          FlutterBeep.beep();
          Vibration.vibrate();
          Vibration.vibrate();
          Vibration.vibrate();
        }
      });
    });
  }

  void _stopTiming() {
    _timer?.cancel();
    if (_startTime != null) {
      setState(() {
        _isTiming = false;
        _speechTimes.add({
          'name': _speechNameController.text,
          'description': _speechDescriptionController.text,
          'time': _elapsedTime.inSeconds,
        });
        _speechNameController.clear();
        _speechDescriptionController.clear();
        _elapsedTime = Duration.zero;
        _saveSpeechTimes();
        FocusScope.of(context).unfocus();
      });
    }
  }

  void _deleteTime(int index) {
    setState(() {
      _speechTimes.removeAt(index);
      _saveSpeechTimes();
    });
  }

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
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 2,
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Guide()));
              break;
            case 2:
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _speechNameController,
                      decoration: InputDecoration(
                        labelText: 'Speech Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _speechDescriptionController,
                      decoration: InputDecoration(
                        labelText: 'Speech Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Time: ${_elapsedTime.inMinutes.toString().padLeft(2, '0')}:${(_elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Speech Times',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _speechTimes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(_speechTimes[index]['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_speechTimes[index]['description']),
                        Text('${(_speechTimes[index]['time'] ~/ 60).toString().padLeft(2, '0')}:${(_speechTimes[index]['time'] % 60).toString().padLeft(2, '0')}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTime(index),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isTiming ? _stopTiming : _startTiming,
        backgroundColor: Colors.white,
        child: Icon(_isTiming ? Icons.stop : Icons.play_arrow),
      ),
    );
  }
}
