import 'package:dartz/dartz.dart';
import 'package:shamo_clone/data/models/wishlist_model.dart';
import 'package:shamo_clone/domain/entities/wishlist.dart';

import '../../utils/failure.dart';

abstract class WishlistRepository {
  Future<Either<Failure, String>> insertWishlist(WishListModel wishlist);
  Future<Either<Failure, String>> removeWishlist(int id);
  Future<Either<Failure, String>> clearWishlist();
  Future<Either<Failure, Wishlist?>> getWishlistById(int id);
  Future<Either<Failure, List<Wishlist>>> getWishlist();
}
