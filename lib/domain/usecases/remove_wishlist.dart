import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/repositories/wishlist_repository.dart';
import 'package:shamo_clone/utils/failure.dart';

class RemoveWishlist {
  final WishlistRepository repository;
  RemoveWishlist(this.repository);
  Future<Either<Failure, String>> execute(int id) async {
    return await repository.removeWishlist(id);
  }
}
