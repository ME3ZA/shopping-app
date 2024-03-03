import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/custom_textfields.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/constants/utils.dart';
import 'package:my_amazon_app/default_pay.dart';
import 'package:my_amazon_app/features/address/services/address_services.dart';
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address";
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();
  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: "Total Amount",
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  void onGooglePayResult(res) {
    {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }

    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = '';
    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${pincodeController.text}, -  ${cityController.text},';
      } else {
        throw Exception("Please Enter All Values");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      ShowSnackBar(context, "Please Enter Your Address ");
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVar.appBarColor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: "Flat , House , Building",
                    ),
                    CustomTextField(
                      controller: areaController,
                      hintText: "Area, Street",
                    ),
                    CustomTextField(
                      controller: pincodeController,
                      hintText: "Pin - Post Code",
                    ),
                    CustomTextField(
                      controller: cityController,
                      hintText: "City/Town",
                    ),
                  ],
                ),
              ),
              GooglePayButton(
                onPressed: () => payPressed(address),
                paymentConfiguration:
                    PaymentConfiguration.fromJsonString(defaultGooglePay),
                paymentItems: paymentItems,
                width: 300,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onGooglePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
