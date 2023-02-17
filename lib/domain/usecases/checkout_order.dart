import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/entities/order.dart';
import 'package:shamo_clone/domain/entities/transaction.dart';
import 'package:shamo_clone/domain/repositories/transaction_repository.dart';
import 'package:shamo_clone/helpers/checkout_order_mapper.dart';
import 'package:shamo_clone/utils/failure.dart';

class CheckoutOrder {
  final TransactionRepository repository;
  final CheckoutOrderMapper mapper;
  CheckoutOrder(
    this.repository,
    this.mapper,
  );

  Future<Either<Failure, Transaction>> execute(OrderEntity order) async {
    final orderMapped = mapper.fromEntity(order);
    return await repository.checkout(orderMapped);
  }
}
