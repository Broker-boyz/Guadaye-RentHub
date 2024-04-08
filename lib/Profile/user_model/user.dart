class User {
  final String username;
  final String email;
  final String imagePath;

  User({required this.username, required this.email, required this.imagePath});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      imagePath: map['imagePath'] ?? '',
    );
  }
}
