import 'package:flutter/material.dart';
import 'package:my_amazon_app/constants/global_var.dart';

class MyCustomButton extends StatelessWidget {
  final String txt;
  final VoidCallback onClick;
  final Color? color;
  const MyCustomButton(
      {super.key, required this.txt, required this.onClick, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      child: Text(txt),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          backgroundColor: GlobalVar.secondaryColor,
          foregroundColor: GlobalVar.backgroundColor),
    );
  }
}
