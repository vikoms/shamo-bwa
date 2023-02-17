import 'package:flutter/material.dart';
import 'package:shamo_clone/domain/entities/product.dart';
import 'package:shamo_clone/presentation/pages/product_detail_page.dart';

import '../../theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetailPage.ROUTE_NAME,
        arguments: product.id,
      ),
      child: Container(
        width: 195,
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
            product.galleries.isEmpty
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
      ),
    );
  }
}
