import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class PhraseShakePage extends StatefulWidget {
  const PhraseShakePage({Key? key}) : super(key: key);

  @override
  _PhraseShakePageState createState() => _PhraseShakePageState();
}

class _PhraseShakePageState extends State<PhraseShakePage> {
  late ShakeDetector detector;
  static const List<String> quotes = [
    'Bonjour - Hello',
    'Comment ça va ? - How are you?',
    'Ça va bien, merci. Et vous ? - I\'m fine, thank you. And you?',
    'S\'il vous plaît - Please',
    'Merci - Thank you',
    'De rien - You\'re welcome',
    'Excusez-moi - Excuse me',
    'Pardon - Sorry',
    'Au revoir - Goodbye',
    'À bientôt - See you soon',
    'Oui - Yes',
    'Non - No',
    'Parlez-vous anglais ? - Do you speak English?',
    'Je ne parle pas français. - I don\'t speak French.',
    'Je m\'appelle... - My name is...',
    'Comment vous appelez-vous ? - What is your name?',
    'Je suis désolé(e) - I am sorry',
    'Je ne comprends pas - I don\'t understand',
    'Combien ça coûte ? - How much does it cost?',
    'Où est... ? - Where is...?',
  ];
  late String quote;

  @override
  void initState() {
    super.initState();
    quote = quotes.first;

    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        final newQuote = (List.of(quotes)
          ..remove(quote)
          ..shuffle())
            .first;

        setState(() {
          quote = newQuote;
        });
      },
    );
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('Shuffle Example'),
      ),
      body: Container(
        padding: EdgeInsets.all(48),
        child: Center(
          child: Text(
            quote,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
