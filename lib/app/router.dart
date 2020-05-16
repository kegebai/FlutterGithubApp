import 'package:flutter/material.dart';
import 'package:flutter_github_app/pages/login/login_page.dart';

import '../module_scaffold.dart';
import '../pages/splash/zfjtl_splash.dart';
import './utils/router_utils.dart';

class Router {
  static const String home = '/';
  static const String nav  = 'nav';
  static const String module_scaffold = 'module_scaffold';
  static const String login = 'login';
  static const String splash = 'splash';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //
      case splash:
        return Top2BottomRouter(child: ZfjtlSplash());
        break;
      // 
      case module_scaffold:
        return Left2RightRouter(child: ModuleScaffold());
        break;
      //
      case login:
        return Right2LeftRouter(child: LoginPage());
        break;

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}