import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/loader.dart';
import 'package:my_amazon_app/common/widgets/one_product.dart';
import 'package:my_amazon_app/features/account/services/account_services.dart';
import 'package:my_amazon_app/features/order_details/screens/order_details.dart';
import 'package:my_amazon_app/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      "My Orders",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                  ),
                ],
              ),
              Container(
                height: 150,
                padding: EdgeInsets.only(left: 5, top: 10, right: 0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, OrderDetails.routeName,
                            arguments: orders![index]);
                      },
                      child: OneProduct(
                        myImage: orders![index].products[0].images[0],
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
  }
}
