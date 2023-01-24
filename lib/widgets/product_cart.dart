import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shamo_clone/models/product_model.dart';

import '../theme.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      margin: EdgeInsets.only(
        right: defaultMargin,
      ),
      decoration: BoxDecoration(
        color: backgroundColor6,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          product.galleries.length <= 0
              ? Image.asset(
                  "assets/image_shoes.png",
                  width: 215,
                  height: 150,
                )
              : Image.network(
                  product.galleries[0].url,
                  width: 215,
                  height: 150,
                  errorBuilder: ((context, error, stackTrace) {
                    return Image.asset(
                      "assets/image_shoes.png",
                      width: 215,
                      height: 150,
                    );
                  }),
                ),
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
              right: defaultMargin,
              left: defaultMargin,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.category.name,
                  style: subtitleTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: regular,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: subtitleTextStyle.copyWith(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "\$ ${product.price}",
                  style: priceTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
