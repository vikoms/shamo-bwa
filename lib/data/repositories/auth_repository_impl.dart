import 'package:dartz/dartz.dart';
import 'package:shamo_clone/data/datasources/auth_remote_data_source.dart';
import 'package:shamo_clone/utils/failure.dart';
import 'package:shamo_clone/domain/entities/user.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../utils/exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authSource;
  AuthRepositoryImpl(this.authSource);

  @override
  Future<Either<Failure, UserEntity>> signUp(
      String name, String username, String email, String password) async {
    try {
      final result = await authSource.signUp(name, username, email, password);
      return Right(result.toEntity());
    } on ServerException {
      return Left(
        ServerFailure(""),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(
      String email, String password) async {
    try {
      final result = await authSource.signIn(email, password);
      return Right(result.toEntity());
    } on ServerException {
      return Left(
        ServerFailure(""),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
