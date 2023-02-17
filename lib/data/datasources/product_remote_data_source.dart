import 'package:dio/dio.dart';
import 'package:shamo_clone/data/models/product_model.dart';
import 'package:shamo_clone/utils/exception.dart';

import '../../helpers/dio_exception_helper.dart';
import '../models/base_response.dart';
import '../models/category_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductDataModel> getProducts();
  Future<CategoryDataModel> getCategories();

  Future<ProductDataModel> getProductsByCategories(int categoryId);
  Future<ProductModel> getProductById(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;
  ProductRemoteDataSourceImpl({required this.dio});
  @override
  Future<ProductDataModel> getProducts() async {
    try {
      final response = await dio.get('/products');
      if (response.statusCode == 200) {
        final baseResponse = BaseResponse.fromJson(response.data);

        if (baseResponse.meta.status == 'success') {
          return ProductDataModel.fromJson(baseResponse.data);
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
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await dio.get('/products', queryParameters: {
        'id': id,
      });
      if (response.statusCode == 200) {
        final result = BaseResponse.fromJson(response.data);

        if (result.meta.status == 'success') {
          return ProductModel.fromJson(result.data);
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
  Future<CategoryDataModel> getCategories() async {
    try {
      final response = await dio.get('/categories');
      if (response.statusCode == 200) {
        final baseResponse = BaseResponse.fromJson(response.data);

        if (baseResponse.meta.status == 'success') {
          return CategoryDataModel.fromJson(baseResponse.data);
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
  Future<ProductDataModel> getProductsByCategories(int categoryId) async {
    try {
      final response = await dio.get('/products', queryParameters: {
        'categories': categoryId,
      });
      if (response.statusCode == 200) {
        final baseResponse = BaseResponse.fromJson(response.data);

        if (baseResponse.meta.status == 'success') {
          return ProductDataModel.fromJson(baseResponse.data);
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
