import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/loader.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/account/screens/single_product.dart';
import 'package:my_amazon_app/features/admin/screen/products_screen.dart';
import 'package:my_amazon_app/features/admin/services/admin_services.dart';
import 'package:my_amazon_app/features/product_details/screens/product_details.dart';
import 'package:my_amazon_app/models/products.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  fetchAllProduct() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  @override
  void initState() {
    super.initState();
    fetchAllProduct();
  }

  void addNewProduct() {
    Navigator.pushNamed(context, ProductsScreen.routeName);
  }

  void navigateToDetailScreen(Product product) {
    Navigator.pushNamed(
      context,
      ProductDetails.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Loader()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Admin Panel Posts",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: GlobalVar.secondaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: products!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final productData = products![index];
                        return GestureDetector(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 140,
                                child: GestureDetector(
                                  onTap: () =>
                                      navigateToDetailScreen(productData),
                                  child: SingleProduct(
                                    image: productData.images[0],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        productData.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        deleteProduct(productData, index),
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: "Add New Product",
              child: Icon(Icons.add),
              onPressed: addNewProduct,
            ),
          );
  }
}
