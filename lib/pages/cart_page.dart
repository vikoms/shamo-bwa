import 'package:flutter/material.dart';
import 'package:shamo_clone/pages/checkout_page.dart';
import 'package:shamo_clone/theme.dart';

import '../widgets/cart_product.dart';

class CartPage extends StatefulWidget {
  static const ROUTE_NAME = "/cart-page";

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transparentColor,
        centerTitle: true,
        title: Text(
          "Your Cart",
          style: primaryTextStyle,
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        itemCount: 10,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          return CartProduct();
        },
      ),
      bottomNavigationBar: Container(
        height: 170,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Subtotal",
                    style: primaryTextStyle,
                  ),
                  Text(
                    "\$ 255.5",
                    style: priceTextStyle,
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              margin: EdgeInsets.symmetric(
                vertical: defaultMargin,
              ),
              color: Color(
                0xff2B2938,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, CheckoutPage.ROUTE_NAME);
              },
              child: Container(
                height: 55,
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Continue To Checkout",
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: primaryTextColor,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Center _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icon_empty_cart.png",
            width: 80,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Opss! Your Cart is Empty",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Let's find your favorite shoes",
            style: subtitleTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: 154,
            margin: const EdgeInsets.only(
              top: 20,
            ),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
              ),
              child: Text(
                "Explore State",
                style: primaryTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
