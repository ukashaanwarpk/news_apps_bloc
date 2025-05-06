import 'package:flutter/material.dart';
import '../../views/home/home_screen.dart';
import '../../views/splash/splash_screen.dart';
import 'route_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case RouteName.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      default:
        return MaterialPageRoute(
          builder:
              (context) => const Scaffold(
                body: Center(child: Text('No Route Defined')),
              ),
        );
    }
  }
}
