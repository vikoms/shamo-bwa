import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/category.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<Product>>> getProductsByCategory(int categoryId);

  Future<Either<Failure, Product>> getProdyctById(int id);
}
