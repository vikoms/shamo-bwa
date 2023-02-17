import 'package:flutter/cupertino.dart';
import 'package:shamo_clone/domain/entities/cart.dart';
import 'package:shamo_clone/domain/entities/order.dart';
import 'package:shamo_clone/domain/usecases/checkout_order.dart';
import 'package:shamo_clone/domain/usecases/clear_cart.dart';
import 'package:shamo_clone/utils/request_state.dart';

class CheckoutProvider extends ChangeNotifier {
  final CheckoutOrder checkout;
  final ClearCart clearCart;
  CheckoutProvider({
    required this.checkout,
    required this.clearCart,
  });

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Cart> _carts = [];
  List<Cart> get carts => _carts;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  void setCarts(List<Cart> newCarts) {
    _carts = newCarts;
    _totalPrice = _carts
        .map((e) => e.quantity * e.price)
        .reduce((value, element) => value + element)
        .toDouble();
    notifyListeners();
  }

  Future<void> checkoutOrder(
      {required void Function(String) onSuccess,
      required void Function(String) onFailure}) async {
    final List<OrderItem> items = [];
    for (var cart in _carts) {
      items.add(OrderItem(
        id: cart.id,
        quantity: cart.quantity,
      ));
    }

    final order = OrderEntity(
      address: "Kota Bandung",
      items: items,
      status: 'PENDING',
      totalPrice: totalPrice,
      shippingPrice: 0,
    );

    _state = RequestState.Loading;
    notifyListeners();
    final result = await checkout.execute(order);
    result.fold((error) => onFailure(error.message), (transaction) async {
      await clearCart.execute();
      onSuccess(
        "Checkout success",
      );
    });
    _state = RequestState.Loaded;
    notifyListeners();
  }
}
