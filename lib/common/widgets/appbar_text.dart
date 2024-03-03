import 'package:flutter/material.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AppbarText extends StatelessWidget {
  const AppbarText({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: BoxDecoration(
        gradient: GlobalVar.appBarColor,
      ),
      padding: EdgeInsets.only(
        left: 5,
        right: 5,
        bottom: 5,
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: "Hi, ",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: user.name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
