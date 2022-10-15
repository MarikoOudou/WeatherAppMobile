import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/configs/router_value.dart';
import 'package:flutter_application_1/presentation/screens/screen_my_home.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => MyHomePage(
            title: "Home Screen",
          ),
        );
      // case '/second':
      //   return MaterialPageRoute(
      //     builder: (_) => SecondScreen(
      //       title: "Second Screen",
      //       color: Colors.redAccent,
      //     ),
      //   );
      // case '/third':
      //   return MaterialPageRoute(
      //     builder: (_) => ThirdScreen(
      //       title: "Thirst Screen",
      //       color: Colors.greenAccent,
      //     ),
      //   );
      default:
        return MaterialPageRoute(
          builder: (_) => MyHomePage(
            title: "Home Screen",
          ),
        );
    }
  }
}
