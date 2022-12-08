import 'package:flutter/material.dart';

class ThingModels {
  final String uid;
  
  final String backImage;
  final String title;
  final String thingId;

  ThingModels({
    required this.uid,
    
    required this.backImage,
    required this.title,
    required this.thingId
  });

  Map<String, dynamic> toJsond() => {
        
        "uid": uid,
        "backImage": backImage,
        "title": title,
        "thingId":thingId,
      };
}
