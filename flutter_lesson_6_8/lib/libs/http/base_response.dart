// import 'package:json_annotation/json_annotation.dart';

// part 'base_response.g.dart';

// @JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  final int code;
  final String message;
  final T data;

  BaseResponse({
    required this.message,
    required this.data,
    required this.code,
  });

  // factory BaseResponse.fromJson(Map<String, dynamic> json) =>
  //     _$BaseResponseFromJson(json);
  // Map<String, dynamic> toJson() => _$BaseResponseToJson(this);

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"message\":\"$message\"");
    sb.write(",\"errorMsg\":\"$code\"");
    sb.write(",\"data\":\"$data\"");
    sb.write('}');
    return sb.toString();
  }
}

class ResponseCode {
  /// 成功
  static const int SUCCESS = 0;

  /// 错误
  static const int ERROR = 1;

  /// 更多
}
