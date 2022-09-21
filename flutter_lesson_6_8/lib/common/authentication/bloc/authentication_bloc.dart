import 'package:cainiaowo/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../authentication.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  late AuthenticationRepository _authenticationRepository;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.uninitialized()) {
    // App 启动初始化本地已登录用户数据
    on<AppStartEvent>((event, emit) => _onAppStart(emit));

    on<LoginEvent>((event, emit) => _onLogin(event, emit));

    on<LogoutEvent>((event, emit) => _onLogout(emit));
  }

  _onAppStart(Emitter<AuthenticationState> emit) {
    User? user = _authenticationRepository.getUser();
    if (user != null)
      emit(AuthenticationState.authenticated(user));
    else
      emit(const AuthenticationState.uninitialized());
  }

  _onLogin(LoginEvent event, Emitter<AuthenticationState> emit) {
    this
        ._authenticationRepository
        .saveAuthenticationInfo(event.user, event.token);

    emit(AuthenticationState.authenticated(event.user));
  }

  _onLogout(Emitter<AuthenticationState> emit) {
    this._authenticationRepository.clearAuthenticationInfo();
    emit(const AuthenticationState.uninitialized());
  }
}
