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
      String uid, Uint8List file, String title) async {
    String res = 'Some error occured';
    try {
      String thingId = Uuid().v1();
      String backImage =
          await StorageMethods().uploadImageToStorage('backImages', file, true);

      ThingModels thing = ThingModels(
          uid: _auth.currentUser!.uid,
          
          backImage: backImage,
          title: title,
          thingId: thingId);

      await _fiestore
          .collection('backImages')
          .doc(thingId)
          .set(thing.toJsond());
      res = 'Success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> enterThingTexts(
      String text, String thingId, String description) async {
    String res = "Some error occured";

    try {
      if (text.isNotEmpty) {
        String thingTextId = Uuid().v1();
        await _fiestore
            .collection('backImages')
            .doc(thingId)
            .collection('thingTexts')
            .doc(thingTextId)
            .set({
          "text": text,
          "thingId": thingId,
          "description": description,
          "datePublished": DateTime.now(),
          "itemId": thingTextId,
        });
        res = 'Success';
      } else {
        res = "Enter text";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> DeleteThing(String ThingId) async {
    String res = "Some error occured";
    try {
      await _fiestore.collection('backImages').doc(ThingId).delete();
      res = 'Success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> DeleteItems(String thingId, String itemId) async {
    String res = "Some error occured!";
    try {
      await _fiestore
          .collection('backImages')
          .doc(thingId)
          .collection('thingTexts')
          .doc(itemId)
          .delete();
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
