import 'package:dartz/dartz.dart';
import 'package:shamo_clone/data/datasources/cart_local_data_source.dart';
import 'package:shamo_clone/domain/entities/cart.dart';
import 'package:shamo_clone/domain/repositories/cart_repository.dart';
import 'package:shamo_clone/utils/failure.dart';

class GetCart {
  final CartRepository repository;
  GetCart(this.repository);
  Future<Either<Failure, List<Cart>>> execute() async {
    return await repository.getCart();
  }
}
