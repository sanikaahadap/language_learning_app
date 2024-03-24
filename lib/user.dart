import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUser
{
  final String email;
  final String name;


  ModelUser({required this.email,required this.name});

  Map<String,dynamic> toJson()=>
      {
        'email': email,
        'name': name,
      };

  static ModelUser fromSnap(DocumentSnapshot snap)
  {
    var snapshot=snap.data() as Map<String,dynamic>;

    return ModelUser(
        email: snapshot['email'],
        name: snapshot['name'],

    );
  }
}