import 'package:dartz/dartz.dart';
import 'package:shamo_clone/data/datasources/wishlist_local_data_source.dart';
import 'package:shamo_clone/domain/entities/wishlist.dart';
import 'package:shamo_clone/data/models/wishlist_model.dart';
import 'package:shamo_clone/domain/repositories/wishlist_repository.dart';
import 'package:shamo_clone/utils/exception.dart';
import 'package:shamo_clone/utils/failure.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistLocalDataSource dataSource;
  WishlistRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Wishlist>>> getWishlist() async {
    try {
      final result = await dataSource.getWishlist();
      return Right(result.map((e) => e.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(
        DatabaseFailure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Wishlist?>> getWishlistById(int id) async {
    try {
      final result = await dataSource.getWishlistById(id);
      return Right(result?.toEntity());
    } on DatabaseException catch (e) {
      return Left(
        DatabaseFailure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> insertWishlist(WishListModel wishlist) async {
    try {
      final result = await dataSource.insertWishtlist(wishlist);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(
        DatabaseFailure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> removeWishlist(int id) async {
    try {
      final result = await dataSource.removeWishlist(id);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(
        DatabaseFailure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> clearWishlist() async {
    try {
      final result = await dataSource.clearWishlist();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(
        DatabaseFailure(
          e.message,
        ),
      );
    }
  }
}
