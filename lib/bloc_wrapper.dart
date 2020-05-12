import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_app/storages/local_storage.dart';

import './blocs/global/global_bloc.dart';
import './blocs/global/global_event.dart';

class BlocWrapper extends StatelessWidget {
  final LocalStorage storage;
  final Widget child;

  const BlocWrapper({Key key, this.child, this.storage});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalBloc>(create: (_) => GlobalBloc(storage)..add(LoadApp())),
        
      ], 
      child: child,
    );
  }
}