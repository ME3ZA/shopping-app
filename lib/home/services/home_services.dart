import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_amazon_app/constants/error_handling.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/constants/utils.dart';
import 'package:my_amazon_app/models/products.dart';
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/products?category=$category"),
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
            productList.add(
              Product.fromJson(
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
    return productList;
  }

  Future<Product> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      name: "",
      description: "",
      quantity: 0,
      images: [],
      category: "",
      price: 0,
    );
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/deal-of-day"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
      );
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
    return product;
  }
}
