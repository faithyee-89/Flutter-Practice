import 'package:pigeon/pigeon.dart';
///配置信息
@ConfigurePigeon(PigeonOptions(
  dartOut: 'pigeon/output/request_channel.dart',
  objcHeaderOut: 'pigeon/output/FlutterRequestChannel.h',
  objcSourceOut: 'pigeon/output/FlutterRequestChannel.m',
  javaOut: 'pigeon/output/RequestChannel.java',
))
///定义的交互对象
class RequestParams {
  String? requestName;
  String? requestVersion;
}
///定义的交互对象
class Reply {
  String? replyName;
  String? replyVersion;
}

@HostApi()
abstract class RequestChannelAPI {
  Reply getFinalRequestParams(RequestParams param);
}

/// flutter pub run pigeon --input pigeon/request_channel.dart --dart_out pigeon/output
