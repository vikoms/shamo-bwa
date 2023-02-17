import 'package:flutter/cupertino.dart';
import 'package:shamo_clone/domain/entities/cart.dart';
import 'package:shamo_clone/domain/usecases/get_cart.dart';
import 'package:shamo_clone/domain/usecases/remove_cart.dart';
import 'package:shamo_clone/domain/usecases/update_cart.dart';
import 'package:shamo_clone/utils/request_state.dart';

class CartProvider extends ChangeNotifier {
  final GetCart getCart;
  final RemoveCart removeCart;
  final UpdateCart updateCart;

  CartProvider({
    required this.getCart,
    required this.removeCart,
    required this.updateCart,
  });

  List<Cart> _carts = [];
  List<Cart> get carts => _carts;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  Future<void> getCarts() async {
    _state = RequestState.Loading;
    notifyListeners();
    final result = await getCart.execute();
    result.fold((error) {
      _message = error.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (carts) {
      _carts = carts;
      _state = RequestState.Loaded;
      getTotalPrice();
      notifyListeners();
    });
  }

  Future<void> removeCartItem(Cart cart,
      {required void Function(String) onFailure}) async {
    if (cart.quantity == 1) {
      final removeResult = await removeCart.execute(cart.id);
      removeResult.fold((error) {
        onFailure(error.message);
      }, (message) async {
        final existingCart =
            _carts.firstWhere((element) => element.id == cart.id);
        _carts.remove(existingCart);
        getTotalPrice();

        notifyListeners();
      });
    } else {
      final updatedCart = cart.copyWith(cart.quantity - 1);
      final updateResult = await updateCart.execute(updatedCart);
      updateResult.fold((error) {
        onFailure(error.message);
      }, (message) async {
        _carts = _carts
            .map((item) =>
                item.id == cart.id ? item.copyWith(updatedCart.quantity) : item)
            .toList();
        getTotalPrice();

        notifyListeners();
      });
    }
  }

  Future<void> addCartItem(Cart cart,
      {required void Function(String) onFailure}) async {
    final updatedCart = cart.copyWith(cart.quantity + 1);
    final updateResult = await updateCart.execute(updatedCart);
    updateResult.fold((error) {
      onFailure(error.message);
    }, (message) async {
      _carts = _carts
          .map((item) =>
              item.id == cart.id ? item.copyWith(updatedCart.quantity) : item)
          .toList();
      getTotalPrice();

      notifyListeners();
    });
  }

  void getTotalPrice() {
    if (_carts.isNotEmpty) {
      _totalPrice = carts
          .map((c) => c.price * c.quantity)
          .reduce((a, b) => a + b)
          .toDouble();
    }
    notifyListeners();
  }
}
