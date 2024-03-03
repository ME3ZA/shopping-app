import 'package:flutter/material.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/search/screen/search_screen.dart';
import 'package:my_amazon_app/home/widgets/address_user.dart';
import 'package:my_amazon_app/home/widgets/carousel_images.dart';
import 'package:my_amazon_app/home/widgets/categories.dart';
import 'package:my_amazon_app/home/widgets/today_deal.dart';

class MyHomeScreen extends StatefulWidget {
  static const routeName = "";
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreen();
}

class _MyHomeScreen extends State<MyHomeScreen> {
  void navaigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVar.appBarColor,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 5),
                  child: Material(
                    borderRadius: BorderRadius.circular(4),
                    elevation: 5,
                    child: TextFormField(
                      onFieldSubmitted: navaigateToSearchScreen,
                      decoration: InputDecoration(
                        prefix: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(top: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Search",
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.mic_none,
                  color: Colors.black,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressUser(),
            SizedBox(
              height: 10,
            ),
            Categories(),
            SizedBox(
              height: 10,
            ),
            CarouselImages(),
            TodayDeal(),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Us",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        Text(
                          "Telephone : 01287189922",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(Icons.email),
                        Text(
                          "Email : ahmedrush96@gmail.com",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
