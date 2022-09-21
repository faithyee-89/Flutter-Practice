part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.mobileValidation = const MobileValidation.pure(),
    this.passwordValidation = const PasswordValidation.pure(),
  });

  final FormzStatus status;
  final MobileValidation mobileValidation;
  final PasswordValidation passwordValidation;

  LoginState copyWith({
    FormzStatus? status,
    MobileValidation? mobileValidation,
    PasswordValidation? passwordValidation,
  }) {
    return LoginState(
      status: status ?? this.status,
      mobileValidation: mobileValidation ?? this.mobileValidation,
      passwordValidation: passwordValidation ?? this.passwordValidation,
    );
  }

  @override
  List<Object> get props => [status, mobileValidation, passwordValidation];
}
