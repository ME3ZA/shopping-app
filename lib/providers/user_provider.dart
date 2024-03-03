import 'package:flutter/material.dart';
import 'package:my_amazon_app/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: "",
    name: "",
    password: "",
    email: "",
    address: "",
    type: "",
    token: "",
    cart: [],
  );

  User get user => _user;
  void setUser(String userData) {
    _user = User.fromJson(userData);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
