import 'package:flutter/material.dart';

class ThingModels {
  final String uid;
  final String username;
  final String backImage;
  final String title;

  ThingModels({
    required this.uid,
    required this.username,
    required this.backImage,
    required this.title,
  });

  Map<String, dynamic> toJsond() => {
        "username": username,
        "uid": uid,
        "backImage": backImage,
        "title": title
      };
}
