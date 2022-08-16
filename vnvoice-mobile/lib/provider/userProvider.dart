import 'package:flutter/cupertino.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? user;

  UserProvider () {
    user = null;
  }

  void setUser(User signInUser) {
    user = signInUser;
    notifyListeners();
  }

  bool isSignedIn() {
    return user != null;
  }

  User? getUser() {
    return user;
  }

}