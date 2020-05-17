import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './app/router.dart';
import './blocs/oauth/oauth_bloc.dart';
import './blocs/oauth/oauth_state.dart';
import './blocs/oauth/oauth_event.dart';
import './blocs/global/global_bloc.dart';
import './blocs/global/global_state.dart';
import './repositories/itf/user_repository.dart';
import './pages/login/login_page.dart';
import './pages/splash/zfjtl_splash.dart';

class App extends StatelessWidget {
  final UserRepository userRepos;

  const App({this.userRepos});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(builder: (_, gState) {
      return MaterialApp(
        ///
        localizationsDelegates: [
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          // GSYLocalizationsDelegate.delegate,
        ],
        title: 'Flutter Github',
        debugShowCheckedModeBanner: false,
        /// 
        onGenerateRoute: Router.generateRoute,
        ///
        theme: ThemeData(
          primarySwatch: gState.storage.color,
          fontFamily: gState.storage.fontFamily,
        ),
        ///
        home: BlocBuilder<OAuthBloc, OAuthState>(
          builder: (ctx, authState) {
            // if (authState is UnOAuthed) {
            //   return LoginPage();
            // } 
            return ZfjtlSplash(authState: authState);
          },
        ),
      );
    });
  }
}
