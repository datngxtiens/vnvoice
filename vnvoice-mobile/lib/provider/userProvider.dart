import 'package:flutter/cupertino.dart';
import '../models/userModel.dart';

class UserProvider with ChangeNotifier {
  User? user;

  UserProvider () {
    user = null;
  }

  void setUser(User thisuser) {
    user= thisuser;
    notifyListeners();
  }



}