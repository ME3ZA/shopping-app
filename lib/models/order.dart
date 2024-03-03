import 'dart:convert';

import 'package:my_amazon_app/models/products.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userID;
  final int orderedAt;
  final int status;
  final double totalPrice;
  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userID,
    required this.orderedAt,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'products': products.map((x) => x.toMap()).toList()});
    result.addAll({'quantity': quantity});
    result.addAll({'address': address});
    result.addAll({'userID': userID});
    result.addAll({'orderedAt': orderedAt});
    result.addAll({'status': status});
    result.addAll({'totalPrice': totalPrice});

    return result;
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: List<Product>.from(
        map['products']?.map(
          (x) => Product.fromMap(x['product']),
        ),
      ),
      quantity: List<int>.from(
        map['products']?.map((x) => x['quantity']),
      ),
      address: map['address'] ?? '',
      userID: map['userID'] ?? '',
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
