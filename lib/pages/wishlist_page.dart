import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/pages/product_detail_page.dart';
import 'package:shamo_clone/providers/page_provider.dart';

import '../theme.dart';

class WishlistPage extends StatefulWidget {
  static const ROUTE_NAME = "/wishlist-page";

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    PageProvider provider = Provider.of<PageProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        toolbarHeight: 87,
        backgroundColor: transparentColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Favorite Shoes",
          style: primaryTextStyle,
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(defaultMargin),
        itemBuilder: (context, index) {
          return _buildItemFavorite(context);
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20,
          );
        },
        itemCount: 10,
      ),
    );
  }

  Widget _buildItemFavorite(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailPage.ROUTE_NAME,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: backgroundColor4,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/image_shoes3.png",
                  ),
                ),
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
                    "Terrex Urban Low",
                    style: primaryTextStyle.copyWith(
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
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                "assets/button_wishlist_blue.png",
                width: 34,
                height: 34,
              ),
            )
          ],
        ),
      ),
    );
  }

  Center _buildEmptyState(PageProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/image_wishlist.png",
            width: 74,
            height: 62,
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "You don't have dream shoes?",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Let's find your favorite shoes",
            style: subtitleTextStyle,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            width: 152,
            height: 44,
            child: TextButton(
              onPressed: () {
                provider.currentIndex = 0;
              },
              child: Text(
                "Explore Store",
                style: primaryTextStyle.copyWith(
                  fontWeight: medium,
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
          )
        ],
      ),
    );
  }
}
