part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = const Username.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  final Username status;
  final Username username;
  final Password password;

  LoginState copyWith({
    Username? status,
    Username? username,
    Password? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
