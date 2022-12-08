import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyAemj extends StatefulWidget {
  
  const MyAemj({super.key});

  @override
  State<MyAemj> createState() => _MyAemjState();
}

class _MyAemjState extends State<MyAemj> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 20,
      width: double.infinity,
      child: Column(
  
        children: [
          Row(
            children: [
              Text('Enter text'),
              //IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
            ],
          )
        ],
      ),
    );
  }
}
