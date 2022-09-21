part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

// class AuthenticationStatusChanged extends AuthenticationEvent {
//   const AuthenticationStatusChanged(this.status);

//   final AuthenticationStatus status;

//   @override
//   List<Object> get props => [status];
// }

//App启动事件
class AppStartEvent extends AuthenticationEvent {}

///登录事件
class LoginEvent extends AuthenticationEvent {
  final String token;
  final User user;

  LoginEvent(this.token, this.user);

  @override
  List<Object?> get props => [token, user];

  @override
  String toString() => "LoggedIn { token: $token }";
}

///退出登录事件
class LogoutEvent extends AuthenticationEvent {}
