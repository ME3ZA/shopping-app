import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/stars.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/models/products.dart';

class SearchedProducts extends StatelessWidget {
  final Product product;
  const SearchedProducts({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (var i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Row(
                children: [
                  Image.network(
                    product.images[0],
                    fit: BoxFit.fitHeight,
                    width: 135,
                    height: 135,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 235,
                        padding: EdgeInsets.symmetric(
                          horizontal: 35,
                        ),
                        child: Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: EdgeInsets.symmetric(
                          horizontal: 35,
                        ),
                        child: Text(
                          "\$${product.price.toString()}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: EdgeInsets.only(
                          left: 35,
                          top: 5,
                        ),
                        child: Stars(rating: avgRating),
                      ),
                      Container(
                        width: 235,
                        padding: EdgeInsets.symmetric(
                          horizontal: 35,
                        ),
                        child: Text(
                          "Free Shipping",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: EdgeInsets.symmetric(
                          horizontal: 35,
                        ),
                        child: Text(
                          "In Stock",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: GlobalVar.secondaryColor,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
