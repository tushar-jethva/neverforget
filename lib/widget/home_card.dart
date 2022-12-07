import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyHomeCard extends StatefulWidget {
  final snap;
  const MyHomeCard({super.key, required this.snap});

  @override
  State<MyHomeCard> createState() => _MyHomeCardState();
}

class _MyHomeCardState extends State<MyHomeCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.23,
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.all(14),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.23,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    image: DecorationImage(
                        image:
                            // CachedNetworkImageProvider(widget.snap['backImage']),
                            AssetImage('assets/travel.jpg'),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 7,
                        offset: Offset(0, 4),
                      )
                    ]),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Color.fromARGB(154, 144, 202, 249)),
                padding: EdgeInsets.all(15),
                child: Text(
                  'Trave;',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NewFont'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
