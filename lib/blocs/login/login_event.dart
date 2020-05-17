import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged(this.email);

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email: $email }';
}

class PwdChanged extends LoginEvent {
  final String pwd;

  PwdChanged(this.pwd);

  @override
  List<Object> get props => [pwd];

  @override
  String toString() => 'PwdChanged { pwd: $pwd }';
}

class Submitted extends LoginEvent {
  final String email;
  final String pwd;
  final BuildContext ctx;

  Submitted(this.ctx, this.email, this.pwd);

  @override
  List<Object> get props => [email, pwd];

  @override
  String toString() => 'Submitted { email: $email, pwd: $pwd }';
}

// class LoginWithGoogle extends LoginEvent {}

class LogIn extends LoginEvent {
  final String email;
  final String pwd;
  final BuildContext ctx;

  const LogIn(this.ctx, {@required this.email, @required this.pwd});

  @override
  List<Object> get props => [email, pwd];

  @override
  String toString() => 'Login { email: $email, pwd: $pwd }';
}