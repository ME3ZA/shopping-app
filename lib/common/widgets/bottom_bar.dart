import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/account/screens/account_screen.dart';
import 'package:my_amazon_app/features/cart/screen/cart_screen.dart';
import 'package:my_amazon_app/home/screens/home_screen.dart';
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const routeName = "/main-home";
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _pageIndex = 0;

  void pageIndex(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  List<Widget> pages = [
    const MyHomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        selectedItemColor: GlobalVar.selectedNavBarColor,
        unselectedItemColor: GlobalVar.unselectedNavBarColor,
        backgroundColor: GlobalVar.backgroundColor,
        iconSize: 24,
        onTap: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: 40,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _pageIndex == 0
                        ? GlobalVar.selectedNavBarColor!
                        : GlobalVar.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: Icon(Icons.home_rounded),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 40,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _pageIndex == 1
                        ? GlobalVar.selectedNavBarColor!
                        : GlobalVar.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: Icon(Icons.person_3_rounded),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 40,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _pageIndex == 2
                        ? GlobalVar.selectedNavBarColor!
                        : GlobalVar.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: badges.Badge(
                badgeStyle: badges.BadgeStyle(badgeColor: Colors.cyanAccent),
                badgeContent: Text(userCartLength.toString()),
                child: Icon(Icons.shopping_cart_checkout_rounded),
              ),
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
