import 'package:equatable/equatable.dart';

import '../../repositories/interface/user_repository.dart';

abstract class OAuthState extends Equatable {
  const OAuthState();

  @override
  List<Object> get props => [];
}

class UnInitialized extends OAuthState {}

class OAuthed extends OAuthState {
  final String displayName;

  const OAuthed(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'OAuthed { displayName: $displayName }';
}

class UnOAuthed extends OAuthState {
  final UserRepository userRepo;

  const UnOAuthed(this.userRepo);

  @override
  List<Object> get props => [userRepo];

  @override
  String toString() => 'UnOAuthed { userRepo: $userRepo }';
}