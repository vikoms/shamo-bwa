import 'package:equatable/equatable.dart';
import 'package:shamo_clone/domain/entities/user.dart';

class UserModel extends Equatable {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.roles,
    this.emailVerifiedAt,
    this.currentTeamId,
    this.profilePhotoPath,
    this.createdAt,
    this.updatedAt,
    required this.profilePhotoUrl,
  });

  final int id;
  final String name;
  final String email;
  final String username;
  String? roles;
  String? emailVerifiedAt;
  String? currentTeamId;
  String? profilePhotoPath;
  DateTime? createdAt;
  DateTime? updatedAt;
  final String profilePhotoUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        roles: json["roles"],
        emailVerifiedAt: json["email_verified_at"],
        currentTeamId: json["current_team_id"],
        profilePhotoPath: json["profile_photo_path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profilePhotoUrl: json["profile_photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "roles": roles,
        "email_verified_at": emailVerifiedAt,
        "current_team_id": currentTeamId,
        "profile_photo_path": profilePhotoPath,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profile_photo_url": profilePhotoUrl,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        username,
        roles,
        emailVerifiedAt,
        currentTeamId,
        profilePhotoPath,
        createdAt,
        updatedAt,
        profilePhotoPath,
      ];

  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        email: email,
        username: username,
        profilePhotoUrl: profilePhotoUrl,
      );
}
