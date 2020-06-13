import 'package:flutter/material.dart';
import 'package:flutter_github_app/pages/login/login_page.dart';

import './home_screen.dart';
import '../pages/splash/zfjtl_splash.dart';
import './utils/router_utils.dart';

class Router {
  static const String home = '/';
  static const String nav  = 'nav';
  static const String home_screen = 'home_screen';
  static const String login = 'login';
  static const String splash = 'splash';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //
      case splash:
        return Top2BottomRouter(child: ZfjtlSplash());
        break;
      // 
      case home_screen:
        return Left2RightRouter(child: HomeScreen());
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