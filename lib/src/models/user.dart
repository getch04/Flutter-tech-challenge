// lib/models/user.dart

class UserModel {
  final String id;
  final String username;

  UserModel({
    required this.id,
    required this.username,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      username: data['username'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
    };
  }
}
