// To parse this JSON data, do
//
//     final addToCardModel = addToCardModelFromJson(jsonString);

import 'dart:convert';

AddToCardModel addToCardModelFromJson(String str) =>
    AddToCardModel.fromJson(json.decode(str));

String addToCardModelToJson(AddToCardModel data) => json.encode(data.toJson());

class AddToCardModel {
  String? status;
  List<Datum>? data;
  String? message;

  AddToCardModel({
    this.status,
    this.data,
    this.message,
  });

  factory AddToCardModel.fromJson(Map<String, dynamic> json) => AddToCardModel(
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
  String? categoery;
  String? thumnail;
  String? type;
  String? title;
  String? file;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.categoery,
    this.thumnail,
    this.type,
    this.title,
    this.file,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        categoery: json["categoery"],
        thumnail: json["thumnail"],
        type: json["type"],
        title: json["title"],
        file: json["file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoery": categoery,
        "thumnail": thumnail,
        "type": type,
        "title": title,
        "file": file,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
