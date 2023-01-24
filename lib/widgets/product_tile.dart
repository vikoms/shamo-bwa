import 'package:flutter/material.dart';
import 'package:shamo_clone/models/product_model.dart';
import 'package:shamo_clone/pages/product_detail_page.dart';

import '../theme.dart';

// ProductModel(
//               id: 123,
//               name: "cekson",
//               price: 123,
//               description: "description",
//               tags: null,
//               category: CategoryModel(id: 12, name: "as"),
//               createdAt: DateTime(2020),
//               updatedAt: DateTime(2120),
//               galleries: []
class ProductTile extends StatelessWidget {
  final ProductModel product;
  const ProductTile({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailPage.ROUTE_NAME,
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: defaultMargin,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.galleries[0].url,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
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
                    product.category.name,
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: regular,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "\$ ${product.price}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: priceTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
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
