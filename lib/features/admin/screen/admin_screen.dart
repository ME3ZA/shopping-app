import 'package:flutter/material.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/account/services/account_services.dart';
import 'package:my_amazon_app/features/admin/screen/order_screen.dart';
import 'package:my_amazon_app/features/admin/screen/posts_screen.dart';

class AdminScreen extends StatefulWidget {
  static const routeName = "/admin-home";
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AccountServices accountServices = AccountServices();
  int _pageIndex = 0;

  void pageIndex(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  List<Widget> pages = [
    PostsScreen(),
    OrderScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVar.appBarColor,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/goat.png",
                  height: 80,
                  width: 60,
                ),
              ),
              Container(
                child: Text("Administrator Mode"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        selectedItemColor: GlobalVar.selectedNavBarColor,
        unselectedItemColor: GlobalVar.unselectedNavBarColor,
        backgroundColor: GlobalVar.backgroundColor,
        iconSize: 24,
        onTap: (index) {
          if (index != 2) {
            pageIndex(index);
          } else {
            accountServices.logOut(context);
          }
        },
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
              child: Icon(Icons.all_inbox),
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
              child: Icon(
                Icons.logout,
              ),
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
