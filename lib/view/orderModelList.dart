// To parse this JSON data, do
//
//     final orderModelList = orderModelListFromJson(jsonString);

import 'dart:convert';

OrderModelList orderModelListFromJson(String str) =>
    OrderModelList.fromJson(json.decode(str));

String orderModelListToJson(OrderModelList data) => json.encode(data.toJson());

class OrderModelList {
  String? message;
  List<Datum>? data;

  OrderModelList({
    this.message,
    this.data,
  });

  factory OrderModelList.fromJson(Map<String, dynamic> json) => OrderModelList(
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
  int? productId;
  int? orderId;
  int? price;
  String? productName;
  String? variation;
    String? design;
  dynamic? discountOnProduct;
  String? discountType;
  int? quantity;
  int? taxAmount;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic? variant;
  String? unit;
  int? isStockDecreased;

  Datum({
    this.id,
    this.productId,
    this.orderId,
    this.price,
    this.productName,
    this.variation,
    this.design,
    this.discountOnProduct,
    this.discountType,
    this.quantity,
    this.taxAmount,
    this.createdAt,
    this.updatedAt,
    this.variant,
    this.unit,
    this.isStockDecreased,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["product_id"],
        orderId: json["order_id"],
        price: json["price"],
        productName: json["product_name"],
        variation: json["variation"],
          design: json["design"],
        discountOnProduct: json["discount_on_product"],
        discountType: json["discount_type"],
        quantity: json["quantity"],
        taxAmount: json["tax_amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        variant: json["variant"],
        unit: json["unit"],
        isStockDecreased: json["is_stock_decreased"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "order_id": orderId,
        "price": price,
        "product_name": productName,
        "variation": variation,
        "design":design,
        "discount_on_product": discountOnProduct,
        "discount_type": discountType,
        "quantity": quantity,
        "tax_amount": taxAmount,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "variant": variant,
        "unit": unit,
        "is_stock_decreased": isStockDecreased,
      };
}
