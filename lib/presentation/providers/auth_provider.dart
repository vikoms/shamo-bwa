import 'package:flutter/cupertino.dart';
import 'package:shamo_clone/domain/usecases/sign_in.dart';
import 'package:shamo_clone/domain/usecases/sign_up.dart';
import 'package:shamo_clone/domain/entities/user.dart';

import '../../helpers/auth_helper.dart';

class AuthProvider with ChangeNotifier {
  final SignUp signUp;
  final SignIn signIn;
  AuthProvider(
    this.signUp,
    this.signIn,
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late UserEntity _user;
  UserEntity get user => _user;

  late String _errorMessage = '';
  String get errorMessage => _errorMessage;

  set user(UserEntity user) {
    _user = user;
    notifyListeners();
  }

  Future<void> register({
    required String name,
    required String username,
    required String email,
    required String password,
    required void Function(String) onFailure,
    required void Function() onSuccess,
  }) async {
    try {
      _isLoading = true;
      var result = await signUp.execute(name, username, email, password);
      result.fold((error) {
        _errorMessage = error.message;
        onFailure(_errorMessage);
      }, (user) async {
        await AuthHelper.setAccessToken(user.token ?? "");
        onSuccess();
      });
    } catch (e) {
      _errorMessage = e.toString();
      onFailure(_errorMessage);
      _isLoading = false;
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required Function onSuccess,
    required void Function(String) onFailure,
  }) async {
    try {
      final result = await signIn.execute(email, password);

      bool status = false;
      result.fold((error) {
        onFailure(error.message);
      }, (user) async {
        await AuthHelper.setAccessToken(user.token ?? "");
        onSuccess();
      });
    } catch (e) {
      onFailure(e.toString());
    }
  }
}
