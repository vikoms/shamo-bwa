import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/repositories/auth_repository.dart';
import 'package:shamo_clone/domain/entities/user.dart';

import '../../utils/failure.dart';

class SignUp {
  final AuthRepository authRepository;
  SignUp(this.authRepository);
  Future<Either<Failure, UserEntity>> execute(
    String name,
    String username,
    String email,
    String password,
  ) async {
    return await authRepository.signUp(name, username, email, password);
  }
}
