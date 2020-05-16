import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/dlog.dart';
import '../../app/utils/validators.dart';
import '../../repositories/itf/user_repository.dart';

import './login_event.dart';
import './login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepos;
  
  LoginBloc({@required this.userRepos}) : assert(userRepos != null);

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } 
    else if (event is PwdChanged) {
      yield* _mapPwdChangedToState(event.pwd);
    } 
    else if (event is LogIn) {
      yield* _mapLogInToState(email: event.email, pwd: event.pwd, ctx: event.ctx);
    } 
  }

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
    Stream<LoginEvent> events, 
    transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PwdChanged);
    });

    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PwdChanged);
    }).debounceTime(Duration(milliseconds: 300));

    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPwdChangedToState(String pwd) async* {
    yield state.update(
      // isPwdValid: Validators.isValidPassword(pwd),
      isPwdValid: pwd.isNotEmpty,
    );
  }

  Stream<LoginState> _mapLogInToState({String email, String pwd, ctx}) async* {
    try {
      await userRepos.signIn(ctx, email, pwd);
      yield LoginState.success();
    } catch (e) {
      Dlog.log(e);
      yield LoginState.failure();
    }
  }
}