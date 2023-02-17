import 'package:equatable/equatable.dart';
import 'package:shamo_clone/data/models/product_model.dart';
import 'package:shamo_clone/domain/entities/transaction.dart';

class TransactionDataModel extends Equatable {
  TransactionDataModel({
    required this.currentPage,
    required this.transactions,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
  });

  final int? currentPage;
  final List<TransactionModel> transactions;
  final int? from;
  final int? lastPage;
  final String? perPage;
  final int? to;
  final int? total;

  factory TransactionDataModel.fromJson(Map<String, dynamic> json) =>
      TransactionDataModel(
        currentPage: json["current_page"],
        transactions: List<TransactionModel>.from(
            json["data"].map((x) => TransactionModel.fromJson(x))),
        from: json["from"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "per_page": perPage,
        "to": to,
        "total": total,
        "transactions":
            List<TransactionModel>.from(transactions.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        currentPage,
        from,
        lastPage,
        perPage,
        to,
        total,
        transactions,
      ];
}

class TransactionModel extends Equatable {
  const TransactionModel({
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
  final List<TransactionItemModel> items;

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      usersId: json['users_id'],
      address: json['address'],
      totalPrice: json['total_price'],
      shippingPrice: json['shipping_price'],
      status: json['status'],
      id: json['id'],
      items: List<TransactionItemModel>.from(
          json['items'].map((x) => TransactionItemModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "users_id": usersId,
        "address": address,
        "total_price": totalPrice,
        "shipping_price": shippingPrice,
        "status": status,
        "id": id,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };

  Transaction toEntity() => Transaction(
        usersId: usersId,
        address: address,
        totalPrice: totalPrice,
        shippingPrice: shippingPrice,
        status: status,
        id: id,
        items: items.map((e) => e.toEntity()).toList(),
      );

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

class TransactionItemModel extends Equatable {
  const TransactionItemModel({
    required this.id,
    required this.usersId,
    required this.productsId,
    required this.transactionsId,
    required this.quantity,
    required this.product,
  });

  final int id;
  final int usersId;
  final int productsId;
  final int transactionsId;
  final int quantity;
  final TransactionProductModel? product;

  factory TransactionItemModel.fromJson(Map<String, dynamic> json) =>
      TransactionItemModel(
        id: json['id'],
        usersId: json['users_id'],
        productsId: json['products_id'],
        transactionsId: json['transactions_id'],
        quantity: json['quantity'],
        product: json['product'] == null
            ? null
            : TransactionProductModel.fromJson(json['product']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "users_id": usersId,
        "products_id": productsId,
        "transactions_id": transactionsId,
        "quantity": quantity,
        "product": product?.toJson(),
      };

  TransactionItem toEntity() => TransactionItem(
        id: id,
        usersId: usersId,
        productsId: productsId,
        transactionsId: transactionsId,
        quantity: quantity,
        product: product?.toEntity(),
      );

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

class TransactionProductModel extends Equatable {
  TransactionProductModel({
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

  TransactionProduct toEntity() => TransactionProduct(
        id: id,
        name: name,
        price: price,
        description: description,
        categoriesId: categoriesId,
      );

  factory TransactionProductModel.fromJson(Map<String, dynamic> json) =>
      TransactionProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        categoriesId: json["categories_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "categories_id": categoriesId,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        description,
        categoriesId,
      ];
}
