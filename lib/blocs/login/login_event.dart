import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class UsernameChanged extends LoginEvent {
  final String email;

  UsernameChanged(this.email);

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'UsernameChanged { username: $email }';
}

class PasswordChanged extends LoginEvent {
  final String pwd;

  PasswordChanged(this.pwd);

  @override
  List<Object> get props => [pwd];

  @override
  String toString() => 'PasswordChanged { password: $pwd }';
}

class Submitted extends LoginEvent {
  final String email;
  final String pwd;

  Submitted(this.email, this.pwd);

  @override
  List<Object> get props => [email, pwd];

  @override
  String toString() => 'Submitted { username: $email, password: $pwd }';
}