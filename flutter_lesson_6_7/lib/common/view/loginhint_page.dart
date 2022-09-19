import 'package:cainiaowo/business/login/login.dart';
import 'package:flutter/material.dart';

class LoginHintPage extends StatelessWidget {
  const LoginHintPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '您还未登陆，请先登录！',
          style: TextStyle(
            fontSize: 14,
            color: Color(0x99999999),
          ),
        ),
        Container(
          width: 200,
          height: 35,
          margin: const EdgeInsets.only(top: 20),
          child: ButtonTheme(
            minWidth: double.infinity,
            child: RaisedButton(
              key: const Key('loginForm_continue_raisedButton'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: Color(0xfffc9900),
              child: const Text('登  录',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  )),
              onPressed: () {
                Navigator.of(context).push(LoginPage.route());
              },
            ),
          ),
        )
      ],
    );
  }
}
