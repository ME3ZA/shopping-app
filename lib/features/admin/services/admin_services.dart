import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:my_amazon_app/constants/error_handling.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/constants/utils.dart';
import 'package:my_amazon_app/models/order.dart';
import 'package:my_amazon_app/models/products.dart';
import 'package:http/http.dart' as http;
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AdminServices {
  void addProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic("dka994wy4", "l7cexmen");
      List<String> imageURL = [];
      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageURL.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageURL,
        category: category,
        price: price,
      );

      http.Response res = await http.post(
        Uri.parse("$uri/admin/add-product"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          ShowSnackBar(context, "Product Added Successfully!");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/get-products"),
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

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/get-orders"),
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

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse("$uri/admin/change-status"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'id': order.id,
            'status': status,
          }));
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.post(Uri.parse("$uri/admin/delete-product"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'auth-token': userProvider.user.token,
              },
              body: jsonEncode({
                'id': product.id,
              }));
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  void deleteOrder({
    required BuildContext context,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse("$uri/admin/delete-order"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'id': order.id,
          }));
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }
}
