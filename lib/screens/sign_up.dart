import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:never_forget/FirebaseMethods/auth_methods.dart';
import 'package:never_forget/screens/home_screen.dart';
import 'package:never_forget/screens/signin.dart';
import 'package:never_forget/utills/utills.dart';
import 'package:never_forget/widget/button.dart';
import 'package:never_forget/widget/colors.dart';
import 'package:never_forget/widget/textfield.dart';

class MySignUpScreen extends StatefulWidget {
  const MySignUpScreen({super.key});

  @override
  State<MySignUpScreen> createState() => _MySignUpScreenState();
}

class _MySignUpScreenState extends State<MySignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List image =
        await pickImage(ImageSource.gallery, FilterQuality.medium);
    setState(() {
      _image = image;
    });
  }

  void signUp() async {
    setState(() {
      _isLoading = true;
    });
    String res = await MyAuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        profileFile: _image!);

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
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(30),
                Text(
                  'Never Forget',
                  style: TextStyle(
                      color: Colors.blue.shade400,
                      fontFamily: 'NewFont',
                      fontSize: 50),
                ),
                Gap(80),
                Stack(
                  children: [
                    _image!=null?
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: MemoryImage(_image!),
                      backgroundColor: Colors.white,
                    ):
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/travel.jpg'),
                    ),
                    Positioned(
                      child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(Icons.add_a_photo),
                      ),
                      bottom: -5,
                      right: -1,
                    ),
                  ],
                ),
                Gap(30),
                MyTextField(
                    textEditingController: _usernameController,
                    hintText: 'Enter Username',
                    textInputType: TextInputType.text),
                Gap(10),
                MyTextField(
                    textEditingController: _emailController,
                    hintText: 'Enter email',
                    textInputType: TextInputType.emailAddress),
                Gap(10),
                MyTextField(
                  textEditingController: _passwordController,
                  hintText: 'Enter password',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                Gap(10),
               InkWell(
                onTap: signUp,
                child: Container(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text('Sign Up'),
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
                    Text('Already have an account?'),
                    Gap(2),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MySignIn()));
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
