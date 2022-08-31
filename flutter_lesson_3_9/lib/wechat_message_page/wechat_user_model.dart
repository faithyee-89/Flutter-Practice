///https://javiercbk.github.io/json_to_dart/

class WeChatUserModel {
  List<Data>? data;

  WeChatUserModel({this.data});

  WeChatUserModel.fromJson(Map<String, dynamic> json) {
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
  String? idstr;
  List<Users>? users;
  String? screenName;
  String? createdAt;
  String? text;
  Badge? badge;
  bool? messageFree;

  Data(
      {this.idstr,
      this.users,
      this.screenName,
      this.createdAt,
      this.text,
      this.badge,
      this.messageFree});

  Data.fromJson(Map<String, dynamic> json) {
    idstr = json['idstr'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    screenName = json['screen_name'];
    createdAt = json['created_at'];
    text = json['text'];
    badge = json['badge'] != null ? new Badge.fromJson(json['badge']) : null;
    messageFree = json['messageFree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idstr'] = this.idstr;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['screen_name'] = this.screenName;
    data['created_at'] = this.createdAt;
    data['text'] = this.text;
    if (this.badge != null) {
      data['badge'] = this.badge!.toJson();
    }
    data['messageFree'] = this.messageFree;
    return data;
  }
}

class Users {
  String? profileImageUrl;

  Users({this.profileImageUrl});

  Users.fromJson(Map<String, dynamic> json) {
    profileImageUrl = json['profile_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image_url'] = this.profileImageUrl;
    return data;
  }
}

class Badge {
  String? type;
  int? value;
  String? text;
  bool? show;
  bool? dot;

  Badge({this.type, this.value, this.text, this.show, this.dot});

  Badge.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    text = json['text'];
    show = json['show'];
    dot = json['dot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    data['text'] = this.text;
    data['show'] = this.show;
    data['dot'] = this.dot;
    return data;
  }
}
