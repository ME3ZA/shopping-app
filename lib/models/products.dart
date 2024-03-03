import 'dart:convert';

import 'package:my_amazon_app/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  final String? userID;
  final List<Rating>? rating;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    this.userID,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'quantity': quantity});
    result.addAll({'images': images});
    result.addAll({'category': category});
    result.addAll({'price': price});
    result.addAll({'rating': rating});
    if (id != null) {
      result.addAll({'id': id});
    }
    if (userID != null) {
      result.addAll({'userID': userID});
    }

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
      userID: map['userID'],
      rating: map["ratings"] != null
          ? List<Rating>.from(
              map["ratings"]?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
