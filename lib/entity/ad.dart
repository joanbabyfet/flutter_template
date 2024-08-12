import 'dart:convert';

class Ad {
  int? code;
  String? msg;
  int? timestamp;
  AdList? data;

  Ad({
    this.code,
    this.msg,
    this.timestamp,
    this.data,
  });

  factory Ad.fromRawJson(String str) => Ad.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    code: json["code"],
    msg: json["msg"],
    timestamp: json["timestamp"],
    data: json["data"] == null ? null : AdList.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "timestamp": timestamp,
    "data": data?.toJson(),
  };
}

class AdList {
  List<AdItem>? list;

  AdList({
    this.list,
  });

  factory AdList.fromRawJson(String str) => AdList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdList.fromJson(Map<String, dynamic> json) => AdList(
    list: json["list"] == null ? [] : List<AdItem>.from(json["list"]!.map((x) => AdItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class AdItem {
  int? id;
  int? catid;
  String? title;
  String? img;
  String? url;
  int? sort;
  int? status;
  int? createTime;
  String? createUser;
  int? updateTime;
  String? updateUser;
  int? deleteTime;
  String? deleteUser;

  AdItem({
    this.id,
    this.catid,
    this.title,
    this.img,
    this.url,
    this.sort,
    this.status,
    this.createTime,
    this.createUser,
    this.updateTime,
    this.updateUser,
    this.deleteTime,
    this.deleteUser,
  });

  factory AdItem.fromRawJson(String str) => AdItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdItem.fromJson(Map<String, dynamic> json) => AdItem(
    id: json["id"],
    catid: json["catid"],
    title: json["title"],
    img: json["img"],
    url: json["url"],
    sort: json["sort"],
    status: json["status"],
    createTime: json["create_time"],
    createUser: json["create_user"],
    updateTime: json["update_time"],
    updateUser: json["update_user"],
    deleteTime: json["delete_time"],
    deleteUser: json["delete_user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "catid": catid,
    "title": title,
    "img": img,
    "url": url,
    "sort": sort,
    "status": status,
    "create_time": createTime,
    "create_user": createUser,
    "update_time": updateTime,
    "update_user": updateUser,
    "delete_time": deleteTime,
    "delete_user": deleteUser,
  };
}