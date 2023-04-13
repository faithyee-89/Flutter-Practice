import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            child: Image.asset(
              'image/ic_login_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 101),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      child: Image.asset('image/ic_launcher.png',
                          fit: BoxFit.fill),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 19),
                alignment: Alignment.center,
                width: ScreenUtil().screenWidth,
                height: 30,
                child: Text(
                  "欢迎登录中控管理平台",
                  style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 59.5, left: 49.5, right: 49.5),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: '请输入登录账号',
                      hintStyle:
                          TextStyle(fontSize: 15, color: Color(0xFFABBDD5))),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, left: 49.5, right: 49.5),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: '请输入登录密码',
                      hintStyle:
                          TextStyle(fontSize: 15, color: Color(0xFFABBDD5))),
                ),
              ),
              Expanded(flex: 1, child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 24),
                    width: 11,
                    height: 11,
                    child: Image.asset("image/ic_checkbox_uncheck.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 9.5, bottom: 24),
                    child: Text(
                      '我已阅读并同意《软件许可及服务协议》',
                      style: TextStyle(fontSize: 11, color: Color(0xFFFFFFFF)),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 49.5, right: 49.5, bottom: 25),
                alignment: Alignment.center,
                width: ScreenUtil().screenWidth,
                height: 42.5,
                decoration: BoxDecoration(
                    color: Color(0xFFABBDD5),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "登录",
                  style: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 57.5),
                alignment: Alignment.bottomCenter,
                width: ScreenUtil().screenWidth,
                height: 30,
                child: Text(
                  "联系客服",
                  style: TextStyle(fontSize: 12, color: Color(0xFFFFFFFF)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
