// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  List<Datum>? data;
  int? status;

  BannerModel({
    this.data,
    this.status,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
      };
}

class Datum {
  int? id;
  String? title;
  String? image;
  String? type;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic? categoryId;

  Datum({
    this.id,
    this.title,
    this.image,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "type": type,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "category_id": categoryId,
      };
}
