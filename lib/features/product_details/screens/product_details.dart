import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_amazon_app/common/widgets/custom_buttons.dart';
import 'package:my_amazon_app/common/widgets/stars.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/constants/utils.dart';
import 'package:my_amazon_app/features/product_details/screens/product_services/product_details_services.dart';
import 'package:my_amazon_app/features/search/screen/search_screen.dart';
import 'package:my_amazon_app/models/products.dart';
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = "/product-details";
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;
  @override
  void initState() {
    double totalRating = 0;
    for (var i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }

    super.initState();
  }

  void navaigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    productDetailsServices.addToCart(context: context, product: widget.product);
    ShowSnackBar(context, "Item Added Successfully");
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id!),
                  Stars(rating: avgRating),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Text(
                widget.product.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map(
                (e) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      e,
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(viewportFraction: 0.6),
            ),
            Container(
              color: Colors.black38,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: "Price: ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "\$${widget.product.price} ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: GlobalVar.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                widget.product.description,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              color: Colors.black38,
              height: 5,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: MyCustomButton(
                txt: "Add to Cart",
                onClick: addToCart,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black38,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                "Rate The Product",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: ((context, index) => Icon(
                    Icons.star,
                    color: GlobalVar.secondaryColor,
                  )),
              onRatingUpdate: (rating) {
                productDetailsServices.rateProduct(
                    context: context, product: widget.product, rating: rating);
              },
            ),
          ],
        ),
      ),
    );
  }
}
