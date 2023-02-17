import 'package:equatable/equatable.dart';
import 'package:shamo_clone/data/models/product_model.dart';

class Transaction extends Equatable {
  const Transaction({
    required this.usersId,
    required this.address,
    required this.totalPrice,
    required this.shippingPrice,
    required this.status,
    required this.id,
    required this.items,
  });

  final int usersId;
  final String address;
  final int totalPrice;
  final int shippingPrice;
  final String status;
  final int id;
  final List<TransactionItem> items;

  int getTotalPrice() {
    return items
        .map((e) => e.getTotalPrice())
        .reduce((value, element) => value + element);
  }

  @override
  List<Object?> get props => [
        usersId,
        address,
        totalPrice,
        shippingPrice,
        status,
        id,
        items,
      ];
}

class TransactionItem extends Equatable {
  const TransactionItem({
    required this.id,
    required this.usersId,
    required this.productsId,
    required this.transactionsId,
    required this.quantity,
    this.product,
  });

  final int id;
  final int usersId;
  final int productsId;
  final int transactionsId;
  final int quantity;
  final TransactionProduct? product;

  int getTotalPrice() {
    return quantity * (product?.price ?? 0);
  }

  @override
  List<Object?> get props => [
        id,
        usersId,
        productsId,
        transactionsId,
        quantity,
        product,
      ];
}

class TransactionProduct extends Equatable {
  TransactionProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.categoriesId,
  });

  final int id;
  final String name;
  final int price;
  final String description;
  final int categoriesId;

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        description,
        categoriesId,
      ];
}
