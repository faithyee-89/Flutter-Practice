> # 课程目标
> 
> - 课程详情页需求分析
> - 课程详情页网络模块封装
> - 课程详情页实现
> - 课程播放页需求分析
> - 课程播放页网络模块封装
> - 课程播放页实现
> - 补充项目存储方式及Webview的使用

# 课程代码

# 正文

### 一、课程详情页需求分析

![课程详情页动图](https://note.youdao.com/yws/public/resource/93d337fcdeaa9ecdbf71fd780a47f5c0/DC87FF37057E483D9F2C900D9454D44C?ynotemdtimestamp=1663738691596)

### 二、网络模块及路由模块封装

封装课程详情和课程播放页的路由跳转

routes.dart

```dart
class Routes {
  static String home = "/";
  static String login = "/login";
  static String courseDetail = "/courseDetail";
  static String lessonPlay = "/lessonPlay";
  static String webViewPage = "/webViewPage";

  static void configRoutes(FluroRouter router) {
    router.define(home, handler: homeHandler);
    router.define(login, handler: loginHandler);
    router.define(courseDetail, handler: courseDetailHandler);
    router.define(lessonPlay, handler: lessonPlayHandler);
    router.define(webViewPage, handler: webViewPageHandler);
    router.notFoundHandler = emptyHandler;
  }
}
```

route_handlers.dart

```dart
Handler courseDetailHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return CourseDetailPage(
    courseId: int.parse(parameters['courseId']![0]),
  );
});

Handler lessonPlayHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return LessonPlayPage(
    courseId: int.parse(parameters['courseId']![0]),
    lessonKey: parameters['lessonKey']?[0],
  );
});

Handler webViewPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return WebViewPage(
    url: parameters["url"]![0],
    title: parameters["title"]?.first,
    isLocalUrl: false,
  );
});
```

课程详情页网络模块

course_api_path.dart

```dart
// 课程详情
const String net_coursedetail_path_detail = '/course/detail';

// 课程章节列表
const String net_coursedetail_path_lessions = '/course/lessons';

// 课程评价列表
const String net_coursedetail_path_comments = '/comment/list';

// 获取课程分类
const String net_course_path_category = '/course/category';

// 获取课程列表
const String net_course_path_courselist = '/course/v2/list';

// 课程的最后一次学习记录
const String net_course_last_playinfo = '/course/last/playinfo';

```

course_api.dart

```
  /// 课程详情
  static Future<Course> courseDetail({
    required int courseId,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['course_id'] = courseId;

    return HttpManager.get(net_coursedetail_path_detail,
            params: queryParameters)
        .then((json) => Course.fromJson(json));
  }
  
  static Future<CourseAuthority> getCourseAuthority({
    required int courseId,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['course_id'] = courseId;

    return HttpManager.get("/course/authority", params: queryParameters)
        .then((json) => CourseAuthority.fromJson(json));
  }

  // 课程章节目录
  static Future<List<Chapter>> courseLessons({
    required int courseId,
  }) {
    Map<String, dynamic> queryParameters = {};
    queryParameters['course_id'] = courseId;

    return HttpManager.get(
      net_coursedetail_path_lessions,
      params: queryParameters,
    ).then((response) {
      return List<Map>.from(response)
          .map((dynamic e) => Chapter.fromJson(e))
          .toList();
    });
  }
  
  
  ...
```


### 三、课程详情页实现

![课程详情-课程介绍栏](https://note.youdao.com/yws/public/resource/93d337fcdeaa9ecdbf71fd780a47f5c0/17A6AD977C93493498EEC1C244D7C5EA?ynotemdtimestamp=1663738691596)

![课程详情-课程介绍栏2](https://note.youdao.com/yws/public/resource/93d337fcdeaa9ecdbf71fd780a47f5c0/5B812DB79FDC4CCA9F7133C2B6B74DF6?ynotemdtimestamp=1663738691596)

![课程详情-目录栏](https://note.youdao.com/yws/public/resource/93d337fcdeaa9ecdbf71fd780a47f5c0/9EBE56BAD95344A58EEA73BE0D230B46?ynotemdtimestamp=1663738691596)

![课程详情-评价栏2](https://note.youdao.com/yws/public/resource/93d337fcdeaa9ecdbf71fd780a47f5c0/1E362DEE0C6B4BF8B2F7EB896AFFE471?ynotemdtimestamp=1663738691596)

页面顶部上滑渐变效果

lib\pages\course_detail\view\index.dart

```
builder: (context, state) {
            return Skeleton(
              row: 20,
              loading: state.courseDetail == null,
              child: NestedScrollView(
                  controller: _scrollViewController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return _silverBuilder(context, innerBoxIsScrolled);
                  },
                  body: _buildTabBarView(state)),
            );
},
          
List<Widget> _silverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      _sliverAppBar(innerBoxIsScrolled),
      _sliverTabBar(),
    ];
  }
  
Widget _sliverAppBar(bool innerBoxIsScrolled) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
    ...
      forceElevated: innerBoxIsScrolled,
      
      flexibleSpace: FlexibleSpaceBar(
          background: Container(
              color: AppColors.backgroundColor,
              margin: EdgeInsets.only(top: 150.h),
              height: double.infinity,
              child: BlocBuilder<CourseBloc, CourseState>(
                  builder: (context, state) {
                return _courseSumary(state);
              }))),
    );
  }
```


页面html内容展示


```yaml
dependencies:
  flutter:
    sdk: flutter

  flutter_html: ^2.2.1
```



```dart
 Widget _courseDesc() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 20.h),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '课程介绍',
              style: titleStyle,
            ),
            BlocBuilder<CourseBloc, CourseState>(
              builder: (context, state) {
                // print(state.courseDetail?.desc);
                // return Container();
                return Html(
                  data: """${state.courseDetail?.desc}""",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
```


### 四、课程播放页需求分析

![视频播放页](https://note.youdao.com/yws/public/resource/93d337fcdeaa9ecdbf71fd780a47f5c0/9CB341DAC7DD434981A8913969679A81?ynotemdtimestamp=1663738691596)

### 五、课程播放页网络模块封装

net_play_path.dart

```dart
// 课时播放地址
const String net_play_urls = '/lesson/playinfo';

```
net_play.dart

```dart
import 'package:cainiaowo/libs/http/http_manager.dart';
import 'package:cainiaowo/api/play/net_play_path.dart';
import 'package:cainiaowo/models/video_play_info.dart';

class CNWPlayNetManager {
  static Future<VideoPlayInfo> lessonUrls(String lessonKey) {
    Map<String, dynamic> queryParameters = {
      'key': lessonKey,
    };
    return HttpManager.get(
      net_play_urls,
      params: queryParameters,
    ).then((response) => VideoPlayInfo.fromJson(response));
  }
}

```




### 六、课程播放页实现

整个过程需要创建flutter的插件，然后通过主项目引用的方式进行关联

#### 步骤一、创建管理视频的插件项目

打开控制台，在flutter项目目录下输入命令行：


```
flutter create --template=plugin --platforms=android,ios -i objc -a java f_tx_splayer_
```
![image](https://note.youdao.com/yws/public/resource/93d337fcdeaa9ecdbf71fd780a47f5c0/084E939A68C84A44B77C147B324322E2?ynotemdtimestamp=1663738691596)

创建完毕后，在yaml里有插件标识的配置内容

日常开发flutter插件的时候，可以使用插件目录下的example来调试

![image](https://note.youdao.com/yws/public/resource/93d337fcdeaa9ecdbf71fd780a47f5c0/6F285ECE4AA4485AA8EF76EE6C430A19?ynotemdtimestamp=1663738691596)

#### 第二步、参考腾讯云点播播放器说明文档，在flutter插件的安卓原生代码中集成视频SDK

[https://cloud.tencent.com/document/product/881/20213](https://cloud.tencent.com/document/product/881/20213)

#### 第三步、在flutter插件中封装接口去调用插件中的播放器api，并且提供api给外部项目使用

..\lib\pages\play\view\index.dart

```
  Widget _buidVideoPlayer() {
    return BlocListener<CourseBloc, CourseState>(
        listener: (context, state) {
          if (state.lastPlayInfo != null && this.lessonKey == null) {
            LastPlayLessonInfo lastPlayLessonInfo = state.lastPlayInfo!;

            if (lastPlayLessonInfo.has!) {
              this.lessonKey = lastPlayLessonInfo.lessonKey;
              courseBloc.add(GetPlayInfoEvent(this.lessonKey!));
            }
          }

          if (state.playInfo != null) {
            Tcplayer tcplayer = state.playInfo!.tcplayer!;

            if (fileId == null || fileId != tcplayer.fileId) {
              fileId = tcplayer.fileId;
              TencentVideoPlayModel tencentModel = TencentVideoPlayModel(
                  appId: tcplayer.appId!,
                  fileId: tcplayer.fileId!,
                  psign: tcplayer.psign);

              if (_controller.value.isPlaying) {
                _controller.stop();
              }
              _controller.playTencentVideo(tencentModel);
            }
          }
        },
```

..\tx_super_player\lib\Core\cniao5_video_player_controller.dart

```dart
  Future<bool> playTencentVideo(TencentVideoPlayModel params) async {
    if (_isDisposedOrNotInitialized) {
      return false;
    }
    value = value.copyWith(isPlaying: true);
    final result = await _channel.invokeMethod(
        PlayerControllerEvent.methodPlayTencentVideo, params.toJson());
    return result == 0;
  }
```


### 七、补充项目存储方式及Webview的使用

#### 1. 存储方式

1. 在yaml配置中集成存储插件



```yaml
environment:
  sdk: ">=2.14.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter

  shared_preferences: ^2.0.11
```

2. 调用插件：功能实现在之前的健全类里repo类里

storage.dart

```dart
/// 本地存储
class StorageUtil {
  StorageUtil._internal();
  static final StorageUtil _instance = StorageUtil._internal();

  factory StorageUtil() {
    return _instance;
  }

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool>? setString(String key, String value, {bool encrypt: false}) {
    // if (value == null || value == "") return  Future.error(new Error());

    if (encrypt) {
      value = EncryptUtils.aesEncrypt(value, SECRET_KEY);
    }
    return _prefs?.setString(key, value);
  }

    ...
}

```

authentication_repository.dart

```dart
/// uninitialized - 身份验证未初始化；  authenticated - 认证成功；  unauthenticated 认证失败
enum AuthenticationStatus { uninitialized, authenticated, unauthenticated }

class AuthenticationRepository {
  User? _user;

  User? getUser() {
    if (_user == null) {
      String? json =
          StorageUtil().getString(STORAGE_LOGIN_USER_KEY, encrypt: true);
      if (json != null) {
        Map map = jsonDecode(json);
        _user = User.fromJson(map as Map<String, dynamic>);
      }
    }
    return _user;
  }

  String? getToken() {
    return StorageUtil().getString(STORAGE_LOGIN_TOKEN_KEY, encrypt: true);
  }

  /// 缓存登录信息（token 和 user）
  void saveAuthenticationInfo(User user, String token) {
    String json = jsonEncode(user.toJson());
    StorageUtil().setString(STORAGE_LOGIN_USER_KEY, json, encrypt: true);

    StorageUtil().setString(STORAGE_LOGIN_TOKEN_KEY, token, encrypt: true);

    Global.loginToken = token;
  }

  /// 清除登录信息
  void clearAuthenticationInfo() {
    StorageUtil().remove(STORAGE_LOGIN_USER_KEY);
    StorageUtil().remove(STORAGE_LOGIN_TOKEN_KEY);
  }
}

```

#### 2. flutter和h5之间的交互

1. yaml配置引用webview


```yaml
dependencies:
  flutter:
    sdk: flutter

  webview_flutter: ^2.8.0
```

2. 集成webview页面

lib\pages\webview\index.dart

```dart
class _WebViewPage extends State<WebViewPage> {
  String _pageTitle = "加载中...";
  late WebViewController _webViewController;

  // H5 端调用Flutter 的方法
  /// cniaoApp.postMessage(JSON.stringify({method:"方法名",data:{"xxxx":'xxxx'}}));
  JavascriptChannel jsBridge(BuildContext context) => JavascriptChannel(
      name: 'cniaoApp', // 与h5 端的一致 不然收不到消息
      onMessageReceived: (JavascriptMessage message) async {
        String jsonStr = message.message;
        JsBridgeUtil.executeMethod(context, JsBridgeUtil.parseJson(jsonStr));
      });

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar(), body: _buildBody());
  }

  _buildAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        _pageTitle,
        style: TextStyle(color: Colors.black, fontSize: AppFontSize.normalSp),
      ),
      leading: IconButton(
        icon: Icon(
          CNWFonts.back,
          color: AppColors.black,
          size: 80.w,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  _buildBody() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 1,
          width: double.infinity,
          child: const DecoratedBox(
              decoration: BoxDecoration(color: Color(0xFFEEEEEE))),
        ),
        Expanded(
          flex: 1,
          child: WebView(
            initialUrl: widget.isLocalUrl
                ? Uri.dataFromString(widget.url,
                        mimeType: 'text/html',
                        encoding: Encoding.getByName('utf-8'))
                    .toString()
                : widget.url,
            userAgent: "cniao5App",
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: <JavascriptChannel>[jsBridge(context)].toSet(),
            onWebViewCreated: (WebViewController controller) {
              _webViewController = controller;
              if (widget.isLocalUrl) {
                _loadHtmlAssets(controller);
              } else {
                controller.loadUrl(widget.url);
              }
            },
            onPageFinished: (String value) {
              _webViewController.getTitle().then((title) {
                setState(() {
                  this._pageTitle = title ?? "";
                });
              });

              /// 如果嵌入的页面是cniao5.com ,则调用h5页面的登录方法
              _webViewController.currentUrl().then((url) {
                if (url != null && url.contains("m.cniao5.com")) {
                  _nativeAppUserLogin();
                }
              });
            },
          ),
        )
      ],
    );
  }

  _nativeAppUserLogin() {
    String? userToken = Global.loginToken;
    if (userToken != null) {
      String h5LoginScript = "nativeAppUserLogin('$userToken')";
      _webViewController.runJavascript(h5LoginScript);
    }
  }

//加载本地文件
  _loadHtmlAssets(WebViewController controller) async {
    String htmlPath = await rootBundle.loadString(widget.url);
    controller.loadUrl(Uri.dataFromString(htmlPath,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}

```

3. h5调用flutter方法

lib\pages\webview\index.dart

```dart
class _WebViewPage extends State<WebViewPage> {
  String _pageTitle = "加载中...";
  late WebViewController _webViewController;

  // H5 端调用Flutter 的方法
  /// cniaoApp.postMessage(JSON.stringify({method:"方法名",data:{"xxxx":'xxxx'}}));
  JavascriptChannel jsBridge(BuildContext context) => JavascriptChannel(
      name: 'cniaoApp', // 与h5 端的一致 不然收不到消息
      onMessageReceived: (JavascriptMessage message) async {
        String jsonStr = message.message;
        JsBridgeUtil.executeMethod(context, JsBridgeUtil.parseJson(jsonStr));
      });
```

lib\pages\webview\js_bridge_util.dart

```dart
class JsBridgeUtil {
  /// 将json字符串转化成对象
  static JsBridge parseJson(String jsonStr) {
    JsBridge jsBridgeModel = JsBridge.fromMap(jsonDecode(jsonStr));
    return jsBridgeModel;
  }

  /// 向H5开发接口调用
  static executeMethod(BuildContext context, JsBridge jsBridge) async {
    if (jsBridge.method == 'getAppToken') {
      jsBridge.success.call();
    }
  }
}

```

4. flutter数据及登录态同步到webview中

lib\pages\webview\index.dart

```dart
Expanded(
          flex: 1,
          child: WebView(
            initialUrl: widget.isLocalUrl
                ? Uri.dataFromString(widget.url,
                        mimeType: 'text/html',
                        encoding: Encoding.getByName('utf-8'))
                    .toString()
                : widget.url,
            userAgent: "cniao5App",
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: <JavascriptChannel>[jsBridge(context)].toSet(),
            onWebViewCreated: (WebViewController controller) {
              _webViewController = controller;
              if (widget.isLocalUrl) {
                _loadHtmlAssets(controller);
              } else {
                controller.loadUrl(widget.url);
              }
            },
            onPageFinished: (String value) {
              _webViewController.getTitle().then((title) {
                setState(() {
                  this._pageTitle = title ?? "";
                });
              });

              /// 如果嵌入的页面是cniao5.com ,则调用h5页面的登录方法
              _webViewController.currentUrl().then((url) {
                if (url != null && url.contains("m.cniao5.com")) {
                  _nativeAppUserLogin();
                }
              });
            },
          ),
```


```dart
  _nativeAppUserLogin() {
    String? userToken = Global.loginToken;
    if (userToken != null) {
      String h5LoginScript = "nativeAppUserLogin('$userToken')";
      _webViewController.runJavascript(h5LoginScript);
    }
  }
```
