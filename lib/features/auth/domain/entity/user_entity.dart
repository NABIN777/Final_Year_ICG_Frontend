class UserEntity {
  final String? id;
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  UserEntity({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });
}
