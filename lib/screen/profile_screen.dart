import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
//  ProfileScreen(this.userId);

  // final String userId;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
//   final FirebaseAuth auth =  FirebaseAuth.instance;

// void getdata(){

// }
//   void inputData() async{
// final FirebaseUser user = await auth.currentUser();
// final uid = user.uid;
// final imageUrl = Firestore.instance.collection("users").snapshots();

// listen((userData){
//   setState(() {
//     username = userData.data()['uid'];

//   });

// }}

  //final User user = auth.currentUser();
  //final userData = Firestore.instance.collection("users").document(authResult.user.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proflie Screen"),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app,
                          color: Colors.black), // change the color
                      SizedBox(width: 2),
                      Text("Logout"),
                    ],
                  ),
                ),
                value: "logout",
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == "logout") {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      // body: Column(children: [
      //  FutureBuilder(
      //    future: Provider.of(context).auth
      //    ,builder: builder)
      // ],),
    );
  }
}
