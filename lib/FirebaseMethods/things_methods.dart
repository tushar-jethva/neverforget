import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:never_forget/FirebaseMethods/storage_methods.dart';
import 'package:never_forget/models/things_model.dart';
import 'package:uuid/uuid.dart';

class ThingMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fiestore = FirebaseFirestore.instance;

  Future<String> uploadThing(
      String uid, String username, Uint8List file, String title) async {
    String res = 'Some error occured';
    try {
      String thingId = Uuid().v1();
      String backImage =
          await StorageMethods().uploadImageToStorage('backImages', file, true);

     ThingModels thing =  ThingModels(
          uid: _auth.currentUser!.uid, username: username, backImage: backImage, title: title);

      await _fiestore.collection('backImages').doc(thingId).set(thing.toJsond());
      res = 'Success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
