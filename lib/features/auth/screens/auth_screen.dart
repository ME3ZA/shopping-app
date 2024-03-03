import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/custom_buttons.dart';
import 'package:my_amazon_app/common/widgets/custom_textfields.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/auth/services/auth_service.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth_screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signInFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  void signUpUser() {
    _authService.signUpUser(
        context: context,
        name: _nameController.text,
        password: _passwordController.text,
        email: _emailController.text);
  }

  void signInUser() {
    _authService.signInUser(
        context: context,
        password: _passwordController.text,
        email: _emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVar.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Welcome to Mongez Shopping App !",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  ListTile(
                    tileColor: _auth == Auth.signup
                        ? GlobalVar.backgroundColor
                        : GlobalVar.greyBackgroundCOlor,
                    title: Text(
                      "Create Account",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: Radio(
                        activeColor: GlobalVar.secondaryColor,
                        value: Auth.signup,
                        groupValue: _auth,
                        onChanged: (Auth? val) {
                          setState(() {
                            _auth = val!;
                          });
                        }),
                  ),
                  if (_auth == Auth.signup)
                    Container(
                      color: GlobalVar.backgroundColor,
                      padding: EdgeInsets.all(4),
                      child: Form(
                        key: _signUpFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _nameController,
                              hintText: "Name",
                            ),
                            CustomTextField(
                              controller: _emailController,
                              hintText: "Email",
                            ),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: "Password",
                              isPassword: true,
                            ),
                            MyCustomButton(
                                txt: "Sign Up",
                                onClick: () {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    signUpUser();
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                  ListTile(
                    tileColor: _auth == Auth.signin
                        ? GlobalVar.backgroundColor
                        : GlobalVar.greyBackgroundCOlor,
                    title: Text(
                      "Sign In",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: Radio(
                        activeColor: GlobalVar.secondaryColor,
                        value: Auth.signin,
                        groupValue: _auth,
                        onChanged: (Auth? val) {
                          setState(() {
                            _auth = val!;
                          });
                        }),
                  ),
                  if (_auth == Auth.signin)
                    Container(
                      color: GlobalVar.backgroundColor,
                      padding: EdgeInsets.all(4),
                      child: Form(
                          key: _signInFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _emailController,
                                hintText: "Email",
                              ),
                              CustomTextField(
                                controller: _passwordController,
                                hintText: "Password",
                                isPassword: true,
                              ),
                              MyCustomButton(
                                  txt: "Sign In",
                                  onClick: () {
                                    if (_signInFormKey.currentState!
                                        .validate()) {
                                      signInUser();
                                    }
                                  })
                            ],
                          )),
                    ),
                ],
              ),
            )),
      ),
    );
  }
}
