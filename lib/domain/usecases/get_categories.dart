import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/repositories/product_repository.dart';

import '../../utils/failure.dart';
import '../entities/category.dart';

class GetCategories {
  final ProductRepository repository;
  GetCategories(this.repository);

  Future<Either<Failure, List<Category>>> execute() async {
    return await repository.getCategories();
  }
}
