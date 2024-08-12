import 'dart:convert';

class Article {
  int? code;
  String? msg;
  int? timestamp;
  ArticleList? data;

  Article({
    this.code,
    this.msg,
    this.timestamp,
    this.data,
  });

  factory Article.fromRawJson(String str) => Article.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    code: json["code"],
    msg: json["msg"],
    timestamp: json["timestamp"],
    data: json["data"] == null ? null : ArticleList.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "timestamp": timestamp,
    "data": data?.toJson(),
  };
}

class ArticleList {
  List<ArticleItem>? list;
  int? nextPage;
  int? total;

  ArticleList({
    this.list,
    this.nextPage,
    this.total,
  });

  factory ArticleList.fromRawJson(String str) => ArticleList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleList.fromJson(Map<String, dynamic> json) => ArticleList(
    list: json["list"] == null ? [] : List<ArticleItem>.from(json["list"]!.map((x) => ArticleItem.fromJson(x))),
    nextPage: json["next_page"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
    "next_page": nextPage,
    "total": total,
  };
}

class ArticleItem {
  int? id;
  int? catid;
  String? title;
  String? info;
  String? content;
  String? img;
  String? author;
  String? extra;
  int? sort;
  int? status;
  int? createTime;
  String? createUser;
  int? updateTime;
  String? updateUser;
  int? deleteTime;
  String? deleteUser;

  ArticleItem({
    this.id,
    this.catid,
    this.title,
    this.info,
    this.content,
    this.img,
    this.author,
    this.extra,
    this.sort,
    this.status,
    this.createTime,
    this.createUser,
    this.updateTime,
    this.updateUser,
    this.deleteTime,
    this.deleteUser,
  });

  factory ArticleItem.fromRawJson(String str) => ArticleItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleItem.fromJson(Map<String, dynamic> json) => ArticleItem(
    id: json["id"],
    catid: json["catid"],
    title: json["title"],
    info: json["info"],
    content: json["content"],
    img: json["img"],
    author: json["author"],
    extra: json["extra"],
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
    "info": info,
    "content": content,
    "img": img,
    "author": author,
    "extra": extra,
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