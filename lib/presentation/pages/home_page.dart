import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/presentation/providers/home_page_provider.dart';
import 'package:shamo_clone/theme.dart';
import 'package:shamo_clone/presentation/widgets/product_cart.dart';
import 'package:shamo_clone/utils/request_state.dart';

import '../widgets/product_tile.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = "/home";

  const HomePage({super.key});
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<HomePageProvider>(context, listen: false)
        ..getProducts()
        ..getCategories()
        ..getProductsByCategory(0)
        ..getProfile(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              _buildProductsByCategory(),
              _buildProducts()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductsByCategory() {
    return Consumer<HomePageProvider>(
      builder: ((context, value, child) {
        final state = value.productsCategoyState;

        if (state == RequestState.Loading) {
          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state == RequestState.Loaded) {
          return Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value.categoryTitle,
                  style: primaryTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                value.productsPerCategory.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: value.productsPerCategory
                              .map(
                                (product) => ProductCard(product: product),
                              )
                              .toList(),
                        ),
                      )
                    : Center(
                        child: Text(
                          "Produk Tidak Ada",
                          style: primaryTextStyle,
                        ),
                      ),
              ],
            ),
          );
        } else if (state == RequestState.Error) {
          return Center(
            child: Container(
              child: Text(
                value.productsCategoryMessage,
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Container(
              child: Text(
                'Something Wrong, please try again later...',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildProducts() {
    return Consumer<HomePageProvider>(
      builder: ((context, value, child) {
        final state = value.productState;

        if (state == RequestState.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state == RequestState.Loaded) {
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
                  children: value.products
                      .map(
                        (product) => ProductTile(product: product),
                      )
                      .toList(),
                )
              ],
            ),
          );
        } else if (state == RequestState.Error) {
          return Center(
            child: Container(
              child: Text(
                value.productMessage,
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Container(
              child: Text(
                'Something Wrong, please try again later...',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildCategories() {
    return Consumer<HomePageProvider>(
      builder: (context, value, child) {
        final state = value.categoryState;
        if (state == RequestState.Loading) {
          return const Center(child: const CircularProgressIndicator());
        } else if (state == RequestState.Loaded) {
          return Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: value.categories.map((category) {
                  return _buildChip(
                    category.isSelected,
                    category.name,
                    category.id,
                  );
                }).toList(),
              ),
            ),
          );
        } else if (state == RequestState.Error) {
          return Center(
            child: Container(
              child: Text(
                value.categoryMessage,
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Container(
              child: Text(
                'Something Wrong, please try again later...',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildChip(bool isSelected, String text, int id) {
    return InkWell(
      onTap: () {
        Provider.of<HomePageProvider>(context, listen: false)
            .setCategorySelected(id);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(
          right: 10,
        ),
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
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<HomePageProvider>(
      builder: (context, value, child) {
        if (value.profile != null) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hallo, ${value.profile?.name}",
                      style: primaryTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      "@${value.profile?.username}",
                      style: subtitleTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(27),
                child: CachedNetworkImage(
                  width: 54,
                  height: 54,
                  imageUrl: value.profile?.profilePhotoUrl ?? "",
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/image_profile.png"),
                ),
              ),
            ],
          );
        } else {
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
      },
    );
  }
}
