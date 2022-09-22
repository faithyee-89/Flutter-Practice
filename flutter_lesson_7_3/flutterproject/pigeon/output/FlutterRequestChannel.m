// Autogenerated from Pigeon (v0.3.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "null"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString*, id>* wrapResult(NSDictionary *result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
        @"code": (error.code ? error.code : [NSNull null]),
        @"message": (error.message ? error.message : [NSNull null]),
        @"details": (error.details ? error.details : [NSNull null]),
        };
  }
  return @{
      @"result": (result ? result : [NSNull null]),
      @"error": errorDict,
      };
}

@interface RequestParams ()
+(RequestParams*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface Reply ()
+(Reply*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end

@implementation RequestParams
+(RequestParams*)fromMap:(NSDictionary*)dict {
  RequestParams* result = [[RequestParams alloc] init];
  result.requestName = dict[@"requestName"];
  if ((NSNull *)result.requestName == [NSNull null]) {
    result.requestName = nil;
  }
  result.requestVersion = dict[@"requestVersion"];
  if ((NSNull *)result.requestVersion == [NSNull null]) {
    result.requestVersion = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.requestName ? self.requestName : [NSNull null]), @"requestName", (self.requestVersion ? self.requestVersion : [NSNull null]), @"requestVersion", nil];
}
@end

@implementation Reply
+(Reply*)fromMap:(NSDictionary*)dict {
  Reply* result = [[Reply alloc] init];
  result.replyName = dict[@"replyName"];
  if ((NSNull *)result.replyName == [NSNull null]) {
    result.replyName = nil;
  }
  result.replyVersion = dict[@"replyVersion"];
  if ((NSNull *)result.replyVersion == [NSNull null]) {
    result.replyVersion = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.replyName ? self.replyName : [NSNull null]), @"replyName", (self.replyVersion ? self.replyVersion : [NSNull null]), @"replyVersion", nil];
}
@end

void RequestChannelAPISetup(id<FlutterBinaryMessenger> binaryMessenger, id<RequestChannelAPI> api) {
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.RequestChannelAPI.getFinalRequestParams"
        binaryMessenger:binaryMessenger];
    if (api) {
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        RequestParams *input = [RequestParams fromMap:message];
        FlutterError *error;
        Reply *output = [api getFinalRequestParams:input error:&error];
        callback(wrapResult([output toMap], error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
