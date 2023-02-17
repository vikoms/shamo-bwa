import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/entities/user.dart';
import 'package:shamo_clone/domain/repositories/profile_repository.dart';
import 'package:shamo_clone/utils/failure.dart';

class GetProfile {
  final ProfileRepository repository;
  GetProfile(this.repository);
  Future<Either<Failure, UserEntity>> execute() async {
    return await repository.getProfile();
  }
}
