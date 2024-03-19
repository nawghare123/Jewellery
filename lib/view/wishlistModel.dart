// To parse this JSON data, do
//
//     final wishlistModel = wishlistModelFromJson(jsonString);

import 'dart:convert';

WishlistModel wishlistModelFromJson(String str) =>
    WishlistModel.fromJson(json.decode(str));

String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());

class WishlistModel {
  List<Wishlist>? wishlist;
  List<List<Product>>? product;

  WishlistModel({
    this.wishlist,
    this.product,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        wishlist: List<Wishlist>.from(
            json["wishlist"].map((x) => Wishlist.fromJson(x))),
        product: List<List<Product>>.from(json["product"]
            .map((x) => List<Product>.from(x.map((x) => Product.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "wishlist": List<dynamic>.from(wishlist!.map((x) => x.toJson())),
        "product": List<dynamic>.from(
            product!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Product {
  int? id;
  String? name;
  String? description;
  String? image;
  int? price;
  String? variations;
  String? tax;
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

  Product({
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
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        "category": category,
        "purity": purity,
      };
}

class Wishlist {
  int? id;
  int? userId;
  int? productId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Wishlist({
    this.id,
    this.userId,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
