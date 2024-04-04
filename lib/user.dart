import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUser {
  final String email;
  final String name;
  final String language;
  final double level;
  final bool agreement;

  ModelUser({
    required this.email,
    required this.name,
    required this.language,
    required this.level,
    required this.agreement,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'language': language,
      'level': level,
      'agreement': agreement,
    };
  }

  static ModelUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ModelUser(
      email: snapshot['email'],
      name: snapshot['name'],
      language: snapshot['language'],
      level: snapshot['level'],
      agreement: snapshot['agreement'],
    );
  }
}
