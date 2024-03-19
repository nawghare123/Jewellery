// To parse this JSON data, do
//
//     final updateProfileModel = updateProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) =>
    UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) =>
    json.encode(data.toJson());

class UpdateProfileModel {
  String? message;
  Data? data;

  UpdateProfileModel({
    this.message,
    this.data,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? state;
  String? city;
  String? address;
  String? pincode;
  String? image;
  DateTime? updatedAt;

  Data({
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.state,
    this.city,
    this.address,
    this.pincode,
    this.image,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fName: json["f_name"],
        lName: json["l_name"],
        phone: json["phone"],
        email: json["email"],
        state: json["state"],
        city: json["city"],
        address: json["address"],
        pincode: json["pincode"],
        image: json["image"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "f_name": fName,
        "l_name": lName,
        "phone": phone,
        "email": email,
        "state": state,
        "city": city,
        "address":address,
        "pincode": pincode,
        "image": image,
        "updated_at": updatedAt!.toIso8601String(),
      };
}
