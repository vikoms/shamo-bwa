import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/providers/product_provider.dart';
import 'package:shamo_clone/theme.dart';

class ProductDetailPage extends StatefulWidget {
  static const String ROUTE_NAME = "/product-detail-page";
  final String product;
  const ProductDetailPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
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
    ProductProvider provider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: backgroundColor6,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(provider, context),
              Container(
                margin: EdgeInsets.only(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 30,
                        left: 30,
                        right: 30,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.products[0].name,
                                  style: primaryTextStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                Text(
                                  provider.products[0].category.name,
                                  style: subtitleTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: regular,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              "assets/button_wishlist.png",
                              width: 46,
                            ),
                          )
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
                            "\$ ${provider.products[0].price}",
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
                            provider.products[0].description,
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
                                    borderRadius: BorderRadius.circular(6),
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
                              onPressed: () {},
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
      ),
    );
  }

  Column _buildHeader(ProductProvider provider, BuildContext context) {
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
                icon: Icon(
                  Icons.chevron_left,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_bag,
                ),
              ),
            ],
          ),
        ),
        CarouselSlider(
          items: provider.products[0].galleries
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
          children: provider.products[0].galleries.map((e) {
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
