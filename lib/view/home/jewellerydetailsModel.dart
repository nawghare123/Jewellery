// import 'dart:convert';

// JewelleryDetailsModel jewelleryDetailsModelFromJson(String str) =>
//     JewelleryDetailsModel.fromJson(json.decode(str));

// String jewelleryDetailsModelToJson(JewelleryDetailsModel data) =>
//     json.encode(data.toJson());

// class JewelleryDetailsModel {
//   Data? data;
//   int? status;

//   JewelleryDetailsModel({
//     this.data,
//     this.status,
//   });

//   factory JewelleryDetailsModel.fromJson(Map<String, dynamic> json) =>
//       JewelleryDetailsModel(
//         data: Data.fromJson(json["data"]),
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data!.toJson(),
//         "status": status,
//       };
// }

// class Data {
//   int? id;
//   String? name;
//   String? description;
//   List<String>? image;
//   int? price;
//   List<Variation>? variations;
//   int? tax;
//   int? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   List<String>? attributes;
//   List<CategoryId>? categoryIds;
//   List<ChoiceOption>? choiceOptions;
//   dynamic? discount;
//   dynamic? discountType;
//   dynamic? taxType;
//   String? unit;
//   int? unitValue;
//   int? totalStock;
//   int? minOrderQty;
//   String? productType;
//   String? productAssign;
//   int? wishlistCount;
//   List<dynamic>? rating;
//   List<dynamic>? translations;

//   Data({
//     this.id,
//     this.name,
//     this.description,
//     this.image,
//     this.price,
//     this.variations,
//     this.tax,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.attributes,
//     this.categoryIds,
//     this.choiceOptions,
//     this.discount,
//     this.discountType,
//     this.taxType,
//     this.unit,
//     this.unitValue,
//     this.totalStock,
//     this.minOrderQty,
//     this.productType,
//     this.productAssign,
//     this.wishlistCount,
//     this.rating,
//     this.translations,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         image: List<String>.from(json["image"].map((x) => x)),
//         price: json["price"],
//         variations: List<Variation>.from(
//             json["variations"].map((x) => Variation.fromJson(x))),
//         tax: json["tax"],
//         status: json["status"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         attributes: List<String>.from(json["attributes"].map((x) => x)),
//         categoryIds: List<CategoryId>.from(
//             json["category_ids"].map((x) => CategoryId.fromJson(x))),
//         choiceOptions: List<ChoiceOption>.from(
//             json["choice_options"].map((x) => ChoiceOption.fromJson(x))),
//         discount: json["discount"],
//         discountType: json["discount_type"],
//         taxType: json["tax_type"],
//         unit: json["unit"],
//         unitValue: json["unit_value"],
//         totalStock: json["total_stock"],
//         minOrderQty: json["min_order_qty"],
//         productType: json["product_type"],
//         productAssign: json["product_assign"],
//         wishlistCount: json["wishlist_count"],
//         rating: List<dynamic>.from(json["rating"].map((x) => x)),
//         translations: List<dynamic>.from(json["translations"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "description": description,
//         "image": List<dynamic>.from(image!.map((x) => x)),
//         "price": price,
//         "variations": List<dynamic>.from(variations!.map((x) => x.toJson())),
//         "tax": tax,
//         "status": status,
//         "created_at": createdAt!.toIso8601String(),
//         "updated_at": updatedAt!.toIso8601String(),
//         "attributes": List<dynamic>.from(attributes!.map((x) => x)),
//         "category_ids": List<dynamic>.from(categoryIds!.map((x) => x.toJson())),
//         "choice_options":
//             List<dynamic>.from(choiceOptions!.map((x) => x.toJson())),
//         "discount": discount,
//         "discount_type": discountType,
//         "tax_type": taxType,
//         "unit": unit,
//         "unit_value": unitValue,
//         "total_stock": totalStock,
//         "min_order_qty": minOrderQty,
//         "product_type": productType,
//         "product_assign": productAssign,
//         "wishlist_count": wishlistCount,
//         "rating": List<dynamic>.from(rating!.map((x) => x)),
//         "translations": List<dynamic>.from(translations!.map((x) => x)),
//       };
// }

// class CategoryId {
//   String? id;
//   int? position;

//   CategoryId({
//     this.id,
//     this.position,
//   });

//   factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
//         id: json["id"],
//         position: json["position"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "position": position,
//       };
// }

// class ChoiceOption {
//   String? name;
//   String? title;
//   List<String>? options;

