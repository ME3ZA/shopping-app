import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/custom_buttons.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/admin/services/admin_services.dart';
import 'package:my_amazon_app/features/search/screen/search_screen.dart';
import 'package:my_amazon_app/models/order.dart';
import 'package:intl/intl.dart';
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  static const String routeName = "/order-details";
  final Order order;
  const OrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int currentStep = 0;
  AdminServices adminServices = AdminServices();
  void navaigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  void changeOrderStatus(int status) {
    if (currentStep < 3) {
      adminServices.changeOrderStatus(
        context: context,
        status: status + 1,
        order: widget.order,
        onSuccess: () {
          setState(() {
            currentStep += 1;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "View Order Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Order Date : ${DateFormat().format(
                        DateTime.fromMillisecondsSinceEpoch(
                          (widget.order.orderedAt),
                        ),
                      )}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Order ID : ${widget.order.id}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Total Price :\$${widget.order.totalPrice}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Purchase Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text("Quantity : ${widget.order.quantity[i]}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Track Your Order",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Stepper(
                    currentStep: currentStep,
                    controlsBuilder: (context, details) {
                      if (user.type == "admin") {
                        return MyCustomButton(
                            txt: "Done",
                            onClick: () =>
                                changeOrderStatus(details.currentStep));
                      } else
                        return SizedBox();
                    },
                    steps: [
                      Step(
                        title: Text("Pending"),
                        content: Text(
                            "Your order is being prepared to be deleivered"),
                        isActive: currentStep > 0,
                        state: currentStep > 0
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: Text("Completed"),
                        content: Text("Your order is ready to be deleivered"),
                        isActive: currentStep > 1,
                        state: currentStep > 1
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: Text("Delivering"),
                        content: Text("Your order is being deleivered"),
                        isActive: currentStep > 2,
                        state: currentStep > 2
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: Text("Received"),
                        content: Text("Your order has been deleivered"),
                        isActive: currentStep >= 3,
                        state: currentStep > 3
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
