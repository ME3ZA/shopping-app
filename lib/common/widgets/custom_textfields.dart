import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final int maxLines;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Enter Your ${widget.hintText}";
          } else {
            return null;
          }
        },
        maxLines: widget.maxLines,
      ),
    );
  }
}
