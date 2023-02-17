import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:shamo_clone/domain/entities/cart.dart';
import 'package:shamo_clone/domain/entities/product.dart';
import 'package:shamo_clone/domain/entities/wishlist.dart';
import 'package:shamo_clone/domain/usecases/get_product_by_id.dart';
import 'package:shamo_clone/domain/usecases/get_wishlist_by_id.dart';
import 'package:shamo_clone/domain/usecases/insert_cart.dart';
import 'package:shamo_clone/domain/usecases/insert_wishlist.dart';
import 'package:shamo_clone/domain/usecases/remove_wishlist.dart';
import 'package:shamo_clone/domain/usecases/update_cart.dart';
import 'package:shamo_clone/utils/request_state.dart';

import '../../domain/usecases/get_cart_by_id.dart';

class ProductDetailProvider extends ChangeNotifier {
  final InsertWishlist insertWishlist;
  final GetWishlistById getWishlistById;
  final RemoveWishlist removeWishlist;
  final GetProductById getProductById;
  final GetCartById getCartById;
  final UpdateCart updateCart;
  final InsertCart insertCart;
  ProductDetailProvider({
    required this.insertWishlist,
    required this.getWishlistById,
    required this.removeWishlist,
    required this.getProductById,
    required this.updateCart,
    required this.insertCart,
    required this.getCartById,
  });

  late Product _product;
  Product get product => _product;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  bool _isWishlist = false;
  bool get isWishlist => _isWishlist;

  Future<void> insertProductWishlist(Product product,
      void Function(String) onSuccess, void Function(String) onFailure) async {
    try {
      final wishlist = Wishlist(
        id: product.id,
        name: product.name,
        price: product.price,
        photo: product.galleries[0].url,
      );
      final result = await insertWishlist.execute(wishlist);
      result.fold(
        (error) => onFailure(error.message),
        (message) async {
          await isWishlistAdded(product.id);
          onSuccess(message);
        },
      );
    } catch (e) {
      onFailure(e.toString());
    }
  }

  Future<void> isWishlistAdded(int id) async {
    final result = await getWishlistById.execute(id);
    result.fold((l) {
      _isWishlist = false;
      notifyListeners();
    }, (wishlist) {
      _isWishlist = wishlist != null;
      notifyListeners();
    });
  }

  Future<void> getProduct(int id) async {
    _state = RequestState.Loading;
    notifyListeners();
    final result = await getProductById.execute(id);
    result.fold((error) {
      _message = error.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (product) {
      _product = product;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> addToCart(
    Product product, {
    required void Function(String) onSuccess,
    required void Function(String) onFailure,
  }) async {
    final result = await getCartById.execute(product.id);
    result.fold((error) => onFailure(error.message), (cart) async {
      if (cart != null) {
        final existingCart = cart.copyWith(cart.quantity + 1);
        final updateCartResult = await updateCart.execute(existingCart);
        updateCartResult.fold((error) {
          onFailure(error.message);
        }, (message) {
          onSuccess('Product success added to cart');
        });
      } else {
        final newCart = Cart(
          id: product.id,
          name: product.name,
          price: product.price,
          photo: product.galleries[0].url,
          quantity: 1,
        );
        final insertCartResult = await insertCart.execute(newCart);
        insertCartResult.fold((error) {
          onFailure(error.message);
        }, (message) {
          onSuccess('Product success added to cart');
        });
      }
    });
  }
}
