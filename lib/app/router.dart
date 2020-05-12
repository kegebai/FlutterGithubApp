import 'package:flutter/material.dart';

import '../module_scaffold.dart';
import './utils/router_utils.dart';

class Router {
  static const String home = '/';
  static const String nav  = 'nav';
  static const String module_scaffold = 'module_scaffold';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // 
      case module_scaffold:
        return Left2RightRouter(child: ModuleScaffold());
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