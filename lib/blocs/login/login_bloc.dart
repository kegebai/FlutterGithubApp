import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/dlog.dart';
import '../../repositories/user_repository.dart';

import './login_event.dart';
import './login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepo;
  
  LoginBloc({@required this.userRepo}) : assert(userRepo != null);

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is UsernameChanged) {
      yield* _mapUsernameChangedToState(event.username);
    } 
    else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } 
    else if (event is LogIn) {
      yield* _mapLogInToState(
        ctx: event.ctx, 
        username: event.username, 
        password: event.password
      );
    } 
  }

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
    Stream<LoginEvent> events, 
    transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! UsernameChanged && event is! PasswordChanged);
    });

    final debounceStream = events.where((event) {
      return (event is UsernameChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));

    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  Stream<LoginState> _mapUsernameChangedToState(String username) async* {
    yield state.update(
      // isUsernameValid: Validators.isValidEmail(username),
      isUsernameValid: username.isNotEmpty,
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      // isPwdValid: Validators.isValidPassword(pwd),
      isPasswordValid: password.isNotEmpty,
    );
  }

  Stream<LoginState> _mapLogInToState({ctx, String username, String password}) async* {
    try {
      await userRepo.signIn(ctx, username, password);
      yield LoginState.success();
    } catch (e) {
      Dlog.log(e);
      yield LoginState.failure();
    }
  }
}