import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/repositories/cart_repository.dart';
import 'package:shamo_clone/utils/failure.dart';

import '../entities/cart.dart';

class GetCartById {
  final CartRepository repository;
  GetCartById(this.repository);
  Future<Either<Failure, Cart?>> execute(int id) async {
    return await repository.getCartById(id);
  }
}
