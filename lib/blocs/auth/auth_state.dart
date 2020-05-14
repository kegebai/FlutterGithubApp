import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthState {}

class Authed extends AuthState {
  final String displayName;

  const Authed(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'Authed { displayName: $displayName }';
}

class Unauthed extends AuthState {}