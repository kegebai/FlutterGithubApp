import 'package:equatable/equatable.dart';

import '../../repositories/user_repository.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class UnInitialized extends AuthState {}

class OAuthed extends AuthState {
  final String displayName;

  const OAuthed(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'OAuthed { displayName: $displayName }';
}

class UnOAuthed extends AuthState {
  final UserRepository userRepo;

  const UnOAuthed(this.userRepo);

  @override
  List<Object> get props => [userRepo];

  @override
  String toString() => 'UnOAuthed { userRepo: $userRepo }';
}