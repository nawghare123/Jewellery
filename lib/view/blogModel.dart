// To parse this JSON data, do
//
//     final blogModel = blogModelFromJson(jsonString);

import 'dart:convert';

BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));

String blogModelToJson(BlogModel data) => json.encode(data.toJson());

class BlogModel {
  String? status;
  List<Datum>? data;
  String? message;

  BlogModel({
    this.status,
    this.data,
    this.message,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  int? id;
  String? title;
  String? description;
  String? image;
  String? banner;
  String? author;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.title,
    this.description,
    this.image,
    this.banner,
    this.author,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        banner: json["banner"],
        author: json["author"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "banner": banner,
        "author": author,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
