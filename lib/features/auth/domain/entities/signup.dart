class SignUpEntity {
  final String fullName;
  final String email;
  final String password;
   String? uId;

  SignUpEntity({
    required this.fullName,
    required this.email,
    required this.password,
     this.uId
  });

  bool isValidFullName() {
    return fullName.isNotEmpty && fullName.trim().contains(' ');
  }

  bool isValidPassword() {
    return password.length >= 6;
  }


}
