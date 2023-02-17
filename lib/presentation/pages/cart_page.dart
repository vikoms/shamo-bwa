import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/presentation/pages/checkout_page.dart';
import 'package:shamo_clone/presentation/providers/cart_provider.dart';
import 'package:shamo_clone/theme.dart';
import 'package:shamo_clone/utils/request_state.dart';

import '../widgets/cart_product.dart';

class CartPage extends StatefulWidget {
  static const ROUTE_NAME = "/cart-page";

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    Future.microtask(
        () => Provider.of<CartProvider>(context, listen: false).getCarts());
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
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          if (value.state == RequestState.Loaded) {
            return ListView.separated(
              padding: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              itemCount: value.carts.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemBuilder: (context, index) {
                return CartProduct(
                  cart: value.carts[index],
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, value, child) {
          if (value.state == RequestState.Loading) {
            return Container(
              color: backgroundColor1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Loading....',
                      style: primaryTextStyle,
                    ),
                  ],
                ),
              ),
            );
          } else if (value.state == RequestState.Loaded) {
            if (value.carts.isNotEmpty) {
              return Container(
                height: 130,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal",
                            style: primaryTextStyle,
                          ),
                          Text(
                            "\$ ${value.totalPrice}",
                            style: priceTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      color: const Color(
                        0xff2B2938,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          CheckoutPage.ROUTE_NAME,
                          arguments: value.carts,
                        );
                      },
                      child: Container(
                        height: 55,
                        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                        padding: const EdgeInsets.symmetric(
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
              );
            } else {
              return _buildEmptyState();
            }
          } else {
            return Container(
              color: backgroundColor1,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'Oopss... ${value.message}',
                        style: primaryTextStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          value.getCarts();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: secondaryColor,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin,
                            vertical: 10,
                          ),
                          child: Text(
                            'Try Again',
                            style: primaryTextStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
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
