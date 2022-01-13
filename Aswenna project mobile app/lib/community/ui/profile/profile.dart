import 'package:aswenna/community/services/auth.dart';
import 'package:aswenna/community/ui/authenticate_ui/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'info.dart';

class Profile extends StatelessWidget {
  Profile({Key key}) : super(key: key);

  final _authService = AuthService();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF00695C),
        leading: SizedBox(),
        // On Android it's false by default
        centerTitle: true,
        title: Text("Profile"),
        actions: <Widget>[
        ],
      ),
      body: Column(
        children: [
          // SizedBox(
          //   height: 70,
          // ),
          Info(
            name: _auth.currentUser.displayName,
            email: _auth.currentUser.email,
            image: "assets/images/pic.png",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: FlatButton(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Color(0xFFF5F6F9),
              onPressed: () {
                final success =  _authService.logout();
                if (success) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                }
              },
              child: Row(
                children: [
                  Icon(Icons.directions_run_outlined, color: Color(0xFF0C9869)),
                  // Icons.person_outline_outlined
                  SizedBox(width: 30),
                  Expanded(
                    child: Text("Logout"),
                  ),
                  Icon(Icons.chevron_right_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




