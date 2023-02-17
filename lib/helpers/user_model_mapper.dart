import '../data/models/user_model.dart';
import '../domain/entities/user.dart';

class UserModelMapper {
  UserModel fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id ?? 0,
      name: entity.name,
      email: entity.email,
      username: entity.username,
      profilePhotoUrl: entity.profilePhotoUrl ?? '',
    );
  }
}
