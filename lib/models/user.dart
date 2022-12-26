import 'dart:convert';

class User {
  String? id;
  String? role;
  String? password;
  String? firstname;
  String? lastname;
  String? nickname;
  String? email;
  String? birthday;
  String? mobile;
  String? cefrlevel;

  User({
    this.id,
    this.role,
    this.password,
    this.firstname,
    this.lastname,
    this.nickname,
    this.email,
    this.birthday,
    this.mobile,
    this.cefrlevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
      'nickname': nickname,
      'email': email,
      'birthday': birthday,
      'mobile': mobile,
      'cefrlevel': cefrlevel,
    };
  }

  Map<String, dynamic> toMap2() {
    return {
      'role': role,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
      'nickname': nickname,
      'email': email,
      'mobile': mobile,
    };
  }

  Map<String, dynamic> toMap3() {
    return {
      'id': id,
      'role': role,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
    };
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  String getFullName() => '$firstname $lastname';

  User copyWith({
    String? id,
    String? role,
    String? password,
    String? firstname,
    String? lastname,
    String? nickname,
    String? email,
    String? birthday,
    String? mobile,
    String? cefrlevel,
  }) {
    return User(
      id: id ?? this.id,
      role: role ?? this.role,
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      mobile: mobile ?? this.mobile,
      cefrlevel: cefrlevel ?? this.cefrlevel,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      role: map['role'],
      password: map['password'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      nickname: map['nickname'],
      email: map['email'],
      birthday: map['date_birth'],
      mobile: map['mobile'],
      cefrlevel: map['cefrlevel'],
    );
  }
}
