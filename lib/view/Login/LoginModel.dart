// class LoginModel {
//   String? status;
//   String? message;

//   LoginModel({this.status, this.message});

//   LoginModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     return data;
//   }
// }

// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? status;
  Data? data;
  String? message;

  LoginModel({
    this.status,
    this.data,
    this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
        "message": message,
      };
}

class Data {
  int? id;
  String? fName;
  String? lName;
  String? email;
  dynamic? image;
  int? isPhoneVerified;
  dynamic? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic? emailVerificationToken;
  String? phone;
  String? address;
  String? role;
  dynamic? cmFirebaseToken;
  String? temporaryToken;
  String? status;

  Data({
    this.id,
    this.fName,
    this.lName,
    this.email,
    this.image,
    this.isPhoneVerified,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.emailVerificationToken,
    this.phone,
    this.address,
    this.role,
    this.status,
    this.cmFirebaseToken,
    this.temporaryToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        fName: json["f_name"],
        lName: json["l_name"],
        email: json["email"],
        image: json["image"],
        isPhoneVerified: json["is_phone_verified"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        emailVerificationToken: json["email_verification_token"],
        phone: json["phone"],
        address: json["address"],
        role: json["role"],
        status: json["status"],
        cmFirebaseToken: json["cm_firebase_token"],
        temporaryToken: json["temporary_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "l_name": lName,
        "email": email,
        "image": image,
        "is_phone_verified": isPhoneVerified,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "email_verification_token": emailVerificationToken,
        "phone": phone,
        "address":address,
        "role": role,
        "status": status,
        "cm_firebase_token": cmFirebaseToken,
        "temporary_token": temporaryToken,
      };
}
