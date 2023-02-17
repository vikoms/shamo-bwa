import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/entities/cart.dart';

import '../../data/models/cart_model.dart';
import '../../utils/failure.dart';

abstract class CartRepository {
  Future<Either<Failure, String>> insertCart(CartModel cart);
  Future<Either<Failure, String>> removeCart(int id);
  Future<Either<Failure, String>> clearCart();
  Future<Either<Failure, Cart?>> getCartById(int id);
  Future<Either<Failure, String>> updateCart(CartModel cart);
  Future<Either<Failure, List<Cart>>> getCart();
}
