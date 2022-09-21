import 'package:cainiaowo/api/login/net_login.dart';
import 'package:cainiaowo/common/authentication/authentication.dart';
// import 'package:cainiaowo/common/authentication/authentication_repository/authentication_repository.dart';
import 'package:cainiaowo/models/user.dart';
import 'package:cainiaowo/pages/login/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<UserLoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;

  LoginBloc({
    required AuthenticationBloc authenticationBloc,
  })  : _authenticationBloc = authenticationBloc,
        super(const LoginState()) {
    on<OnLoginEvent>((event, emit) => _login(event, emit));

    on<MobileChangedEvent>((event, emit) {
      final mobileValidation = MobileValidation.dirty(event.mobi);
      emit(state.copyWith(
        mobileValidation: mobileValidation,
        status: Formz.validate([state.passwordValidation, mobileValidation]),
      ));
    });

    on<PasswordChangedEvent>((event, emit) {
      final passwordValidation = PasswordValidation.dirty(event.password);
      emit(state.copyWith(
        passwordValidation: passwordValidation,
        status: Formz.validate([passwordValidation, state.mobileValidation]),
      ));
    });
  }

  _login(OnLoginEvent event, Emitter<LoginState> emit) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        LoginInfo loginInfo = await CNWLoginNetManager.login(
            state.mobileValidation.value, state.passwordValidation.value);

        _authenticationBloc.add(LoginEvent(loginInfo.token, loginInfo.user));
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on Exception catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
