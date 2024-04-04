import 'package:flutter/material.dart';
import 'rest.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null ? Icon(Icons.add_a_photo) : null,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Name: Sanika',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Email: hadapsanika@gmail.com',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                );
              },
              child: Text('Privacy Policy'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguagesPage()),
                );

              },
              child: Text('Phrase Generator'),

            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OtherEnd()),
                );

              },
              child: Text('Other End'),

            ),

          ],
        ),
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                // Insert your privacy policy text here
                'Our language learning app is designed to help users learn French, German, and Hindi effectively. We are committed to protecting your privacy and ensuring the security of your personal information. ...',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                // Insert your contact information here
                'If you have any questions or concerns about our privacy practices or the handling of your personal information, please contact us at sanika@langlearn.co.in',
                style: TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtherEnd(),
                    ),
                  );


                },
                child: Text('Other End'),

              ),
            ],
          ),
        ),
      ),
    );
  }
}


class OtherEnd extends StatelessWidget {
  // Placeholder for API key
  final String apiKey = 'API_KEY: msh4445e2bd124932925d49b92d5p19d7b7jsn550f43ca915';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Other End'),
      ),
      body: FutureBuilder<String?>(
        // Placeholder for API call
        future: fetchPrivacyPolicyText(), // Function to fetch privacy policy text
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator while fetching data
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            // Show error message if API call fails or returns null
            return Center(
              child: Text('Failed to load data'),
            );
          } else {
            // Display the fetched privacy policy text
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      snapshot.data!, // Display the fetched text (use '!' to assert non-null)
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // Function to fetch privacy policy text (placeholder for API call)
  Future<String?> fetchPrivacyPolicyText() async {
    // Placeholder for API call
    await Future.delayed(Duration(seconds: 2)); // Simulating delay
    return 'Our language learning app is designed to help users learn French, German, and Hindi effectively. We are committed to protecting your privacy and ensuring the security of your personal information. If you have any questions or concerns about our privacy practices or the handling of your personal information, please contact us at sanika@langlearn.co.in';
  }
}
