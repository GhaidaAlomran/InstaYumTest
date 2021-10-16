import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instayum/screen/auth_screen.dart';
import 'package:instayum/screen/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.orangeAccent,
        backgroundColor: Color(0xFFeb6d44),
        accentColor: Color(0xFFeb6d44),
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Color(0xFFeb6d44),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      // the onAuthStateChanged such as change when the user creat new account or login
      home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              // it mean he is authintecated
              return ProfileScreen();
            }
            return AuthScreen(); //otherwise he does not have an accoun and return him to authScreen
          }),
    );
  }
}
