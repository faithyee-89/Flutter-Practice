> ### 本节课⽬标
> - 掌握TextField的使⽤(输⼊框)

Material组件库中提供了输⼊框组件TextField TextField属性：


```
const TextField({
 Key key,
 this.controller, // 控制正在编辑文本
 this.focusNode, // 获取键盘焦点
 this.decoration = const InputDecoration(), // 边框装
饰
 TextInputType keyboardType, // 键盘类型
 this.textInputAction, // 键盘的操作按钮类型
 this.textCapitalization = TextCapitalization.none, // 配置大
小写键盘
 this.style, // 输入文本样式
 this.textAlign = TextAlign.start, // 对齐方式
 this.textDirection, // 文本方向
 this.autofocus = false, // 是否自动对焦
 this.obscureText = false, // 是否隐藏内容，例如密码格式
 this.autocorrect = true, // 是否自动校正
 this.maxLines = 1, // 最大行数
 this.maxLength, // 允许输入的最大长度
 this.maxLengthEnforced = true, // 是否允许超过输入最大长度
 this.onChanged, // 文本内容变更时回调
 this.onEditingComplete, // 提交内容时回调
 this.onSubmitted, // 用户提示完成时回调
 this.inputFormatters, // 验证及格式
 this.enabled, // 是否不可点击
 this.cursorWidth = 2.0, // 光标宽度
 this.cursorRadius, // 光标圆角弧度
 this.cursorColor, // 光标颜色
 this.keyboardAppearance, // 键盘亮度
 this.scrollPadding = const EdgeInsets.all(20.0), // 滚动到
视图中时，填充边距
 this.enableInteractiveSelection, // 长按是否展示【剪切/复制/粘贴菜
单LengthLimitingTextInputFormatter】
 this.onTap, // 点击时回调
})
```

InputDecoration属性:


```
InputDecoration({
     this.icon, //位于装饰器外部和输入框前面的图片
     this.labelText, //用于描述输入框，例如这个输入框是用来输入用户名还是密码
    的，当输入框获取焦点时默认会浮动到上方，
     this.labelStyle, // 控制labelText的样式,接收一个TextStyle类型的值
     this.helperText, //辅助文本，位于输入框下方，如果errorText不为空的话，
    则helperText不会显示
     this.helperStyle, //helperText的样式
     this.hintText, //提示文本，位于输入框内部
     this.hintStyle, //hintText的样式
     this.hintMaxLines, //提示信息最大行数
     this.errorText, //错误信息提示
     this.errorStyle, //errorText的样式
     this.errorMaxLines, //errorText最大行数
     this.hasFloatingPlaceholder = true, //labelText是否浮动，默认
    为true，修改为false则labelText在输入框获取焦点时不会浮动且不显示
     this.isDense, //改变输入框是否为密集型，默认为false，修改为true时，图
    标及间距会变小
     this.contentPadding, //内间距
     this.prefixIcon, //位于输入框内部起始位置的图标。
     this.prefix, //预先填充的Widget,跟prefixText同时只能出现一个
     this.prefixText, //预填充的文本，例如手机号前面预先加上区号等
     this.prefixStyle, //prefixText的样式
     this.suffixIcon, //位于输入框后面的图片,例如一般输入框后面会有个眼睛，控
    制输入内容是否明文
     this.suffix, //位于输入框尾部的控件，同样的不能和suffixText同时使用
     this.suffixText,//位于尾部的填充文字
     this.suffixStyle, //suffixText的样式
     this.counter,//位于输入框右下方的小控件，不能和counterText同时使用
     this.counterText,//位于右下方显示的文本，常用于显示输入的字符数量
     this.counterStyle, //counterText的样式
     this.filled, //如果为true，则输入使用fillColor指定的颜色填充
     this.fillColor, //相当于输入框的背景颜色
     this.errorBorder, //errorText不为空，输入框没有焦点时要显示的边框
     this.focusedBorder, //输入框有焦点时的边框,如果errorText不为空的话，
    该属性无效
     this.focusedErrorBorder, //errorText不为空时，输入框有焦点时的边框
     this.disabledBorder, //输入框禁用时显示的边框，如果errorText不为空的
    话，该属性无效
     this.enabledBorder, //输入框可用时显示的边框，如果errorText不为空的
    话，该属性无效
     this.border, //正常情况下的border
     this.enabled = true, //输入框是否可用
     this.semanticCounterText,
     this.alignLabelWithHint,
})

```

- #### 代码及UI示例


```
import 'package:flutter/material.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // 获取文本方式2
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // textfield控件使用
        body: Center(
          child: TextField(
            controller: controller,
            // 获取文本方式1
            onChanged: (String s) {
              // print(s);
              print(controller.text);
            },

            // obscureText: false,
            // keyboardType: TextInputType.number,
            // textInputAction: TextInputAction.done,
            // cursorColor: Colors.red,
            // cursorWidth: 15,
            // cursorRadius: Radius.circular(10),
            // maxLength: 3,
            decoration: InputDecoration(
              // icon: Icon(Icons.person),
              prefixIcon: Icon(Icons.phone_android),
              suffixIcon: Icon(Icons.close),
              hintText: '请输入账号',
              labelText: '请输入账号',
              helperText: '帮助文字',
              helperStyle: TextStyle(
                color: Colors.green,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
      ),
    );
  }
}

```

![textfield](https://note.youdao.com/yws/public/resource/49e06f9ddd493847d692a8eb4b0b19dd/49DB6978444F4FD4878FF56F6581F130?ynotemdtimestamp=1661673428313)
