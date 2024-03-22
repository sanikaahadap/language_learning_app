import 'package:flutter/material.dart';

class LanguageLearningAppHomePage extends StatefulWidget {
  final bool fromLogin;

  const LanguageLearningAppHomePage({Key? key, this.fromLogin = false}) : super(key: key);

  @override
  _LanguageLearningAppHomePageState createState() => _LanguageLearningAppHomePageState();
}

class _LanguageLearningAppHomePageState extends State<LanguageLearningAppHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Language Learning App'),
        backgroundColor: const Color(0xFF4CAF50), // Green color for app bar
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50), // Green color for drawer header
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                // Handle Profile page navigation
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                // Handle Settings page navigation
              },
            ),
            // Add more drawer items as needed
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white, // White background color
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to Language Learning App',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF4CAF50), // Green color for text
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
                      );
                    },
                    child: Text(widget.fromLogin ? 'Continue Learning' : 'Start Learning'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LanguageSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FrenchQuizPage()),
                );
              },
              child: Text('French Quiz'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GermanQuizPage()),
                );
              },
              child: Text('German Quiz'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HindiQuizPage()),
                );
              },
              child: Text('Hindi Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

class FrenchQuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('French Quiz'),
      ),
      body: Center(
        child: Text('French Quiz Questions Go Here'),
      ),
    );
  }
}

class GermanQuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('German Quiz'),
      ),
      body: Center(
        child: Text('German Quiz Questions Go Here'),
      ),
    );
  }
}

class HindiQuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hindi Quiz'),
      ),
      body: Center(
        child: Text('Hindi Quiz Questions Go Here'),
      ),
    );
  }
}
