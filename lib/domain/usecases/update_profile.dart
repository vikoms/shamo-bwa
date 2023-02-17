import 'package:dartz/dartz.dart';
import 'package:shamo_clone/domain/entities/user.dart';
import 'package:shamo_clone/domain/repositories/profile_repository.dart';
import 'package:shamo_clone/helpers/user_model_mapper.dart';

import '../../utils/failure.dart';

class UpdateProfile {
  final ProfileRepository repository;
  final UserModelMapper mapper;

  UpdateProfile(
    this.repository,
    this.mapper,
  );

  Future<Either<Failure, UserEntity>> execute(UserEntity user) async {
    return await repository.updateProfile(mapper.fromEntity(user));
  }
}
