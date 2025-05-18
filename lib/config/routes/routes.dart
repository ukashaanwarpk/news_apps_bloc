import 'package:flutter/material.dart';
import 'package:news_apps_bloc/model/category_news_model.dart';
import 'package:news_apps_bloc/views/categories/categories_screen.dart';
import 'package:news_apps_bloc/views/details/detail_screen.dart';
import '../../views/home/home_screen.dart';
import '../../views/splash/splash_screen.dart';
import 'route_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RouteName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case RouteName.detail:
        final args = settings.arguments as Map<String, dynamic>;
        final article = args['article'] as Articles;
        final index = args['index'] as int;

        return MaterialPageRoute(
          builder: (context) => DetailScreen(article: article, index: index),
        );

      case RouteName.categoires:
        return MaterialPageRoute(
          builder: (context) => const CategoriesScreen(),
        );

      default:
        return MaterialPageRoute(
          builder:
              (context) =>
                  const Scaffold(body: Center(child: Text('No Route Defined'))),
        );
    }
  }
}
