

import 'package:flutter/material.dart';

import '../Presentation/pages/country_detail_screen.dart';
import '../Presentation/pages/home_screen.dart';
import '../core/models/CountryResponseModel.dart';
import '../Presentation/pages/page_splash.dart';


class Routes{
  static const String splash = '/';
  static const String home = '/home';
  static const String detailCountry = '/detail';
}

class AppRouter{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => SplashPage()
        );

      case Routes.home:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const HomeScreen()
        );

      case Routes.detailCountry:
        final country = settings.arguments as CountryResponseModel;
        return MaterialPageRoute(
          builder: (_) => CountryDetailScreen(country: country),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}