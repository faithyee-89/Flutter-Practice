import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatelessWidget {
  NewsDetailPage({Key? key, required this.url}) : super(key: key);
  String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: url,
        // 要打开js加载api
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
