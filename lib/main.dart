import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './app.dart';
import './app/dlog.dart';
import './bloc_wrapper.dart';
import './blocs/debug_bloc_delegate.dart';
import './pages/error_page.dart';
import './repositories/imp/user_repository_imp.dart';
import './storages/local_storage.dart';

void main() {
  BlocSupervisor.delegate = DebugBlocDelegate();

  final storage = LocalStorage();
  final userRepos = new UserRepositoryImp(storage);

  runZoned(
    () {
      ErrorWidget.builder = (FlutterErrorDetails details) {
        Zone.current.handleUncaughtError(
          details.exception, 
          details.stack,
        );
        return ErrorPage(
          message: details.exception.toString() + '\n' + details.stack.toString(), 
          details: details,
        );
      };
      runApp(
        BlocWrapper(storage: storage, userRepos: userRepos, child: App()),
      );
    },
    onError: (Object obj, StackTrace stack) {
      Dlog.log('$obj\n $stack');
    }
  );

  // runApp(
  //   BlocWrapper(
  //     storage: storage, 
  //     userRepos: userRepos,
  //     child: App(userRepos: userRepos),
  //   ),
  // );
}