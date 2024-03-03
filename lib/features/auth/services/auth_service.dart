import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/bottom_bar.dart';
import 'package:my_amazon_app/constants/error_handling.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/constants/utils.dart';
import 'package:my_amazon_app/features/admin/screen/admin_screen.dart';
import 'package:my_amazon_app/models/user.dart';
import "package:http/http.dart" as http;
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String name,
    required String password,
    required String email,
  }) async {
    try {
      User user = User(
        id: "",
        name: name,
        password: password,
        email: email,
        address: "",
        type: "",
        token: "",
        cart: [],
      );
      http.Response res = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            ShowSnackBar(context, "Your account has been created successfully");
          });
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String password,
    required String email,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          dynamic userData = jsonDecode(res.body);
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString("auth-token", userData["token"]);
          if (userData["type"] == "user") {
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomBar.routeName,
              (route) => false,
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AdminScreen.routeName,
              (route) => false,
            );
          }
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("auth-token");
      if (token == null) {
        prefs.setString("auth-token", "");
      }
      var tokenRespo = await http.post(
        Uri.parse("$uri/tokenIsValid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': token!
        },
      );

      var respo = jsonDecode(tokenRespo.body);
      if (respo == true) {
        http.Response userRespo = await http.get(
          Uri.parse("$uri/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': token
          },
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRespo.body);
      }
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }
}
