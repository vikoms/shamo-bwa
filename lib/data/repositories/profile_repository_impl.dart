import 'package:shamo_clone/data/datasources/profile_remote_data_source.dart';
import 'package:shamo_clone/data/models/user_model.dart';
import 'package:shamo_clone/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/repositories/profile_repository.dart';
import 'package:shamo_clone/utils/exception.dart';
import 'package:shamo_clone/utils/failure.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remote;
  ProfileRepositoryImpl(this.remote);
  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      final result = await remote.getProfile();
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(e.message),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile(UserModel user) async {
    try {
      final result = await remote.updateProfile(user);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(
        ServerFailure(e.message),
      );
    }
  }
}
