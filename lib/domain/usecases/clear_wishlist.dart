import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/repositories/wishlist_repository.dart';
import 'package:shamo_clone/utils/failure.dart';

class ClearWishlist {
  final WishlistRepository repository;
  ClearWishlist(this.repository);
  Future<Either<Failure, String>> execute() async {
    return await repository.clearWishlist();
  }
}
