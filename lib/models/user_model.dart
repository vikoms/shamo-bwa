class UserModel {
  final int id;
  final String name;
  final String email;
  final String username;
  final String profilePhotoUrl;
  String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.profilePhotoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        username: json['username'],
        profilePhotoUrl: json['profile_photo_url'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'profile_photo_url': profilePhotoUrl,
      'token': token,
    };
  }
}
