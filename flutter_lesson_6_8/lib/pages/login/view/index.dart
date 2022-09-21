import 'package:cainiaowo/common/authentication/authentication.dart';
import 'package:cainiaowo/common/icons.dart';
import 'package:cainiaowo/common/values/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cainiaowo/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            CNWFonts.back,
            color: Color(0xFF303133),
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '用户登录',
          style: TextStyle(
            color: Color(0xff333333),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status == AuthenticationStatus.authenticated)
            Navigator.pop(context);
        },
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ClipOval(
                      child: Container(
                        color: Color(0xFFf5f5f5),
                        width: 200.w,
                        height: 200.w,
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage("assets/login/logo1.png"),
                          width: 150.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: BlocProvider(
                    create: (context) {
                      return LoginBloc(
                          authenticationBloc:
                              context.read<AuthenticationBloc>());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: LoginForm(),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
