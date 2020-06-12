import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './app/local_storage.dart';
import './blocs/auth/auth_bloc.dart';
import './blocs/auth/auth_event.dart';
import './blocs/home/home_bloc.dart';
import './blocs/home/home_event.dart';
import './blocs/global/global_bloc.dart';
import './blocs/global/global_event.dart';
import './repositories/imp/repo_repository_imp.dart';
import './repositories/user_repository.dart';

class BlocWrapper extends StatelessWidget {
  final LocalStorage storage;
  final UserRepository userRepo;

  final Widget child;

  const BlocWrapper({Key key, this.child, this.storage, this.userRepo});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalBloc>(
          create: (_) => GlobalBloc(storage)..add(LoadApp()),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(userRepo)..add(UnInited()),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(repository: new RepoRepositoryImp())..add(Fetch()),
        ),
      ], 
      child: child,
    );
  }
}