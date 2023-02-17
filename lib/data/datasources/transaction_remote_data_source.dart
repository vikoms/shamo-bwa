import 'package:dio/dio.dart';
import 'package:shamo_clone/data/models/order_model.dart';
import 'package:shamo_clone/data/models/transaction_model.dart';

import '../../helpers/dio_exception_helper.dart';
import '../../utils/exception.dart';
import '../models/base_response.dart';

abstract class TransactionRemoteDataSource {
  Future<TransactionModel> checkout(OrderModel checkout);
  Future<TransactionDataModel> getTransactions(int page);
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final Dio dio;
  TransactionRemoteDataSourceImpl(
    this.dio,
  );

  @override
  Future<TransactionModel> checkout(OrderModel order) async {
    try {
      Map<String, dynamic> payload = order.toJson();
      final response = await dio.post(
        '/checkout',
        data: payload,
      );
      if (response.statusCode == 200) {
        final result = BaseResponse.fromJson(response.data);

        if (result.meta.status == 'success' && result.data != null) {
          var mantap = result.data['items'][0];
          return TransactionModel.fromJson(result.data);
        } else {
          throw Exception(result.meta.message);
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
  Future<TransactionDataModel> getTransactions(int page) async {
    try {
      final response = await dio.get('/transactions', queryParameters: {
        'limit': 10,
        'page': page,
      });
      if (response.statusCode == 200) {
        final baseResponse = BaseResponse.fromJson(response.data);

        if (baseResponse.meta.status == 'success') {
          return TransactionDataModel.fromJson(baseResponse.data);
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
