class UserModel {
  List<Data>? data;

  UserModel({this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? head;
  String? name;
  String? desc;
  List<String>? pics;
  String? time;

  Data({this.head, this.name, this.desc, this.pics, this.time});

  Data.fromJson(Map<String, dynamic> json) {
    head = json['head'];
    name = json['name'];
    desc = json['desc'];
    pics = json['pics'].cast<String>();
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['head'] = this.head;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['pics'] = this.pics;
    data['time'] = this.time;
    return data;
  }
}
