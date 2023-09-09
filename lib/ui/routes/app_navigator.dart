import 'package:flutter/material.dart';
import 'package:nweather_app/ui/routes/app_routes.dart';
import '../pages/home_page/home_page.dart';
import '../pages/search_page/search_page.dart';

class AppNavigator {
  static String initRoute = AppRoutes.home;

  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.home: (_) => const HomePage(),
      AppRoutes.search: (_) => const SearchPage(),
    };
  }
}
