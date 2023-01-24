import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shamo_clone/pages/checkout_finish_page.dart';
import 'package:shamo_clone/theme.dart';

class CheckoutPage extends StatefulWidget {
  static const ROUTE_NAME = "/checkout";
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transparentColor,
        centerTitle: true,
        title: Text(
          "Checkout Details",
          style: primaryTextStyle,
        ),
      ),
      body: Container(
        color: backgroundColor3,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildListItems(),
              _buildAddressDetails(),
              _buildPaymentSummary(),
              SizedBox(
                height: defaultMargin,
              ),
              const Divider(
                thickness: 1,
                color: Color(0xFF2E3141),
              ),
              _buildCheckoutButton()
            ],
          ),
        ),
      ),
    );
  }

  Container _buildCheckoutButton() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 30,
      ),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, CheckoutFinish.ROUTE_NAME);
        },
        child: Text(
          "Checkout Now",
          style: primaryTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 16,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Container _buildPaymentSummary() {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
      ),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Summary",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Product Quantity",
                style: subtitleTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
              Text(
                "2 Items",
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Product Price",
                style: subtitleTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
              Text(
                "\$ 575.96",
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping",
                style: subtitleTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
              Text(
                "Free",
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
            ],
          ),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(
              vertical: 10,
            ),
            color: Color(0xFF2E3141),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style:
                    priceTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
              ),
              Text(
                "\$ 575.92",
                style:
                    priceTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildAddressDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Address Details",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/icon_store_location.png",
                    width: 40,
                  ),
                  Image.asset(
                    'assets/icon_line.png',
                    height: 30,
                  ),
                  Image.asset(
                    'assets/icon_your_address.png',
                    width: 40,
                  ),
                ],
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Store Location",
                    style: subtitleTextStyle,
                  ),
                  Text(
                    "Adidas Core",
                    style: primaryTextStyle,
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  Text(
                    "Your Address",
                    style: subtitleTextStyle,
                  ),
                  Text(
                    "Marsemoon",
                    style: primaryTextStyle,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Container _buildListItems() {
    return Container(
      margin: EdgeInsets.only(
        top: defaultMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "List Items",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 12,
            ),
            height: 120,
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: backgroundColor4,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: backgroundColor6,
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/image_shoes3.png",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Terrex Urban Low",
                              style: primaryTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: semiBold,
                              ),
                            ),
                            Text(
                              "\$143,98",
                              style: priceTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "2 Items",
                        style: subtitleTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
