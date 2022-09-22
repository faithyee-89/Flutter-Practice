import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/page_visibility.dart';
import 'package:cainiaowo_base_module/request_channel.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

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
