import 'package:flutter/material.dart';

String uri = "http://192.168.1.104:3000";

class GlobalVar {
  static const appBarColor = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );
  static const secondaryColor = Color.fromARGB(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800];
  static const unselectedNavBarColor = Colors.black87;

  static const List<String> carouselImages = [
    "https://m.media-amazon.com/images/I/41W640BgueL._AC._SR360,460.jpg",
    "https://m.media-amazon.com/images/I/61USAscNrJL._AC._SR360,460.jpg",
    "https://m.media-amazon.com/images/I/61vjem3PlaL._AC._SR360,460.jpg",
    "https://m.media-amazon.com/images/I/71rggA5Ls4L._AC._SR360,460.jpg",
    "https://m.media-amazon.com/images/I/51hYfQoLukL._AC._SR360,460.jpg",
    "https://m.media-amazon.com/images/I/71OGAsIyoZL._AC._SR360,460.jpg",
  ];

  static const List<Map<String, String>> categoriesImages = [
    {
      'title': 'Bathroom Accessories',
      'image': 'assets/images/Bathroom Accesories.jpg',
    },
    {
      'title': 'Bedding',
      'image': 'assets/images/Bedding.jpg',
    },
    {
      'title': 'Cleaning Tools',
      'image': 'assets/images/Cleaning Tools.jpg',
    },
    {
      'title': 'Home Decor',
      'image': 'assets/images/Home Decor.jpg',
    },
    {
      'title': 'Lighting',
      'image': 'assets/images/Lighting.jpg',
    },
    {
      'title': 'Storage',
      'image': 'assets/images/Storage & Organization.jpg',
    },
  ];
}
