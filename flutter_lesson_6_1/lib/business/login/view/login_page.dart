import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../common/icons.dart';
import '../../authentication/authentication.dart';
import '../../authentication/authentication_repository/authentication_repository.dart';
import '../bloc/login_bloc.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          '登录',
          style: TextStyle(
            color: Color(0xff333333),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              Navigator.pop(context);
              break;
            case AuthenticationStatus.unauthenticated:
              break;
            default:
              break;
          }
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Image.asset(
                  "assets/login/logo.png",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: BlocProvider(
                  create: (context) {
                    return LoginBloc(
                      authenticationRepository:
                          RepositoryProvider.of<AuthenticationRepository>(
                              context),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: LoginForm(),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
