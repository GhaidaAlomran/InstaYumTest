import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instayum/screen/profile_screen.dart';
import 'package:instayum/widget/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void _submitAouthForm(
    String email,
    String username,
    String password,
    File image,
    bool isSignUp,
    BuildContext ctx,
    // we recevice the context of form Scafflod to have the ability to push the snakcbar messages and to use theme color.
  ) async {
    UserCredential authResult;
    try {
      setState(() {
        isLoading = true;
      });
      if (isSignUp) {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final ref = FirebaseStorage.instance.ref().child("user_image").child(
            authResult.user.uid +
                "jpg"); //we put the user is + jpg to be the name of the image and to make it unqie we use user id

        // we add onComplete to can add await
        await ref.putFile(
            image); // i delete .onComplete but maybe this is not the solution

        final url = await ref.getDownloadURL();

        await FirebaseFirestore
            .instance //just to store the username in the database
            .collection("users")
            .doc(authResult.user.uid)
            .set({
          "username": username,
          "email": email,
          "image_url": url,
        });
        // ProfileScreen(authResult.user.uid);
      } else {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on PlatformException catch (err) {
      setState(() {
        isLoading = false;
      });
      //to handel the error of firebase in case of entring non-valid email or password
      var message = "Threr is an error, please check your credentials!";

      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
            content: Text(message), backgroundColor: Theme.of(ctx).errorColor),
      );
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      // to catch any other kind of errors
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orange, //Theme.of(context).backgroundColor,
      body: AuthFrom(_submitAouthForm, isLoading),
    );
  }
}
