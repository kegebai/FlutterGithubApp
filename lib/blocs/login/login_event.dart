import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class UsernameChanged extends LoginEvent {
  final String username;

  UsernameChanged(this.username);

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'UsernameChanged { username: $username }';
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged(this.password);

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends LoginEvent {
  final String username;
  final String password;
  final BuildContext ctx;

  Submitted(this.ctx, this.username, this.password);

  @override
  List<Object> get props => [username, password];

  @override
  String toString() => 'Submitted { username: $username, password: $password }';
}

// class LoginWithGoogle extends LoginEvent {}

class LogIn extends LoginEvent {
  final String username;
  final String password;
  final BuildContext ctx;

  const LogIn(this.ctx, {@required this.username, @required this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() => 'Login { username: $username, password: $password }';
}