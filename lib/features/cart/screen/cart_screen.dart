import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/custom_buttons.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/address/screens/address_screen.dart';
import 'package:my_amazon_app/features/cart/widgets/cart_product.dart';
import 'package:my_amazon_app/features/cart/widgets/cart_subtotal.dart';
import 'package:my_amazon_app/features/search/screen/search_screen.dart';
import 'package:my_amazon_app/home/widgets/address_user.dart';
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: query,
    );
  }

  void navigateToAddress(int sum) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: sum.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
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
                      onFieldSubmitted: (query) =>
                          navigateToSearchScreen(query),
                      decoration: InputDecoration(
                        prefix: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
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
                          borderRadius: BorderRadius.all(Radius.circular(5)),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AddressUser(),
            CartSubtotal(),
            Padding(
              padding: EdgeInsets.all(8),
              child: MyCustomButton(
                txt: "Proceed to Buy (${user.cart.length})",
                onClick: () => navigateToAddress(sum),
              ),
            ),
            Divider(color: Colors.black.withOpacity(0.08), height: 1),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: user.cart.length,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
