import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/entities/product.dart';
import 'package:shamo_clone/domain/repositories/product_repository.dart';
import 'package:shamo_clone/utils/failure.dart';

class GetProductsByCategories {
  final ProductRepository repository;
  GetProductsByCategories(this.repository);

  Future<Either<Failure, List<Product>>> execute(int categoryId) async {
    return await repository.getProductsByCategory(categoryId);
  }
}
