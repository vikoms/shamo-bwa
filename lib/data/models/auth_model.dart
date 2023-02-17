import 'package:equatable/equatable.dart';
import 'package:shamo_clone/data/models/user_model.dart';
import 'package:shamo_clone/domain/entities/user.dart';

class AuthModel extends Equatable {
  AuthModel({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  final String accessToken;
  final String tokenType;
  final UserModel user;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "user": user.toJson(),
      };

  UserEntity toEntity() => UserEntity(
        id: user.id,
        name: user.name,
        email: user.email,
        username: user.username,
        profilePhotoUrl: user.profilePhotoUrl,
        token: accessToken,
      );

  @override
  List<Object?> get props => [
        accessToken,
        tokenType,
        user,
      ];
}
