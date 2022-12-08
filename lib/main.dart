import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:never_forget/providers/user_provider.dart';
import 'package:never_forget/screens/home_screen.dart';
import 'package:never_forget/screens/sign_up.dart';
import 'package:never_forget/firebase_options.dart';
import 'package:never_forget/screens/signin.dart';
import 'package:never_forget/widget/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return MyHomeScreen();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Some Eroor"),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: blueColor),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(color: blueColor),
              );
            }
            return MySignIn();
          },
        ),
      ),
    );
  }
}
