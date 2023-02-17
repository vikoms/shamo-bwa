import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/domain/entities/cart.dart';
import 'package:shamo_clone/presentation/pages/checkout_finish_page.dart';
import 'package:shamo_clone/presentation/providers/checkout_provider.dart';
import 'package:shamo_clone/theme.dart';
import 'package:shamo_clone/utils/app_utils.dart';
import 'package:shamo_clone/utils/request_state.dart';

class CheckoutPage extends StatefulWidget {
  static const ROUTE_NAME = "/checkout";
  final List<Cart> carts;
  const CheckoutPage({super.key, required this.carts});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<CheckoutProvider>(context, listen: false)
        .setCarts(widget.carts));
  }

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
      body: Consumer<CheckoutProvider>(
        builder: (context, value, child) {
          return Container(
            color: backgroundColor3,
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildListItems(
                    value.carts,
                  ),
                  _buildAddressDetails(),
                  _buildPaymentSummary(
                    value.carts.length,
                    value.totalPrice,
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color(0xFF2E3141),
                  ),
                  value.state == RequestState.Loading
                      ? CircularProgressIndicator()
                      : _buildCheckoutButton(value),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container _buildCheckoutButton(CheckoutProvider provider) {
    return Container(
      margin: const EdgeInsets.symmetric(
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
          provider.checkoutOrder(
              onSuccess: (message) {
                AppUtils.showSuccessSnackbar(context, message);

                Navigator.pushReplacementNamed(
                  context,
                  CheckoutFinish.ROUTE_NAME,
                );
              },
              onFailure: (message) =>
                  AppUtils.showAlertSnackbar(context, message));
        },
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          "Checkout Now",
          style: primaryTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Container _buildPaymentSummary(int totalItem, double totalPrice) {
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
                "$totalItem Items",
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
                "\$ $totalPrice",
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
                "\$ $totalPrice",
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
                    "Kota Bandung",
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

  Container _buildListItems(List<Cart> carts) {
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
            margin: const EdgeInsets.only(
              top: 12,
            ),
            height: carts.length * 120,
            child: ListView(
              children: carts.map((e) => _buildListItem(e)).toList(),
            ),
          )
        ],
      ),
    );
  }

  Container _buildListItem(Cart item) {
    return Container(
      margin: EdgeInsets.only(
        top: 12,
      ),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              width: 60,
              height: 60,
              imageUrl: item.photo,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
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
                  item.name,
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  "\$${item.price * item.quantity}",
                  style: priceTextStyle,
                ),
              ],
            ),
          ),
          Text(
            "${item.quantity} Items",
            style: subtitleTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
