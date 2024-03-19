class CityModel {
  String? status;
  List<State1>? state;
  String? message;

  CityModel({this.status, this.state, this.message});

  CityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['state'] != null) {
      state = <State1>[];
      json['state'].forEach((v) {
        state!.add(new State1.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.state != null) {
      data['state'] = this.state!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class State1 {
  int? id;
  String? cityName;

  State1({this.id, this.cityName});

  State1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_name'] = this.cityName;
    return data;
  }
}