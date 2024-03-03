import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/bottom_bar.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/admin/screen/admin_screen.dart';
import 'package:my_amazon_app/features/auth/screens/auth_screen.dart';
import 'package:my_amazon_app/features/auth/services/auth_service.dart';
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:my_amazon_app/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'G.O.A.T Shopping',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: GlobalVar.secondaryColor),
        scaffoldBackgroundColor: GlobalVar.backgroundColor,
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == "user"
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}
