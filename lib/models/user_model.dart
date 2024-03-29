import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
 
  final String email;
  final String uid;
  final String profilePic;

  UserModel({
    
    required this.email,
    required this.uid,
    required this.profilePic,
  });

  Map<String, dynamic> toJsond() => {
       
        "email": email,
        "uid": uid,
        "profilPic": profilePic,
      };

  //      static user formSnap(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;
  //   return user(
  //       email: snapshot['email'],
  //       bio: snapshot['bio'],
  //       followers: snapshot['followers'],
  //       following: snapshot['following'],
  //       profile: snapshot['profile'],
  //       uid: snapshot['uid'],
  //       username: snapshot['username']);
  // }

  static UserModel formSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        
        email: snapshot['email'],
        uid: snapshot['uid'],
        profilePic: snapshot['profilPic']);
  }
}
