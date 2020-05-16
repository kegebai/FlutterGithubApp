import 'package:equatable/equatable.dart';

abstract class OAuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Uninited extends OAuthEvent {}

class LoggedInStarted extends OAuthEvent {}

class LoggedIn extends OAuthEvent {}

class LoggedOut extends OAuthEvent {}