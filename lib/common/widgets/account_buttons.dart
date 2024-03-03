import 'package:flutter/material.dart';
import 'package:my_amazon_app/constants/global_var.dart';

class AccountButtons extends StatelessWidget {
  final String txt;
  final VoidCallback onClick;
  const AccountButtons({super.key, required this.txt, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: GlobalVar.secondaryColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: OutlinedButton(
        onPressed: onClick,
        child: Text(txt),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
