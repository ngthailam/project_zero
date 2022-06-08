import 'package:de1_mobile_friends/presentation/main_page.dart';
import 'package:de1_mobile_friends/presentation/page/food/food_manage_page.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String main = '';
  static const String home = 'home';
  static const String foodManage = 'food/manage';

  static generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(
            builder: (context) => const MainPage(), settings: settings);
      case home:
        return MaterialPageRoute(
            builder: (context) => const HomePage(), settings: settings);
      case foodManage:
        return MaterialPageRoute(
            builder: (context) => const FoodManagePage(), settings: settings);
      default:
        return Container();
    }
  }
}
