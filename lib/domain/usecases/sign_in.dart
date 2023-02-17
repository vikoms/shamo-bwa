import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/entities/user.dart';
import 'package:shamo_clone/domain/repositories/auth_repository.dart';
import 'package:shamo_clone/utils/failure.dart';

class SignIn {
  final AuthRepository repository;
  SignIn(this.repository);

  Future<Either<Failure, UserEntity>> execute(
      String email, String password) async {
    return await repository.signIn(email, password);
  }
}
