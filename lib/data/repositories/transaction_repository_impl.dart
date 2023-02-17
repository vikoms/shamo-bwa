import 'package:dartz/dartz.dart';
import 'package:shamo_clone/data/datasources/transaction_remote_data_source.dart';
import 'package:shamo_clone/data/models/order_model.dart';
import 'package:shamo_clone/domain/entities/transaction.dart';
import 'package:shamo_clone/domain/repositories/transaction_repository.dart';
import 'package:shamo_clone/utils/exception.dart';
import 'package:shamo_clone/utils/failure.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource dataSource;
  TransactionRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, Transaction>> checkout(OrderModel order) async {
    try {
      final result = await dataSource.checkout(order);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions(int page) async {
    try {
      final result = await dataSource.getTransactions(page);
      return Right(result.transactions.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          e.message,
        ),
      );
    }
  }
}
