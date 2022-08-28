> ### 本节课⽬标
> - 掌握Text组件、Image组件和Icon组件的使⽤
> - 掌握本地资源⽂件的使⽤


- #### Text组件

⽂本组件是以字符串形式显示的单⼀格式，这个⽂本字符串可以是多⾏显示也可以是单独⼀⾏显示，主要取决于你的布局限制。


```
class Text extends StatelessWidget {
     const Text(this.data, {
         Key key,
         this.style,// 字体的样式设置
         this.textAlign, // 文本对齐方式
         this.textDirection,// 文本方向
         this.overflow, // overflow
         this.textScaleFactor,// 字体显示倍率
         this.maxLines, // 文字显示最大行数
 })
```

- #### TextStyle ⽂字样式


```
const TextStyle({
     this.color, // 颜色
     this.fontSize, // 字号
     this.fontWeight, // 字重，加粗也用这个字段
    FontWeight.w700
     this.fontStyle, // FontStyle.normal
    FontStyle.italic斜体
     this.letterSpacing, // 字符间距 就是单个字母或者汉字之间的间
    隔，可以是负数
     this.wordSpacing, // 字间距 句字之间的间距
     this.textBaseline, // 基线，两个值，字面意思是一个用来排字母的，
    一人用来排表意字的（类似中文）
     this.height, // 当用来Text控件上时，行高（会乘以
    fontSize,所以不以设置过大）
     this.decoration, // 添加上划线，下划线，删除线
     this.decorationColor, // 划线的颜色
     this.decorationStyle, // 这个style可能控制画实线，虚线，两条线，点,
    波浪线等
     this.debugLabel,
     String fontFamily, // 字体
     String package,
 })
```

- #### 引⽤本地图⽚资源
1. 在根⽬录新建⽂件夹 /images
2. 在 /image 下放⼊图⽚
3. 在pubspec.yaml声明添加的图⽚⽂件夹
- #### Image 图⽚组件

常⽤加载图⽚的两种⽅式：


1. Image.asset: 本地资源
2. Image.network: ⽹络资源



```
BoxFi：fit属性可以控制图⽚的拉伸和挤压
BoxFit.fill:全图显示，图片会被拉伸，并充满父容器。
BoxFit.contain:全图显示，显示原比例，可能会有空隙。
BoxFit.cover：显示可能拉伸，可能裁切，充满（图片要充满整个容器，还不变形）。
BoxFit.fitWidth：宽度充满（横向充满），显示可能拉伸，可能裁切。
BoxFit.fitHeight ：高度充满（竖向充满）,显示可能拉伸，可能裁切。
BoxFit.scaleDown：效果和contain差不多，但是此属性不允许显示超过源图片大小，可小不可大
```

- #### 代码及UI示例



```
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 文本控件演示代码
          Container(
            margin: EdgeInsets.only(top: 100),
              height: 200,
              width: 200,
              color: Colors.blue,
              // 文本控件
              child: Text(
                '文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本',
                /**
             * 文本对齐方式
             * TextAlign.end
             */
                textAlign: TextAlign.end,
                overflow: TextOverflow.clip,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 5,
                  height: 2,
                  decoration: TextDecoration.overline,
                ),
              ),
            ),
            // Image控件演示代码
            Container(
              width: 300,
              height: 300,
              color: Colors.orange,
              // 网络图片地址：https://doc.flutterchina.club/images/flutter-mark-square-100.png
              // child: Image.asset(
              //   'image/flutter_icon.jpg',
              //   // 填充方式
              //   fit: BoxFit.fill,
              // ),

              // child: Image.network(
              //   'https://doc.flutterchina.club/images/flutter-mark-square-100.png',
              //   fit: BoxFit.fill,
              // ),

              child: Icon(
                Icons.stars,
                ),

            ),
        ]),
      ),
    );
  }
}

```

![textimage](https://note.youdao.com/yws/public/resource/f4fbb30743f334e89004a9d3d495d938/34E66E598BB14B679279AD7B91638AFA?ynotemdtimestamp=1661660465284)