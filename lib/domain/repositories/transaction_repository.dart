import 'package:dartz/dartz.dart';
import 'package:shamo_clone/data/models/order_model.dart';

import '../../utils/failure.dart';
import '../entities/transaction.dart';

abstract class TransactionRepository {
  Future<Either<Failure, Transaction>> checkout(OrderModel order);
  Future<Either<Failure, List<Transaction>>> getTransactions(int page);
}
