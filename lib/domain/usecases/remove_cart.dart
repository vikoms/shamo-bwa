import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/repositories/cart_repository.dart';
import 'package:shamo_clone/utils/failure.dart';

class RemoveCart {
  final CartRepository repository;
  RemoveCart(this.repository);
  Future<Either<Failure, String>> execute(int id) async {
    return await repository.removeCart(id);
  }
}
