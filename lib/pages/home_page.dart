import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/providers/product_provider.dart';
import 'package:shamo_clone/theme.dart';
import 'package:shamo_clone/widgets/product_cart.dart';

import '../widgets/product_tile.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = "/home";
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    Container _buildPopularProducts() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Popular Products",
              style: primaryTextStyle.copyWith(
                fontSize: 22,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 14,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: productProvider.products
                    .map(
                      (product) => ProductCard(product: product),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            top: defaultMargin,
            right: defaultMargin,
            left: defaultMargin,
          ),
          child: ListView(
            children: [
              _buildHeader(),
              _buildCategories(),
              _buildPopularProducts(),
              _buildProducts(productProvider)
            ],
          ),
        ),
      ),
    );
  }

  Container _buildProducts(ProductProvider productProvider) {
    return Container(
      margin: EdgeInsets.only(
        top: defaultMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "New Arrivals",
            style: primaryTextStyle.copyWith(
              fontSize: 22,
              fontWeight: semiBold,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            children: productProvider.products
                .map(
                  (product) => ProductTile(product: product),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  Container _buildCategories() {
    return Container(
      margin: EdgeInsets.only(
        top: defaultMargin,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildChip(true, "All Shoes"),
            SizedBox(
              width: 16,
            ),
            _buildChip(false, "Running"),
            SizedBox(
              width: 16,
            ),
            _buildChip(false, "Training"),
            SizedBox(
              width: 16,
            ),
            _buildChip(false, "Basketball"),
          ],
        ),
      ),
    );
  }

  Container _buildChip(bool isSelected, String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? primaryColor : transparentColor,
        border: Border.all(
          color: isSelected ? primaryColor : subtitleColor,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      child: Text(
        text,
        style: primaryTextStyle.copyWith(
          fontSize: 13,
          color: isSelected ? primaryTextColor : subtitleColor,
          fontWeight: medium,
        ),
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hallo, Alex",
                style: primaryTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: semiBold,
                ),
              ),
              Text(
                "@alexkeinn",
                style: subtitleTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset("assets/image_profile.png"),
        )
      ],
    );
  }
}
