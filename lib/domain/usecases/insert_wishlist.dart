import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/entities/wishlist.dart';
import 'package:shamo_clone/domain/repositories/wishlist_repository.dart';
import 'package:shamo_clone/helpers/wishlist_model_mapper.dart';

import '../../utils/failure.dart';

class InsertWishlist {
  final WishlistRepository repository;
  final WishlistMapper mapper;

  InsertWishlist(
    this.repository,
    this.mapper,
  );

  Future<Either<Failure, String>> execute(Wishlist wishlist) async {
    final wishlistModel = mapper.fromEntity(wishlist);
    return await repository.insertWishlist(wishlistModel);
  }
}
