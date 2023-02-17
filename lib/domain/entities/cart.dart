import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final int id;
  final String name;
  final int price;
  final String photo;
  final int quantity;

  Cart({
    required this.id,
    required this.name,
    required this.price,
    required this.photo,
    required this.quantity,
  });

  Cart copyWith(int quantity) => Cart(
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
