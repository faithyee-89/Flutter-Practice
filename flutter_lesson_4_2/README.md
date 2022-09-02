> ### 本节课⽬标
> - 掌握flutter⽹络请求


发起HTTP请求

http⽀持位于dart:io，所以要创建⼀个HTTP client， 我们需要添加⼀个导⼊：


```
import 'dart:io';

var httpClient = new HttpClient();
```



该 client ⽀持常⽤的HTTP操作, GET, POST, PUT, DELETE. ⽹络调⽤通常遵循如下步骤：

1. 创建 client.
2. 构造 Uri.
3. 发起请求, 等待请求，同时您也可以配置请求headers、 body。
4. 关闭请求, 等待响应.
5. 解码响应的内容.


```
get() async {
  var httpClient = new HttpClient();
  var uri = new Uri.http(
      'example.com', '/path1/path2', {'param1': '42', 'param2': 'foo'});
  var request = await httpClient.getUrl(uri);
  var response = await request.close();
  var responseBody = await response.transform(UTF8.decoder).join();
}

```


- 模拟接⼝
- [http://aider.meizu.com/app/weather/listWeather?cityIds=101010100](http://aider.meizu.com/app/weather/listWeather?cityIds=101010100)

![网络请求](https://note.youdao.com/yws/public/resource/d2a26adc83145244021ba3f9ac10939c/B16C2DE3339C456895852ECDA41264D5?ynotemdtimestamp=1662124609367)


#### 代码及UI示例

main.dart


```
import 'package:flutter/material.dart';
import 'package:flutter_lesson_4_2/weather_page.dart';

void main() {
  runApp(MaterialApp(
    home: WeatherPage(),
  ));
}

```

weather_page.dart ： 首页


```
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_lesson_4_2/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  /// 标题字体
  TextStyle _titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  /// 数据源
  WeatherModel? _weatherModel;

  /// 获取网络数据
  Future _loadData() async {
    await Future.delayed(Duration(seconds: 1));
    String url = 'http://aider.meizu.com/app/weather/listWeather';

    HttpClient httpClient = HttpClient();

    /// get请求
    // var request = await httpClient.getUrl(Uri.parse(url));
    /// post请求
    var request = await httpClient.postUrl(Uri(
        scheme: 'http',
        host: 'aider.meizu.com',
        path: '/app/weather/listWeather',
        queryParameters: {"cityIds": "101010100"}));

    var response = await request.close();
    var json = await response.transform(utf8.decoder).join();
    var jsonData = jsonDecode(json);
    setState(() {
      _weatherModel = WeatherModel.fromJson(jsonData);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            'http://5b0988e595225.cdn.sohucs.com/images/20190927/4f20b1e1d2834e3b9b59ce4d5ca148e1.jpeg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: _viewBody(),
          )
        ],
      ),
    );
  }

  Widget _viewBody() {
    return _weatherModel == null
        ? Center(
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
          )
        : ListView(
            children: [
              _adviceListView(),
              _weatherHoursListView(),
              _futurWeather(),
            ],
          );
  }

  /// 今日指数
  Widget _adviceListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '今日指数',
          style: _titleStyle,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _weatherModel!.value![0].indexes!.length,
            itemBuilder: (c, index) {
              return ListTile(
                title: Text(_weatherModel!.value![0].indexes![index].name!),
                subtitle:
                    Text(_weatherModel!.value![0].indexes![index].content!),
              );
            })
      ],
    );
  }

  /// 当天小时天气
  Widget _weatherHoursListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '天气时段',
          style: _titleStyle,
        ),
        SizedBox(
          height: 90,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _weatherModel!.value!.first.weatherDetailsInfo!
                  .weather3HoursDetailsInfos!.length,
              itemBuilder: (c, index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        _weatherModel!.value!.first.weatherDetailsInfo!
                            .weather3HoursDetailsInfos![index].endTime!
                            .split(' ')
                            .last,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(_weatherModel!.value!.first.weatherDetailsInfo!
                              .weather3HoursDetailsInfos![index].weather! +
                          ' ' +
                          _weatherModel!
                              .value!
                              .first
                              .weatherDetailsInfo!
                              .weather3HoursDetailsInfos![index]
                              .highestTemperature!)
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  Widget _futurWeather() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '未来天气',
          style: _titleStyle,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _weatherModel!.value!.first.weathers!.length,
            itemBuilder: (c, index) {
              return ListTile(
                title: Text(_weatherModel!.value!.first.weathers![index].week!),
                subtitle:
                    Text(_weatherModel!.value!.first.weathers![index].weather!),
              );
            })
      ],
    );
  }
}

```

weather_model.dart（代码省略）

![今日指数](https://note.youdao.com/yws/public/resource/d2a26adc83145244021ba3f9ac10939c/BB3B3B09E8754B34905BBE8D5982D1D0?ynotemdtimestamp=1662124609367)

