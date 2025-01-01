import 'package:flutter/material.dart';
import 'package:myapp/pages/dictionary.dart';
import 'package:myapp/pages/guide.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/timer.dart';
import 'package:myapp/pages/tournaments.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  _loadNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _controller.text = (prefs.getString('note') ?? "");
    });
  }

  _saveNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('note', _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            children: [
            Expanded(
              child: TextField(
              controller: _controller,
              maxLines: null,
              expands: true,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(
                hintText: 'Enter your notes in chamber here...',
                border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (text) {
                _saveNote();
              },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 5,
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
              break;
          }
        },
      ),
    );
  }
}