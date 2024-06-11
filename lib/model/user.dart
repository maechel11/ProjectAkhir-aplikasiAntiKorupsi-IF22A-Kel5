class User {
  String? idUser;
  String? userName;
  String? email;
  String? pass;

  User({
    this.idUser,
    this.userName,
    this.email,
    this.pass,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json['id_user'],
        userName: json['username'],
        email: json['email'],
        pass: json['pass'],
      );

  Map<String, dynamic> toJson() => {
        'id_user': idUser,
        'username': userName,
        'email': email,
        'pass': pass,
      };
}
