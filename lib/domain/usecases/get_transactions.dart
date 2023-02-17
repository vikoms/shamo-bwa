import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/entities/transaction.dart';
import 'package:shamo_clone/domain/repositories/transaction_repository.dart';
import 'package:shamo_clone/utils/failure.dart';

class GetTransactions {
  final TransactionRepository repository;
  GetTransactions(this.repository);
  Future<Either<Failure, List<Transaction>>> execute(int page) async {
    return await repository.getTransactions(page);
  }
}
