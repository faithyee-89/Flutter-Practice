// import 'package:cainiaowo/pages/video.dart';
import 'package:cainiaowo/pages/main_laout/view/index.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'common/authentication/authentication_repository/authentication_repository.dart';
import 'common/authentication/bloc/authentication_bloc.dart';

class App extends StatelessWidget {
  const App({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        lazy: false,
        create: (_) {
          AuthenticationBloc authBolc = AuthenticationBloc(
              authenticationRepository: authenticationRepository);
          authBolc.add(AppStartEvent());
          return authBolc;
        },
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
    // return ScreenUtilInit(
    //   designSize: Size(1080, 1920),
    //   builder: () => MaterialApp(
    //     home: MainLayout(),
    //     builder: EasyLoading.init(),
    //   ),
    // );
    return MaterialApp(
      home: MainLayout(),
    );
  }
}
