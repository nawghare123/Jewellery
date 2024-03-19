// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String? message;
  List<Datum>? data;

  OrderModel({
    this.message,
    this.data,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? userId;
  String? orderAmount;
  String? couponDiscountAmount;
  String? couponDiscountTitle;
  String? paymentStatus;
  String? orderStatus;
  String? totalTaxAmount;
  String? paymentMethod;
  String? transactionReference;
  String? deliveryAddressId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? checked;
  int? deliveryManId;
  String? deliveryCharge;
  String? orderNote;
  String? couponCode;
  String? orderType;
  int? branchId;
  String? invoice;
  String? callback;
  String? extraDiscount;
  String? deliveryAddress;

  Datum({
    this.id,
    this.userId,
    this.orderAmount,
    this.couponDiscountAmount,
    this.couponDiscountTitle,
    this.paymentStatus,
    this.orderStatus,
    this.totalTaxAmount,
    this.paymentMethod,
    this.transactionReference,
    this.deliveryAddressId,
    this.createdAt,
    this.updatedAt,
    this.checked,
    this.deliveryManId,
    this.deliveryCharge,
    this.orderNote,
    this.couponCode,
    this.orderType,
    this.branchId,
    this.invoice,
    this.callback,
    this.extraDiscount,
    this.deliveryAddress,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        orderAmount: json["order_amount"],
        couponDiscountAmount: json["coupon_discount_amount"],
        couponDiscountTitle: json["coupon_discount_title"],
        paymentStatus: json["payment_status"],
        orderStatus: json["order_status"],
        totalTaxAmount: json["total_tax_amount"],
        paymentMethod: json["payment_method"],
        transactionReference: json["transaction_reference"],
        deliveryAddressId: json["delivery_address_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        checked: json["checked"],
        deliveryManId: json["delivery_man_id"],
        deliveryCharge: json["delivery_charge"],
        orderNote: json["order_note"],
        couponCode: json["coupon_code"],
        orderType: json["order_type"],
        branchId: json["branch_id"],
        invoice: json["invoice"],
        callback: json["callback"],
        extraDiscount: json["extra_discount"],
        deliveryAddress: json["delivery_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_amount": orderAmount,
        "coupon_discount_amount": couponDiscountAmount,
        "coupon_discount_title": couponDiscountTitle,
        "payment_status": paymentStatus,
        "order_status": orderStatus,
        "total_tax_amount": totalTaxAmount,
        "payment_method": paymentMethod,
        "transaction_reference": transactionReference,
        "delivery_address_id": deliveryAddressId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "checked": checked,
        "delivery_man_id": deliveryManId,
        "delivery_charge": deliveryCharge,
        "order_note": orderNote,
        "coupon_code": couponCode,
        "order_type": orderType,
        "branch_id": branchId,
        "invoice": invoice,
        "callback": callback,
        "extra_discount": extraDiscount,
        "delivery_address": deliveryAddress,
      };
}
