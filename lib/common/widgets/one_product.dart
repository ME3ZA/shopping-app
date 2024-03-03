import 'package:flutter/material.dart';

class OneProduct extends StatelessWidget {
  final String myImage;
  const OneProduct({super.key, required this.myImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          width: 180,
          padding: EdgeInsets.all(10),
          child: Image.network(
            myImage,
            fit: BoxFit.contain,
            height: 180,
            width: 180,
          ),
        ),
      ),
    );
  }
}
