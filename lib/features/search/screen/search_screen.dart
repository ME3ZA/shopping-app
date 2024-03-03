import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/loader.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/product_details/screens/product_details.dart';
import 'package:my_amazon_app/features/search/screen/services/search_services.dart';
import 'package:my_amazon_app/features/search/screen/widgets/searched_products.dart';
import 'package:my_amazon_app/home/widgets/address_user.dart';
import 'package:my_amazon_app/models/products.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search-screen";
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();
  @override
  void initState() {
    super.initState();
    fetchSearchProducts();
  }

  fetchSearchProducts() async {
    products = await searchServices.fetchSearchProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

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
      body: products == null
          ? Loader()
          : Column(
              children: [
                AddressUser(),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ProductDetails.routeName,
                              arguments: products![index]);
                        },
                        child: SearchedProducts(
                          product: products![index],
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
