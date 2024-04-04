import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LanguagesPage extends StatefulWidget {
  @override
  _LanguagesPageState createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  String translatedText = '';
  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchTranslation();
  }

  Future<void> fetchTranslation() async {
    setState(() {
      isLoading = true;
    });

    final String apiUrl = 'https://translate-all-languages.p.rapidapi.com/translate';
    final headers = {
      'X-Rapidapi-Key': 'd124932925msh4445e2bd49b92d5p19d7b7jsn550f43ca9156',
      'X-Rapidapi-Host': 'translate-all-languages.p.rapidapi.com',
    };

    final response = await http.get(
      Uri.parse('$apiUrl?toLang=fr&text=If%20you%20don%E2%80%99t%20know%20what%20language%20the%20text%20is%20written%20in%2C%20our%20API%20will%20detect%20the%20language%20of%20the%20original%20request.&fromLang=en'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        translatedText = responseData['translatedText'];
        isLoading = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phrase generator'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : isError
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Le français est une langue romance originaire de France.',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'French is a Romance language originating in France.',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      )
          : Center(
        child: Text(
          translatedText,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
