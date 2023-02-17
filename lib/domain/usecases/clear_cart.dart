import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/repositories/cart_repository.dart';
import 'package:shamo_clone/utils/failure.dart';

class ClearCart {
  final CartRepository repository;
  ClearCart(this.repository);
  Future<Either<Failure, String>> execute() async {
    return await repository.clearCart();
  }
}
