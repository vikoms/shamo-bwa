import 'package:flutter/cupertino.dart';
import 'package:shamo_clone/domain/entities/user.dart';
import 'package:shamo_clone/domain/usecases/clear_cart.dart';
import 'package:shamo_clone/domain/usecases/clear_wishlist.dart';
import 'package:shamo_clone/domain/usecases/get_profile.dart';
import 'package:shamo_clone/domain/usecases/update_profile.dart';
import 'package:shamo_clone/helpers/auth_helper.dart';
import 'package:shamo_clone/utils/request_state.dart';

class ProfileProvider extends ChangeNotifier {
  final GetProfile getProfile;
  final UpdateProfile updateProfile;
  final ClearCart clearCart;
  final ClearWishlist clearWishlist;
  ProfileProvider({
    required this.getProfile,
    required this.updateProfile,
    required this.clearCart,
    required this.clearWishlist,
  });

  late UserEntity _user;
  UserEntity get user => _user;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  RequestState _updateState = RequestState.Empty;
  RequestState get updateState => _updateState;

  String _message = '';
  String get message => _message;

  Future<void> getUserProfile() async {
    _updateState = RequestState.Empty;
    _message = '';
    _state = RequestState.Loading;
    notifyListeners();
    final result = await getProfile.execute();

    result.fold((error) {
      _message = error.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (user) {
      _user = user;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> updateUserProfile(
      String name, String email, String username, Function onSuccess) async {
    if (updateState == RequestState.Loading) return;
    final user =
        UserEntity.updateProfile(name: name, email: email, username: username);
    _updateState = RequestState.Loading;
    _message = '';
    notifyListeners();
    final result = await updateProfile.execute(user);
    result.fold((error) {
      _message = error.message;
      _updateState = RequestState.Error;
      notifyListeners();
    }, (user) {
      _user = user;
      _updateState = RequestState.Loaded;
      onSuccess();
      notifyListeners();
    });
  }

  void logout(BuildContext context, Function onSuccess,
      void Function(String) onFailure) async {
    try {
      await clearCart.execute();
      await clearWishlist.execute();
      AuthHelper.logOut(context);
      onSuccess();
    } catch (e) {
      onFailure(e.toString());
    }
  }
}
