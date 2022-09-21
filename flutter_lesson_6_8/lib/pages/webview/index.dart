import 'dart:convert';
import 'dart:io';

import 'package:cainiaowo/common/icons.dart';
import 'package:cainiaowo/common/values/index.dart';
import 'package:cainiaowo/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'js_bridge_util.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({required this.url, this.isLocalUrl = false, this.title});

  final String url;
  final String? title;
  final bool isLocalUrl;

  @override
  _WebViewPage createState() => _WebViewPage();
}

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
