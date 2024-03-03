import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_amazon_app/constants/error_handling.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/constants/utils.dart';
import 'package:my_amazon_app/features/auth/screens/auth_screen.dart';
import 'package:my_amazon_app/models/order.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../providers/user_provider.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/order/me"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
      );
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
    return orderList;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }
}
