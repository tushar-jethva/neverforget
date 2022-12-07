import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:never_forget/widget/colors.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function()? fun;
  const MyButton({super.key, required this.text, required this.fun});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fun,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: blueColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
              onPressed: () {},
              child: Text(
                text,
                style: style.copyWith(fontWeight: FontWeight.bold),
              ))),
    );
  }
}
