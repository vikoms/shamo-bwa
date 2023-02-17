import 'package:dartz/dartz.dart';
import 'package:shamo_clone/data/models/wishlist_model.dart';
import 'package:shamo_clone/domain/entities/wishlist.dart';
import 'package:shamo_clone/domain/repositories/wishlist_repository.dart';
import 'package:shamo_clone/utils/failure.dart';

class GetWishlistById {
  final WishlistRepository repository;

  GetWishlistById(this.repository);

  Future<Either<Failure, Wishlist?>> execute(int id) async {
    return await repository.getWishlistById(id);
  }
}
