import 'package:equatable/equatable.dart';
import 'package:flutter_github_app/repositories/itf/user_repository.dart';

abstract class OAuthState extends Equatable {
  const OAuthState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends OAuthState {}

class OAuthed extends OAuthState {
  final String displayName;

  const OAuthed(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'OAuthed { displayName: $displayName }';
}

class UnOAuthed extends OAuthState {
  final UserRepository userRepos;

  const UnOAuthed(this.userRepos);

  @override
  List<Object> get props => [userRepos];

  @override
  String toString() => 'UnOAuthed { userRepos: $userRepos }';
}