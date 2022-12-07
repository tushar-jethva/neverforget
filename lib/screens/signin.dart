import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:never_forget/FirebaseMethods/auth_methods.dart';
import 'package:never_forget/screens/home_screen.dart';
import 'package:never_forget/screens/sign_up.dart';
import 'package:never_forget/utills/utills.dart';
import 'package:never_forget/widget/button.dart';
import 'package:never_forget/widget/colors.dart';
import 'package:never_forget/widget/textfield.dart';

class MySignIn extends StatefulWidget {
  const MySignIn({super.key});

  @override
  State<MySignIn> createState() => _MySignInState();
}

class _MySignInState extends State<MySignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signIn() async {
    setState(() {
      _isLoading = true;
    });
    String res = await MyAuthMethods().signInUser(
        email: _emailController.text, password: _passwordController.text);

        setState(() {
          _isLoading = false;
        });
    if (res != 'Success') {
      showSnackbar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Gap(200),
          Text(
            'Never Forget',
            style: TextStyle(
                color: Colors.blue.shade400,
                fontFamily: 'NewFont',
                fontSize: 50),
          ),
          Gap(50),
          MyTextField(
              textEditingController: _emailController,
              hintText: 'Enter Email...',
              textInputType: TextInputType.emailAddress),
          Gap(10),
          MyTextField(
            textEditingController: _passwordController,
            hintText: 'Enter password...',
            textInputType: TextInputType.text,
            isPass: true,
          ),
          Gap(10),
          InkWell(
                onTap: signIn,
                child: Container(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text('Sign In'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: blueColor),
                ),
              ),
          Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Still you not Sign Up?'),
              Gap(2),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MySignUpScreen()));
                },
                child: Text(
                  "Do Now",
                  style: TextStyle(
                      color: Colors.blue.shade400, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
