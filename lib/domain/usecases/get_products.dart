import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/repositories/product_repository.dart';

import '../../utils/failure.dart';
import '../entities/product.dart';

class GetProducts {
  final ProductRepository repository;
  GetProducts(this.repository);
  Future<Either<Failure, List<Product>>> execute() {
    return repository.getProducts();
  }
}
