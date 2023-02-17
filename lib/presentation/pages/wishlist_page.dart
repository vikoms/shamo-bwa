import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/domain/entities/wishlist.dart';
import 'package:shamo_clone/presentation/pages/product_detail_page.dart';
import 'package:shamo_clone/presentation/providers/page_provider.dart';
import 'package:shamo_clone/presentation/providers/wishlist_provider.dart';
import 'package:shamo_clone/utils/app_utils.dart';
import 'package:shamo_clone/utils/request_state.dart';

import '../../theme.dart';

class WishlistPage extends StatefulWidget {
  static const ROUTE_NAME = "/wishlist-page";

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<WishlistProvider>(context, listen: false)
        .getWishlistProduct());
  }

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider =
        Provider.of<PageProvider>(context, listen: false);
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
      body: Consumer<WishlistProvider>(
        builder: (context, value, child) {
          if (value.state == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.state == RequestState.Loaded) {
            if (value.wishlist.isNotEmpty) {
              return ListView.separated(
                padding: EdgeInsets.all(defaultMargin),
                itemBuilder: (context, index) {
                  return _buildItemFavorite(context, value.wishlist[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
                itemCount: value.wishlist.length,
              );
            } else {
              return _buildEmptyState(pageProvider);
            }
          } else {
            return Center(
              child: Text(
                "Oopss.... Something wrong, please try again later",
                style: primaryTextStyle,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildItemFavorite(BuildContext context, Wishlist wishlist) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailPage.ROUTE_NAME,
          arguments: wishlist.id,
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
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                width: 60,
                height: 60,
                imageUrl: wishlist.photo,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
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
                    wishlist.name,
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    "\$${wishlist.price}",
                    style: priceTextStyle,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Provider.of<WishlistProvider>(context, listen: false)
                    .removeWishlistProduct(wishlist.id,
                        onSuccess: (message) =>
                            AppUtils.showSuccessSnackbar(context, message),
                        onFailure: (message) =>
                            AppUtils.showAlertSnackbar(context, message));
              },
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
          const SizedBox(
            height: 24,
          ),
          Text(
            "You don't have dream shoes?",
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
            style: subtitleTextStyle,
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
            ),
            width: 152,
            height: 44,
            child: TextButton(
              onPressed: () {
                provider.currentIndex = 0;
              },
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Explore Store",
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
