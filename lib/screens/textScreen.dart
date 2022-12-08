import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:never_forget/FirebaseMethods/things_methods.dart';
import 'package:never_forget/utills/utills.dart';
import 'package:never_forget/widget/colors.dart';
import 'package:never_forget/widget/mytextcard.dart';

class MyTextScreen extends StatefulWidget {
  final snap;
  const MyTextScreen({super.key, required this.snap});

  @override
  State<MyTextScreen> createState() => _MyTextScreenState();
}

class _MyTextScreenState extends State<MyTextScreen> {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void enteringText() async {
    try {
      String res = await ThingMethods().enterThingTexts(
          _itemController.text, widget.snap['thingId'], _descController.text);
      if (res == "Success") {
        showSnackbar(res, context);
        Navigator.of(context).pop();
        setState(() {
          @override
          void dispose() {
            // TODO: implement dispose
            super.dispose();
            _itemController.dispose();
            _descController.dispose();
          }
        });
      } else {
        showSnackbar(res, context);
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
  }

  void _enterText(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Enter Itmes'),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _itemController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1)),
                    hintText: 'Enter Item:',
                  ),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _descController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1)),
                    hintText: 'Enter Description:',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SimpleDialogOption(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      padding: EdgeInsets.all(12),
                      child: Container(
                          width: 80,
                          height: 40,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.red.shade300,
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ))),
                  SimpleDialogOption(
                      onPressed: () {
                        enteringText();
                      },
                      padding: EdgeInsets.all(12),
                      child: Container(
                          width: 60,
                          height: 40,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.green.shade400,
                          ),
                          child: Text(
                            'Add',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ))),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('Enter Itmes'),
                        children: [
                          SimpleDialogOption(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: _itemController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1)),
                                hintText: 'Enter Item:',
                              ),
                            ),
                          ),
                          SimpleDialogOption(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: _descController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1)),
                                hintText: 'Enter Description:',
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  padding: EdgeInsets.all(12),
                                  child: Container(
                                      width: 80,
                                      height: 40,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.red.shade300,
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ))),
                              SimpleDialogOption(
                                  onPressed: enteringText,
                                  padding: EdgeInsets.all(12),
                                  child: Container(
                                      width: 60,
                                      height: 40,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.green.shade400,
                                      ),
                                      child: Text(
                                        'Add',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ))),
                            ],
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.add),
              color: Colors.black,
            ),
          ],
          backgroundColor: Colors.blue.shade200,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text(
            'Items',
            style: style.copyWith(fontFamily: 'NewFont'),
          )),
      backgroundColor: backgroundcolor,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('backImages')
            .doc(widget.snap['thingId'])
            .collection('thingTexts')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return MyTextCard(snap: snapshot.data!.docs[index].data());
              });
        },
      ),
    );
  }
}
