import 'package:flutter/material.dart';
import 'package:congressional_debate_companion/pages/dictionary.dart';
import 'package:congressional_debate_companion/pages/timer.dart';
import 'package:congressional_debate_companion/pages/tournaments.dart';
import 'package:congressional_debate_companion/pages/home.dart';
import 'package:congressional_debate_companion/pages/notes.dart';
import 'package:url_launcher/url_launcher.dart';

class Guide extends StatelessWidget {
  const Guide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resources',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'NSDA Guide',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'This is the best resource if you are just getting started with Congress. It teaches you absolutely everything you would need to know. Plus, it is the official guide published by the National Speech and Debate Association.',
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => launchUrl(Uri.parse(
                            'https://www.speechanddebate.org/wp-content/uploads/2017-Congressional-Debate-Guide.pdf')),
                        child: const Row(
                          children: [
                            Icon(Icons.link, color: Colors.blue),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'NSDA Guide PDF',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'How To Congress YouTube Playlist',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'This is a YouTube playlist that covers everything you need to know and more. Specifically, it teaches you how you can start winning tournaments and how it actually feels to be a competitor. Although the videos are quite long, they are excellent if you would like to start winning.',
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => launchUrl(Uri.parse(
                            'https://www.youtube.com/watch?v=XJ_CJ5-G3YE&list=PLtsLp1nqk_11nJrpsfWu5-mbLZuhqxbfx')),
                        child: const Row(
                          children: [
                            Icon(Icons.link, color: Colors.blue),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'YouTube Playlist',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Official NSDA Powerpoint',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Are you a coach, captain, or anyone who needs a lecturable powerpoint to introduce Congressional Debate? This is the perfect resource for you. It is a powerpoint that covers everything you need to know about Congressional Debate. It is perfect for introducing Congressional Debate to new members.',
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => launchUrl(Uri.parse(
                            'https://docs.google.com/presentation/d/1EQVTyVmbXEIyt5FaVPh8n7Ufr7337eLMmCxPCDTQgA8/edit#slide=id.g398612dcdb_0_50')),
                        child: const Row(
                          children: [
                            Icon(Icons.link, color: Colors.blue),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'NSDA Powerpoint (Google Slides)',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Winning Speech Video',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'You can go through all of the resources above and get a good sense on how to debate, not how to win. This video is a winning speech from the national championships. Examine how the competitor delivers his speech, his body language, his diction; everything. If you can replicate this, you can win.',
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => launchUrl(Uri.parse(
                            'https://www.youtube.com/watch?v=cHi5AKySAes')),
                        child: const Row(
                          children: [
                            Icon(Icons.link, color: Colors.blue),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Youtube Video',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Legislative Session Video',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'This is a video of a legislative session. It is a great resource if you would like to see how a real legislative session is conducted. This video is extremely long, so it is reccomended to watch this in parts.',
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => launchUrl(Uri.parse(
                            'https://www.youtube.com/watch?v=OSGp403cMZI')),
                        child: const Row(
                          children: [
                            Icon(Icons.link, color: Colors.blue),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Youtube Video',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
