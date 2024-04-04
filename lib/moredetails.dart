import 'package:flutter/material.dart';

class MoreDetails extends StatefulWidget {
  @override
  _MoreDetailsState createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    LanguageInfo(
      language: 'French',
      content: [
        "French is Spoken Across the Entire Globe",
        "France is a Hugely Popular Tourist and Cultural Destination",
        "French has a Rich History",
        "French has Widespread Influence",
        "French is Used Widely in the United States as Well",
        "French and Ballet Go Hand in Hand",
        "And so do French and the Culinary World",
      ],
    ),
    LanguageInfo(
      language: 'German',
      content: [
        "German can be found all over the world",
        "English and German are sister languages",
        "German has some bizarre and hilarious proverbs",
        "All nouns are capitalised",
        "German is the ‘language of the writers and thinkers’",
        "German boasts words that simply don’t exist in English",
        "German loves compound nouns",
      ],
    ),
    LanguageInfo(
      language: 'Hindi',
      content: [
        "Hindi is an Indo-European language",
        "Hindi is spoken by 366 million people across the world",
        "English has borrowed a great number of words from Hindi",
        "Each letter of the Hindi alphabet has its own independent and distinct sound",
        "India’s Hindi-speaking regions celebrate Hindi Day annually on 14th September",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facts'),
        backgroundColor: Colors.blue, // Change the app bar color as desired
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'French',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'German',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Hindi',
          ),
        ],
      ),
    );
  }
}

class LanguageInfo extends StatelessWidget {
  final String language;
  final List<String> content;

  LanguageInfo({required this.language, required this.content});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: content.length,
      itemBuilder: (context, index) {
        return Card(
          color: _getCardColor(language),
          child: ListTile(
            title: Text(
              content[index],
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getCardColor(String language) {
    switch (language) {
      case 'French':
        return Colors.yellowAccent;
      case 'German':
        return Colors.greenAccent;
      case 'Hindi':
        return Colors.orangeAccent;
      default:
        return Colors.white;
    }
  }
}