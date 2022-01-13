import 'package:flutter/foundation.dart';

class MMber extends ChangeNotifier {
  String id;
  String username;
  String email;

  void updateMMber(String id, String username,String email) {
    this.id = id;
    this.username = username;
    this.email = email;

    print(id);
    print(username);
    print(email);

    notifyListeners();
  }
}