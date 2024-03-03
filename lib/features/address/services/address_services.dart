import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_amazon_app/constants/error_handling.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/constants/utils.dart';
import 'package:my_amazon_app/models/user.dart';
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/save-user-address"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': userProvider.user.id,
          'address': address,
        }),
      );
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)["address"],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/order"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userProvider.user.token,
          },
          body: jsonEncode(
            {
              'cart': userProvider.user.cart,
              'address': address,
              'totalPrice': totalSum,
            },
          ));
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          ShowSnackBar(context, "Your Order Has Been Placed Successfully.");
          User user = userProvider.user.copyWith(cart: []);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }
}
