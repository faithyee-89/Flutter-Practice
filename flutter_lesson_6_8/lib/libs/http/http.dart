import 'dart:async';
import 'package:cainiaowo/config.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'base_interceptor.dart';
import 'base_response.dart';
import 'cache.dart';
import 'connectivity_request_retrier.dart';
import 'exceptions.dart';
import 'retry_interceptor.dart';

class Http {
  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  static Http _instance = Http._internal();

  factory Http() => _instance;

  Dio? dio;
  CancelToken _cancelToken = new CancelToken();

  Http._internal() {
    if (dio == null) {
      // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
      BaseOptions options = new BaseOptions(
        connectTimeout: CONNECT_TIMEOUT,
        // 响应流上前后两次接受到数据的间隔，单位为毫秒。
        receiveTimeout: RECEIVE_TIMEOUT,
      );

      dio = new Dio(options);

      // // 添加拦截器
      dio!.interceptors.add(BaseResponseInterceptor());

      // 加内存缓存
      // dio.interceptors.add(NetCacheInterceptor());

      dio!.interceptors.add(
        RetryOnConnectionChangeInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
            dio: dio!,
            connectivity: Connectivity(),
          ),
        ),
      );

      dio!.interceptors.add(LogInterceptor(
          requestBody: Env.envConfig.debug, responseBody: Env.envConfig.debug));

      // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
      // if (PROXY_ENABLE) {
      //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      //       (client) {
      //     client.findProxy = (uri) {
      //       return "PROXY $PROXY_IP:$PROXY_PORT";
      //     };
      //     //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
      //     client.badCertificateCallback =
      //         (X509Certificate cert, String host, int port) => true;
      //   };
      // }
    }
  }

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  void init(
      {required String baseUrl,
      int? connectTimeout,
      int? receiveTimeout,
      List<Interceptor>? interceptors}) {
    dio!.options = dio!.options.copyWith(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        contentType: 'application/json; charset=utf-8',
        headers: {});
    if (interceptors != null && interceptors.isNotEmpty) {
      dio!.interceptors.addAll(interceptors);
    }
  }

  /// 设置headers
  void setHeaders(Map<String, dynamic> map) {
    dio!.options.headers.addAll(map);
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel("cancelled");
  }

  /// 请求
  Future<T> request<T>(
    String path, {
    HttpMethods method = HttpMethods.get,
    Map<String, dynamic>? params,
    data,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    String? cacheKey,
    bool cacheDisk = false,
  }) {
    const _methodValues = {
      HttpMethods.get: 'get',
      HttpMethods.post: 'post',
      HttpMethods.put: 'put',
      HttpMethods.delete: 'delete',
      HttpMethods.patch: 'patch',
      HttpMethods.head: 'head'
    };

    options ??= Options(method: _methodValues[method]);
    options = options.copyWith(extra: {
      "refresh": refresh,
      "noCache": noCache,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });

    return dio!
        .request(path,
            data: data,
            queryParameters: params,
            cancelToken: cancelToken,
            options: options,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress)
        .then((response) {
      BaseResponse<T> baseResponse = response.data;
      T businessData = baseResponse.data;
      return Future.value(businessData);
    }).onError((error, stackTrace) {
      ApiException apiException = ApiException.create(error as DioError);
      EasyLoading.showError(apiException.message);
      return Future.error(error);
    });
  }

  /// restful get 操作
  Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    String? cacheKey,
    bool cacheDisk = false,
  }) {
    return request(path,
        method: HttpMethods.get,
        params: params,
        cancelToken: cancelToken,
        options: options,
        refresh: refresh,
        noCache: noCache,
        cacheKey: cacheKey,
        cacheDisk: cacheDisk);
  }

  /// restful post 操作
  Future<T> post<T>(
    String path, {
    Map<String, dynamic>? params,
    data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return request<T>(
      path,
      method: HttpMethods.post,
      data: data,
      params: params,
      cancelToken: cancelToken,
      options: options,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }

  /// restful put 操作
  Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return request(
      path,
      method: HttpMethods.put,
      params: params,
      cancelToken: cancelToken,
      options: options,
    );
  }

  /// restful patch 操作
  Future patch(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return request(
      path,
      method: HttpMethods.patch,
      params: params,
      cancelToken: cancelToken,
      options: options,
    );
  }

  /// restful delete 操作
  Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return request(
      path,
      method: HttpMethods.delete,
      params: params,
      cancelToken: cancelToken,
      options: options,
    );
  }

  /// restful post form 表单提交操作
  Future postForm(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return request(
      path,
      method: HttpMethods.post,
      data: FormData.fromMap(params!),
      cancelToken: cancelToken,
      options: options,
    );
  }
}

enum HttpMethods {
  get,
  post,
  put,
  delete,
  patch,
  head,
}
