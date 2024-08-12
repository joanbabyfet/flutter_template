import 'dart:convert';

class User {
  int? code;
  String? msg;
  int? timestamp;
  UserProfile? data;

  User({
    this.code,
    this.msg,
    this.timestamp,
    this.data,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    code: json["code"],
    msg: json["msg"],
    timestamp: json["timestamp"],
    data: json["data"] == null ? null : UserProfile.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "timestamp": timestamp,
    "data": data?.toJson(),
  };
}

class UserProfile {
  String? id;
  String? username;
  String? realname;
  String? email;
  String? phoneCode;
  String? phone;
  String? avatar;
  String? language;
  String? token;

  UserProfile({
    this.id,
    this.username,
    this.realname,
    this.email,
    this.phoneCode,
    this.phone,
    this.avatar,
    this.language,
    this.token,
  });

  factory UserProfile.fromRawJson(String str) => UserProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"],
    username: json["username"],
    realname: json["realname"],
    email: json["email"],
    phoneCode: json["phone_code"],
    phone: json["phone"],
    avatar: json["avatar"],
    language: json["language"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "realname": realname,
    "email": email,
    "phone_code": phoneCode,
    "phone": phone,
    "avatar": avatar,
    "language": language,
    "token": token,
  };
}