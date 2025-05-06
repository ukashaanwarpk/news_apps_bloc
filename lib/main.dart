import 'package:flutter/material.dart';
import 'package:news_apps_bloc/utils/service_locator.dart';
import 'package:news_apps_bloc/views/splash/splash_screen.dart';

void main() {
  ServiceLocator.initializeLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
