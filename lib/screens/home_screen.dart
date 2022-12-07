import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:never_forget/FirebaseMethods/things_methods.dart';
import 'package:never_forget/models/user_model.dart';
import 'package:never_forget/providers/user_provider.dart';
import 'package:never_forget/screens/signin.dart';
import 'package:never_forget/utills/utills.dart';
import 'package:never_forget/widget/colors.dart';
import 'package:never_forget/widget/home_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final TextEditingController _itemNameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Uint8List? _file;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _itemNameController.dispose();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshUser();
  }

  void postImage(String uid, String username) async {
    try {
      String res = await ThingMethods()
          .uploadThing(_itemNameController.text, uid, _file!, username);

      if (res == 'Success') {
        showSnackbar('Post is successfully uploaded!', context);
        clearImage();
      } else {
        showSnackbar(res, context);
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: _itemNameController,
                  decoration: InputDecoration(hintText: 'Enter Name...'),
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Choose Image'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                      ImageSource.gallery, FilterQuality.medium);

                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue.shade300,
              title: Text(
                'Never Forget',
                style: TextStyle(fontFamily: 'NewFont'),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      _selectImage(context);
                    },
                    icon: const Icon(Icons.add)),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MySignIn()));
                    },
                    icon: const Icon(Icons.settings)),
              ],
            ),
            // body: StreamBuilder(
            //   stream: FirebaseFirestore.instance
            //       .collection('backImages')
            //       .snapshots(),
            //   builder: (context,
            //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(
            //         child: CircularProgressIndicator(color: blueColor),
            //       );
            //     }

            //     return ListView.builder(
            //         itemCount: snapshot.data!.docs.length,
            //         itemBuilder: (context, index) => MyHomeCard(
            //               snap: snapshot.data!.docs[index].data(),
            //             ));
            //   },
            // ),
            body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('backImages')
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) =>
                        MyHomeCard(snap: snapshot.data!.docs[index].data()));
              },
            ),
          )
        : Scaffold(
            body: Center(
                child: TextButton(
              onPressed: () => postImage(user!.uid, user.username),
              child: Text('Upload'),
            )),
          );
  }
}
