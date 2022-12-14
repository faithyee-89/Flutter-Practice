// Autogenerated from Pigeon (v0.3.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class RequestParams;
@class Reply;

@interface RequestParams : NSObject
@property(nonatomic, copy, nullable) NSString * requestName;
@property(nonatomic, copy, nullable) NSString * requestVersion;
@end

@interface Reply : NSObject
@property(nonatomic, copy, nullable) NSString * replyName;
@property(nonatomic, copy, nullable) NSString * replyVersion;
@end

@protocol RequestChannelAPI
-(nullable Reply *)getFinalRequestParams:(RequestParams*)input error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void RequestChannelAPISetup(id<FlutterBinaryMessenger> binaryMessenger, id<RequestChannelAPI> _Nullable api);

NS_ASSUME_NONNULL_END
