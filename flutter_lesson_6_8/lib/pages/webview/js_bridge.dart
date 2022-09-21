class JsBridge {
  String method; // 方法名
  Map data; // 传递数据
  Function success; // 执行成功回调
  Function error; // 执行失败回调

  JsBridge(this.method, this.data, this.success, this.error);

  /// jsonEncode方法中会调用实体类的这个方法。如果实体类中没有这个方法，会报错。
  Map toJson() {
    Map map = new Map();
    map["method"] = this.method;
    map["data"] = this.data;
    map["success"] = this.success;
    map["error"] = this.error;
    return map;
  }

  static JsBridge fromMap(Map<String, dynamic> map) {
    JsBridge jsonModel =
        new JsBridge(map['method'], map['data'], map['success'], map['error']);
    return jsonModel;
  }

  @override
  String toString() {
    return "JsBridge: {method: $method, data: $data, success: $success, error: $error}";
  }
}
