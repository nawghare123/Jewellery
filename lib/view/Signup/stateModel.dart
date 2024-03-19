class StateListModel {
  String? status;
  List<State1>? state;
  String? message;

  StateListModel({this.status, this.state, this.message});

  StateListModel.fromJson(Map<String, dynamic> json) {
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
  String? stateName;

  State1({this.id, this.stateName});

  State1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_name'] = this.stateName;
    return data;
  }
}