import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, {this.isBindPhone, this.logo, this.token, this.username});

  final int id;
  final bool isBindPhone;
  final String logo;
  final String token;
  final String username;

  @override
  List<Object> get props => [id, isBindPhone, logo, token, username];

  static const empty = User(0);
}
