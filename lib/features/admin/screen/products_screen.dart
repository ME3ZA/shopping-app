import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/custom_buttons.dart';
import 'package:my_amazon_app/common/widgets/custom_textfields.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/constants/utils.dart';
import 'package:my_amazon_app/features/admin/services/admin_services.dart';

class ProductsScreen extends StatefulWidget {
  static const routeName = "/products-screen";
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  String defaultVal = "Bedding";
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    "Bathroom Accessories",
    "Bedding",
    "Cleaning Tools",
    "Home Decor",
    "Lighting",
    "Storage",
  ];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.addProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: defaultVal,
        images: images,
      );
    }
  }

  void selectedImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVar.appBarColor,
            ),
          ),
          title: Text(
            "Add New Product",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (e) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                e,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(viewportFraction: 0.6),
                      )
                    : GestureDetector(
                        onTap: selectedImages,
                        child: DottedBorder(
                          dashPattern: [10, 6],
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Select Product Image",
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: productNameController,
                  hintText: "Product Name",
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: descriptionController,
                  hintText: "Product Description",
                  maxLines: 8,
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: priceController,
                  hintText: "Product Price",
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: quantityController,
                  hintText: "Product Quantity",
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    items: productCategories.map(
                      (String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      setState(
                        () {
                          defaultVal = value!;
                        },
                      );
                    },
                    value: defaultVal,
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                MyCustomButton(
                  txt: "Add Product",
                  onClick: sellProduct,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
