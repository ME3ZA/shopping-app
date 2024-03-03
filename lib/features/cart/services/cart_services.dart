import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_amazon_app/constants/error_handling.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/constants/utils.dart';
import 'package:my_amazon_app/models/products.dart';
import 'package:my_amazon_app/models/user.dart';
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse("$uri/api/remove-from-cart/${product.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
      );
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)["cart"]);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }
}
