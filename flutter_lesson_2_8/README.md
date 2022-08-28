> ### 本节课⽬标
> - 根据所学的线性布局、image组件、icon组件、container组件和点击事件等绘制⼀个登录界⾯
> - 点击登录时获取账号密码⽂本

实现效果：

![image](https://note.youdao.com/yws/public/resource/a5346d62aa49cc023ec5144a9f3f0648/50CA739F6DFE4FC9B4DA0357DC794016?ynotemdtimestamp=1661707507990)


- #### 代码及UI示例

- wechat_login_page.dart

```
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          // MediaQuery.of(context) 这个方法可以通过context获取当前页面的高度
          height: MediaQuery.of(context).size.height - 20,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                '取消',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '用手机号登录',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            _countrySelectRow(),
            SizedBox(
              height: 10,
            ),
            _line(),
            _phoneInput(),
            _line(),
            _passwordRow(),
            _line(),
            SizedBox(
              height: 40,
            ),
            _loginButton(),
            Expanded(child: SizedBox()),
            //bottomRow需要配合 MediaQuery.of(context) 去放在最底部
            _bottomRow(),
          ]),
        ),
      ),
    ));
  }

  Widget _bottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '登录遇到问题？',
          style: TextStyle(color: Colors.blueGrey),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          width: 1,
          height: 20,
          color: Colors.blueGrey,
        ),
        Text(
          '其他方式登录',
          style: TextStyle(color: Colors.blueGrey),
        )
      ],
    );
  }

  // 登录按钮
  Widget _loginButton() {
    return Column(
      children: [
        InkWell(
          onTap: _onLoginButtonTap,
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            alignment: Alignment.center,
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              '登录',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Text(
          '通过短信验证码登录',
          style: TextStyle(
            color: Colors.blueGrey,
          ),
        )
      ],
    );
  }

  // 密码输入框
  Widget _passwordRow() {
    return Row(
      children: [
        Text(
          '密码',
        ),
        SizedBox(
          width: 110,
        ),
        Expanded(
          child: TextField(
            controller: password,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '请输入密码',
              hintStyle: TextStyle(
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ],
    );
  }

// 手机号输入框
  Widget _phoneInput() {
    return Row(
      children: [
        Text(
          '+86',
        ),
        SizedBox(
          width: 100,
        ),
        Container(
          height: 40,
          width: 1,
          color: Colors.grey.shade300,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextField(
          controller: phone,
          decoration: InputDecoration(
            hintText: '请填写手机号码',
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Colors.grey.shade300,
            ),
          ),
        )),
      ],
    );
  }

  // 国家选择
  Widget _countrySelectRow() {
    return Row(
      children: [
        Text('国家/地区'),
        SizedBox(
          width: 20,
        ),
        Text('中国'),
        Expanded(child: SizedBox()),
        Icon(Icons.keyboard_arrow_right),
      ],
    );
  }

  // 分割线
  Widget _line() {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey.shade300,
    );
  }

  void _onLoginButtonTap() {
  print(phone.text);
  print(password.text);
}
}



```

- main.dart

```
import 'package:flutter/material.dart';
import 'package:flutter_lesson_2_8/wechat_login_page.dart';

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
```

![微信](https://note.youdao.com/yws/public/resource/a5346d62aa49cc023ec5144a9f3f0648/7A0145AA39004A8AB79F261ACEE9B3E4?ynotemdtimestamp=1661707507990)





