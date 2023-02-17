import 'package:shamo_clone/data/datasources/db/database_helper.dart';
import 'package:shamo_clone/data/models/cart_model.dart';

import '../../utils/exception.dart';

abstract class CartLocalDataSource {
  Future<List<CartModel>> getCarts();
  Future<String> insertCart(CartModel cart);
  Future<String> removeCart(int id);
  Future<String> clearCart();
  Future<CartModel?> getCart(int id);
  Future<String> updateCart(CartModel cart);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final DatabaseHelper databaseHelper;
  CartLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<List<CartModel>> getCarts() async {
    try {
      final result = await databaseHelper.getCarts();
      return result.map((e) => CartModel.fromMap(e)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> insertCart(CartModel cart) async {
    try {
      final result = await databaseHelper.insertCart(cart);
      return 'Product success added to cart';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeCart(int id) async {
    try {
      final result = await databaseHelper.removeCart(id);
      return 'Product success removed from cart';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> updateCart(CartModel cart) async {
    try {
      final result = await databaseHelper.updateCart(cart);
      return 'Success';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<CartModel?> getCart(int id) async {
    try {
      final result = await databaseHelper.getCartById(id);
      if (result != null) {
        return CartModel.fromMap(result);
      } else {
        return null;
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> clearCart() async {
    try {
      final result = await databaseHelper.clearCart();
      return 'Success';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
