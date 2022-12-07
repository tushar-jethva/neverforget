import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:never_forget/FirebaseMethods/storage_methods.dart';
import 'package:never_forget/models/user_model.dart';

class MyAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


   Future<UserModel> getUserDetail() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return UserModel.formSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List profileFile,
  }) async {
    String res = "Some error occured!";

    try {
      if (username.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          profileFile.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        String photo_url = await StorageMethods()
            .uploadImageToStorage('profilePic', profileFile, false);

        UserModel users = UserModel(
            username: username,
            email: email,
            uid: userCredential.user!.uid,
            profilePic: photo_url);

        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(users.toJsond());

        res = "Success";
      } else {
        res = "Some field is empty";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured!";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Some field is empty";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
