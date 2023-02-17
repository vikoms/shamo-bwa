import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final String address;
  final List<OrderItemModel> items;
  final String status;
  final double totalPrice;
  final double shippingPrice;

  OrderModel({
    required this.address,
    required this.items,
    required this.status,
    required this.totalPrice,
    required this.shippingPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'items': items.map((item) => item.toJson()).toList(),
      'status': status,
      'total_price': totalPrice,
      'shipping_price': shippingPrice,
    };
  }

  @override
  List<Object?> get props => [
        address,
        items,
        status,
        totalPrice,
        shippingPrice,
      ];
}

class OrderItemModel extends Equatable {
  final int id;
  final int quantity;
  OrderItemModel({
    required this.id,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [
        id,
        quantity,
      ];
}
