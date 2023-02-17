import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shamo_clone/presentation/providers/transaction_provider.dart';
import 'package:shamo_clone/utils/request_state.dart';

import '../../theme.dart';

class MyTransactionPage extends StatefulWidget {
  static const ROUTE_NAME = '/my-transaction-page';
  const MyTransactionPage({super.key});

  @override
  State<MyTransactionPage> createState() => _MyTransactionPageState();
}

class _MyTransactionPageState extends State<MyTransactionPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Future.microtask(() =>
            Provider.of<TransactionProvider>(context, listen: false)
                .fetchMoreTransactions());
      }
    });
    Future.microtask(() =>
        Provider.of<TransactionProvider>(context, listen: false)
            .getTransactionList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transparentColor,
        centerTitle: true,
        title: Text(
          "My Transactions",
          style: primaryTextStyle,
        ),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, value, child) {
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
            if (value.transactions.isNotEmpty) {
              return Container(
                margin: EdgeInsets.only(
                  left: defaultMargin,
                  right: defaultMargin,
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index >= value.transactions.length) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: CircularProgressIndicator(strokeWidth: 1.5),
                        ),
                      );
                    }
                    final product = value.transactions[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: backgroundColor4,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.shopify,
                                    color: Colors.white,
                                    size: 46,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        product.items[0].product?.name ??
                                            "Product Unknown",
                                        style: primaryTextStyle,
                                      ),
                                      Text(
                                        "${product.items[0].quantity} items",
                                        style: secondaryTextStyle,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  product.status,
                                  style: primaryTextStyle.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          product.items.length > 1
                              ? Text(
                                  '+${product.items.length - 1} Items More',
                                  style: secondaryTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                )
                              : Container(),
                          Divider(
                            color: backgroundColor6.withAlpha(20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Price : ',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '\$ ${product.getTotalPrice()}',
                                style: priceTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: value.hasReachedMaxPage
                      ? value.transactions.length
                      : value.transactions.length + 1,
                  // itemCount: value.transactions.length +
                  //     (value.pagingState == RequestState.Loading ? 1 : 0),
                ),
              );
            } else {
              return _buildEmptyState();
            }
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
                          value.getTransactionList();
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
        },
      ),
    );
  }

  Center _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icon_empty_cart.png",
            width: 80,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Opss! Your transactions is empty",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
