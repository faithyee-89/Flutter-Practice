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
