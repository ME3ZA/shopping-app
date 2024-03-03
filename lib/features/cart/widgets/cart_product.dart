import 'package:flutter/material.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/cart/services/cart_services.dart';
import 'package:my_amazon_app/features/product_details/screens/product_services/product_details_services.dart';
import 'package:my_amazon_app/models/products.dart';
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();
  void increaseQuantity(Product product) {
    productDetailsServices.addToCart(
      context: context,
      product: product,
    );
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(
      context: context,
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
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
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => decreaseQuantity(product),
                        child: Container(
                          width: 35,
                          height: 35,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.remove,
                            size: 19,
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 1.5,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Container(
                          width: 35,
                          height: 35,
                          alignment: Alignment.center,
                          child: Text(
                            quantity.toString(),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => increaseQuantity(product),
                        child: Container(
                          width: 35,
                          height: 35,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add,
                            size: 19,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
