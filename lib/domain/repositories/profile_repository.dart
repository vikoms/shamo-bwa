import 'package:dartz/dartz.dart';
import 'package:shamo_clone/data/models/user_model.dart';
import 'package:shamo_clone/domain/entities/user.dart';

import '../../utils/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity>> getProfile();
  Future<Either<Failure, UserEntity>> updateProfile(UserModel user);
}
