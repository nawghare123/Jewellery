class BrandModel {
  List<Data>? data;
  int? status;

  BrandModel({this.data, this.status});

  BrandModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  int? parentId;
  int? position;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? bannerImage;
  // List<Translations>? translations;

  Data(
      {this.id,
      this.name,
      this.parentId,
      this.position,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.bannerImage,
      // this.translations
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    position = json['position'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    bannerImage = json['banner_image'];
    // if (json['translations'] != null) {
    //   translations = <Translations>[];
    //   json['translations'].forEach((v) {
    //     translations!.add(new Translations.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['position'] = this.position;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['banner_image'] = this.bannerImage;
    // if (this.translations != null) {
    //   data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

// class Translations {
//   int? id;
//   String? name;

//   Translations({this.id, this.name});

//   Translations.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
  // }
//}