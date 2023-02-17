import 'package:dio/dio.dart';
import 'package:shamo_clone/data/models/auth_model.dart';

import '../../helpers/dio_exception_helper.dart';
import '../../utils/exception.dart';
import '../models/base_response.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> signUp(
      String name, String username, String email, String password);
  Future<AuthModel> signIn(String email, String password);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl(this.dio);
  @override
  Future<AuthModel> signUp(
      String name, String username, String email, String password) async {
    var body = {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    };

    try {
      final response = await dio.post('/register', data: body);

      if (response.statusCode == 200) {
        final baseResponse = BaseResponse.fromJson(response.data);
        return AuthModel.fromJson(baseResponse.data);
      } else {
        throw ServerException(response.statusMessage.toString());
      }
    } on DioError catch (error) {
      throw ServerException(DioErrorHelper.getErrorMessage(error));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AuthModel> signIn(String email, String password) async {
    var body = {
      'email': email,
      'password': password,
    };
    try {
      final response = await dio.post('/login', data: body);
      if (response.statusCode == 200) {
        final baseResponse = BaseResponse.fromJson(response.data);
        return AuthModel.fromJson(baseResponse.data);
      } else {
        throw ServerException(response.statusMessage.toString());
      }
    } on DioError catch (error) {
      throw ServerException(DioErrorHelper.getErrorMessage(error));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
