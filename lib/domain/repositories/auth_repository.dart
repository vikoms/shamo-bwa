import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/entities/user.dart';

import '../../utils/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signUp(
    String name,
    String username,
    String email,
    String password,
  );

  Future<Either<Failure, UserEntity>> signIn(String email, String password);
}
