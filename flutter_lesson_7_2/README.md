> # 课程目标
> - PlatformChannel (跨平台通信机制)介绍
> - Native 与Flutter通过channel通信介绍
> - Android实现与Flutter的通信通道
> - iOS实现与Flutter的通信通道
> - PlatformChannel深入分析
> - FlutterBoost的三大常见的使用场景
> - FlutterBoost源码分析
> - pegion库的使用
> - Native与Flutter通过Pigeon通信
> - iOS通过pigeon通信

# 正文

## 一、PlatformChannel (跨平台通信机制)介绍

### 课程目标

- PlatformChannel的基本使用

#### 1. Flutter跨端通信支持的平台

![微信截图_20220922101722](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/EF6F14019B2549168CEC6CD19E9D6CD9?ynotemdtimestamp=1663831738074)

#### 2. PlatformChannel类型

![微信截图_20220922101807](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/3992CCBFD27F4D58AA2FADEBEFDB5C50?ynotemdtimestamp=1663831738074)

#### 3. 跨端调用原理示例

![微信截图_20220922102118](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/FC8FDCBA428F4EB2BC3B5DD3E3DE72D2?ynotemdtimestamp=1663831738074)

#### 4. 平台同奥数据类型

![微信截图_20220922102323](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/1392D7C39867478A84CB23090616D7C2?ynotemdtimestamp=1663831738074)

## 二、Native 与Flutter通过channel通信介绍（实战）

项目名：business_module

1. flutter端调用android端方法，并接收native端的数据


```dart
class _MyHomePageState extends State<MyHomePage>
    with PageVisibilityObserver
{
  @override
  void onPageShow() {
    super.onPageShow();
    print("MyHomePage - onPageShow");
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ///注册监听器
    PageVisibilityBinding.instance.addObserver(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    ///移除监听器
    PageVisibilityBinding.instance.removeObserver(this);
    super.dispose();
  }
  ///1.定义两个常量
  //通道名称(与Native一致)
  static const platformChannelName = 'platformChannelName';

  //通道调用方法名称(与Native一致)
  static const platformChannelMethodName_getNativeName =
      'platformChannelMethodName_getNativeName';
///2.从Flutter创建方法通道
  //创建方法通道
  static const platform = MethodChannel(platformChannelName);


  String name = 'flutter';
  Future<void> _getNativeName() async {
    String _name;
    try {
      _name =
          await platform.invokeMethod(platformChannelMethodName_getNativeName);
    } on PlatformException catch (e) {
      _name = "Failed to get '${e.message}'.";
    }

    setState(() {
      name = _name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              name,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: _getNativeName,
        onPressed: _getNativeNameByPigeon,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
///通过鸽子生成的代码调用Native
  Future<void> _getNativeNameByPigeon() async {
    String _name;
    var requestChannelAPI = RequestChannelAPI();
    Reply reply = await requestChannelAPI.getFinalRequestParams(RequestParams());

    setState(() {
      name = reply.replyName??'';
    });
  }
}

```

## 三、Android实现与Flutter的通信通道

项目名：AndroidNativeProject


1. flutter端调用android端方法，并接收native端的数据

native侧初始化

```java
public class NativeApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
        AppUtil.sApplication = this;
//        FlutterUtil.copyAssetsFile2flutter(this);
        //初始化缓存引擎
//        initFlutterEngine();
        //初始化flutterBoost

        initFlutterBoost();

    }

    //初始化flutterboost
    private void initFlutterBoost() {
        FlutterBoost.instance().setup(this, new FlutterBoostDelegate() {
                    @Override
                    public void pushNativeRoute(FlutterBoostRouteOptions options) {
                        //这里根据options.pageName来判断你想跳转哪个页面，这里简单给一个
                        Intent intent = new Intent(FlutterBoost.instance().currentActivity(), MainActivity.class);
                        FlutterBoost.instance().currentActivity().startActivityForResult(intent, options.requestCode());
                    }

                    @Override
                    public void pushFlutterRoute(FlutterBoostRouteOptions options) {
                        Intent intent = new FlutterBoostActivity.CachedEngineIntentBuilder(FlutterBoostActivity.class)
                                .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
                                .destroyEngineWithActivity(false)
                                .uniqueId(options.uniqueId())
                                .url(options.pageName())
                                .urlParams(options.arguments())
                                .build(FlutterBoost.instance().currentActivity());
                        FlutterBoost.instance().currentActivity().startActivity(intent);
                    }
                }, engine -> {
                    //引擎创建成功时的回调
                    //添加FlutterPlugin到引擎中
//                    engine.getPlugins().add(new PluginGetName());
                    engine.getPlugins().add(new PluginGetNameByPigeon());
                }
        );
    }

    public FlutterEngine flutterEngine;

    public void initFlutterEngine() {
        // Instantiate a FlutterEngine.
        flutterEngine = new FlutterEngine(this);

        // Start executing Dart code to pre-warm the FlutterEngine.
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );

        // Cache the FlutterEngine to be used by FlutterActivity.
        FlutterEngineCache
                .getInstance()
                .put("my_engine_id", flutterEngine);

    }
}

```

native与flutter之间通信类

```java
/**
 * Flutter 与 Native 通信的插件类
 * 1.实现FlutterPlugin接口
 * 2.在onAttachedToEngine方法中创建自己的方法通道
 * 3.在方法通道中根据名字调用Native方法
 *
 */
public class PluginGetNameByPigeon implements FlutterPlugin,RequestChannel.RequestChannelAPI {

    /**
     * 绑定到引擎时调用
     * @param flutterPluginBinding
     */
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        RequestChannel.RequestChannelAPI.setup(flutterPluginBinding.getBinaryMessenger(),this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {

    }


    @Override
    public RequestChannel.Reply getFinalRequestParams(RequestChannel.RequestParams arg) {
        RequestChannel.Reply reply = new RequestChannel.Reply();
        reply.setReplyName("Android");
        reply.setReplyVersion("1.0");
        return reply;
    }
}

```




