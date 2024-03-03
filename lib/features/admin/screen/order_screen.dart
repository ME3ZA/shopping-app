import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/loader.dart';
import 'package:my_amazon_app/common/widgets/one_product.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/admin/services/admin_services.dart';
import 'package:my_amazon_app/features/order_details/screens/order_details.dart';
import 'package:my_amazon_app/models/order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  void deleteOrder(Order order, int index) {
    adminServices.deleteOrder(
      context: context,
      order: order,
      onSuccess: () {
        orders!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? Loader()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Orders History",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: GlobalVar.secondaryColor,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: orders!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      final orderData = orders![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            OrderDetails.routeName,
                            arguments: orderData,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 400,
                            child: Row(
                              children: [
                                Expanded(
                                  child: OneProduct(
                                    myImage: orderData.products[0].images[0],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      deleteOrder(orderData, index),
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
