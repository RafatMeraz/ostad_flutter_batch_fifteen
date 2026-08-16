class SignUpParams {
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String password;
  final String city;

  SignUpParams({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "phone": phone,
      "city": city,
    };
  }
}
