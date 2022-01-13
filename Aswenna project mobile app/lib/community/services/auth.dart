import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'database.dart';

class AuthService extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _dbService = Database();

  //Change State
  //Using provider to set allow access the Member class for all the page.
  //This function return a Member type: instance of the Member object
  //can access Member field

  Stream<User> get user {
    return _auth.authStateChanges();
  }

  User get memberDetail {
    return _auth.currentUser;
  }


  //register user using email and password + adding additional states to the firebase database
  Future<bool> registerUserWithEmailAndPassword(String email, String password,
      String username) async {
    try {
        UserCredential result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await result.user.updateProfile(displayName: username);
        User user = result.user;
        await result.user.updateProfile(displayName: username);

        await _dbService.createMember(result.user.uid, username, email);

        return true;
    } on FirebaseAuthException catch (e) {
      //Check the error code and modify it to find the correct code so that
      //can show the correct error;
      print(e.code);
      throw e;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //Login user using email and password
  Future signInUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  bool logout() {
    try {
      _auth.signOut();
      print("signOut");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}