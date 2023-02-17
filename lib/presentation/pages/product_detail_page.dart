import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/domain/entities/product.dart';
import 'package:shamo_clone/presentation/pages/cart_page.dart';
import 'package:shamo_clone/presentation/providers/product_detail_provider.dart';
import 'package:shamo_clone/theme.dart';
import 'package:shamo_clone/utils/app_utils.dart';
import 'package:shamo_clone/utils/request_state.dart';

class ProductDetailPage extends StatefulWidget {
  static const String ROUTE_NAME = "/product-detail-page";
  final int productId;
  const ProductDetailPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<ProductDetailProvider>(context, listen: false)
          ..getProduct(widget.productId)
          ..isWishlistAdded(widget.productId));
  }

  List familiarShoes = [
    'assets/image_shoes.png',
    'assets/image_shoes2.png',
    'assets/image_shoes3.png',
    'assets/image_shoes4.png',
    'assets/image_shoes5.png',
    'assets/image_shoes6.png',
    'assets/image_shoes7.png',
    'assets/image_shoes8.png',
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor6,
      body: Consumer<ProductDetailProvider>(
        builder: ((context, value, child) {
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
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(value.product, context),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      decoration: BoxDecoration(
                        color: backgroundColor1,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(24),
                          topLeft: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 30,
                              left: 30,
                              right: 30,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.product.name,
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                      Text(
                                        value.product.category.name,
                                        style: subtitleTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: regular,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    value.insertProductWishlist(value.product,
                                        (message) {
                                      AppUtils.showSuccessSnackbar(
                                          context, message);
                                    }, (error) {
                                      AppUtils.showAlertSnackbar(
                                          context, error);
                                    });
                                  },
                                  child: Image.asset(
                                    value.isWishlist
                                        ? "assets/button_wishlist_blue.png"
                                        : "assets/button_wishlist.png",
                                    width: 46,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: backgroundColor2),
                            margin: EdgeInsets.only(
                              top: 20,
                              right: defaultMargin,
                              left: defaultMargin,
                            ),
                            padding: EdgeInsets.all(
                              16,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Price starts from",
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: regular,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$ ${value.product.price}",
                                  style: priceTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // DESCRIPTION
                          Container(
                            margin: EdgeInsets.only(
                              top: 20,
                              right: defaultMargin,
                              left: defaultMargin,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Description",
                                  style: primaryTextStyle.copyWith(
                                    fontWeight: medium,
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  value.product.description,
                                  style: subtitleTextStyle.copyWith(
                                    fontWeight: medium,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Familiar Shoes
                          Container(
                            margin: EdgeInsets.only(
                              top: defaultMargin,
                              right: defaultMargin,
                              left: defaultMargin,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Familiar Shoes",
                                  style: primaryTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: medium,
                                  ),
                                ),
                                Container(
                                  height: 54,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 54,
                                        height: 54,
                                        decoration: BoxDecoration(
                                          color: backgroundColor6,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              familiarShoes[index],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (content, index) {
                                      return SizedBox(
                                        width: 10,
                                      );
                                    },
                                    itemCount: familiarShoes.length,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.all(
                              defaultMargin,
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 54,
                                    height: 54,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/button_chat.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor: primaryColor,
                                    ),
                                    child: Text(
                                      "Add To Cart",
                                      style: primaryTextStyle.copyWith(
                                        fontWeight: semiBold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    onPressed: () {
                                      value.addToCart(value.product,
                                          onSuccess: (message) =>
                                              AppUtils.showSuccessSnackbar(
                                                  context, message),
                                          onFailure: (message) =>
                                              AppUtils.showAlertSnackbar(
                                                  context, message));
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
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
                          value.getProduct(widget.productId);
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
        }),
      ),
    );
  }

  Column _buildHeader(Product product, BuildContext context) {
    int index = -1;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 25,
            right: defaultMargin,
            left: defaultMargin,
          ),
          color: backgroundColor6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.chevron_left,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartPage.ROUTE_NAME);
                },
                icon: const Icon(
                  Icons.shopping_bag,
                ),
              ),
            ],
          ),
        ),
        CarouselSlider(
          items: product.galleries
              .map((image) => Image.network(
                    image.url,
                    width: MediaQuery.of(context).size.width,
                    height: 310,
                    fit: BoxFit.cover,
                  ))
              .toList(),
          options: CarouselOptions(
            initialPage: 0,
            onPageChanged: ((index, reason) {
              setState(() {
                currentIndex = index;
              });
            }),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: product.galleries.map((e) {
            index++;
            return _buildIndicator(index);
          }).toList(),
        )
      ],
    );
  }

  Container _buildIndicator(int index) {
    return Container(
      width: currentIndex == index ? 16 : 4,
      height: 4,
      margin: EdgeInsets.symmetric(
        horizontal: 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: currentIndex == index ? primaryColor : Color(0xffC4C4C4),
      ),
    );
  }
}
