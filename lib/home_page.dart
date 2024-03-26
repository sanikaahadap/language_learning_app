import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
              decoration: BoxDecoration(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            // Add more drawer items as needed
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Language Learning App',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white, // Text color
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Button color
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Button border radius
                  ),
                ),
                child: Text(
                  widget.fromLogin ? 'Continue Learning' : 'Start Learning',
                  style: TextStyle(fontSize: 18), // Button text style
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Selection'),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50), // Larger padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'French Quiz',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GermanQuizPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50), // Larger padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'German Quiz',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HindiQuizPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Background color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50), // Larger padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Hindi Quiz',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FrenchQuizPage extends StatefulWidget {
  @override
  _FrenchQuizPageState createState() => _FrenchQuizPageState();
}

class _FrenchQuizPageState extends State<FrenchQuizPage> {

  Map<int, String?> selectedOptions = {};
  int frenchScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('French Quiz'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('French Quiz: Learn Basic Phrases'),
            SizedBox(height: 20),
            _buildQuestion(1, 'How do you say "Hello" in French?', ['Bonjour', 'Merci', 'Salut', 'Excusez-moi'], 'Bonjour'),
            SizedBox(height: 20),
            _buildQuestion(2, 'How do you say "Goodbye" in French?', ['Au revoir', 'Merci', 'Salut', 'Excusez-moi'], 'Au revoir'),
            SizedBox(height: 20),
            _buildQuestion(3, 'How do you say "Thank you" in French?', ['Merci', 'Bonjour', 'Salut', 'Excusez-moi'], 'Merci'),
            SizedBox(height: 20),
            _buildQuestion(4, 'How do you say "Please" in French?', ['S\'il vous plaît', 'Bonjour', 'Salut', 'Excusez-moi'], 'S\'il vous plaît'),
            SizedBox(height: 20),
            _buildQuestion(5, 'How do you say "Excuse me" in French?', ['Excusez-moi', 'Bonjour', 'Salut', 'Merci'], 'Excusez-moi'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Calculate score based on selected options
                _calculateFrenchScore();
                // Navigate to score page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FrenchScorePage(score: frenchScore)),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(int questionNumber, String questionText, List<String> options, String correctOption) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(' $questionNumber: $questionText'),
        ..._buildOptions(questionNumber, options, correctOption),
      ],
    );
  }

  List<Widget> _buildOptions(int questionNumber, List<String> options, String correctOption) {
    return options.map((option) {
      return RadioListTile(
        title: Text(option),
        value: option,
        groupValue: selectedOptions[questionNumber],
        onChanged: (value) {
          setState(() {
            selectedOptions[questionNumber] = value.toString();
          });
        },
      );
    }).toList();
  }
  void _storeData(int score) {
    FirebaseFirestore.instance
        .collection('french_scores') // Change 'french_scores' to your desired collection name
        .add({
      'score': score,
      'timestamp': Timestamp.now(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
    })
        .then((value) => print("Score added to Firestore"))
        .catchError((error) => print("Failed to add score to Firestore: $error"));
  }

// Inside _calculateFrenchScore method
  void _calculateFrenchScore() {
    // Reset score
    frenchScore = 0;

    // Implement score calculation logic here
    selectedOptions.forEach((questionNumber, selectedOption) {
      if (selectedOption == correctOptions[questionNumber]) {
        frenchScore++;
      }
    });

    // Store score in Firestore
    _storeData(frenchScore);
  }

  // Correct options for each question
  final Map<int, String> correctOptions = {
    1: 'Bonjour',
    2: 'Au revoir',
    3: 'Merci',
    4: 'S\'il vous plaît',
    5: 'Excusez-moi',
  };
}

class FrenchScorePage extends StatelessWidget {
  final int score;

  const FrenchScorePage({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('French Quiz Score'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your French Quiz Score:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '$score / 5', // Total questions
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the home page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguageLearningAppHomePage(),
                  )
                );
              },
              child: Text('Go to Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class GermanQuizPage extends StatefulWidget {
  @override
  _GermanQuizPageState createState() => _GermanQuizPageState();
}

class _GermanQuizPageState extends State<GermanQuizPage> {
  Map<int, String?> selectedOptions = {};
  int germanScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('German Quiz'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('German Quiz: Learn Basic Phrases'),
            SizedBox(height: 20),
            _buildQuestion(1, 'How do you say "Hello" in German?', ['Hallo', 'Danke', 'Auf Wiedersehen', 'Entschuldigung'], 'Hallo'),
            SizedBox(height: 20),
            _buildQuestion(2, 'How do you say "Goodbye" in German?', ['Hallo', 'Danke', 'Auf Wiedersehen', 'Entschuldigung'], 'Auf Wiedersehen'),
            SizedBox(height: 20),
            _buildQuestion(3, 'How do you say "Thank you" in German?', ['Hallo', 'Danke', 'Auf Wiedersehen', 'Entschuldigung'], 'Danke'),
            SizedBox(height: 20),
            _buildQuestion(4, 'How do you say "Please" in German?', ['Hallo', 'Danke', 'Bitte', 'Entschuldigung'], 'Bitte'),
            SizedBox(height: 20),
            _buildQuestion(5, 'How do you say "Excuse me" in German?', ['Hallo', 'Danke', 'Auf Wiedersehen', 'Entschuldigung'], 'Entschuldigung'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Calculate score based on selected options
                _calculateGermanScore();
                // Navigate to score page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GermanScorePage(score: germanScore)),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(int questionNumber, String questionText, List<String> options, String correctOption) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(' $questionNumber: $questionText'),
        ..._buildOptions(questionNumber, options, correctOption),
      ],
    );
  }

  List<Widget> _buildOptions(int questionNumber, List<String> options, String correctOption) {
    return options.map((option) {
      return RadioListTile(
        title: Text(option),
        value: option,
        groupValue: selectedOptions[questionNumber],
        onChanged: (value) {
          setState(() {
            selectedOptions[questionNumber] = value.toString();
          });
        },
      );
    }).toList();
  }

  void _storeData(int score) {
    FirebaseFirestore.instance
        .collection('german_scores') // Change 'german_scores' to your desired collection name
        .add({
      'score': score,
      'timestamp': Timestamp.now(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
    })
        .then((value) => print("Score added to Firestore"))
        .catchError((error) => print("Failed to add score to Firestore: $error"));
  }

// Inside _calculateGermanScore method
  void _calculateGermanScore() {
    // Reset score
    germanScore = 0;

    // Implement score calculation logic here
    selectedOptions.forEach((questionNumber, selectedOption) {
      if (selectedOption == correctOptions[questionNumber]) {
        germanScore++;
      }
    });

    // Store score in Firestore
    _storeData(germanScore);
  }

  // Correct options for each question
  final Map<int, String> correctOptions = {
    1: 'Hallo',
    2: 'Auf Wiedersehen',
    3: 'Danke',
    4: 'Bitte',
    5: 'Entschuldigung',
  };
}

class GermanScorePage extends StatelessWidget {
  final int score;

  const GermanScorePage({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('German Quiz Score'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your German Quiz Score:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '$score / 5', // Total questions
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the home page
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LanguageLearningAppHomePage(),
                    )
                );
              },
              child: Text('Go to Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class HindiQuizPage extends StatefulWidget {
  @override
  _HindiQuizPageState createState() => _HindiQuizPageState();
}

class _HindiQuizPageState extends State<HindiQuizPage> {
  Map<int, String?> selectedOptions = {};
  int hindiScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hindi Quiz'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hindi Quiz: Learn Basic Phrases'),
            SizedBox(height: 20),
            _buildQuestion(1, 'How do you say "Hello" in Hindi?', ['Namaste', 'Dhanyawad', 'Alvida', 'Kshama Kijiye'], 'Namaste'),
            SizedBox(height: 20),
            _buildQuestion(2, 'How do you say "Goodbye" in Hindi?', ['Namaste', 'Dhanyawad', 'Alvida', 'Kshama Kijiye'], 'Alvida'),
            SizedBox(height: 20),
            _buildQuestion(3, 'How do you say "Thank you" in Hindi?', ['Namaste', 'Dhanyawad', 'Alvida', 'Kshama Kijiye'], 'Dhanyawad'),
            SizedBox(height: 20),
            _buildQuestion(4, 'How do you say "Please" in Hindi?', ['Namaste', 'Dhanyawad', 'Alvida', 'Kshama Kijiye'], 'Kshama Kijiye'),
            SizedBox(height: 20),
            _buildQuestion(5, 'How do you say "Excuse me" in Hindi?', ['Namaste', 'Dhanyawad', 'Alvida', 'Kshama Kijiye'], 'Kshama Kijiye'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Calculate score based on selected options
                _calculateHindiScore();
                // Navigate to score page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HindiScorePage(score: hindiScore)),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(int questionNumber, String questionText, List<String> options, String correctOption) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(' $questionNumber: $questionText'),
        ..._buildOptions(questionNumber, options, correctOption),
      ],
    );
  }

  List<Widget> _buildOptions(int questionNumber, List<String> options, String correctOption) {
    return options.map((option) {
      return RadioListTile(
        title: Text(option),
        value: option,
        groupValue: selectedOptions[questionNumber],
        onChanged: (value) {
          setState(() {
            selectedOptions[questionNumber] = value.toString();
          });
        },
      );
    }).toList();
  }

  void _storeData(int score) {
    FirebaseFirestore.instance
        .collection('hindi_scores') // Change 'hindi_scores' to your desired collection name
        .add({
      'score': score,
      'timestamp': Timestamp.now(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
    })
        .then((value) => print("Score added to Firestore"))
        .catchError((error) => print("Failed to add score to Firestore: $error"));
  }

// Inside _calculateHindiScore method
  void _calculateHindiScore() {
    // Reset score
    hindiScore = 0;

    // Implement score calculation logic here
    selectedOptions.forEach((questionNumber, selectedOption) {
      if (selectedOption == correctOptions[questionNumber]) {
        hindiScore++;
      }
    });

    // Store score in Firestore
    _storeData(hindiScore);
  }

  // Correct options for each question
  final Map<int, String> correctOptions = {
    1: 'Namaste',
    2: 'Alvida',
    3: 'Dhanyawad',
    4: 'Kshama Kijiye',
    5: 'Kripa Karke',
  };
}

class HindiScorePage extends StatelessWidget {
  final int score;

  const HindiScorePage({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hindi Quiz Score'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Hindi Quiz Score:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '$score / 5', // Total questions
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the home page
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LanguageLearningAppHomePage(),
                    )
                );
              },
              child: Text('Go to Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}
