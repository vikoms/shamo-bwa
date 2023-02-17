import 'package:dartz/dartz.dart';
import 'package:shamo_clone/data/datasources/cart_local_data_source.dart';
import 'package:shamo_clone/utils/exception.dart';
import 'package:shamo_clone/utils/failure.dart';
import 'package:shamo_clone/domain/entities/cart.dart';
import 'package:shamo_clone/data/models/cart_model.dart';

import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource dataSource;
  CartRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Cart>>> getCart() async {
    try {
      final result = await dataSource.getCarts();
      return Right(result.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Cart?>> getCartById(int id) async {
    try {
      final result = await dataSource.getCart(id);
      return Right(result?.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> insertCart(CartModel cart) async {
    try {
      final result = await dataSource.insertCart(cart);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeCart(int id) async {
    try {
      final result = await dataSource.removeCart(id);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateCart(CartModel cart) async {
    try {
      final result = await dataSource.updateCart(cart);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> clearCart() async {
    try {
      final result = await dataSource.clearCart();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
