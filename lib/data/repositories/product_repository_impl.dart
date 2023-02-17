import 'package:shamo_clone/data/datasources/product_remote_data_source.dart';
import 'package:shamo_clone/utils/exception.dart';
import 'package:shamo_clone/utils/failure.dart';

import 'package:shamo_clone/domain/entities/product.dart';

import 'package:dartz/dartz.dart';

import '../../domain/entities/category.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource dataSource;
  ProductRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final result = await dataSource.getProducts();
      return Right(result.products.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(e.message),
      );
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final result = await dataSource.getCategories();
      return Right(result.data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(e.message),
      );
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      int categoryId) async {
    try {
      final result = await dataSource.getProductsByCategories(categoryId);
      return Right(result.products.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(e.message),
      );
    }
  }

  @override
  Future<Either<Failure, Product>> getProdyctById(int id) async {
    try {
      final result = await dataSource.getProductById(id);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(e.message),
      );
    }
  }
}
