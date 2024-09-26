class SignUpEntity {
  final String fullName;
  final String email;
  final String password;

  SignUpEntity({
    required this.fullName,
    required this.email,
    required this.password,
  });

  bool isValidFullName() {
    return fullName.isNotEmpty && fullName.trim().contains(' ');
  }

  bool isValidPassword() {
    return password.length >= 6;
  }


}
