// To parse this JSON data, do
//
//     final getCardModel = getCardModelFromJson(jsonString);

import 'dart:convert';

GetCardModel getCardModelFromJson(String str) =>
    GetCardModel.fromJson(json.decode(str));

String getCardModelToJson(GetCardModel data) => json.encode(data.toJson());

class GetCardModel {
  String? status;
  List<Datum>? data;
  String? message;

  GetCardModel({
    this.status,
    this.data,
    this.message,
  });

  factory GetCardModel.fromJson(Map<String, dynamic> json) => GetCardModel(
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
  String? userId;
  String? productId;
  String? productName;
  String? variant;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.userId,
    this.productId,
    this.productName,
    this.variant,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        variant: json["variant"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "product_name": productName,
        "variant": variant,
        "image": image,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
