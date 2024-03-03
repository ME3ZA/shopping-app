import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/loader.dart';
import 'package:my_amazon_app/features/product_details/screens/product_details.dart';
import 'package:my_amazon_app/home/services/home_services.dart';
import 'package:my_amazon_app/models/products.dart';

class TodayDeal extends StatefulWidget {
  const TodayDeal({super.key});

  @override
  State<TodayDeal> createState() => _TodayDealState();
}

class _TodayDealState extends State<TodayDeal> {
  Product? product;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(context, ProductDetails.routeName, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Loader()
        : product!.name.isEmpty
            ? SizedBox()
            : GestureDetector(
                onTap: navigateToDetailScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 15,
                        bottom: 15,
                      ),
                      child: Text(
                        "Deal of the day!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 200,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 120, top: 20, bottom: 5),
                      child: Text(
                        product!.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 175, bottom: 50),
                      child: Text(
                        '\$${product!.price.toString()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map(
                              (e) => Image.network(
                                e,
                                fit: BoxFit.fitWidth,
                                width: 100,
                                height: 100,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                    ),
                  ],
                ),
              );
  }
}
