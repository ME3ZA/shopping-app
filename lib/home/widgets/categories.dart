import 'package:flutter/material.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/home/screens/category_deals.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  void toCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDeals.routeName, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVar.categoriesImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (() => toCategoryPage(
                  context,
                  GlobalVar.categoriesImages[index]["title"]!,
                )),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      GlobalVar.categoriesImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 120,
                      width: 170,
                    ),
                  ),
                ),
                Text(
                  GlobalVar.categoriesImages[index]['title']!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
