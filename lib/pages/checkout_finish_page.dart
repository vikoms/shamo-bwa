import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shamo_clone/pages/home_page.dart';
import 'package:shamo_clone/pages/main_page.dart';
import 'package:shamo_clone/theme.dart';

class CheckoutFinish extends StatefulWidget {
  static const ROUTE_NAME = "/checkout-finish";
  const CheckoutFinish({super.key});

  @override
  State<CheckoutFinish> createState() => _CheckoutFinishState();
}

class _CheckoutFinishState extends State<CheckoutFinish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        toolbarHeight: 87,
        backgroundColor: transparentColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Checkout Success",
          style: primaryTextStyle,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icon_empty_cart.png",
              height: 70,
              width: 80,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "You made a transaction",
              style: primaryTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Stay at home while we \n prepare your dream shoes",
              style: subtitleTextStyle,
              textAlign: TextAlign.center,
            ),
            Container(
              width: 196,
              height: 44,
              margin: EdgeInsets.only(
                top: defaultMargin,
              ),
              child: TextButton(
                child: Text(
                  "Order The Shoes",
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, MainPage.ROUTE_NAME, (route) => false);
                },
              ),
            ),
            Container(
              width: 196,
              height: 44,
              margin: EdgeInsets.only(
                top: defaultMargin,
              ),
              child: TextButton(
                child: Text(
                  "View My Order",
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF39374B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
