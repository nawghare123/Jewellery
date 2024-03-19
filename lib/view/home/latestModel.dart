// To parse this JSON data, do
//
//     final latestModel = latestModelFromJson(jsonString);

import 'dart:convert';

LatestModel latestModelFromJson(String str) =>
    LatestModel.fromJson(json.decode(str));

String latestModelToJson(LatestModel data) => json.encode(data.toJson());

class LatestModel {
  List<Datum>? data;
  int? status;

  LatestModel({
    this.data,
    this.status,
  });

  factory LatestModel.fromJson(Map<String, dynamic> json) => LatestModel(
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
  String? name;
  String? description;
  String? image;
  int? price;
  String? variations;
  int? tax;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? attributes;
  String? categoryIds;
  String? choiceOptions;
  dynamic? discount;
  dynamic? discountType;
  dynamic? taxType;
  String? unit;
  int? unitValue;
  int? totalStock;
  String? design;
  String? totalUnit;
  String? totalWeight;
  String? jewelryType;
  int? minOrderQty;
  String? productType;
  String? productAssign;
  String? brand;
  String? category;
  String? purity;
  List<dynamic>? translations;

  Datum({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.variations,
    this.tax,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.attributes,
    this.categoryIds,
    this.choiceOptions,
    this.discount,
    this.discountType,
    this.taxType,
    this.unit,
    this.unitValue,
    this.totalStock,
    this.design,
    this.totalUnit,
    this.totalWeight,
    this.jewelryType,
    this.minOrderQty,
    this.productType,
    this.productAssign,
    this.brand,
    this.category,
    this.purity,
    this.translations,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        variations: json["variations"],
        tax: json["tax"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        attributes: json["attributes"],
        categoryIds: json["category_ids"],
        choiceOptions: json["choice_options"],
        discount: json["discount"],
        discountType: json["discount_type"],
        taxType: json["tax_type"],
        unit: json["unit"],
        unitValue: json["unit_value"],
        totalStock: json["total_stock"],
        design: json["design"],
        totalUnit: json["total_unit"],
        totalWeight: json["total_weight"],
        jewelryType: json["jewelry_type"],
        minOrderQty: json["min_order_qty"],
        productType: json["product_type"],
        productAssign: json["product_assign"],
        brand: json["brand"],
        category: json["category"],
        purity: json["purity"],
        translations: List<dynamic>.from(json["translations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "variations": variations,
        "tax": tax,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "attributes": attributes,
        "category_ids": categoryIds,
        "choice_options": choiceOptions,
        "discount": discount,
        "discount_type": discountType,
        "tax_type": taxType,
        "unit": unit,
        "unit_value": unitValue,
        "total_stock": totalStock,
        "design": design,
        "total_unit": totalUnit,
        "total_weight": totalWeight,
        "jewelry_type": jewelryType,
        "min_order_qty": minOrderQty,
        "product_type": productType,
        "product_assign": productAssign,
        "brand": brand,
"category":category,
        "purity": purity,
        "translations": List<dynamic>.from(translations!.map((x) => x)),
      };
}
