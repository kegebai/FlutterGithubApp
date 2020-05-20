import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './app/router.dart';
import './blocs/oauth/oauth_bloc.dart';
import './blocs/oauth/oauth_state.dart';
import './blocs/oauth/oauth_event.dart';
import './blocs/global/global_bloc.dart';
import './blocs/global/global_state.dart';
import './generated/i18n.dart';
import './repositories/itf/user_repository.dart';
import './pages/login/login_page.dart';
import './pages/splash/zfjtl_splash.dart';

class App extends StatefulWidget {
  const App();

  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  final i18n = I18n.delegate;

  @override
  void initState() {
    super.initState();
    I18n.onLocaleChanged = _onLocalChange;
  }

  _onLocalChange(Locale locale) {
    setState(() {
      I18n.locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(builder: (_, gState) {
      return MaterialApp(
        ///
        localizationsDelegates: [
          i18n,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: i18n.supportedLocales,
        ///
        title: I18n.of(context).app_name,
        ///
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