## 四、iOS实现与Flutter的通信通道

略

## 五、PlatformChannel深入分析

### 本节目标

1. 了解远离
2. 避开一些易犯的错误

#### 1. MethodChannel流程图

flutter侧请求native

![微信截图_20220922110507](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/E1AF47573E2A44859E0D64D9A86C7B67?ynotemdtimestamp=1663831738074)

native回调flutter层

![微信截图_20220922111008](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/0001E2D35CB543CF80BB0898F2CBF96A?ynotemdtimestamp=1663831738074)

#### 2. 引擎核心类

![微信截图_20220922111127](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/3DC0015467B54A78AAA9413260FB0403?ynotemdtimestamp=1663831738074)

#### 3. flutter架构图




![微信截图_20220922111212](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/4A017CD8DC894BF5B1E485DDF9CF0DBD?ynotemdtimestamp=1663831738074)

```java
/**
     * 绑定到引擎时调用
     * @param flutterPluginBinding
     */
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        MethodChannel methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), platformChannelName);
        methodChannel.setMethodCallHandler(
                (call, result) -> {
                    // Note: this method is invoked on the main thread.
                    if (call.method.equals(platformChannelMethodName_getNativeName)) {

                        result.success("Android");
                    } else {
                        result.notImplemented();
                    }
                }
        );
    }

```


通信的关键组件是Native Plugins，通信的线程是在主线程上

#### 4. 平台架构图

![微信截图_20220922111620](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/4DCD71AC8CD1440F9AE4211DEB114F76?ynotemdtimestamp=1663831738074)

#### 5. 总结

method is invoked on the main thread.


## 六、FlutterBoost的三大常见的使用场景

### 1. 目标

1. 了解FlutterBoost的3种使用场景
2. 了解FlutterBoost的使用原理


### 2. FlutterBoostV3.0-preview.9

![image](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/7BEEDAE5E5F245FBBA695E84DAD39DD7?ynotemdtimestamp=1663831738074)

### 3. 页面路由跳转

![image](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/F51BE8BFD3EB48A792B89F54AC91DD25?ynotemdtimestamp=1663831738074)

开启页面：


```
BoostNavigator.instance.push
```


关闭页面：


```
BoostNavigator.instance.pop
```

native侧的api示例


```java
public void startFlutterByBoost(){
        HashMap map = new HashMap<>();
        map.put("key", "firstPageFromFlutterBoost");
        FlutterBoostRouteOptions options = new FlutterBoostRouteOptions.Builder()
                .pageName("firstPage")
                .arguments(map)
                .requestCode(1111)
                .build();
        FlutterBoost.instance().open(options);
    }
```


### 4. 生命周期相关

![image](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/6D4631D40AE84A339C862BEA4D01AB8D?ynotemdtimestamp=1663831738074)

App层：


```java
onBackground
onForeground
onPagePush
onPagePop
onPageHide
onPageShow
```





![image](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/478D3DF766FF4F949450A78CDE4C0A9C?ynotemdtimestamp=1663831738074)

页面层：


```java
onBackground
onForeground
onPageHide
onPageShow
```

### 5. 自定义事件传递

BoostChannel.instance.addEventListener(三端调用)
BoostChannel.instance.sendEventToNative(Flutter调用)
FlutterBoost.instance().sendEventToFlutter(双端调用)

![image](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/7B430452CA3D4BE19B9E4AB90D50EF98?ynotemdtimestamp=1663831738074)

![image](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/0791FBEAF4A8435DA6BB99A0E8BBC8FC?ynotemdtimestamp=1663831738074)

## 七、FlutterBoost源码分析

### 1. 实现原理

通过Pigeon（开源库）实现跨端调用

![image](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/5CF435340CCF4A8D81D39AB6F4CA77CC?ynotemdtimestamp=1663831738074)

![image](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/12655BD1B4C046648C606D0BC01D2104?ynotemdtimestamp=1663831738074)

### 2. 在Flutter项目下看flutterBoost的源码

项目名：business_module

![image](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/C32F5BCB47C044C399D952EA0E00B601?ynotemdtimestamp=1663831738074)

## 八、pegion库的使用

### 1. 引入Pigeon库

![image](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/A971FA6244944C18B4FFBA044A244C20?ynotemdtimestamp=1663831738074)

创建方便开发进行跨端通信的文件

### 2. Pigeon文件的声明

![image](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/33E710D337FD45CDAD4A460A521F2CAE?ynotemdtimestamp=1663831738074)

![image](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/7FAD5135BD264DD3A56A70E0FD0F7E0A?ynotemdtimestamp=1663831738074)

### 3. Pigeon文件的生成



#### 0.2版本构建pigeon对应的文件执行以下命令


```
flutter pub run pigeon --input pigeon/message.dart
```

#### 0.3版本构建pigeon对应的文件执行以下命令


```
flutter pub run pigeon --input pigeon/request_channel.dart --dart_out pigeon/output
```



### 4. Pigeon生成对应的文件

![image](https://note.youdao.com/yws/public/resource/92b2ac40e16124deed005a734f431aab/B241FD99F4C4499FA90E31EBA8364D28?ynotemdtimestamp=1663831738074)

## 九、Native与Flutter通过Pigeon通信

### 1. 项目名

- flutter项目：flutterproject
- android项目：AndroidNativeProject




## 十、iOS通过pigeon通信

略