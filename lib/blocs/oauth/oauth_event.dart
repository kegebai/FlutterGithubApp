import 'package:equatable/equatable.dart';

abstract class OAuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UnInited extends OAuthEvent {}

class LoggedIn extends OAuthEvent {}

class LoggedOut extends OAuthEvent {}