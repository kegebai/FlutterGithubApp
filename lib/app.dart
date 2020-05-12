import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './app/router.dart';
import './blocs/global/global_bloc.dart';
import './blocs/global/global_state.dart';
import './pages/splash/splash.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(builder: (_, state) {
      return MaterialApp(
        ///多语言实现代理
        localizationsDelegates: [
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          // GSYLocalizationsDelegate.delegate,
        ],
        title: 'Flutter Github',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Router.generateRoute,
        theme: ThemeData(
          primarySwatch: state.storage.color,
          fontFamily: state.storage.fontFamily,
        ),
        home: Splash(),
      );
    });
  }
}
