/*
 * @Ro: 『Road endless its long and far, I will seek up and down.』
 * @Descripttion: 
 * @Author: Ro
 * @Date: 2021-02-09 15:23:45
 */
import 'package:flutter/material.dart';
import 'business/authentication/authentication.dart';
import 'business/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business/home/home.dart';
import 'business/login/login.dart';
import 'business/splash/splash.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
