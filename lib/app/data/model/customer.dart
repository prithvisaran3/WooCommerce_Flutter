class CustomerRes {
  dynamic email;
  dynamic firstName;
  dynamic lastName;
  dynamic username;
  dynamic password;

  CustomerRes({
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.password,
  });

  factory CustomerRes.fromMap(Map<String, dynamic> json) => CustomerRes(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "password": password,
      };
}
