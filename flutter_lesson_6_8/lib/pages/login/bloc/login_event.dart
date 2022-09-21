part of 'login_bloc.dart';

abstract class UserLoginEvent extends Equatable {
  const UserLoginEvent();

  @override
  List<Object> get props => [];
}

class MobileChangedEvent extends UserLoginEvent {
  const MobileChangedEvent(this.mobi);

  final String mobi;

  @override
  List<Object> get props => [mobi];
}

class PasswordChangedEvent extends UserLoginEvent {
  const PasswordChangedEvent(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class OnLoginEvent extends UserLoginEvent {
  const OnLoginEvent();
}
