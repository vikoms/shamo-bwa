import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/entities/cart.dart';
import 'package:shamo_clone/domain/repositories/cart_repository.dart';
import 'package:shamo_clone/helpers/cart_model_mapper.dart';
import 'package:shamo_clone/utils/failure.dart';

class UpdateCart {
  final CartRepository repository;
  final CartModelMapper mapper;
  UpdateCart(this.repository, this.mapper);
  Future<Either<Failure, String>> execute(Cart cart) async {
    return await repository.updateCart(mapper.fromEntity(cart));
  }
}
