import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/bottom_bar.dart';
import 'package:my_amazon_app/features/address/screens/address_screen.dart';
import 'package:my_amazon_app/features/admin/screen/admin_screen.dart';
import 'package:my_amazon_app/features/admin/screen/products_screen.dart';
import 'package:my_amazon_app/features/auth/screens/auth_screen.dart';
import 'package:my_amazon_app/features/order_details/screens/order_details.dart';
import 'package:my_amazon_app/features/product_details/screens/product_details.dart';
import 'package:my_amazon_app/features/search/screen/search_screen.dart';
import 'package:my_amazon_app/home/screens/category_deals.dart';
import 'package:my_amazon_app/home/screens/home_screen.dart';
import 'package:my_amazon_app/models/order.dart';
import 'package:my_amazon_app/models/products.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());

    case MyHomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const MyHomeScreen());

    case BottomBar.routeName:
      return MaterialPageRoute(builder: (_) => const BottomBar());

    case ProductsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ProductsScreen());

    case AdminScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AdminScreen());

    case CategoryDeals.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDeals(
          category: category,
        ),
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );

    case ProductDetails.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetails(
          product: product,
        ),
      );

    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );

    case OrderDetails.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        builder: (_) => OrderDetails(
          order: order,
        ),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(child: Text("Error, Page Not Found")),
              ));
  }
}
