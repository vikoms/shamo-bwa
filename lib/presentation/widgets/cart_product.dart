import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/domain/entities/cart.dart';
import 'package:shamo_clone/presentation/providers/cart_provider.dart';
import 'package:shamo_clone/utils/app_utils.dart';

import '../../theme.dart';

class CartProduct extends StatelessWidget {
  final Cart cart;
  const CartProduct({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  width: 60,
                  height: 60,
                  imageUrl: cart.photo,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.name,
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "\$${cart.price}",
                      style: priceTextStyle,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addCartItem(
                        cart,
                        onFailure: (message) =>
                            AppUtils.showAlertSnackbar(context, message),
                      );
                    },
                    child: Image.asset(
                      "assets/button_add.png",
                      width: 16,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "${cart.quantity}",
                    style: primaryTextStyle,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .removeCartItem(
                        cart,
                        onFailure: (message) =>
                            AppUtils.showAlertSnackbar(context, message),
                      );
                    },
                    child: Image.asset(
                      "assets/button_min.png",
                      width: 16,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
