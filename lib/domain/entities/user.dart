class UserEntity {
  int? id;
  final String name;
  final String email;
  final String username;
  String? profilePhotoUrl;
  String? token;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.profilePhotoUrl,
    this.token,
  });

  UserEntity.updateProfile({
    required this.name,
    required this.email,
    required this.username,
  });
}
