import 'package:flutter/cupertino.dart';
import 'package:shamo_clone/domain/entities/wishlist.dart';
import 'package:shamo_clone/domain/usecases/get_wishlist.dart';
import 'package:shamo_clone/domain/usecases/remove_wishlist.dart';
import 'package:shamo_clone/utils/request_state.dart';

class WishlistProvider extends ChangeNotifier {
  final RemoveWishlist removeWishlist;
  final GetWishlist getWishlist;
  WishlistProvider({
    required this.removeWishlist,
    required this.getWishlist,
  });

  List<Wishlist> _wishlist = [];
  List<Wishlist> get wishlist => _wishlist;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> getWishlistProduct() async {
    _state = RequestState.Loading;
    notifyListeners();
    final result = await getWishlist.execute();
    result.fold((error) {
      _message = error.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (wishlist) {
      _wishlist = wishlist;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> removeWishlistProduct(
    int id, {
    required void Function(String) onSuccess,
    required void Function(String) onFailure,
  }) async {
    final result = await removeWishlist.execute(id);
    result.fold((error) => onFailure(error.message), (message) {
      final selected = _wishlist.firstWhere((item) => item.id == id);
      _wishlist.remove(selected);
      onSuccess(message);
      notifyListeners();
    });
  }
}
