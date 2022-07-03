import 'package:de1_mobile_friends/presentation/page/food/food_manage_page.dart';
import 'package:de1_mobile_friends/presentation/page/home/home_page.dart';
import 'package:de1_mobile_friends/presentation/page/main/main_page.dart';
import 'package:de1_mobile_friends/presentation/page/place_detail/place_detail_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String main = '/';
  static const String home = 'home';
  static const String foodManage = 'food/manage';
  static const String placeDetail = 'place/detail';

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
      case placeDetail:
        final placeId = (settings.arguments as String?) ?? '';
        return MaterialPageRoute(
            builder: (context) => PlaceDetailPage(
                  placeId: placeId,
                ),
            settings: settings);
      default:
        return Container();
    }
  }
}
