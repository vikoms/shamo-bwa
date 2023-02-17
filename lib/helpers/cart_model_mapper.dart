import 'package:shamo_clone/data/models/cart_model.dart';

import '../domain/entities/cart.dart';

class CartModelMapper {
  CartModel fromEntity(Cart cart) => CartModel(
        id: cart.id,
        name: cart.name,
        price: cart.price,
        photo: cart.photo,
        quantity: cart.quantity,
      );
}