//   ChoiceOption({
//     this.name,
//     this.title,
//     this.options,
//   });

//   factory ChoiceOption.fromJson(Map<String, dynamic> json) => ChoiceOption(
//         name: json["name"],
//         title: json["title"],
//         options: List<String>.from(json["options"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "title": title,
//         "options": List<dynamic>.from(options!.map((x) => x)),
//       };
// }

// class Variation {
//   String? type;
//   int? price;
//   int? stock;

//   Variation({
//     this.type,
//     this.price,
//     this.stock,
//   });

//   factory Variation.fromJson(Map<String, dynamic> json) => Variation(
//         type: json["type"],
//         price: json["price"],
//         stock: json["stock"],
//       );

//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "price": price,
//         "stock": stock,
//       };
// }
// To parse this JSON data, do
//
//     final jewelleryDetailsModel = jewelleryDetailsModelFromJson(jsonString);

import 'dart:convert';

JewelleryDetailsModel jewelleryDetailsModelFromJson(String str) =>
    JewelleryDetailsModel.fromJson(json.decode(str));

String jewelleryDetailsModelToJson(JewelleryDetailsModel data) =>
    json.encode(data.toJson());

class JewelleryDetailsModel {
  Data? data;
  int? status;

  JewelleryDetailsModel({
    this.data,
    this.status,
  });

  factory JewelleryDetailsModel.fromJson(Map<String, dynamic> json) =>
      JewelleryDetailsModel(
        data: Data.fromJson(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "status": status,
      };
}

class Data {
  int? id;
  String? name;
  String? description;
  List<String>? image;
  int? price;
  List<Variation>? variations;
  int? tax;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? attributes;
  List<CategoryId>? categoryIds;
  List<ChoiceOption>? choiceOptions;
  String? discount;
  String? discountType;
  String? taxType;
  String? unit;
  String? brand;
  int? unitValue;
  int? totalStock;
  String? design;
  String? totalUnit;
  String? totalWeight;
  String? jewelryType;
  int? minOrderQty;
  String? productType;
  String? productAssign;
  int? wishlistCount;
  List<dynamic>? rating;
  List<dynamic>? translations;

  Data({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.variations,
    this.tax,
    this.brand,
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
    this.wishlistCount,
    this.rating,
    this.translations,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: List<String>.from(json["image"].map((x) => x)),
        price: json["price"],
        variations: List<Variation>.from(
            json["variations"].map((x) => Variation.fromJson(x))),
        tax: json["tax"],
         brand: json["brand"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        attributes: List<String>.from(json["attributes"].map((x) => x)),
        categoryIds: List<CategoryId>.from(
            json["category_ids"].map((x) => CategoryId.fromJson(x))),
        choiceOptions: List<ChoiceOption>.from(
            json["choice_options"].map((x) => ChoiceOption.fromJson(x))),
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
        wishlistCount: json["wishlist_count"],
        rating: List<dynamic>.from(json["rating"].map((x) => x)),
        translations: List<dynamic>.from(json["translations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": List<dynamic>.from(image!.map((x) => x)),
        "price": price,
        "variations": List<dynamic>.from(variations!.map((x) => x.toJson())),
        "tax": tax,
        'brand':brand,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "attributes": List<dynamic>.from(attributes!.map((x) => x)),
        "category_ids": List<dynamic>.from(categoryIds!.map((x) => x.toJson())),
        "choice_options":
            List<dynamic>.from(choiceOptions!.map((x) => x.toJson())),
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
        "wishlist_count": wishlistCount,
        "rating": List<dynamic>.from(rating!.map((x) => x)),
        "translations": List<dynamic>.from(translations!.map((x) => x)),
      };
}

class CategoryId {
  String? id;
  int? position;

  CategoryId({
    this.id,
    this.position,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["id"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
      };
}

class ChoiceOption {
  String? name;
  String? title;
  List<String>? options;

  ChoiceOption({
    this.name,
    this.title,
    this.options,
  });

  factory ChoiceOption.fromJson(Map<String, dynamic> json) => ChoiceOption(
        name: json["name"],
        title: json["title"],
        options: List<String>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "options": List<dynamic>.from(options!.map((x) => x)),
      };
}

class Variation {
  String? type;
  int? price;
  int? stock;

  Variation({
    this.type,
    this.price,
    this.stock,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        type: json["type"],
        price: json["price"],
        stock: json["stock"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "price": price,
        "stock": stock,
      };
}
