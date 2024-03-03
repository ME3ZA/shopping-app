import 'package:flutter/material.dart';
import 'package:my_amazon_app/common/widgets/account_buttons.dart';
import 'package:my_amazon_app/features/account/services/account_services.dart';

class MainButtons extends StatelessWidget {
  const MainButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AccountButtons(
              txt: "Logout",
              onClick: () => AccountServices().logOut(context),
            ),
          ],
        )
      ],
    );
  }
}
