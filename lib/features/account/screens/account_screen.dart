import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/appbar_text.dart';
import 'package:my_amazon_app/common/widgets/main_buttons.dart';
import 'package:my_amazon_app/common/widgets/orders.dart';
import 'package:my_amazon_app/constants/global_var.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
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
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.notifications_on_rounded),
                    ),
                    Icon(Icons.search_rounded),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          AppbarText(),
          SizedBox(
            height: 15,
          ),
          MainButtons(),
          SizedBox(
            height: 15,
          ),
          Orders(),
        ],
      ),
    );
  }
}
