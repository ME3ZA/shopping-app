import 'package:flutter/material.dart';
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddressUser extends StatelessWidget {
  const AddressUser({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ],
        ),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Icon(
            Icons.location_pin,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Delivery to ${user.name} - ${user.address}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 5,
              right: 6,
              top: 2,
            ),
            child: Icon(
              Icons.arrow_drop_down,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
