import 'package:equatable/equatable.dart';
import 'package:shamo_clone/domain/entities/product.dart';

import '../../domain/entities/cart.dart';

class CartModel extends Equatable {
  final int id;
  final String name;
  final int price;
  final String photo;
  final int quantity;

  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.photo,
    required this.quantity,
  });

  factory CartModel.fromProductEntity(Product product, int quantity) =>
      CartModel(
          id: product.id,
          name: product.name,
          price: product.price,
          photo: product.galleries[0].url,
          quantity: quantity);

  factory CartModel.fromMap(Map<String, dynamic> map) => CartModel(
        id: map['id'],
        name: map['name'],
        price: map['price'],
        photo: map['photo'],
        quantity: map['quantity'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'photo': photo,
        'quantity': quantity
      };

  Cart toEntity() => Cart(
        id: id,
        name: name,
        price: price,
        photo: photo,
        quantity: quantity,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        photo,
      ];
}
