import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:never_forget/FirebaseMethods/things_methods.dart';
import 'package:never_forget/utills/utills.dart';
import 'package:never_forget/widget/colors.dart';

class MyTextCard extends StatefulWidget {
  final snap;
  const MyTextCard({super.key, required this.snap});

  @override
  State<MyTextCard> createState() => _MyTextCardState();
}

class _MyTextCardState extends State<MyTextCard> {
  textDeletes() async {
    try {
      String res = await ThingMethods()
          .DeleteItems(widget.snap['thingId'], widget.snap['itemId']);
      if (res == "Success") {
        showSnackbar("Deleted", context);
      } else {
        showSnackbar(res, context);
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
  }

  openDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              InkWell(
                onTap: () async {
                  textDeletes();
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Text('Delete'),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: openDialog,
      child: Container(
        padding: EdgeInsets.all(12),
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      widget.snap['text'],
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      widget.snap['description'],
                      style: TextStyle(color: Colors.black87),
                    ),
                    Text(
                        DateFormat.yMMMd()
                            .format(widget.snap['datePublished'].toDate()),
                        style: TextStyle(color: Colors.black87)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
