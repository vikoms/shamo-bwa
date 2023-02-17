import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shamo_clone/data/models/user_model.dart';

import '../../helpers/dio_exception_helper.dart';
import '../../utils/exception.dart';
import '../models/base_response.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getProfile();
  Future<UserModel> updateProfile(UserModel user);
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final Dio dio;
  ProfileRemoteDataSourceImpl(this.dio);
  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await dio.get('/user');
      if (response.statusCode == 200) {
        final baseResponse = BaseResponse.fromJson(response.data);

        if (baseResponse.meta.status == 'success') {
          return UserModel.fromJson(baseResponse.data);
        } else {
          throw Exception(baseResponse.meta.message);
        }
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
  Future<UserModel> updateProfile(UserModel user) async {
    try {
      var body = {
        'name': user.name,
        'email': user.email,
        'username': user.username,
      };
      final response = await dio.post(
        '/user',
        data: body,
      );
      if (response.statusCode == 200) {
        final baseResponse = BaseResponse.fromJson(response.data);

        if (baseResponse.meta.status == 'success') {
          return UserModel.fromJson(baseResponse.data);
        } else {
          throw Exception(baseResponse.meta.message);
        }
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
