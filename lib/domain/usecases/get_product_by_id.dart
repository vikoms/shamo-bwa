import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/repositories/product_repository.dart';
import 'package:shamo_clone/utils/failure.dart';

import '../entities/product.dart';

class GetProductById {
  final ProductRepository repository;
  GetProductById(this.repository);
  Future<Either<Failure, Product>> execute(int id) async {
    return await repository.getProdyctById(id);
  }
}
