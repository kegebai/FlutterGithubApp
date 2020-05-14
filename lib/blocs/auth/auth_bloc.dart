import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './auth_event.dart';
import './auth_state.dart';
import '../../repositories/itf/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepo;

  AuthBloc({@required this.userRepo}) : assert(userRepo != null);

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } 
    else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } 
    else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    final isSignedIn = await userRepo.isSignedIn();
    if (isSignedIn) {
      final user = await userRepo.getUserInfo();
      yield Authed(user.name);
    } 
    else {
      yield Unauthed();
    }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    final user = await userRepo.getUserInfo();
    yield Authed(user.name);
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield Unauthed();
    userRepo.signOut(this);
  }
}
