import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String address;
  final List<OrderItem> items;
  final String status;
  final double totalPrice;
  final double shippingPrice;

  OrderEntity({
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

class OrderItem extends Equatable {
  final int id;
  final int quantity;
  OrderItem({
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
