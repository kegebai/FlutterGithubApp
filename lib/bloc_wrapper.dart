import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './blocs/oauth/oauth_bloc.dart';
import './blocs/oauth/oauth_event.dart';
import './blocs/global/global_bloc.dart';
import './blocs/global/global_event.dart';
import './repositories/interface/user_repository.dart';
import './storages/local_storage.dart';

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
        BlocProvider<OAuthBloc>(
          create: (context) => OAuthBloc(userRepo)..add(UnInited()),
        ),
      ], 
      child: child,
    );
  }
}