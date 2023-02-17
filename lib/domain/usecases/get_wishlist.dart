import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/entities/wishlist.dart';
import 'package:shamo_clone/domain/repositories/wishlist_repository.dart';

import '../../utils/failure.dart';

class GetWishlist {
  final WishlistRepository repository;
  GetWishlist(this.repository);
  Future<Either<Failure, List<Wishlist>>> execute() async {
    return await repository.getWishlist();
  }
}
